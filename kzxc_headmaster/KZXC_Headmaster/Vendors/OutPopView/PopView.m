//
//  PopView.m
//  KKXC_Franchisee
//
//  Created by 翁昌青 on 16/8/18.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import "PopView.h"

@implementation PopView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, kWidth, kHeight);
        self.backgroundColor = self.backgroundColor =  [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:0.5];
    }
    return self;
}

- (logout *)logoutview
{
    if (!_logoutview) {
        _logoutview = [[[NSBundle mainBundle] loadNibNamed:@"logout" owner:nil options:nil] firstObject];
        _logoutview.size = CGSizeMake(kWidth - 80, 100);
    }
    return _logoutview;
}

+ (instancetype)logoutWithPopview
{
    PopView *pop = [[PopView alloc]init];
    
    pop.logoutview.centerX = pop.centerX;
    
    pop.logoutview.centerY = pop.centerY;
    
    [pop addSubview:pop.logoutview];
    
    return pop;
    
}

- (void)show
{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

- (void)hidden{
    [self removeFromSuperview];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
