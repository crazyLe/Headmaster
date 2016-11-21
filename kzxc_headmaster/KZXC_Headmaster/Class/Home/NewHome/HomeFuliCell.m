//
//  HomeFuliCell.m
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/8/9.
//  Copyright © 2016年 cqingw. All rights reserved.
//


#import "HomeFuliCell.h"

@implementation HomeFuliCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

    self.btnW.constant = serBtnW;

}
- (IBAction)fuliClick:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(fuliClickedBtn:)]) {
        [_delegate fuliClickedBtn:sender];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
