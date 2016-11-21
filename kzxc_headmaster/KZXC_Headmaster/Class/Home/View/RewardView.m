//
//  RewardView.m
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/7/19.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import "RewardView.h"
#import "NSString+Size.h"

@implementation RewardView


- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.frame = CGRectMake(0, 0, kWidth, kHeight);
    
        self.backgroundColor =  [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:0.5];
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake((kWidth - 280)/2, (kHeight - 175)/2, 280, 175)];
    
        view.userInteractionEnabled = YES;
        
        view.backgroundColor = [UIColor whiteColor];
        
        view.layer.cornerRadius = 5.0;
        
        [self addSubview:view];
        
        UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(30, 40, 80, 20)];
    
        label1.text = @"赚豆余额：";
        
        label1.textColor = [UIColor colorWithHexString:@"c8c8c8"];
        
        label1.font = Font16;
        
        [view addSubview:label1];

        CGSize strsize = [NSString string:@"28000" sizeWithFont:Font16 maxSize:CGSizeMake(70, 20)];
        
        UILabel *douNum = [[UILabel alloc]initWithFrame:CGRectMake(110, 40, strsize.width, 20)];
        douNum.textColor = [UIColor colorWithHexString:@"#666666"];
        douNum.text = kDounum;
        douNum.font = Font16;
        douNum.textAlignment = NSTextAlignmentLeft;
        
        [view addSubview:douNum];
        
        self.dou = douNum;
        
        UIImageView *douzi = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(douNum.frame), 40, 20, 20)];
        douzi.image = [UIImage imageNamed:@"recuit_douzi"];
        [view addSubview:douzi];
        
//        UIView *line3 = [[UIView alloc]initWithFrame:CGRectMake(197, 40, 1, 20)];
//        line3.backgroundColor = [UIColor colorWithHexString:@"e6e6e6"];
//        [view addSubview:line3];
        
//        UIButton *chongzhi = [[UIButton alloc]initWithFrame:CGRectMake(200, 40, 40, 20)];
//        chongzhi.tag = 203;
//        [chongzhi setTitle:@"充值" forState:UIControlStateNormal];
//        [chongzhi setTitleColor:[UIColor colorWithHexString:@"#7bcb1e"] forState:UIControlStateNormal ];
//        chongzhi.titleLabel.font = Font16;
//        [chongzhi addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
//        
//        [view addSubview:chongzhi];
        
        UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 80, 100, 20)];
        label2.textAlignment = NSTextAlignmentRight;
//        label2.text = @"奖励钱辰：";
        label2.textColor = [UIColor colorWithHexString:@"c8c8c8"];
        label2.font = Font16;
        
        [view addSubview:label2];
        self.name = label2;
        
        UITextField *filed = [[UITextField alloc]initWithFrame:CGRectMake(110, 75, 100, 30)];
        //设置文字内容显示位置
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 30)];
        filed.leftView = paddingView;
        filed.leftViewMode = UITextFieldViewModeAlways;
        
        filed.keyboardType = UIKeyboardTypeNumberPad;
        filed.textColor = [UIColor colorWithHexString:@"#666666"];
        filed.layer.borderColor = [UIColor colorWithHexString:@"#dfdfdf"].CGColor;
        filed.layer.borderWidth = 1;
        filed.font = Font16;
        
        [view addSubview:filed];
        
        self.jiangliDou = filed;
        
        UIButton *zhuandou = [[UIButton alloc]initWithFrame:CGRectMake(210, 80, 40, 20)];
        zhuandou.tag = 204;
        zhuandou.titleLabel.font = Font18;
        [zhuandou setTitle:@"赚豆" forState:UIControlStateNormal];
        [zhuandou setTitleColor:[UIColor colorWithHexString:@"#c8c8c8"] forState:UIControlStateNormal ];
        zhuandou.titleLabel.font = fourteenFont;
        [zhuandou addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [view addSubview:zhuandou];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 129, 280, 1)];
        line.backgroundColor = [UIColor colorWithHexString:@"e6e6e6"];
        [view addSubview:line];
        
        UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(139, 129, 1, 45)];
        line2.backgroundColor = [UIColor colorWithHexString:@"e6e6e6"];
        [view addSubview:line2];
        
        UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 130, 140, 45)];
        btn1.showsTouchWhenHighlighted = YES;
        
        btn1.tag  = 201;
        btn1.titleLabel.textAlignment = NSTextAlignmentCenter;
        [btn1 setTitle:@"取消" forState:UIControlStateNormal];
        
        [btn1 setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"#f7f7f7"]] forState:UIControlStateHighlighted];
        
        [btn1 setTitleColor:[UIColor colorWithHexString:@"5db5ff"] forState:UIControlStateNormal];
        [btn1 addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn1];
        
        UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(136, 130, 139, 45)];
        btn2.showsTouchWhenHighlighted = YES;
        btn2.tag = 202;
        btn2.titleLabel.textAlignment = NSTextAlignmentCenter;
        [btn2 setTitle:@"确定" forState:UIControlStateNormal];
        [btn2 setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"#f7f7f7"]] forState:UIControlStateHighlighted];
        [btn2 setTitleColor:[UIColor colorWithHexString:@"5db5ff"] forState:UIControlStateNormal];
        [btn2 addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn2];
        
        
        
    }
    return self;
}

- (void)BtnClick:(UIButton *)sender
{
    NSInteger tag = sender.tag;
    if (202 == tag) {
        
        int douprice = [self.jiangliDou.text intValue];
        
//        if (douprice % 10 || 0 == douprice) {
//            [SVProgressHUD showSuccessWithStatus:@"奖励豆子必须是10的整数倍"];
//            return;
//        }

        if (0 == douprice) {
            [self.hudManager showErrorSVHudWithTitle:@"请输入赚豆" hideAfterDelay:1.0];
            return;
        }
        if (douprice > [kDounum intValue]) {
            [self.hudManager showErrorSVHudWithTitle:@"余额不足" hideAfterDelay:1.0];
            return;
        }
        [self jiangliDouzi:douprice];
    }
    [self removeFromSuperview];
}

- (void)jiangliDouzi:(int)dou
{
    [self.hudManager showNormalStateSVHudWithTitle:@"加载中..." hideAfterDelay:5.0];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"uid"] = kUid;
    param[@"deviceInfo"] = deviceInfo;
    param[@"beans"] = @(dou);
    param[@"userId"] = self.userid;
    param[@"time"] = self.getcurrentTime;
    param[@"sign"] = [HttpsTools getSignWithIdentify:@"/recruit/bonuses" time:self.getcurrentTime];
    NSLog(@"%@",param);
    [HttpsTools kPOST:jiangliDouziUrl parameter:param progress:^(NSProgress *downloadProgress) {
    } succeed:^(id backdata, int code, NSString *msg) {
    
        if (1 == code) {
            NSLog(@"%d",([kDounum intValue] - dou));
            [self.hudManager showSuccessSVHudWithTitle:@"奖励成功" hideAfterDelay:2.0 animaton:YES];
            [[NSUserDefaults standardUserDefaults]setValue:[NSString stringWithFormat:@"%d",[kDounum intValue] - dou] forKey:@"douNum"];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

- (void)setName:(NSString *)name andUserId:(NSString *)userid
{
    self.name.text = [NSString stringWithFormat:@"奖励%@",name];
    self.userid = userid;
}
- (void)show
{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
