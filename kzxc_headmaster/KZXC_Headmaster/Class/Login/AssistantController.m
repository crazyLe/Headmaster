//
//  AssistantController.m
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/7/26.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import "AssistantController.h"
#import "BasicTabBarController.h"
#import "ScanningController.h"

@interface AssistantController ()<UITextFieldDelegate>
{
    NSInteger lastindex;
}
@property(weak,nonatomic)UITextField *phone;
@property(weak,nonatomic)UITextField *psw;

@end

@implementation AssistantController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageWithRenderingMode:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(leftAction:)];
    
    self.title = @"校长助理登录";
    
    UIImageView *bg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"zhulibg_bg"]];
    bg.userInteractionEnabled = YES;
    bg.frame = self.view.bounds;
    [self.view addSubview:bg];
    
    UITextField *text1 = [[UITextField alloc]init];
    text1.keyboardType = UIKeyboardTypeNumberPad;
    [self setTextfiledValue:text1 andImg:@"lg_phone" andtag:301 andplaceholder:@"手机号"];
    [self.view addSubview:text1];
    [text1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(84);
        make.left.mas_offset(15);
        make.size.mas_offset(CGSizeMake(kWidth - 30, loginH));
    }];
    self.phone = text1;
    
    UITextField *text2 = [[UITextField alloc]init];
    text2.keyboardType = UIKeyboardTypeASCIICapable;
    text2.secureTextEntry = YES;
    [self setTextfiledValue:text2 andImg:@"lg_code" andtag:302 andplaceholder:@"密码"];
    [self.view addSubview:text2];
    [text2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(text1.mas_bottom).offset(10);
        make.left.mas_offset(15);
        make.size.mas_offset(CGSizeMake(kWidth - 30, loginH));
    }];
    self.psw = text2;
    
    UIButton *loginBtn = [[UIButton alloc]init];
    loginBtn.backgroundColor = [UIColor colorWithHexString:@"#d32026"];
    loginBtn.layer.masksToBounds = YES;
    loginBtn.layer.cornerRadius = ButtonH/2;
    [loginBtn setTitle:@"登  录" forState:UIControlStateNormal];
    loginBtn.titleLabel.font = Font22;
    [loginBtn addTarget:self action:@selector(loginClick) forControlEvents:UIControlEventTouchUpInside ];
    [bg addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(text2.mas_bottom).offset(20);
        make.left.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(kWidth - 30, ButtonH));
    }];
    
}

- (void)setTextfiledValue:(UITextField *)view andImg:(NSString *)name andtag:(NSInteger)tag andplaceholder:(NSString *)str
{
    view.delegate = self;
    view.tag = tag;
    view.placeholder = str;
    view.textColor = [UIColor whiteColor];
    UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:name]];
    img.frame = CGRectMake(25, (loginH-20)/2, 20, 20);
    //    img.tag = tag;
    [view addSubview:img];
    
    [view setValue:ColorSix forKeyPath:@"_placeholderLabel.textColor"];
    //设置文字内容显示位置
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 55, 30)];
    view.leftView = paddingView;
    view.leftViewMode = UITextFieldViewModeAlways;
    
    [view setBackground:[UIImage imageNamed:@"text_normal"]];
}


- (void)loginClick
{
    [self.hudManager showNormalStateSVHUDWithTitle:@"登录中"];
    
    NSString *phonestr = self.phone.text;
    
    NSString *pswstr = self.psw.text;
    
    if (![ValidateHelper validateMobile:phonestr]) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确手机号"];
        return;
    }
    
    if (![ValidateHelper validatePassword:pswstr]) {
        [SVProgressHUD showErrorWithStatus:@"请输入6~20位密码"];
        return;
    }
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"phone"] = phonestr;
    param[@"time"] = self.getcurrentTime;
    param[@"password"] = pswstr;
    param[@"deviceInfo"] = deviceInfo;
    param[@"pushID"] = pushID;
    param[@"loginChannel"] = @"3";
    param[@"sign"] = [HttpsTools getSignWithIdentify:@"/user/login" time:self.getcurrentTime];
    [HttpsTools kPOST:loginUrl parameter:param progress:^(NSProgress *downloadProgress) {
    } succeed:^(id backdata, int code, NSString *msg) {
//        NSLog(@"%@,%d",backdata,code);
//        [SVProgressHUD showSuccessWithStatus:msg];
        if (1 == code) {
            [self.hudManager showSuccessSVHudWithTitle:msg hideAfterDelay:2.0 animaton:YES];
            [User userWithDict:backdata];
            ScanningController *scan = [[ScanningController alloc]init];
            [self presentViewController:scan animated:YES completion:nil];
//            [self.hudManager dismissSVHud];
        }else
        {
            [self.hudManager showErrorSVHudWithTitle:msg hideAfterDelay:2.0];
        }
        
//        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
//        NSLog(@"%@",error);
    }];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (0 != lastindex) {
        UITextField *text = [self.view viewWithTag:lastindex];
        
        [text setBackground:[UIImage imageNamed:@"text_normal"]];
    }
    [textField setBackground:[UIImage imageNamed:@"text_dianji"]];
    lastindex = textField.tag;
    
}

- (void)leftAction:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
