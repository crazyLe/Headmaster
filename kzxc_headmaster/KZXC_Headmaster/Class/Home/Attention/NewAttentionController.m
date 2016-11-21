//
//  NewAttentionController.m
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/7/26.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#define contentStr @"驾校微名片浏览量"
#define contentW (kWidth - 40 - 10)/2

#import "NewAttentionController.h"

@interface NewAttentionController ()
{
    //说明
    NSString *sm;
}
//说明
@property(weak,nonatomic)UILabel *shuoming;
//今日流览量
@property(weak,nonatomic)UILabel *todayLLNum;
//昨日流览量
@property(weak,nonatomic)UILabel *yesLLNum;
//累计流览量
@property(weak,nonatomic)UILabel *totalNum;
////上线天数
//@property(weak,nonatomic)UILabel *onlineDay;
//微名片报名人数
@property(weak,nonatomic)UILabel *wmpNum;
//提到的驾校数
@property(weak,nonatomic)UILabel *driveNum;
//登上头条宝座数
@property(weak,nonatomic)UILabel *hotNum;

@end

@implementation NewAttentionController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"关注度";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIScrollView *scroll = [[UIScrollView alloc]init];
    scroll.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:scroll];
    [scroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(kWidth, kHeight - 64));
    }];
    
    [scroll setContentSize:CGSizeMake(kWidth, 550)];
    
//    驾校微名片浏览量
    UILabel *title = [[UILabel alloc]init];
    title.text = contentStr;
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor colorWithHexString:@"#ff6867"];
    title.font = BoldFontWithSize(18);
    [scroll addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(25);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(kWidth, 15));
    }];
//    说明
    UILabel *titlesm = [[UILabel alloc]init];
//    titlesm.attributedText = [self addAttrsWithString:sm];
    titlesm.textAlignment = NSTextAlignmentCenter;
    [scroll addSubview:titlesm];
    [titlesm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(title.mas_bottom).offset(5);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(kWidth, 15));
    }];
    self.shuoming = titlesm;
//
    UIImageView *firimg = [[UIImageView alloc]init];
    [self showLine:firimg];
    firimg.backgroundColor = [UIColor colorWithHexString:@"#fbfff7"];
    [scroll addSubview:firimg];
    [firimg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titlesm.mas_bottom).offset(15);
        make.left.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(contentW, 80));
    }];
    
    UILabel *jrNum = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, contentW, 25)];
//    jrNum.text = @"2,659";
    jrNum.textColor = [UIColor colorWithHexString:@"#90d558"];
    jrNum.font = BoldFontWithSize(24);
    jrNum.textAlignment = NSTextAlignmentCenter;
    [firimg addSubview:jrNum];
    self.todayLLNum = jrNum;
    
    UILabel *jrNumBottom = [[UILabel alloc]initWithFrame:CGRectMake(0, 50, contentW, 15)];
    jrNumBottom.text = @"今日浏览量";
    jrNumBottom.font = Font14;
    jrNumBottom.textAlignment = NSTextAlignmentCenter;
    jrNumBottom.textColor = [UIColor colorWithHexString:@"#bcde8e"];
    [firimg addSubview:jrNumBottom];
    
    UIImageView *secimg = [[UIImageView alloc]init];
    [self showLine:secimg];
    secimg.backgroundColor = [UIColor colorWithHexString:@"#fffef5" alpha:1];
    [scroll addSubview:secimg];
    [secimg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(firimg.mas_bottom).offset(10);
        make.left.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(contentW, 80));
    }];
    
    UILabel *zrNum = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, contentW, 25)];
//    zrNum.text = @"3,659";
    zrNum.textColor = [UIColor colorWithHexString:@"#ffb034"];
    zrNum.font = BoldFontWithSize(24);
    zrNum.textAlignment = NSTextAlignmentCenter;
    [secimg addSubview:zrNum];
    self.yesLLNum = zrNum;
    
    UILabel *zrNumBottom = [[UILabel alloc]initWithFrame:CGRectMake(0, 50, contentW, 15)];
    zrNumBottom.text = @"昨日浏览量";
    zrNumBottom.font = Font14;
    zrNumBottom.textAlignment = NSTextAlignmentCenter;
    zrNumBottom.textColor = [UIColor colorWithHexString:@"#ead3ac"];
    [secimg addSubview:zrNumBottom];
    
    
    UIImageView *thiimg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"content_shan"]];
    [scroll addSubview:thiimg];
    [thiimg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(firimg.mas_top);
        make.left.equalTo(firimg.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(contentW, 170));
    }];
    
    UILabel *ljNum = [[UILabel alloc]initWithFrame:CGRectMake(0, 45, contentW, 25)];
//    ljNum.text = @"153,659";
    ljNum.textColor = [UIColor colorWithHexString:@"#ff6867"];
    ljNum.font = BoldFontWithSize(24);
    ljNum.textAlignment = NSTextAlignmentCenter;
    [thiimg addSubview:ljNum];
    self.totalNum = ljNum;
    
    UILabel *ljNumBottom = [[UILabel alloc]initWithFrame:CGRectMake(0, 80, contentW, 15)];
    ljNumBottom.text = @"累积浏览量";
    ljNumBottom.font = Font15;
    ljNumBottom.textAlignment = NSTextAlignmentCenter;
    ljNumBottom.textColor = [UIColor colorWithHexString:@"#ffaaa9"];
    [thiimg addSubview:ljNumBottom];
    
//    UILabel *sxDay = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, contentW, 15)];
////    sxDay.text = @"(上线25天)";
//    sxDay.font = Font15;
//    sxDay.textAlignment = NSTextAlignmentCenter;
//    sxDay.textColor = [UIColor colorWithHexString:@"#ffaaa9"];
//    [thiimg addSubview:sxDay];
//    self.onlineDay = sxDay;
    
    UIImageView *fourimg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"content_renshu"]];
    [scroll addSubview:fourimg];
    [fourimg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(secimg.mas_bottom).offset(10);
        make.left.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(kWidth - 40, 80));
    }];
    
    UIImageView *head = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"content_head"]];
    [fourimg addSubview:head];
    [head mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(25);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    UILabel *bmNum = [[UILabel alloc]initWithFrame:CGRectMake(70, 20, 100, 25)];
//    bmNum.attributedText = [self wmpAttrStrWithString:@"88人"];
    bmNum.textAlignment = NSTextAlignmentLeft;
    [fourimg addSubview:bmNum];
    self.wmpNum = bmNum;
    
    UILabel *bmNumBottom = [[UILabel alloc]initWithFrame:CGRectMake(70, 45, 150, 15)];
    bmNumBottom.text = @"通过微名片报名人数";
    bmNumBottom.font = Font16;
    bmNumBottom.textAlignment = NSTextAlignmentLeft;
    bmNumBottom.textColor = [UIColor colorWithHexString:@"#99c3eb"];
    [fourimg addSubview:bmNumBottom];
    

    
    
    
    //    圈子
    UILabel *title2= [[UILabel alloc]init];
    title2.text = @"圈子";
    title2.textAlignment = NSTextAlignmentCenter;
    title2.textColor = [UIColor colorWithHexString:@"#ff6867"];
    title2.font = BoldFontWithSize(18);
    [scroll addSubview:title2];
    [title2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(fourimg.mas_bottom).offset(25);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(kWidth, 15));
    }];
    //    说明
    UILabel *title2sm = [[UILabel alloc]init];
    title2sm.text = @"(在过去的一个月里，共有···)";
    title2sm.font = Font16;
    title2sm.textColor = ColorNine;
    title2sm.textAlignment = NSTextAlignmentCenter;
    [scroll addSubview:title2sm];
    [title2sm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(title2.mas_bottom).offset(5);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(kWidth, 15));
    }];
    
    UIImageView *qzfirimg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"quanzi_fir"]];
    [scroll addSubview:qzfirimg];
    [qzfirimg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(title2sm.mas_bottom).offset(10);
        make.left.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(contentW, 130));
    }];
    
    UILabel *qzfirNum = [[UILabel alloc]initWithFrame:CGRectMake(15, 25, 100, 25)];
//    qzfirNum.attributedText = [self qzAttrWithString:@"256条" andColor:@"#90d558"];
    qzfirNum.textAlignment = NSTextAlignmentLeft;
    [qzfirimg addSubview:qzfirNum];
    self.driveNum = qzfirNum;
    
    UILabel *qz1NumBottom = [[UILabel alloc]initWithFrame:CGRectMake(15, 60, 80, 15)];
    [self setqzLabelValue:qz1NumBottom andText:@"圈子内容" andColorStr:@"#bcde8e"];
    [qzfirimg addSubview:qz1NumBottom];
    
    UILabel *qz2NumBottom = [[UILabel alloc]initWithFrame:CGRectMake(15, 75, 100, 15)];
    [self setqzLabelValue:qz2NumBottom andText:@"提到您的驾校" andColorStr:@"#bcde8e"];
    [qzfirimg addSubview:qz2NumBottom];
    
    
    UIImageView *qzsecimg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"quanzi_sec"]];
    [scroll addSubview:qzsecimg];
    [qzsecimg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(qzfirimg.mas_top);
        make.left.equalTo(qzfirimg.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(contentW, 130));
    }];
    
    UILabel *qzsecNum = [[UILabel alloc]initWithFrame:CGRectMake(15, 25, 100, 25)];
//    qzsecNum.attributedText = [self qzAttrWithString:@"58次" andColor:@"#ffb034"];
    qzsecNum.textAlignment = NSTextAlignmentLeft;
    [qzsecimg addSubview:qzsecNum];
    self.hotNum = qzsecNum;
    
    UILabel *qzNumBottom = [[UILabel alloc]initWithFrame:CGRectMake(15, 60, 100, 15)];
    [self setqzLabelValue:qzNumBottom andText:@"登上头条宝座" andColorStr:@"#ead3ac"];
    [qzsecimg addSubview:qzNumBottom];
    
    [self loadData];
}



- (void)showLine:(UIView *)view
{
    view.layer.borderColor = [UIColor colorWithHexString:@"#e0f6c2"].CGColor;
    view.layer.borderWidth = 1;
}



- (NSMutableAttributedString *)addAttrsWithString:(NSString *)str
{

    
    str = [NSString stringWithFormat:@"已超过全国%.f％的校长",[str floatValue]*100];
    
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:str];
    
    [attr addAttributes:[NSDictionary dictionaryWithObjectsAndKeys:ColorNine,NSForegroundColorAttributeName,[UIFont systemFontOfSize:16],NSFontAttributeName, nil] range:NSMakeRange(0, str.length)];
    
    [attr addAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithHexString:@"#ff6867"],NSForegroundColorAttributeName,BoldFontWithSize(16),NSFontAttributeName, nil] range:NSMakeRange(5, attr.length - 8)];
    
    return attr;
}

- (NSMutableAttributedString *)wmpAttrStrWithString:(NSString *)str
{
 
    str = [NSString stringWithFormat:@"%@人",str];
    
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:str];
    
    [attr addAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithHexString:@"#68b6ff"],NSForegroundColorAttributeName,[UIFont systemFontOfSize:16],NSFontAttributeName, nil] range:NSMakeRange(0, str.length)];
    
    [attr addAttributes:[NSDictionary dictionaryWithObjectsAndKeys:BoldFontWithSize(24),NSFontAttributeName, nil] range:NSMakeRange(0, str.length-1)];
    
    return attr;
}

- (NSMutableAttributedString *)qzAttrWithString:(NSString *)str andColor:(NSString *)color
{
    if(!str)
    {
        str = @"256条";
    }
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:str];
    
    [attr addAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithHexString:color],NSForegroundColorAttributeName,[UIFont systemFontOfSize:24],NSFontAttributeName, nil] range:NSMakeRange(0, str.length)];
    
    [attr addAttributes:[NSDictionary dictionaryWithObjectsAndKeys:BoldFontWithSize(24),NSFontAttributeName, nil] range:NSMakeRange(0, str.length-1)];
    
    return attr;
    
}

-(void) setqzLabelValue:(UILabel *)label andText:(NSString *)str andColorStr:(NSString *)color
{
    label.text = str;
    label.font = Font16;
    label.textAlignment = NSTextAlignmentLeft;
    label.textColor = [UIColor colorWithHexString:color];
}

- (void)loadData
{
    [SVProgressHUD showWithStatus:@"加载中..."];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"uid"] = kUid;
    param[@"deviceInfo"] = deviceInfo;
    param[@"time"] = self.getcurrentTime;
    param[@"sign"] = [HttpsTools getSignWithIdentify:@"/statistics" time:self.getcurrentTime];
//    NSLog(@"%@",param);
    [HttpsTools kPOST:attenionUrl parameter:param progress:^(NSProgress *downloadProgress) {
    } succeed:^(id backdata, int code, NSString *msg) {
        [SVProgressHUD showWithStatus:msg];
        if (1 == code) {
//            NSLog(@"%@,%d",backdata,code);
            
            NSArray *values = @[[NSString stringWithFormat:@"%@",backdata[@"percent"]],[NSString stringWithFormat:@"%@",backdata[@"cardViewToday"]],[NSString stringWithFormat:@"%@",backdata[@"cardViewYesterday"]],[NSString stringWithFormat:@"%@",backdata[@"cardView"]],[NSString stringWithFormat:@"%@",backdata[@"cardDay"]],[NSString stringWithFormat:@"%@",backdata[@"studentNum"]],[NSString stringWithFormat:@"%@",backdata[@"communityNum"]],[NSString stringWithFormat:@"%@",backdata[@"topNum"]]];
            
            [self updateLabelData:values];
            }
        [SVProgressHUD dismiss];
        
    } failure:^(NSError *error) {
//        NSLog(@"%@",error);
    }];
}

- (void)updateLabelData:(NSArray *)arr
{
    self.shuoming.attributedText = [self addAttrsWithString:arr[0]];
    
    self.todayLLNum.text = arr[1];
    self.yesLLNum.text = arr[2];
    self.totalNum.text = arr[3];
    
//    self.onlineDay.text = [NSString stringWithFormat:@"(上线%@天)",arr[4]];
    
    self.wmpNum.attributedText = [self wmpAttrStrWithString:arr[5]];
    
    self.driveNum.attributedText = [self qzAttrWithString:[NSString stringWithFormat:@"%@条", arr[6]] andColor:@"#90d558"];
    
    self.hotNum.attributedText = [self qzAttrWithString:[NSString stringWithFormat:@"%@次",arr[7]] andColor:@"#ffb034"];

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
