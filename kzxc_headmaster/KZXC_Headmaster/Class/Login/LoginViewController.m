//
//  LoginViewController.m
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/7/26.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import "LoginViewController.h"
#import "BasicTabBarController.h"
#import "AssistantController.h"
#import "JpushManager.h"

@interface LoginViewController ()<UITextFieldDelegate>
{
    NSInteger lastIndex;
    NSInteger highttext;
    int i;
}
@property(weak,nonatomic)UIImageView *bgview;
@property(weak,nonatomic)UITextField *phone;
@property(weak,nonatomic)UITextField *code;
@property(weak,nonatomic)UIButton *codeBtn;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    i = 60;
    
    [self setupNav];
    
    UIImageView *bg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"lg_bg"]];
    bg.userInteractionEnabled = YES;
    bg.frame = CGRectMake(0, 0, kWidth, kHeight);
    self.bgview = bg;
    [self.view addSubview:bg];
    
//    WithFrame:CGRectMake(15, 84, kWidth - 30, 50)
    UITextField *text1 = [[UITextField alloc]init];
//    text1.text = @"18856710365";
    text1.keyboardType = UIKeyboardTypeNumberPad;
    text1.tag = 301;
    text1.placeholder = @"手机号";
    [self setUITextFieldValue:text1 andImg:@"lg_phone" andtag:201];
    [bg addSubview:text1];
    [text1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(84);
        make.left.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(kWidth - 30, loginH));
    }];
    self.phone = text1;
    
    
    UITextField *text2 = [[UITextField alloc]init];
//    text2.text = @"123456";
    text2.tag = 302;
    text2.placeholder = @"密码";
    text2.keyboardType = UIKeyboardTypeASCIICapable;
    text2.secureTextEntry = YES;
    [self setUITextFieldValue:text2 andImg:@"lg_psw" andtag:202];
    [bg addSubview:text2];
    [text2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(text1.mas_bottom).offset(10);
        make.left.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(kWidth - 30, loginH));
    }];
    
    self.code = text2;
    
    UIButton *getcode = [[UIButton alloc]init];
    [getcode setTitle:@"获取验证码" forState:UIControlStateNormal];
    getcode.titleLabel.font = fourteenFont;
    [getcode setTitleColor:[UIColor colorWithHexString:@"#d32026"] forState:UIControlStateNormal];
    [getcode addTarget:self action:@selector(getcodeClcik:) forControlEvents:UIControlEventTouchUpInside];
    [text2 addSubview:getcode];
    [getcode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(text1.mas_bottom).offset(10);
        make.right.mas_equalTo(-25);
        make.size.mas_equalTo(CGSizeMake(75, loginH));
    }];
    getcode.hidden = YES;
    self.codeBtn = getcode;
    
    UIButton *loginBtn = [[UIButton alloc]init];
    loginBtn.titleLabel.font = Font22;
    loginBtn.backgroundColor = [UIColor colorWithHexString:@"#d32026"];
//    loginBtn.alpha = 0.5;
    loginBtn.layer.masksToBounds = YES;
    loginBtn.layer.cornerRadius = HomeBtnH/2;
    [loginBtn setTitle:@"登  录" forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(loginClick) forControlEvents:UIControlEventTouchUpInside ];
    [bg addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(text2.mas_bottom).offset(20);
        make.left.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(kWidth - 30, HomeBtnH));
    }];

    
    UIButton *assisloginBtn = [[UIButton alloc]init];
    assisloginBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    assisloginBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [assisloginBtn setImage:[UIImage imageNamed:@"lg_assis"] forState:UIControlStateNormal];
    [assisloginBtn setBackgroundImage:[UIImage imageNamed:@"text_normal"] forState:UIControlStateNormal];
    [assisloginBtn setBackgroundImage:[UIImage imageNamed:@"text_dianji"] forState:UIControlStateHighlighted];
    [assisloginBtn setTitle:@"校长助理登录" forState:UIControlStateNormal];
    [assisloginBtn addTarget:self action:@selector(assisClcik) forControlEvents:UIControlEventTouchUpInside];
    [bg addSubview:assisloginBtn];
    [assisloginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(bg.mas_bottom).offset(-20);
        make.left.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(kWidth - 30, loginH));
    }];
    
}


- (void)setUITextFieldValue:(UITextField *)view andImg:(NSString *)name andtag:(NSInteger)tag
{
    view.textColor = [UIColor whiteColor];
    view.delegate = self;
    UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:name]];
    img.frame = CGRectMake(25, (loginH-20)/2, 20, 20);
    img.tag = tag;
    [view addSubview:img];
    
    [view setValue:ColorSix forKeyPath:@"_placeholderLabel.textColor"];
    //设置文字内容显示位置
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 55, 30)];
    view.leftView = paddingView;
    view.leftViewMode = UITextFieldViewModeAlways;
    
    [view setBackground:[UIImage imageNamed:@"text_normal"]];
}

- (void)setupNav
{
    
    if (!_isfirstlogin) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageWithRenderingMode:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(leftAction:)];
    }
    
    self.navigationController.navigationBar.barTintColor = [UIColor clearColor];
    
    UISegmentedControl *seg = [[UISegmentedControl alloc]initWithItems:@[@"密码登录",@"验证码登录"]];
    seg.tintColor = NavBackColor;
    seg.selectedSegmentIndex = 0;
    
    [seg setTitleTextAttributes :[NSDictionary dictionaryWithObjectsAndKeys:ColorNine,NSForegroundColorAttributeName,Font17,NSFontAttributeName, nil]forState:UIControlStateNormal];
    
    [seg setTitleTextAttributes :[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,Font17,NSFontAttributeName, nil]forState:UIControlStateSelected];
    seg.frame = CGRectMake(0, 0, 200, 30);
    [seg addTarget:self action:@selector(segClick:) forControlEvents:UIControlEventValueChanged];
    
    self.navigationItem.titleView =  seg;

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (0 != highttext) {
        UITextField *text = [self.view viewWithTag:highttext];
        
        [text setBackground:[UIImage imageNamed:@"text_normal"]];
    }
    [textField setBackground:[UIImage imageNamed:@"text_dianji"]];
    highttext = textField.tag;
    
}

- (void)segClick:(UISegmentedControl *)seg
{
    
    [self.view endEditing:YES];
    
    NSInteger index = seg.selectedSegmentIndex;
    
    NSString *imgName = (0 == index)?@"lg_psw":@"lg_code";
    UIImageView *img = [self.code viewWithTag:202];
    img.image = [UIImage imageNamed:imgName];
    
    NSString *mrStr = (0 == index)?@"密码":@"验证码";
    self.code.placeholder = mrStr;
    
    if (0 == index) {
        self.code.keyboardType = UIKeyboardTypeASCIICapable;
        lastIndex = 0;
    }else
    {
        self.code.keyboardType = UIKeyboardTypeNumberPad;
        self.code.secureTextEntry = NO;
        lastIndex = 1;
    }
    
    BOOL state = (0 == index)?YES:NO;
    self.codeBtn.hidden = state;
    self.code.secureTextEntry = state;
    self.code.text = @"";
}

- (void)loginClick
{
    NSString *phonestr = self.phone.text;
    NSString *codestr = self.code.text;

    NSString *channel;
    if (![ValidateHelper validateMobile:phonestr]) {
        [self.hudManager showErrorSVHudWithTitle:@"请输入正确手机号" hideAfterDelay:2.0];
        return;
    }
    
    if (0 == lastIndex) {
        if (![ValidateHelper validatePassword:codestr]) {
            [self.hudManager showErrorSVHudWithTitle:@"请输入6~20位密码" hideAfterDelay:2.0];
            
            return;
        }
        channel = @"1";
    }else
    {
        if (6 != codestr.length) {
            [self.hudManager showErrorSVHudWithTitle:@"请输入6位数字验证码" hideAfterDelay:2.0];
            return;
        }
        channel = @"2";
    }
   
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"phone"] = phonestr;
    param[@"time"] = self.getcurrentTime;
    param[@"password"] = codestr;
    param[@"deviceInfo"] = deviceInfo;
    param[@"pushID"] = pushID;
    param[@"loginChannel"] = channel;
    param[@"sign"] = [HttpsTools getLoginPhone:phonestr andIdentify:@"/user/login" andTime:self.getcurrentTime];
    NSLog(@"%@",param);
    [self.hudManager showNormalStateSVHUDWithTitle:@"加载中"];
    [HttpsTools kPOST:loginUrl parameter:param progress:^(NSProgress *downloadProgress) {
    } succeed:^(id backdata, int code, NSString *msg) {
        
        
        if (1 == code) {
            //登录成功,保存手机号
            [curDefaults setObject:phonestr forKey:@"phone"];
            
            [User userWithDict:backdata];
            //jpush监听
            [[JpushManager sharedJpushManager] startMonitor];
            
            BasicTabBarController *basic = [[BasicTabBarController alloc]init];
            [self presentViewController:basic animated:YES completion:nil];
            
            [self.hudManager showSuccessSVHudWithTitle:@"登录成功" hideAfterDelay:2.0 animaton:YES];
            
        }
        else {
            
            [self.hudManager showErrorSVHudWithTitle:msg hideAfterDelay:1.0];
            
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}
- (void)assisClcik
{
    AssistantController *assis = [[AssistantController alloc]init];
    [self.navigationController pushViewController:assis animated:YES];
    
}

- (void)getcodeClcik:(UIButton *)btn
{
    NSString *phonestr = self.phone.text;
    
    if (![ValidateHelper validateMobile:phonestr]) {
        [MBProgressHUD showError:@"请输入正确手机号"];
        return;
    }
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTitle:) userInfo:nil repeats:YES];
    [timer fire];
    btn.enabled = NO;
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"phone"] = phonestr;
    param[@"time"] = self.getcurrentTime;
//    param[@"sign"] = [HttpsTools getSignWithIdentify:@"/user/sendCode" time:self.getcurrentTime];
    param[@"flag"] = @"login";
    
    [HttpsTools kPOST:getLogCodeUrl parameter:param progress:^(NSProgress *downloadProgress) {
    } succeed:^(id backdata, int code, NSString *msg) {
        [MBProgressHUD showMessage:msg];
        [MBProgressHUD hideHUD];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
- (void)updateTitle:(NSTimer *)timer
{
    [self.codeBtn setTitle:[NSString stringWithFormat:@"已发送(%d)",i] forState:UIControlStateNormal];
    [self.codeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    i--;
    if (0 == i) {
        [self.codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self.codeBtn setTitleColor:[UIColor colorWithHexString:@"#d32026"] forState:UIControlStateNormal];
        i = 60;
        self.codeBtn.enabled = YES;
        [timer invalidate];
    }
    
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
