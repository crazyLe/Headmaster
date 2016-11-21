//
//  ModifyController.m
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/7/22.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import "ModifyController.h"
#import "UIColor+Hex.h"
#import "LoginGuideController.h"
@interface ModifyController ()
{
    int _oldSecond;
    int _newSecond;
    NSInteger sendtag;
    UIButton *curbutton;

}

@property(weak,nonatomic)UIView *pswView;

@property(weak,nonatomic)UITextField *oldpsw;
@property(weak,nonatomic)UITextField *newpsw;
@property(weak,nonatomic)UITextField *surepsw;

@property(weak,nonatomic)UIView *phoneView;

@property(weak,nonatomic)UITextField *oldnum;
@property(weak,nonatomic)UITextField *oldcode;
@property(weak,nonatomic)UITextField *newnum;
@property(weak,nonatomic)UITextField *newcode;

@property(weak,nonatomic)UIButton *send1Code;
@property(weak,nonatomic)UIButton *send2Code;
@property (strong, nonatomic) NSTimer * oldTimer;
@property (nonatomic, strong) NSTimer * newwTimer;
@property(weak,nonatomic)UIButton *commit;
@property (nonatomic, weak) UIButton * commit2;
//判断界面显示状态
@property (nonatomic, assign) NSInteger tag ;
@property (nonatomic, strong) UITextField *oldpsw_filed ;
@property (nonatomic, strong) UITextField *npsw_filed;
@property (nonatomic, strong) UITextField *surenpsw_filed ;

@end

@implementation ModifyController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的";
    self.view.backgroundColor = RGBColor(247, 247, 247);
    

    
//    [self setupNav];
    
    [self setupPswView];
    
    [self setupPhoneView];
    
    [self setupNav];
    
//    self.phoneView.alpha = 0;
    
    _oldSecond = 60;

    _newSecond = 60;
    
}

- (void)setupNav
{
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    
    [navigationBar setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault]; //此处使底部线条颜色为红色
    
    [navigationBar setShadowImage:[UIImage imageWithColor:NavBackColor]];
    
    UISegmentedControl *seg = [[UISegmentedControl alloc]initWithItems:@[@"修改密码",@"修改手机号"]];
    seg.tintColor = [UIColor whiteColor];
    seg.selectedSegmentIndex = 0;
    
    [seg setTitleTextAttributes :[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,Font17,NSFontAttributeName, nil]forState:UIControlStateNormal];
    
    [seg setTitleTextAttributes :[NSDictionary dictionaryWithObjectsAndKeys:NavBackColor,NSForegroundColorAttributeName,Font17,NSFontAttributeName, nil]forState:UIControlStateSelected];
    
    seg.frame = CGRectMake(0, 0, 200, 30);
    [seg addTarget:self action:@selector(segClick:) forControlEvents:UIControlEventValueChanged];
    if (_isPersonalSetting) {
        
        seg.selectedSegmentIndex = 1;
        self.phoneView.alpha = 1.0;
        self.pswView.alpha = 0;
        
    }else {
        
        seg.selectedSegmentIndex = 0;
        self.pswView.alpha = 1.0;
        self.phoneView.alpha = 0;
        
    }
    self.navigationItem.titleView =  seg;
}
- (void)segClick:(UISegmentedControl *)seg
{
    _tag = seg.selectedSegmentIndex;
    if (_tag == 0) {
        self.phoneView.alpha = 0;
        self.pswView.alpha = 1.0;
        
    }else
    {
        self.phoneView.alpha = 1.0;
        self.pswView.alpha = 0;
    }
}


- (void)setupPswView
{
    UIView *pswview =[[UIView alloc]init];
    pswview.backgroundColor = RGBColor(247, 247, 247);
    [self.view addSubview:pswview];
    [pswview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(kWidth, 45*4+15));
    }];
    
    self.pswView = pswview;
    
    UIView *contentview = [[UIView alloc]init];
    contentview.backgroundColor = [UIColor whiteColor];
    [pswview addSubview:contentview];
    [contentview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(kWidth, 45*3));
    }];
  
    UIButton *show1 = [[UIButton alloc]init];
    show1.tag = 1001;
    [show1 setImage:[UIImage imageNamed:@"safe"] forState:UIControlStateNormal];
    [show1 setImage:[UIImage imageNamed:@"nosafe"] forState:UIControlStateSelected];
    [show1 addTarget:self action:@selector(statueClick:) forControlEvents:UIControlEventTouchUpInside];
    [contentview addSubview:show1];
    [show1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.size.mas_equalTo(CGSizeMake(45, 25));
    }];
    
    
    UIButton *show2 = [[UIButton alloc]init];
    show2.tag = 1002;
    [show2 setImage:[UIImage imageNamed:@"safe"] forState:UIControlStateNormal];
    [show2 setImage:[UIImage imageNamed:@"nosafe"] forState:UIControlStateSelected];
    [show2 addTarget:self action:@selector(statueClick:) forControlEvents:UIControlEventTouchUpInside];
    [contentview addSubview:show2];
    [show2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(show1.mas_bottom).offset(20);
        make.right.mas_equalTo(-10);
        make.size.mas_equalTo(CGSizeMake(45, 25));
    }];
    
    show2.selected = YES;
    
    UIButton *show3 = [[UIButton alloc]init];
    show3.tag = 1003;
    [show3 setImage:[UIImage imageNamed:@"safe"] forState:UIControlStateNormal];
    [show3 setImage:[UIImage imageNamed:@"nosafe"] forState:UIControlStateSelected];
    [show3 addTarget:self action:@selector(statueClick:) forControlEvents:UIControlEventTouchUpInside];
    [contentview addSubview:show3];
    [show3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(show2.mas_bottom).offset(20);
        make.right.mas_equalTo(-10);
        make.size.mas_equalTo(CGSizeMake(45, 25));
    }];
    
    show3.selected = YES;
    
    _oldpsw_filed = [[UITextField alloc]init];
    _oldpsw_filed.placeholder = @"请输入旧密码";
    [contentview addSubview:_oldpsw_filed];
    [_oldpsw_filed mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(140, 44));
    }];
    
    self.oldpsw = _oldpsw_filed;
    
    UIView *line1 = [[UIView alloc]init];
    line1.backgroundColor = [UIColor colorWithHexString:@"#e6e6e6"];
    [contentview addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_oldpsw_filed.mas_bottom);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(kWidth, 1));
    }];
    
    _npsw_filed = [[UITextField alloc]init];
    _npsw_filed.secureTextEntry = YES;
    _npsw_filed.placeholder = @"新密码";
    [contentview addSubview:_npsw_filed];
    [_npsw_filed mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_oldpsw_filed.mas_bottom).offset(1);
        make.left.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(140, 44));
    }];
    
    self.newpsw = _npsw_filed;
    
    UIView *line2 = [[UIView alloc]init];
    line2.backgroundColor = [UIColor colorWithHexString:@"#e6e6e6"];
    [contentview addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_npsw_filed.mas_bottom);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(kWidth, 1));
    }];
    
    _surenpsw_filed = [[UITextField alloc]init];
    _surenpsw_filed.secureTextEntry = YES;
    _surenpsw_filed.placeholder = @"请再次输入新密码";
    [contentview addSubview:_surenpsw_filed];
    [_surenpsw_filed mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_npsw_filed.mas_bottom).offset(1);
        make.left.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(140, 44));
    }];
    
    self.surepsw = _surenpsw_filed;
    
    UIView *line3 = [[UIView alloc]init];
    line3.backgroundColor = [UIColor colorWithHexString:@"#e6e6e6"];
    [contentview addSubview:line3];
    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_surenpsw_filed.mas_bottom);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(kWidth, 1));
    }];

    UIButton *keep = [[UIButton alloc]init];
    keep.tag = 103;
    [keep addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    keep.backgroundColor = CommonButtonBGColor;
    keep.layer.cornerRadius = ButtonH/2;
    [keep setTitle:@"确认修改" forState:UIControlStateNormal];
    [keep setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.pswView addSubview:keep];
    [keep mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line3.mas_bottom).offset(15);
        make.left.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(kWidth - 40, ButtonH));
    }];
    self.commit = keep;
}

- (void)setupPhoneView
{
    
    UIView *phoneview =[[UIView alloc]init];
    phoneview.backgroundColor = RGBColor(247, 247, 247);
    [self.view addSubview:phoneview];
    [phoneview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(kWidth, 45*5+15));
    }];
    
    self.phoneView = phoneview;
    
    UIView *contentview = [[UIView alloc]init];
    contentview.backgroundColor = [UIColor whiteColor];
    [phoneview addSubview:contentview];
    [contentview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(kWidth, 45*4));
    }];
    
    UITextField *oldphone_filed = [[UITextField alloc]init];
    oldphone_filed.keyboardType = UIKeyboardTypeNumberPad;
    oldphone_filed.placeholder = @"请输入旧手机号";
    [contentview addSubview:oldphone_filed];
    [oldphone_filed mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(160, 44));
    }];
    
    self.oldnum = oldphone_filed;
    
    UIView *line1 = [[UIView alloc]init];
    line1.backgroundColor = [UIColor colorWithHexString:@"#e6e6e6"];
    [contentview addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(oldphone_filed.mas_bottom);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(kWidth, 1));
    }];
    
    UITextField *code1_filed = [[UITextField alloc]init];
    code1_filed.keyboardType = UIKeyboardTypeNumberPad;
    code1_filed.placeholder = @"验证码";
    [contentview addSubview:code1_filed];
    [code1_filed mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(oldphone_filed.mas_bottom).offset(1);
        make.left.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(140, 44));
    }];
    
    self.oldcode = code1_filed;
    
    UIButton *send1 = [[UIButton alloc]init];
    [self setSendValues:send1 tag:2001];
    [contentview addSubview:send1];
    [send1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(oldphone_filed.mas_bottom).offset(10);
        make.right.mas_equalTo(-10);
        make.size.mas_equalTo(CGSizeMake(90, 25));
    }];
    
    self.send1Code = send1;
    
    UIView *line2 = [[UIView alloc]init];
    line2.backgroundColor = [UIColor colorWithHexString:@"#e6e6e6"];
    [contentview addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(code1_filed.mas_bottom);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(kWidth, 1));
    }];
    
    UITextField *nphone_filed = [[UITextField alloc]init];
    nphone_filed.keyboardType = UIKeyboardTypeNumberPad;
    nphone_filed.placeholder = @"输入新绑定手机号码";
    [contentview addSubview:nphone_filed];
    [nphone_filed mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(code1_filed.mas_bottom).offset(1);
        make.left.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(160, 44));
    }];
    
    self.newnum = nphone_filed;
    
    UIView *line3 = [[UIView alloc]init];
    line3.backgroundColor = [UIColor colorWithHexString:@"#e6e6e6"];
    [contentview addSubview:line3];
    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nphone_filed.mas_bottom);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(kWidth, 1));
    }];
    
    UITextField *code2_filed = [[UITextField alloc]init];
    code2_filed.keyboardType = UIKeyboardTypeNumberPad;
    code2_filed.placeholder = @"验证码";
    [contentview addSubview:code2_filed];
    [code2_filed mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nphone_filed.mas_bottom).offset(1);
        make.left.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(140, 44));
    }];
    
    self.newcode = code2_filed;
    
    UIButton *send2 = [[UIButton alloc]init];
    [self setSendValues:send2 tag:2002];
    [contentview addSubview:send2];
    [send2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nphone_filed.mas_bottom).offset(10);
        make.right.mas_equalTo(-10);
        make.size.mas_equalTo(CGSizeMake(90, 25));
    }];
    
    self.send2Code = send2;
    UIView *line4 = [[UIView alloc]init];
    line4.backgroundColor = [UIColor colorWithHexString:@"#e6e6e6"];
    [contentview addSubview:line4];
    [line4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(code2_filed.mas_bottom);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(kWidth, 1));
    }];
    
    UIButton *keep = [[UIButton alloc]init];
    keep.tag = 104;
    [keep addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    keep.backgroundColor = CommonButtonBGColor;
    keep.layer.cornerRadius = ButtonH/2;
    [keep setTitle:@"确认修改" forState:UIControlStateNormal];
    [keep setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [phoneview addSubview:keep];
    [keep mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line4.mas_bottom).offset(15);
        make.left.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(kWidth - 40, ButtonH));
    }];
    self.commit2 = keep;
    
}

- (void)setSendValues:(UIButton *)sender tag:(NSInteger)tag
{
    sender.layer.masksToBounds = YES;
    sender.layer.cornerRadius = 5;
    sender.tag = tag;
    sender.titleLabel.font = Font16;
    [sender setTitle:@"发送" forState:UIControlStateNormal];
    [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [sender setBackgroundImage:[UIImage imageWithColor:RGBColor(213, 213, 213)]forState:UIControlStateNormal];
    [sender setBackgroundImage:[UIImage imageWithColor:RGBColor(146, 212, 96)] forState:UIControlStateNormal];
    [sender addTarget:self action:@selector(sendCode:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)statueClick:(UIButton *)sender
{

    switch (sender.tag) {
        case 1001:
        {
            sender.selected = !sender.selected;
            _oldpsw_filed.secureTextEntry = sender.selected;
        }
            break;
        case 1002:
        {
            sender.selected = !sender.selected;
            _npsw_filed.secureTextEntry = sender.selected;
            
        }
            break;
        case 1003:
        {
            sender.selected = !sender.selected;
            _surenpsw_filed.secureTextEntry = sender.selected;
        }
            break;
        default:
            break;
    }
}

- (void)sendCode:(UIButton *)sender
{
//    [self.send1Code setTitle:@"sdasdas" forState:UIControlStateNormal];
    if (sender.tag == 2001) {
        
        if (![ValidateHelper validateMobile:_oldnum.text]) {
            [self.hudManager showErrorSVHudWithTitle:@"手机号不正确" hideAfterDelay:1.0f];
            return;
        }
        
        //旧手机号获取验证码
        NSString * url = getCode;
        NSMutableDictionary * paramDict = [NSMutableDictionary dictionary];
        paramDict[@"phone"] = _oldnum.text;
        paramDict[@"time"] = self.getcurrentTime;
        paramDict[@"flag"] = @"changemobile";
        
        [HttpsTools POST:url parameter:paramDict progress:^(NSProgress *downloadProgress) {
        } succeed:^(id responseObject) {
            
            NSLog(@"旧手机号获取验证码%@",responseObject);
            NSInteger code = [responseObject[@"code"] integerValue];
            NSString * msg = responseObject[@"msg"];
            if (code == 1) {
                

                
            }  else
            {
                [self.hudManager showErrorSVHudWithTitle:msg hideAfterDelay:1.0];
            }
            
            
        } failure:^(NSError *error) {
            
             [self.hudManager showErrorSVHudWithTitle:@"获取验证码失败" hideAfterDelay:1.0];
            
        }];
        
        sender.enabled = NO;
        sendtag = sender.tag;
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateOldBtnTitle) userInfo:nil repeats:YES];
        self.oldTimer = timer;
        
        
    }
    if (sender.tag == 2002) {
        
        if (![ValidateHelper validateMobile:_newnum.text]) {
            [self.hudManager showErrorSVHudWithTitle:@"手机号不正确" hideAfterDelay:1.0f];
            return;
        }
        //新手机号获取验证码
        NSString * url = getCode;
        NSMutableDictionary * paramDict = [NSMutableDictionary dictionary];
        paramDict[@"phone"] = _newnum.text;
        paramDict[@"time"] = self.getcurrentTime;
        paramDict[@"flag"] = @"changemobile";

        [HttpsTools POST:url parameter:paramDict progress:^(NSProgress *downloadProgress) {
        } succeed:^(id responseObject) {
            
            NSLog(@"新手机号获取验证码%@",responseObject);
            NSInteger code = [responseObject[@"code"] integerValue];
            NSString * msg = responseObject[@"msg"];
            if (code == 1) {
                
                
                
            }  else
            {
                [self.hudManager showErrorSVHudWithTitle:msg hideAfterDelay:1.0];
            }
            
            
        } failure:^(NSError *error) {
            
            [self.hudManager showErrorSVHudWithTitle:@"获取验证码失败" hideAfterDelay:1.0];
            
        }];
        
        
        sender.enabled = NO;
        sendtag = sender.tag;
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateNewBtnTitle) userInfo:nil repeats:YES];
        self.newwTimer = timer;
        
    }
    
    


    
}
- (void)updateOldBtnTitle {
    NSString *titlestr = [NSString stringWithFormat:@"已发送(%ds)",_oldSecond];
    [_send1Code setTitle:titlestr forState:UIControlStateNormal];
    _oldSecond --;
    if (_oldSecond == -1) {
        _oldSecond = 60;
        [_send1Code setTitle:@"发送" forState:UIControlStateNormal];
        _send1Code.enabled = YES;
        [_oldTimer invalidate];
    }
    
}
- (void)updateNewBtnTitle {
    NSString *titlestr = [NSString stringWithFormat:@"已发送(%ds)",_newSecond];
    [_send2Code setTitle:titlestr forState:UIControlStateNormal];
    _newSecond --;
    if (_newSecond == -1) {
        _newSecond = 60;
        [_send2Code setTitle:@"发送" forState:UIControlStateNormal];
        _send2Code.enabled = YES;
        [_newwTimer invalidate];
    }
    
}


- (void)click:(UIButton *)sender
{
    
    if (sender.tag == 103) {
        //修改密码
        
        [_oldpsw resignFirstResponder];
        [_newpsw resignFirstResponder];
        [_surepsw resignFirstResponder];
        
        if (![ValidateHelper validatePassword:_oldpsw.text] || ![ValidateHelper validatePassword:_newpsw.text]) {
            [self.hudManager showErrorSVHudWithTitle:@"请输入6~20位密码" hideAfterDelay:2.0];
            
            return;
        }
        
        if (![_newpsw.text isEqualToString:_surepsw.text]) {
            [self.hudManager showErrorSVHudWithTitle:@"两次输入密码不一样" hideAfterDelay:2.0];
            return;
        }
        
        
        NSString * url = editPassword;
        
        NSMutableDictionary * paramDict = [NSMutableDictionary dictionary];
        paramDict[@"uid"] = kUid;
        NSString * timeString = self.getcurrentTime;
        paramDict[@"time"] = timeString;
        paramDict[@"sign"] = [HttpsTools getSignWithIdentify:@"/editPassword" time:timeString];
//        paramDict[@"sign"] = [HttpParamManager getSignWithIdentify:@"/editPassword" time:timeString addExtraStr:_oldpsw.text];
        paramDict[@"oPwd"] = _oldpsw.text;
        paramDict[@"nPwd"] = _newpsw.text;
        
      

        [HttpsTools POST:url parameter:paramDict progress:^(NSProgress *downloadProgress) {
        } succeed:^(id responseObject) {
            
            NSLog(@"修改密码  %@",responseObject);
            NSInteger code = [responseObject[@"code"] integerValue];
           // NSString * msg = responseObject[@"msg"];
            if (code == 1) {
                
                
                [self.hudManager showSuccessKVNHudWithTitle:@"密码修改成功,请重新登录" hideAfterDelay:1.0f];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    //确定退出
                    
                    LoginGuideController *login = [[LoginGuideController alloc]init];
                    
                    UINavigationController *root = [[UINavigationController alloc]initWithRootViewController:login];
                    
                    [root.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg"] forBarMetrics:UIBarMetricsDefault];
                    
                    root.navigationBar.shadowImage =[UIImage imageNamed:@"nav_bg"];
                    
                    root.navigationBar. titleTextAttributes = NavTitleTextAttributes;
                    
                    [self presentViewController:root animated:YES completion:nil];
                });
                
            }else {
                
                CLAlertView * alertView = [[CLAlertView alloc] initWithAlertViewWithTitle:@"密码错误" text:@"对不起您输入的密码有误，请确认后重新尝试" DefauleBtn:nil cancelBtn:@"朕知道了" defaultBtnBlock:^(UIButton *defaultBtn) {
                    
                } cancelBtnBlock:nil];
                
                [alertView show];
            }
            
            
        } failure:^(NSError *error) {
            
            [self.hudManager showErrorSVHudWithTitle:@"修改密码失败" hideAfterDelay:1.0f];
            
            
        }];
    }
    
    if (sender.tag == 104) {
        //修改手机号
        
        if (![ValidateHelper validateMobile:_oldnum.text]) {
            [self.hudManager showErrorSVHudWithTitle:@"手机号不正确" hideAfterDelay:1.0f];
            return;
        }
        if (![ValidateHelper validateMobile:_newnum.text]) {
            [self.hudManager showErrorSVHudWithTitle:@"手机号不正确" hideAfterDelay:1.0f];
            return;
        }
        
        NSString *url = editPhone;
        NSString *time = [HttpParamManager getTime];
        NSMutableDictionary *paramDict = [NSMutableDictionary dictionary];
        paramDict[@"uid"] = kUid;
        paramDict[@"time"] = time;
        paramDict[@"sign"] = [HttpParamManager getSignWithIdentify:@"/editPhone" time:time addExtraStr:_oldnum.text];
        paramDict[@"oPhone"] = _oldnum.text;
        paramDict[@"nPhone"] = _newnum.text;
        paramDict[@"oCode"] = _oldcode.text;
        paramDict[@"nCode"] =  _newcode.text;
        
        [HttpsTools POST:url parameter:paramDict progress:^(NSProgress *downloadProgress) {
        } succeed:^(id responseObject) {
            NSLog(@"修改手机号%@",responseObject);
            NSInteger code = [responseObject[@"code"] integerValue];
            NSString * msg = responseObject[@"msg"];
            if (code ==1) {
                
                [self.hudManager showSuccessKVNHudWithTitle:@"手机号码修改成功" hideAfterDelay:1.0f];
                
            }else {
                
                [self.hudManager showErrorSVHudWithTitle:msg hideAfterDelay:1.0];
            }
            
            
        } failure:^(NSError *error) {
            
            [self.hudManager showErrorSVHudWithTitle:@"修改手机号失败" hideAfterDelay:1.0];
            
        }];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    if (self.oldTimer) {
        [self.oldTimer invalidate];
    }if (self.newwTimer) {
        [self.oldTimer invalidate];
    }
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
