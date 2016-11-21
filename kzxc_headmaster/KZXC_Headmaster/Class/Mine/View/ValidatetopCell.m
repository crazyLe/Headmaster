//
//  ValidatetopCell.m
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/7/22.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import "ValidatetopCell.h"

@implementation ValidatetopCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _headerImgView.layer.cornerRadius = _headerImgView.size.height/2;
    _headerImgView.clipsToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
