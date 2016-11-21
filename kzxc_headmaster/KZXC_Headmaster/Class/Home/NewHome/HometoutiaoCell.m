//
//  HometoutiaoCell.m
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/8/9.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import "HometoutiaoCell.h"
#import <BBCyclingLabel.h>
#import "ToutiaoModel.h"

@implementation HometoutiaoCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)moreClick:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(toutiaoMoreClick:)]) {
        [_delegate toutiaoMoreClick:self];
    }
}

- (void)setTitles:(NSArray *)titles
{
    if (0 != titles.count) {
        _titles = titles;
        _bbCyclingLable  = [[BBCyclingLabel alloc]initWithFrame:CGRectMake(75, 15, kWidth -150, 25) andTransitionType:BBCyclingLabelTransitionEffectScrollUp];
        _bbCyclingLable.font = Font16;
        _bbCyclingLable.textColor = ColorNine;
        
//        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(toutiaoClick)];
//        [self addGestureRecognizer:tap];
        
        [self addSubview:_bbCyclingLable];
        NSTimer *time = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(change) userInfo:nil repeats:YES];
        [time fire];
        a = 0;
    }
}

-(void)toutiaoClick
{
    if ([_delegate respondsToSelector:@selector(toutiaoClickpushWeb:)]) {
        [_delegate toutiaoClickpushWeb:model.communityUrl];
    }
}

- (void)change{
    a++;
    int i = a % _titles.count;
    model = [_titles objectAtIndex:i];
    _bbCyclingLable.text = model.communityTitle;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
