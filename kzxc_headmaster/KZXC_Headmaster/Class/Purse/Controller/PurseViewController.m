//
//  PurseViewController.m
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/7/20.
//  Copyright © 2016年 cqingw. All rights reserved.
//

//#define btnW kWidth/3
//#define btnW kWidth

#import "PurseViewController.h"
#import "OrderListController.h"
#import "RechargeViewController.h"
#import "TXViewController.h"
#import "NSString+Size.h"
#import "HomeWebController.h"


@interface PurseViewController ()<UIAlertViewDelegate>

{
    NSString *curDou;
    CGFloat btnW;
}
@property(strong,nonatomic)UIAlertView *outAlert;
@end

@implementation PurseViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    NSString *url = [[NSUserDefaults standardUserDefaults]objectForKey:@"kFace"];
    
    if (url) {
        
        [self.mineImg sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"placeHeader"]];
    }
    else
    {
    
        self.mineImg.image = [UIImage imageNamed:@"placeHeader"];
    
    }
    

    NSString *nickName = [[NSUserDefaults standardUserDefaults]objectForKey:@"kNickName"];
    
    if (nickName) {
        
        self.myName.text = nickName;
    }
    else
    {
        self.myName.text = @"";
    }
    
    int state = [[[NSUserDefaults standardUserDefaults]objectForKey:@"kState"] intValue];
    if (state == 1) {
        self.vip.hidden = NO;
    }else
    {
        self.vip.hidden = YES;
    }
    
//    _money.attributedText = [self shengyuDouzi:[NSString stringWithFormat:@"赚豆余额:%@",curDou]];
    
    NSLog(@"%d",[kUid intValue]);
    if (0 == [kUid intValue]) {
        _money.attributedText = [self shengyuDouzi:[NSString stringWithFormat:@"赚豆:%d",0]];
        _orderNum.text = [NSString stringWithFormat:@"累积订单: %@",@0];
        _ownMoney.text = [NSString stringWithFormat:@"已赚：%@元", @0];
    }else
    {
        [self loadData];
    }
    
    if ([kAuthState isEqualToString:@"1"]) {
        UIImageView *vip = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"purse_vip"]];
        [self.topView addSubview:vip];
        [vip mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(22);
            make.left.equalTo(self.myName.mas_right).offset(3);
            make.size.mas_offset(CGSizeMake(13, 15));
        }];
        
    }
    
    if (0 == [kShowState intValue]) {
        _chingzhi.hidden = YES;
        _tixian.hidden = YES;
        _money.hidden = YES;
       
    }
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.mineImg.clipsToBounds = YES;
    self.mineImg.layer.cornerRadius = self.mineImg.width/2;
    
     NSString *nickName = [[NSUserDefaults standardUserDefaults]objectForKey:@"kNickName"];
    
    CGSize size = [NSString string:nickName sizeWithFont:Font16 maxSize:CGSizeMake(120, 20)];
    
    [self.myName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(20);
        make.width.mas_offset(size.width + 10);
        make.left.mas_equalTo(90);

    }];

    [self.vip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(22);
        make.left.equalTo(_myName.mas_right).offset(3);
        make.size.mas_offset(CGSizeMake(13, 15));
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    _outAlert = [[UIAlertView alloc]initWithTitle:@"" message:@"您尚未登录!" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去登录", nil];
    _outAlert.tag = 808;
    
    _tixian.layer.borderWidth = 1.0;
    _tixian.layer.borderColor = RGBColor(247, 247, 247).CGColor;
    
    NSArray *btnImgArr = [NSArray array];
    
    if (0 == [kShowState intValue]) {
//        _chingzhi.hidden = YES;
//        _tixian.hidden = YES;
//        _money.hidden = YES;
        btnImgArr = @[@"purse_show"];
        btnW = kWidth;
    }else
    {
        btnImgArr = @[@"purse_show",@"purse_rule",@"purse_question"];
        btnW = kWidth/3;
    }

    NSArray *btnTitleArr = @[@"查询账单",@"赚豆规则",@"如何获得赚豆"];
    
    for (int i = 0; i < btnImgArr.count; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        btn.tag = 101+i;
        btn.frame = CGRectMake(btnW * i, 85, btnW, 35);
        
        [btn setImage:[UIImage imageNamed:btnImgArr[i]] forState:UIControlStateNormal];
        [btn setTitle:btnTitleArr[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15.0];
        [btn setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"#fbfbfb"]] forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [_topView addSubview:btn];
    }
    
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(btnW, 85, 1, 35)];
    line1.backgroundColor = [UIColor colorWithHexString:@"#ececec"];
    [_topView addSubview:line1];
    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(2*btnW, 85, 1, 35)];
    line2.backgroundColor = [UIColor colorWithHexString:@"#ececec"];
    [_topView addSubview:line2];
    
    UILabel *name = [[UILabel alloc]init];
    name.text = @"嫣然为诗笑";
    name.font = Font16;
    name.textColor = ColorSix;
    name.lineBreakMode = NSLineBreakByTruncatingMiddle;
    [self.topView addSubview:name];
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(20);
        make.left.mas_equalTo(90);
    }];
    self.myName = name;
    

    
//    if (isIPhpne4 || isIPhone5) {
//        _money.font = Font11;
//    }

    //判断登录状态
//    if ([kUid intValue] != 0) {
//        
//        [self loadData];
//    }
//    
    
}


- (void)btnClick:(UIButton *)item
{
    NSLog(@"%lu",(long)item.tag);
    
//    if (0 == [kUid intValue]) {
//        [_outAlert show];
//        return;
//    }
    
    NSInteger tag = item.tag;
    
    switch (tag) {
        case 101:
        {
            OrderListController *order = [[OrderListController alloc]init];
            order.type = @"0";
            [self.navigationController pushViewController:order animated:YES];
        }
            break;
            
            case 102:
        {
            HomeWebController *homeweb = [[HomeWebController alloc]init];
            homeweb.str = @"zdgz";
            [self.navigationController pushViewController:homeweb animated:YES];
            
        }
            break;
            case 103:
        {
            HomeWebController *homeweb = [[HomeWebController alloc]init];
            homeweb.str = @"rhhq";
            [self.navigationController pushViewController:homeweb animated:YES];
        }
            break;
        default:
            break;
    }
    
}

- (IBAction)showDetails:(UIButton *)sender {
 
    if (0 == [kUid intValue]) {
        [_outAlert show];
        return;
    }
    
    if (301 == sender.tag) {
        RechargeViewController *rechar = [[RechargeViewController alloc]init];
        [self.navigationController pushViewController:rechar animated:YES];
    }else if (302 == sender.tag)
    {
        TXViewController *tx = [[TXViewController alloc]init];
        tx.dounum = curDou;
        [self.navigationController pushViewController:tx animated:YES];
    }else
    {
        OrderListController *order = [[OrderListController alloc]init];
        order.type = @"1";
        [self.navigationController pushViewController:order animated:YES];
    }
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
            
            curDou = [NSString stringWithFormat:@"%@",backdata[@"beans"]];
            
            NSLog(@"%d",[backdata[@"beans"] isEqualToString:@"(null)"]);
            
            NSString *str1 = backdata[@"beans"];
            NSString *str2 = backdata[@"OrderNum"];
            NSString *str3 = backdata[@"OrderBeans"];
            
            str1 = (0 == str1.length)?@"0":str1;
            str2 = (0 == str2.length)?@"0":str2;
            str3 = (0 == str3.length)?@"0":str3;
            
            _money.attributedText = [self shengyuDouzi:[NSString stringWithFormat:@"赚豆:%@",str1]];
            
            NSLog(@"%d",[backdata[@"OrderBeans"] intValue]);
            _orderNum.text = [NSString stringWithFormat:@"累积订单: %@",str2];
            _ownMoney.text = [NSString stringWithFormat:@"已赚：%@元", str3];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (NSMutableAttributedString *)shengyuDouzi:(NSString *)str
{
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:str];
    [attr addAttribute:NSForegroundColorAttributeName value:ColorNine range:NSMakeRange(0, 3)];
    [attr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#ff6969"] range:NSMakeRange(3, str.length - 3)];
    return attr;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSInteger tag = alertView.tag;
    
    switch (tag) {
        case 808:
        {
            if (1 == buttonIndex) {
                LoginGuideController *login = [[LoginGuideController alloc]init];
                login.gologin = YES;
                UINavigationController *root = [[UINavigationController alloc]initWithRootViewController:login];
                [root.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg"] forBarMetrics:UIBarMetricsDefault];
                root.navigationBar.shadowImage =[UIImage imageNamed:@"nav_bg"];
                root.navigationBar.titleTextAttributes = NavTitleTextAttributes;
                
                [self presentViewController:root animated:YES completion:nil];
            }
        }
            break;
            
        default:
            break;
    }
}
- (IBAction)viewClick:(UITapGestureRecognizer *)sender {
    
    OrderListController *order = [[OrderListController alloc]init];
    order.type = @"1";
    [self.navigationController pushViewController:order animated:YES];
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
