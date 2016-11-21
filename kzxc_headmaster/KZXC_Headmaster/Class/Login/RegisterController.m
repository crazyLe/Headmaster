//
//  RegisterController.m
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/7/26.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import "RegisterController.h"
#import "LoginViewController.h"
#import "BasicTabBarController.h"
#import "ResRulesController.h"

@interface RegisterController ()<UITextFieldDelegate>
{
    NSInteger lastindex;
    int i;
}
@property(strong,nonatomic)User *user;

@end

@implementation RegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBar.alpha = 1;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageWithRenderingMode:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(leftAction:)];
    
    self.title = @"注册";
    
    i = 60;
    
    UIImageView *bg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"lg_bg"]];
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
    text2.keyboardType = UIKeyboardTypeNumberPad;
    [self setTextfiledValue:text2 andImg:@"lg_code" andtag:302 andplaceholder:@"验证码"];
    [self.view addSubview:text2];
    [text2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(text1.mas_bottom).offset(10);
        make.left.mas_offset(15);
        make.size.mas_offset(CGSizeMake(kWidth - 30, loginH));
    }];
    self.code = text2;
    
    UIButton *getcode = [[UIButton alloc]init];
    [getcode setTitle:@"获取验证码" forState:UIControlStateNormal];
    getcode.titleLabel.font = fourteenFont;
    [getcode setTitleColor:[UIColor colorWithHexString:@"#d32026"] forState:UIControlStateNormal];
    [getcode addTarget:self action:@selector(getcodeClcik:) forControlEvents:UIControlEventTouchUpInside];
    [text2 addSubview:getcode];
    [getcode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(-25);
        make.size.mas_equalTo(CGSizeMake(75, loginH));
    }];
    
    self.getcode = getcode;
    
    
    UITextField *text3 = [[UITextField alloc]init];
    text3.keyboardType = UIKeyboardTypeASCIICapable;
    text3.secureTextEntry = YES;
    [self setTextfiledValue:text3 andImg:@"lg_psw" andtag:303 andplaceholder:@"密码"];
    [self.view addSubview:text3];
    [text3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(text2.mas_bottom).offset(10);
        make.left.mas_offset(15);
        make.size.mas_offset(CGSizeMake(kWidth - 30, loginH));
    }];
    self.psw = text3;
    
    UITextField *text4 = [[UITextField alloc]init];
    text4.keyboardType = UIKeyboardTypeASCIICapable;
    text4.secureTextEntry = YES;
    [self setTextfiledValue:text4 andImg:@"lg_psw" andtag:304 andplaceholder:@"确认密码"];
    [self.view addSubview:text4];
    [text4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(text3.mas_bottom).offset(10);
        make.left.mas_offset(15);
        make.size.mas_offset(CGSizeMake(kWidth - 30, loginH));
    }];
    
    self.surepsw = text4;
    
    UIButton *registerBtn = [[UIButton alloc]init];
    registerBtn.backgroundColor = [UIColor colorWithHexString:@"#d32026"];
    registerBtn.titleLabel.font = Font22;
    registerBtn.layer.masksToBounds = YES;
    registerBtn.layer.cornerRadius = HomeBtnH/2;
    [registerBtn setTitle:@"立即注册" forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(registerClick) forControlEvents:UIControlEventTouchUpInside ];
    [bg addSubview:registerBtn];
    [registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(text4.mas_bottom).offset(20);
        make.left.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(kWidth - 30, HomeBtnH));
    }];
    
    UIButton *zhecexieyi = [[UIButton alloc]init];
//    zhecexieyi.backgroundColor = [UIColor colorWithHexString:@"#d32026"];
    zhecexieyi.titleLabel.font = Font16;
//    zhecexieyi.layer.masksToBounds = YES;
//    zhecexieyi.layer.cornerRadius = HomeBtnH/2;
    [zhecexieyi setTitle:@"注册即表示同意《康庄学车注册协议》" forState:UIControlStateNormal];
    [zhecexieyi setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [zhecexieyi addTarget:self action:@selector(registerxieyiClick) forControlEvents:UIControlEventTouchUpInside ];
    [bg addSubview:zhecexieyi];
    [zhecexieyi mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(registerBtn.mas_bottom).offset(10);
        make.left.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(kWidth - 30, HomeBtnH));
    }];
    
}

- (void)registerxieyiClick
{
    ResRulesController *com = [[ResRulesController alloc]init];
    com.urlstr = getResrules;
    [self.navigationController pushViewController:com animated:YES];
}

- (void)getcodeClcik:(UIButton *)btn
{
    NSString *phonestr = self.phone.text;
    
    if (![ValidateHelper validateMobile:phonestr]) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确手机号"];
        return;
    }
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTitle:) userInfo:nil repeats:YES];
    [timer fire];
    btn.enabled = NO;
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"phone"] = phonestr;
    param[@"time"] = self.getcurrentTime;
    param[@"sign"] = [HttpsTools getSignWithIdentify:@"/user/getVerificationCode" time:self.getcurrentTime];
    [HttpsTools kPOST:getResCodeUrl parameter:param progress:^(NSProgress *downloadProgress) {
    } succeed:^(id backdata, int code, NSString *msg) {
        [SVProgressHUD showWithStatus:msg];
        [SVProgressHUD dismiss];
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)updateTitle:(NSTimer *)timer
{
    [self.getcode setTitle:[NSString stringWithFormat:@"已发送(%d)",i] forState:UIControlStateNormal];
    [self.getcode setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    i--;
    if (0 == i) {
        [self.getcode setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self.getcode setTitleColor:[UIColor colorWithHexString:@"#d32026"] forState:UIControlStateNormal];
        self.getcode.enabled = YES;
        i = 60;
        [timer invalidate];
    }
    
}

- (void)registerClick
{
    NSString *phonestr = self.phone.text;
    NSString *codestr = self.code.text;
    NSString *pswstr = self.psw.text;
    NSString *surestr = self.surepsw.text;
    
    if (![ValidateHelper validateMobile:phonestr]) {
        [self.hudManager showErrorSVHudWithTitle:@"请输入正确手机号" hideAfterDelay:2.0];
        return;
    }
    
    if (6 != codestr.length) {
        [self.hudManager showErrorSVHudWithTitle:@"请输入6位数字验证码" hideAfterDelay:2.0];
        return;
    }
    
    if (![ValidateHelper validatePassword:pswstr] ) {
        [self.hudManager showErrorSVHudWithTitle:@"请输入6~20位密码" hideAfterDelay:2.0];
        return;
    }
    
    if (![pswstr isEqualToString:surestr]) {
        [self.hudManager showErrorSVHudWithTitle:@"两次密码输入不同" hideAfterDelay:2.0];
        return;
    }
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"phone"] = phonestr;
    param[@"time"] = self.getcurrentTime;
    param[@"invitation"] = @"";
    param[@"code"] = codestr;
    param[@"pwd"] = pswstr;
    param[@"confirmPwd"] = surestr;
    param[@"deviceInfo"] = deviceInfo;
    param[@"pushID"] = pushID;
    param[@"sign"] = [HttpsTools getSignWithIdentify:@"/user/register" time:self.getcurrentTime];
   
    [self.hudManager showNormalStateSVHUDWithTitle:@"加载中"];
    [HttpsTools kPOST:registerUrl parameter:param progress:^(NSProgress *downloadProgress) {
    } succeed:^(id backdata, int code, NSString *msg) {

        [self.hudManager showNormalStateSVHudWithTitle:msg hideAfterDelay:1.0];
        if (1 == code) {
            
            LoginViewController *login = [[LoginViewController alloc]init];
            login.isfirstlogin = YES;
            UINavigationController *root = [[UINavigationController alloc]initWithRootViewController:login];
            root.navigationBar.titleTextAttributes = NavTitleTextAttributes;
            [root.navigationBar setBackgroundImage:[UIImage imageWithRenderingMode:@"nav_bg"] forBarMetrics:UIBarMetricsDefault];
            [root.navigationBar setShadowImage:[UIImage imageWithColor:[UIColor clearColor]]];
            root.navigationBar.translucent = YES;
            
            [self presentViewController:root animated:YES completion:nil];
            
        }
    } failure:^(NSError *error) {
    }];
}

- (void)leftAction:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
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
