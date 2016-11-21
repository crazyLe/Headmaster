//
//  VouchersCell.m
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/7/19.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import "VouchersCell.h"
#import "DDJModel.h"
#import "NSObject+Time.h"

@implementation VouchersCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
//    _price.attributedText = ;
    
    NSDictionary *juandict = @{NSObliquenessAttributeName:@0.5};
    
    NSMutableAttributedString *juanAttr = [[NSMutableAttributedString alloc]initWithString:@"优惠劵"];
    
    [juanAttr addAttributes:juandict range:NSMakeRange(0, [juanAttr length])];
    
    _juan.attributedText = juanAttr;

}

- (NSMutableAttributedString *)priceStr:(NSString *)price
{
    NSMutableAttributedString *priceAttr = [[NSMutableAttributedString alloc]initWithString:price];
    
    [priceAttr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-BoldOblique" size:30] range:NSMakeRange(1, price.length - 1)];
    
    [priceAttr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-BoldOblique" size:15] range:NSMakeRange(0, 1)];
    
    return priceAttr;
}


- (void)setModel:(DDJModel *)model
{
    _model = model;
    
    _price.attributedText = [self priceStr:[NSString stringWithFormat:@"¥%@",model.money]];
    
    _contentLabel.text = model.title;
    
    NSString * startTimeStr = [self getStamptimeWithString:model.startTime andSec:0];
    NSString * endTimeStr = [self getStamptimeWithString:model.endTime andSec:0];

    NSString *time = [NSString stringWithFormat:@"有效期%@-%@",startTimeStr,endTimeStr];
    _time.text = time;
    
}
- (IBAction)sendDDJagain:(id)sender {
    if ([_delegate respondsToSelector:@selector(clickedCell:)]) {
        [_delegate clickedCell:self];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
