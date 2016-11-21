//
//  AreaButton.m
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/7/11.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import "AreaButton.h"

@implementation AreaButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)layoutSubviews
{
    self.imageView.frame = CGRectMake(60, 6, 18, 9);
    
    self.titleLabel.frame = CGRectMake(0,0, 60, 20);
}

@end
