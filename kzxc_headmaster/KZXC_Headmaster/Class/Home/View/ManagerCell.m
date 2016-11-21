//
//  ManagerCell.m
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/7/19.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import "ManagerCell.h"
#import "RecruitCoach.h"

@implementation ManagerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
    _headimg.layer.cornerRadius = 22.5;
    _headimg.clipsToBounds = YES;
    
    
}
- (IBAction)buttonClick:(UIButton *)sender {
    
    if ([_delegate respondsToSelector:@selector(clickedButtontag:andCell:)]) {
        [_delegate clickedButtontag:sender.tag andCell:self];
    }
}

- (void)setCoach:(RecruitCoach *)coach
{
    _coach = coach;
    
    self.name.text = coach.userName;
    
    [self.headimg sd_setImageWithURL:[NSURL URLWithString:coach.face] placeholderImage:[UIImage imageNamed:@"icon"]];
    
    self.totalnum.text = [NSString stringWithFormat:@"累积招生%@人",coach.peopleNum];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
