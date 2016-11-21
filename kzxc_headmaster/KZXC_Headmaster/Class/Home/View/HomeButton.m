//
//  HomeButtom.m
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/7/11.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import "HomeButton.h"

@implementation HomeButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
        self.titleLabel.font = Font16;
        
        [self setBackgroundImage:[UIImage imageWithColor:[UIColor yellowColor]] forState:UIControlStateHighlighted];
    }
    return self;
}

- (void)layoutSubviews
{
    self.imageView.frame = CGRectMake((self.width - 60)/2, (self.width - 60)/2-5, 60, 60);
    
    self.titleLabel.frame = CGRectMake(0,60, self.width, self.height - 60);
}

@end
