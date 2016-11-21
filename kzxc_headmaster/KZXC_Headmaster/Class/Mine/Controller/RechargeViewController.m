//
//  RechargeViewController.m
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/7/21.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import "RechargeViewController.h"
#import "ZHPickView.h"
#import "PayTools.h"
#import "WXApi.h"

@interface RechargeViewController ()<UITextFieldDelegate,UIActionSheetDelegate>

@property(weak,nonatomic)UIScrollView *scroll;

@property(weak,nonatomic)UILabel *douNum;
@property(weak,nonatomic)UITextField *douinput;

@property(weak,nonatomic)UILabel *totlalDou;

@end

@implementation RechargeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"充值";
    [self setupNav];
    
    UIScrollView *locscroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight - 64)];
    locscroll.backgroundColor = [UIColor whiteColor];
    locscroll.userInteractionEnabled = YES;
    self.scroll = locscroll;
    locscroll.contentSize = CGSizeMake(kWidth, 490);
    [self.view addSubview:locscroll];
    
    [self setupNav];
    
    [self setupToView];
    
    [NOTIFICATION_CENTER addObserver:self selector:@selector(updateDou) name:@"UPDATEDOU" object:nil];
    
    [self loadData];
}

- (void)updateDou
{
     [self loadData];
}

-(void) loadData
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"deviceInfo"] = deviceInfo;
    param[@"uid"] = kUid;
    param[@"time"] = self.getcurrentTime;
    param[@"sign"] = [HttpsTools getSignWithIdentify:@"/Mypurse/Purse" time:self.getcurrentTime];
    [HttpsTools kPOST:myPurseUrl parameter:param progress:^(NSProgress *downloadProgress) {
    } succeed:^(id backdata, int code, NSString *msg) {
        
        NSLog(@"%@,%d",backdata,code);
        if (1 == code) {
            NSString *str1 = backdata[@"beans"];
            str1 = (0 == str1.length)?@"0":str1;
            self.totlalDou.text = str1;
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)setupNav
{
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    
    [navigationBar setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault]; //此处使底部线条颜色为红色
    
    [navigationBar setShadowImage:[UIImage imageWithColor:NavBackColor]];
}

- (void)setupToView
{
    UIView *bgview = [[UIView alloc]init];
    bgview.backgroundColor = NavBackColor;
    [self.scroll addSubview:bgview];
    
    [bgview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(kWidth, 120));
    }];

    UILabel *dou_num = [[UILabel alloc]init];
   
    dou_num.text = [NSString stringWithFormat:@"%d", [kDounum intValue]];
    dou_num.textAlignment = NSTextAlignmentCenter;
    dou_num.textColor = [UIColor colorWithHexString:@"#ffe332"];
    dou_num.font = [UIFont systemFontOfSize:40.0];
    [bgview addSubview:dou_num];
    [dou_num mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(25);
        make.left.mas_equalTo((kWidth -240)/2);
        make.size.mas_equalTo(CGSizeMake(240, 45));
    }];
    self.totlalDou = dou_num;
    
    UILabel *dou_name = [[UILabel alloc]init];
    dou_name.text = @"赚豆余额";
    dou_name.textAlignment = NSTextAlignmentCenter;
    dou_name.textColor = [UIColor whiteColor];
    dou_name.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    [bgview addSubview:dou_name];
    [dou_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(dou_num.mas_bottom).offset(10);
        make.left.mas_equalTo((kWidth - 80)/2);
        make.size.mas_equalTo(CGSizeMake(80, 20));
    }];
    
    NSString *dou_str = @"充值赚豆(1元＝10赚豆)";
    
    NSMutableAttributedString *dou_attr = [[NSMutableAttributedString alloc]initWithString:dou_str];
    
    [dou_attr addAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIColor colorWithHexString:@"#666666"],NSForegroundColorAttributeName,[UIFont fontWithName:@"Helvetica-Bold" size:17],NSFontAttributeName, nil] range:NSMakeRange(0, [dou_str length])];
    
    [dou_attr addAttributes:[NSDictionary dictionaryWithObjectsAndKeys: RGBColor(146, 212, 96),NSForegroundColorAttributeName,fifteenFont,NSFontAttributeName, nil] range:NSMakeRange(4, dou_str.length - 4)];
    
    UILabel *dou_title = [[UILabel alloc]init];
    dou_title.attributedText = dou_attr;
    dou_title.textAlignment = NSTextAlignmentLeft;

    [bgview addSubview:dou_title];
    [dou_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgview.mas_bottom).offset(30);
        make.left.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(170, 20));
    }];
    
    UITextField *dou_input = [[UITextField alloc]init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(valuechange) name:UITextFieldTextDidChangeNotification object:nil];
//    dou_input.delegate = self;
    //设置文字内容显示位置
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 30)];
    dou_input.leftView = paddingView;
    dou_input.leftViewMode = UITextFieldViewModeAlways;
    
    dou_input.keyboardType = UIKeyboardTypeNumberPad;
    dou_input.delegate = self;
    dou_input.placeholder = @"请输入充值金额";
    dou_input.font = Font16;
    
    dou_input.layer.borderColor = [UIColor colorWithHexString:@"#dfdfdf"].CGColor;
    dou_input.layer.borderWidth = 1;
    dou_input.layer.cornerRadius = 3;
    
    dou_input.textColor = [UIColor colorWithHexString:@"#333333"];
    [self.scroll addSubview:dou_input];
    [dou_input mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(dou_title.mas_bottom).offset(15);
        make.left.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(160, 45));
    }];
    
    self.douinput = dou_input;
    
    
    UILabel *dou_after = [[UILabel alloc]init];
    dou_after.text = [NSString stringWithFormat:@"%d赚豆", [kDounum intValue]];
    dou_after.textAlignment = NSTextAlignmentLeft;
    dou_after.textColor = [UIColor colorWithHexString:@"#666666"];
    dou_after.font = [UIFont systemFontOfSize:16.0];
    [bgview addSubview:dou_after];
    [dou_after mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(dou_title.mas_bottom).offset(28);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.size.mas_equalTo(CGSizeMake(80, 20));
    }];
    
    self.douNum = dou_after;
    
    UIImageView *dou_img = [[UIImageView alloc]init];
    dou_img.image = [UIImage imageNamed:@"recuit_douzi"];
    [bgview addSubview:dou_img];
    [dou_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(dou_title.mas_bottom).offset(28);
        make.right.equalTo(dou_after.mas_left);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    UIButton *keep = [[UIButton alloc]init];
    keep.tag = 101;
    [keep addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    keep.backgroundColor = CommonButtonBGColor;
    keep.layer.cornerRadius = ButtonH/2;
    [keep setTitle:@"确认充值" forState:UIControlStateNormal];
    [keep setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.scroll addSubview:keep];
    
    [keep mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(dou_input.mas_bottom).offset(15);
        make.left.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(kWidth - 40, ButtonH));
    }];
    
    
    UIView *tips_view = [[UIView alloc]init];
    tips_view.backgroundColor = [UIColor colorWithHexString:@"#fafafa"];
    [self.scroll addSubview:tips_view];
    
    [tips_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(keep.mas_bottom).offset(25);
        make.left.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(kWidth - 40, 155));
    }];
    
    UILabel *tips_title = [[UILabel alloc]init];
    tips_title.text = @"充值说明:";
    tips_title.textAlignment = NSTextAlignmentLeft;
    tips_title.textColor = [UIColor colorWithHexString:@"#666666"];
    tips_title.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
    [tips_view addSubview:tips_title];
    [tips_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.left.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(80, 20));
    }];
    
    UILabel *tips_one = [[UILabel alloc]init];
    tips_one.text = tipsOne;
    tips_one.textAlignment = NSTextAlignmentLeft;
    tips_one.textColor = ColorSix;
    tips_one.font = fourteenFont;
    [tips_view addSubview:tips_one];
    [tips_one mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tips_title.mas_bottom).offset(10);
        make.left.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(kWidth - 100, 15));
    }];
    
    UILabel *tips_two = [[UILabel alloc]init];
    tips_two.text = tipsTwo;
    tips_two.textAlignment = NSTextAlignmentLeft;
    tips_two.textColor = ColorSix;
    tips_two.font = fourteenFont;
    [tips_view addSubview:tips_two];
    [tips_two mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tips_one.mas_bottom).offset(10);
        make.left.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(kWidth - 100, 15));
    }];
    
    UILabel *tips_thi = [[UILabel alloc]init];
    tips_thi.text = tipsThi;
    tips_thi.numberOfLines = 2;
    tips_thi.textAlignment = NSTextAlignmentLeft;
    tips_thi.textColor = ColorSix;
    tips_thi.font = fourteenFont;
    tips_thi.numberOfLines = 0;
    [tips_view addSubview:tips_thi];
    [tips_thi mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tips_two.mas_bottom).offset(10);
        make.left.mas_equalTo(15);
        make.right.offset(-15);
        
    }];
}

- (void)valuechange
{
    int dou = [self.douinput.text intValue];
    _douNum.text =  [NSString stringWithFormat:@"%d赚豆", dou*10];
}

- (void)click:(UIButton *)sender
{
    [self.view endEditing:YES];
    if(0 == [_douinput.text intValue] || [_douinput.text hasPrefix:@"0"])
    {
        [self.hudManager showErrorSVHudWithTitle:@"请输入正确的充值金额" hideAfterDelay:1.0];
        return;
    }
    
    UIActionSheet *action = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"支付宝",@"微信", nil];
    [action showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
        {
            [self getPaydata:@"1"];
        }
            break;
        case 1:
        {
            [self getPaydata:@"3"];
        }
            break;
            
        default:
            break;
    }
}

//（3微信，1支付宝，2银联）
- (void)getPaydata:(NSString *)paytype
{
    NSString *timestr = [self getcurrentTime];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"uid"] = kUid;
    param[@"time"] = timestr;
    param[@"sign"] = [HttpsTools getSignWithIdentify:@"/topUpBeans" time:timestr];
    
//    param[@"totalMoney"] = @(0.1);
//    param[@"totalBeans"] = @(1);
    
    param[@"totalMoney"] = @([_douinput.text intValue]);
    param[@"totalBeans"] = @([_douinput.text intValue]*10);
    param[@"payType"] = paytype;

    [HttpsTools kPOST:chongzhiUrl parameter:param progress:^(NSProgress *downloadProgress) {
        
    } succeed:^(id backdata, int code, NSString *msg) {
        NSLog(@"%@,%d",backdata,code);
        if (1 == code) {
            NSString *content = backdata[@"content"];
            int payType = [backdata[@"payType"] intValue];
            
            switch (payType) {
                case 1://支付宝
                {
                    [self alipayWithcontent:content];
                }
                    break;
                    
                case 3://微信
                {
                    NSData *decodeData = [[NSData alloc] initWithBase64EncodedString:content options:0];
                    NSDictionary *decodeDic = [NSJSONSerialization JSONObjectWithData:decodeData options:NSJSONReadingMutableContainers error:nil];
                    [self weipaywithcontent:decodeDic];
                    
                }
                    break;
                    
                default:
                    break;
            }
        }
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark 微信支付方法
- (void)weipaywithcontent:(NSDictionary *)decodeDic
{
    PayReq *payReq = [[PayReq alloc] init];
//    payReq.openID              = [decodeDic objectForKey:@"appId"];
    payReq.partnerId           = [decodeDic objectForKey:@"partnerId"];
    payReq.prepayId            = [decodeDic objectForKey:@"prepayId"];
    payReq.nonceStr            = [decodeDic objectForKey:@"nonceStr"];
    payReq.timeStamp           = [[decodeDic objectForKey:@"timeStamp"] unsignedIntValue];
    payReq.package             = [decodeDic objectForKey:@"packageValue"];
    payReq.sign                = [decodeDic objectForKey:@"sign"];
    //发送请求到微信，等待微信返回onResp
    [WXApi sendReq:payReq];
}

- (void)alipayWithcontent:(NSString *)content
{
    [[AlipaySDK defaultService] payOrder:content fromScheme:@"xiaozhangAlipay" callback:^(NSDictionary *resultDic) {
        // 处理支付结果
        //        9000 订单支付成功
        //        8000 正在处理中
        //        4000 订单支付失败
        //        6001 用户中途取消
        //        6002 网络连接出错
        int code = [resultDic[@"resultStatus"] intValue];
        if (9000 == code) {
            [self.hudManager showSuccessSVHudWithTitle:@"赚豆充值成功" hideAfterDelay:2.0 animaton:YES];
        }else
        {
           [self.hudManager showSuccessSVHudWithTitle:@"赚豆充值失败" hideAfterDelay:2.0 animaton:YES];
        }
    }];
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
