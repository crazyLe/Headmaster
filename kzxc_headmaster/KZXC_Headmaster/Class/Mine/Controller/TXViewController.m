//
//  TXViewController.m
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/7/22.
//  Copyright © 2016年 cqingw. All rights reserved.
//
#define jianju 20
#import "TXViewController.h"
#import "NSString+Size.h"
#import "ZHPickView.h"
#import "LoginViewController.h"

@interface TXViewController ()<ZHPickViewDelegate,UIAlertViewDelegate>

{
    NSArray *banks;
    NSArray *banknames;
    NSString *bankid;
}

@property(weak,nonatomic)UIScrollView *scroll;

@property(strong,nonatomic)UILabel *yue_value;

@property(strong,nonatomic)UITextField *doue_filed;
@property(strong,nonatomic)UITextField *yinhang_filed;
@property(strong,nonatomic)UITextField *kahao_filed;
@property(strong,nonatomic)UITextField *name_filed;

@property(strong,nonatomic)UILabel *tips_one;
@property(strong,nonatomic)UILabel *tips_two;
@property(strong,nonatomic)UILabel *tips_thi;
@property(strong,nonatomic)UILabel *tips_four;
@property(strong,nonatomic)UILabel *tips_five;
@property(strong,nonatomic)UILabel *tips_six;

@property(strong,nonatomic)ZHPickView *zhpick;

@end

@implementation TXViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"提现";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIScrollView *locscroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight - 64)];
    locscroll.backgroundColor = [UIColor whiteColor];
    locscroll.userInteractionEnabled = YES;
    self.scroll = locscroll;
    locscroll.contentSize = CGSizeMake(kWidth, 540+45+40);
    [self.view addSubview:locscroll];
    //为了让键盘下去加此点击手势
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyBoardDownTap)];
    [self.scroll addGestureRecognizer:tap];
    
    UILabel *zd_label = [[UILabel alloc]init];
    [self setlabelValues:zd_label andtitle:TXKeyArray[0]];
    [self.scroll addSubview:zd_label];
    [zd_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(35);
        make.left.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(70, 20));
    }];
    
    UILabel *kt_label = [[UILabel alloc]init];
    [self setlabelValues:kt_label andtitle:TXKeyArray[1]];
    [self.scroll addSubview:kt_label];
    [kt_label mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.equalTo(zd_label.mas_bottom).offset(20);
        make.left.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(70, 20));
    }];
    
    UILabel *tx_label = [[UILabel alloc]init];
    [self setlabelValues:tx_label andtitle:TXKeyArray[2]];
    [self.scroll addSubview:tx_label];
    [tx_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(kt_label.mas_bottom).offset(20);
        make.left.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(70, 20));
    }];
    
    UILabel *yh_label = [[UILabel alloc]init];
    [self setlabelValues:yh_label andtitle:TXKeyArray[3]];
    [self.scroll addSubview:yh_label];
    [yh_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tx_label.mas_bottom).offset(20);
        make.left.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(70, 20));
    }];
    
    UILabel *kh_label = [[UILabel alloc]init];
    [self setlabelValues:kh_label andtitle:TXKeyArray[4]];
    [self.scroll addSubview:kh_label];
    [kh_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(yh_label.mas_bottom).offset(20);
        make.left.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(70, 20));
    }];
    
    UILabel *xm_label = [[UILabel alloc]init];
    [self setlabelValues:xm_label andtitle:TXKeyArray[5]];
    [self.scroll addSubview:xm_label];
    [xm_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(kh_label.mas_bottom).offset(20);
        make.left.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(70, 20));
    }];
    
    
    
    CGSize rect = [NSString string:_dounum sizeWithFont:Font16 maxSize:CGSizeMake(kWidth, 15)];
    
    _yue_value = [[UILabel alloc]init];
    _yue_value.textColor = ColorThree;
    _yue_value.text = [NSString stringWithFormat:@"%d",[_dounum intValue]];
    _yue_value.font = [UIFont boldSystemFontOfSize:16];
    [self.scroll addSubview:_yue_value];
    [_yue_value mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(35);
        make.left.mas_equalTo(80+20);
        make.size.mas_equalTo(CGSizeMake(rect.width +10, 20));
    }];
    
    UIImageView *dou_img = [[UIImageView alloc]init];
    dou_img.image = [UIImage imageNamed:@"recuit_douzi"];
    [self.scroll addSubview:dou_img];
    [dou_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(35);
        make.left.equalTo(_yue_value.mas_right).offset(5);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    UILabel *jine_value = [[UILabel alloc]init];
    jine_value.textColor = ColorThree;
    jine_value.text = [NSString stringWithFormat:@"%d元",([_dounum intValue]/10)];
    jine_value.font = Font16;
    [self.scroll addSubview:jine_value];
    [jine_value mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_yue_value.mas_bottom).offset(jianju);
        make.left.mas_equalTo(80+20);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
    
    
    _doue_filed = [[UITextField alloc]init];
    _doue_filed.keyboardType = UIKeyboardTypeNumberPad;
    [self setTextFiledValues:_doue_filed andTitle:TXPlaceholderArray[0]];
    [self.scroll addSubview:_doue_filed];
    [_doue_filed mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(jine_value.mas_bottom).offset(15);
        make.left.mas_equalTo(80+20);
        make.size.mas_equalTo(CGSizeMake(kWidth - 40 - 80, 30));
    }];

    _yinhang_filed = [[UITextField alloc]init];
    _yinhang_filed.enabled = NO;
    [self setTextFiledValues:_yinhang_filed andTitle:TXPlaceholderArray[1]];
   
    [self.scroll addSubview:_yinhang_filed];
    [_yinhang_filed mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_doue_filed.mas_bottom).offset(10);
        make.left.mas_equalTo(80+20);
        make.size.mas_equalTo(CGSizeMake(kWidth - 40 - 80 - 30, 30));
    }];

    UIButton *xiala = [[UIButton alloc]init];
    xiala.tag = 101;
    [xiala addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [xiala setImage:[UIImage imageNamed:@"xiala" ] forState:UIControlStateNormal];
    xiala.layer.borderColor = [UIColor colorWithHexString:@"#dfdfdf"].CGColor;
    xiala.layer.borderWidth = 1;
    [self.scroll addSubview:xiala];
    [xiala mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_doue_filed.mas_bottom).offset(10);
        make.left.equalTo(_yinhang_filed.mas_right);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    _kahao_filed = [[UITextField alloc]init];
    _kahao_filed.keyboardType = UIKeyboardTypeNumberPad;
    [self setTextFiledValues:_kahao_filed andTitle:TXPlaceholderArray[2]];
   
    [self.scroll addSubview:_kahao_filed];
    [_kahao_filed mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_yinhang_filed.mas_bottom).offset(10);
        make.left.mas_equalTo(80+20);
        make.size.mas_equalTo(CGSizeMake(kWidth - 40 - 80, 30));
    }];

    _name_filed = [[UITextField alloc]init];
    [self setTextFiledValues:_name_filed andTitle:TXPlaceholderArray[3]];
    [self.scroll addSubview:_name_filed];
    [_name_filed mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_kahao_filed.mas_bottom).offset(10);
        make.left.mas_equalTo(80+20);
        make.size.mas_equalTo(CGSizeMake(kWidth - 40 - 80, 30));
    }];
    
    UIButton *keep = [[UIButton alloc]init];
    keep.tag = 102;
    [keep addTarget:self action:@selector(sureclick) forControlEvents:UIControlEventTouchUpInside];
    keep.backgroundColor = CommonButtonBGColor;
    keep.layer.cornerRadius = 5;
    [keep setTitle:@"确认提现" forState:UIControlStateNormal];
    [keep setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.scroll addSubview:keep];
    
    [keep mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_name_filed.mas_bottom).offset(20);
        make.left.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(kWidth - 40, ButtonH));
    }];
    
    UIView *tips_view = [[UIView alloc]init];
    tips_view.backgroundColor = [UIColor colorWithHexString:@"#fafafa"];
    [self.scroll addSubview:tips_view];
    
    [tips_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(keep.mas_bottom).offset(25);
        make.left.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(kWidth - 40, 230));
    }];
    
    UILabel *tips_title = [[UILabel alloc]init];
    tips_title.text = @"提现说明:";
    tips_title.textAlignment = NSTextAlignmentLeft;
    tips_title.textColor = [UIColor colorWithHexString:@"#666666"];
    tips_title.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
    [tips_view addSubview:tips_title];
    [tips_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.left.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(80, 20));
    }];
    
    _tips_one = [[UILabel alloc]init];
    [self setTipsValues:_tips_one andtitle:TXTipsArray[0] andtype:0];
    [tips_view addSubview:_tips_one];
    [_tips_one mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tips_title.mas_bottom).offset(10);
        make.left.mas_equalTo(15);

    }];
    
    _tips_two = [[UILabel alloc]init];
    [self setTipsValues:_tips_two andtitle:TXTipsArray[1] andtype:0];
    [tips_view addSubview:_tips_two];
    [_tips_two mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tips_one.mas_bottom).offset(10);
        make.left.mas_equalTo(15);

    }];

    _tips_thi = [[UILabel alloc]init];
    [self setTipsValues:_tips_thi andtitle:TXTipsArray[2] andtype:0];
    [tips_view addSubview:_tips_thi];
    [_tips_thi mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tips_two.mas_bottom).offset(10);
        make.left.mas_equalTo(15);

    }];
    
    _tips_four = [[UILabel alloc]init];
    _tips_four.numberOfLines = 2;
    [self setTipsValues:_tips_four andtitle:TXTipsArray[3] andtype:1];
    [tips_view addSubview:_tips_four];
    [_tips_four mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tips_thi.mas_bottom).offset(10);
        make.left.mas_equalTo(15);

    }];
    
    _tips_five = [[UILabel alloc]init];
    [self setTipsValues:_tips_five andtitle:TXTipsArray[4] andtype:0];
    [tips_view addSubview:_tips_five];
    [_tips_five mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tips_four.mas_bottom).offset(10);
        make.left.mas_equalTo(15);

    }];
    
    _tips_six = [[UILabel alloc]init];
    [self setTipsValues:_tips_six andtitle:TXTipsArray[5] andtype:0];
    [tips_view addSubview:_tips_six];
    [_tips_six mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tips_five.mas_bottom).offset(10);
        make.left.mas_equalTo(15);

    }];
    
    banknames = [curDefaults objectForKey:@"banknames"];

    if (0 == banknames.count) {
        [self loadBankData];
    }
}
- (void)keyBoardDownTap {
    
    [self.scroll endEditing:YES];
}
- (void)setlabelValues:(UILabel *)label andtitle:(NSString *)title
{
    label.textColor = ColorNine;
    
    label.text = title;
    
    label.font = Font16;
}

- (void)setTextFiledValues:(UITextField *)textfiled andTitle:(NSString *)title
{
    textfiled.placeholder = title;
    textfiled.font = Font16;
    textfiled.textColor = ColorThree;
    textfiled.layer.borderColor = [UIColor colorWithHexString:@"#d1d1d1"].CGColor;
    textfiled.layer.borderWidth = 1;
    
    //设置文字内容显示位置
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 30)];
    textfiled.leftView = paddingView;
    textfiled.leftViewMode = UITextFieldViewModeAlways;

}
- (void)setTipsValues:(UILabel *)label andtitle:(NSString *)title andtype:(int)type
{
    label.text = title;
    if (0 != type) {
        label.numberOfLines = 2;
    }
    label.textAlignment = NSTextAlignmentLeft;
    label.textColor = [UIColor colorWithHexString:@"#666666"];
    label.font = Font14;
}

- (void)click:(UIButton *)sender
{
//    NSLog(@"click ...");
    [self.view endEditing:YES];
    
    _zhpick =  [[ZHPickView alloc]initPickviewWithArray:banknames isHaveNavControler:NO ];
    
    _zhpick.delegate = self;
    [_zhpick show];
}


- (void)loadBankData
{
    NSMutableDictionary * paramDict = [NSMutableDictionary dictionary];
    
    paramDict[@"uid"] = kUid;
    NSString * timeString = self.getcurrentTime;
    paramDict[@"time"] = timeString;
    paramDict[@"sign"] = [HttpsTools getSignWithIdentify:@"/bank" time:timeString];
    paramDict[@"deviceInfo"] = deviceInfo;
    
    [HttpsTools kPOST:getBankUrl parameter:paramDict progress:^(NSProgress *downloadProgress) {
    } succeed:^(id backdata, int code, NSString *msg) {
        
        NSLog(@"%@",backdata);
        if (code == 1) {
            
            NSArray *temp = backdata[@"Banks"];
            NSMutableArray *names = [NSMutableArray array];
            for (int i = 0; i<temp.count; i++) {
                NSDictionary *dict = temp[i];
                [names addObject:dict[@"name"]];
            }
            
            [curDefaults setObject:names forKey:@"banknames"];
            [curDefaults setObject:temp forKey:@"banks"];
            
            
            
        }else {
            
        }
    } failure:^(NSError *error) {
        
        [MBProgressHUD showError:@"加载失败"];
        
    }];
    
    
}

- (void)sureclick
{
    //判断是否登录
    if ([kUid isEqualToString:@"0"]){
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"您尚未登录,无法进行此操作!" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去登录", nil];
        alertView.tag = 10000;
        [alertView show];
        
        return;
    }
    if (![kAuthState isEqualToString:@"1"]) {
        
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"您尚未通过实名认证,无法进行此操作!" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alertView show];
        
        return;
    }
    
    [self loadData];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 10000) {
        
        if (buttonIndex == 1) {
            //去登陆
            LoginViewController * vc = [[LoginViewController alloc] init];
            
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}
-(void) loadData
{
    
    NSString *text1 = _doue_filed.text;
    NSString *text2 = _kahao_filed.text;
    NSString *text3 = _yinhang_filed.text;
    NSString *text4 = _name_filed.text;
    
    if (text1.length == 0) {
        [MBProgressHUD showError:@"请输入提现金额"];
        return;
    }
    
    
    if (([text1 intValue] % 100)) {
        [MBProgressHUD showError:@"提现金额必须是100的整数倍"];
        return;
    }
    
    if ([text1 intValue] > [_dounum intValue]) {
        [MBProgressHUD showError:@"提现金额不能大于剩余豆数"];
        return;
    }
    
    if (text3.length == 0) {
        [MBProgressHUD showError:@"请选择正确的银行"];
        return;
    }
    
    if (text2.length < 10) {
        [MBProgressHUD showError:@"请输入正确的银行卡号"];
        return;
    }
    if (![ValidateHelper validateCardNo:text2]) {
        [MBProgressHUD showError:@"请输入正确的银行卡号"];
        return;
    }
   
    if (text4.length<2) {
        [MBProgressHUD showError:@"请输入正确的姓名"];
        return;
    }
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
    param[@"uid"] = kUid;
    
    param[@"totalBeans"] =@([text1 intValue]*10);
//    开户行
    param[@"bankAccount"] = text3;
    
    param[@"bankId"] = bankid;
    param[@"bankCard"] = text2;
    param[@"bankTrueName"] = text4;
    
    param[@"deviceInfo"] = deviceInfo;
    
    param[@"time"] = self.getcurrentTime;
    param[@"sign"] = [HttpsTools getSignWithIdentify:@"/getCash" time:self.getcurrentTime];
    
    NSLog(@"%@",param);
    
    [self.hudManager showNormalStateSVHudWithTitle:@"加载中..." hideAfterDelay:5.0];
    
    [HttpsTools kPOST:tixianUrl parameter:param progress:^(NSProgress *downloadProgress) {
    } succeed:^(id backdata, int code, NSString *msg) {
        NSLog(@"%@,%d,%@",backdata,code,msg);
        if (1 == code) {
            [self.hudManager showSuccessSVHudWithTitle:@"提现申请已提交" hideAfterDelay:1.0 animaton:YES];
            _yue_value.text = [NSString stringWithFormat:@"%d",([_dounum intValue] - [text1 intValue])];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString
{
    _yinhang_filed.text = resultString;

    NSArray *tempbanks = [curDefaults objectForKey:@"banks"];
    for (NSDictionary *dict  in tempbanks) {
        if ([dict[@"name"] isEqualToString:resultString]) {
            bankid = dict[@"id"];
        }
        break;
    }
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [_zhpick removeFromSuperview];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.scroll endEditing:YES];
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
