//
//  HomeTopCell.m
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/8/6.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import "HomeTopCell.h"

@implementation HomeTopCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    CGFloat jianju = (kWidth - 70*4)/5;
    self.firleft.constant = jianju;
    self.secleft.constant = jianju;
    self.thileft.constant = jianju;
    self.four.constant = jianju;
    
    [self.btn1 setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"#fbfbfb"]] forState:UIControlStateHighlighted];
    [self.btn2 setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"#fbfbfb"]] forState:UIControlStateHighlighted];
    [self.btn3 setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"#fbfbfb"]] forState:UIControlStateHighlighted];
    [self.btn4 setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"#fbfbfb"]] forState:UIControlStateHighlighted];

}
- (IBAction)btnClick:(UIButton *)sender {
    NSLog(@"%d",(int)sender.tag);
    if ([_delegate respondsToSelector:@selector(topClickedBtn:)]) {
        [_delegate topClickedBtn:sender];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
