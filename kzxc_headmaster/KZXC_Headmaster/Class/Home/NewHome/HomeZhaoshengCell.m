//
//  HomeZhaoshengCell.m
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/8/9.
//  Copyright © 2016年 cqingw. All rights reserved.
//


#import "HomeZhaoshengCell.h"

@implementation HomeZhaoshengCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.zhaoshengleft.constant = (kWidth/2 - 150)/2;
    
    self.btnW.constant = adBtnW;
    
    UIView *ad_line2 = [[UIView alloc]initWithFrame:CGRectMake(kWidth/2, 50, 1, adBtnW*(95.0/90.0)*2)];
    ad_line2.backgroundColor = RGBColor(240, 240, 240);
    [self addSubview:ad_line2];
    
    UIView *ad_line3 = [[UIView alloc]initWithFrame:CGRectMake(0, 49+2*adBtnW*(95.0/90.0), kWidth, 1)];
    ad_line3.backgroundColor = RGBColor(240, 240, 240);
    [self addSubview:ad_line3];
//
    UIView *ad_line4 = [[UIView alloc]initWithFrame:CGRectMake(3*kWidth/4, 49, 1, 2*adBtnW*(95.0/90.0))];
    ad_line4.backgroundColor = RGBColor(240, 240, 240);
//
    [self addSubview:ad_line4];
//
    UIView *ad_line5 = [[UIView alloc]initWithFrame:CGRectMake(kWidth/2, 50+adBtnW*(95.0/90.0), 2*adBtnW, 1)];
    ad_line5.backgroundColor = RGBColor(240, 240, 240);
    
    [self addSubview:ad_line5];
    
    [self.btn1 setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"#fbfbfb"]] forState:UIControlStateHighlighted];
    [self.btn2 setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"#fbfbfb"]] forState:UIControlStateHighlighted];
    [self.btn3 setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"#fbfbfb"]] forState:UIControlStateHighlighted];
    [self.btn4 setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"#fbfbfb"]] forState:UIControlStateHighlighted];
    
}

- (IBAction)zhaoshengClick:(UIButton *)sender {
    
    NSLog(@"%d",(int)sender.tag);
    
    if ([_delegate respondsToSelector:@selector(zhaoshengClickedBtn:)]) {
        [_delegate zhaoshengClickedBtn:sender];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
