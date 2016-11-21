//
//  RecruitCell.m
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/7/18.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import "RecruitCell.h"
#import "UIColor+Hex.h"
#import "RecruitCoach.h"


@implementation RecruitCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
}


- (void)setCoach:(RecruitCoach *)coach
{
    _coach = coach;
    
    [_headimg sd_setImageWithURL:[NSURL URLWithString:coach.face] placeholderImage:[UIImage imageNamed:@"icon"]];
    
    _name.text = coach.userName;
    
    _personnum.attributedText = [self attr:coach.peopleNum];
    
    _time.text = [self getStamptimeWithString:coach.date andSec:NO];
    
//    _giveBtn.tag = [coach.remainBeans integerValue];
    
}

- (NSMutableAttributedString *)attr:(NSString *)str
{
    NSString *numStr = [NSString stringWithFormat:@"成功招生%@人",str];
    
    NSMutableAttributedString *numAttr = [[NSMutableAttributedString alloc]initWithString:numStr];
    
    [numAttr addAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithHexString:@"#999999"],NSForegroundColorAttributeName, [UIFont systemFontOfSize:12.0],NSFontAttributeName,nil] range:NSMakeRange(0, numStr.length)];
    [numAttr addAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithHexString:@"#7bcb1e"],NSForegroundColorAttributeName, [UIFont systemFontOfSize:15.0],NSFontAttributeName,nil] range:NSMakeRange(4, numStr.length - 5)];
    
    return numAttr;
    
}
- (IBAction)reward:(UIButton *)sender {
    
    self.give(self);
}

@end
