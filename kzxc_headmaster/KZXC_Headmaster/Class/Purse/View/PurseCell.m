//
//  PurseCell.m
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/7/20.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import "PurseCell.h"

@implementation PurseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

}

- (void)setModel:(MonthModel *)model
{
    _model = model;
    
    [_headimg sd_setImageWithURL:[NSURL URLWithString:model.face] placeholderImage:[UIImage imageNamed:@"placeHeader"]];
    
    NSString * timeStr = [Utilities calculateTimeWithFaceTimeDayTarget:model.time];
    NSString * timeStr1 = [self getStamptimeWithString:model.time andSec:2];
    
//    _date.text = [timeStr substringToIndex:10];
//    
    _time.text = [timeStr1 substringFromIndex:11];
    _date.text = timeStr;
    
    _douzi.text = [NSString stringWithFormat:@"%@ 元",_model.beans];
    
    _classtype.text = model.className;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
