//
//  TailorCell.m
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/7/15.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import "TailorCell.h"

@implementation TailorCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.logoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(kWidth -   50 - 34, 5, 40, 40)];
    self.logoImageView.layer.cornerRadius = self.logoImageView.size.width/2;
    self.logoImageView.clipsToBounds = YES;
    [self addSubview:self.logoImageView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
