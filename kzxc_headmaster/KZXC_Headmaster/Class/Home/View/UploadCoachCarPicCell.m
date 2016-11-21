//
//  UploadCoachCarPicCell.m
//  KZXC_Headmaster
//
//  Created by gaobin on 16/8/15.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import "UploadCoachCarPicCell.h"

@implementation UploadCoachCarPicCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _leftImgBtn.tag = 1000;
    [_leftImgBtn addTarget:self action:@selector(leftImgBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    _middleImgBtn.tag = 2000;
    [_middleImgBtn addTarget:self action:@selector(middleImgBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    _rightImgBtn.tag = 3000;
    [_rightImgBtn addTarget:self action:@selector(rightImgBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)leftImgBtnClick {
    
    if ([_delegate respondsToSelector:@selector(UploadCoachCarPicCellDidClickBtnWithBtnType:withBtn:)]) {
        
        [_delegate UploadCoachCarPicCellDidClickBtnWithBtnType:UploadCoachCarPicCellLeftBtn withBtn:_leftImgBtn];
        
    }
    
}
- (void)middleImgBtnClick {
    
    if ([_delegate respondsToSelector:@selector(UploadCoachCarPicCellDidClickBtnWithBtnType:withBtn:)]) {
        
        [_delegate UploadCoachCarPicCellDidClickBtnWithBtnType:UploadCoachCarPicCellMiddleBtn withBtn:_middleImgBtn];
        
    }
    
    
}
- (void)rightImgBtnClick {
    
    if ([_delegate respondsToSelector:@selector(UploadCoachCarPicCellDidClickBtnWithBtnType:withBtn:)]) {
        
        [_delegate UploadCoachCarPicCellDidClickBtnWithBtnType:UploadCoachCarPicCellRightBtn withBtn:_rightImgBtn];
        
    }
    
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
