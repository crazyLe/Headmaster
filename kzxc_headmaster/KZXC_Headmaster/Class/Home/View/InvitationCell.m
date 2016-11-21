//
//  InvitationCell.m
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/7/20.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import "InvitationCell.h"
#import "RecruitCoach.h"

@implementation InvitationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.layer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
    self.layer.shadowOffset = CGSizeMake(0,2);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    self.layer.shadowOpacity = 0.2;//阴影透明度，默认0
    self.layer.shadowRadius = 2;//阴影半径，默认3
    
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
    if ([coach.state isEqualToString:@"5"]) {
        
        [_btn2 setImage:[UIImage imageNamed:@"yaoqing_r"] forState:UIControlStateNormal];
    }if ([coach.state isEqualToString:@"0"]) {
        
        [_btn2 setImage:[UIImage imageNamed:@"send_r"] forState:UIControlStateNormal];
        _btn2.enabled = NO;
    }if ([coach.state isEqualToString:@"2"]) {
        
        [_btn2 setImage:[UIImage imageNamed:@"jujue_r"] forState:UIControlStateNormal];
        _btn2.enabled = NO;
    }
    

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
