//
//  LeaseScrollCell.m
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/7/21.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import "LeaseScrollCell.h"
#import "XWScanImage.h"

@implementation LeaseScrollCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _imgview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kWidth, 175)];

    [_banner addSubview:_imgview];
    
}
- (void)setCocahCarDetail:(CocahCarDetailModel *)cocahCarDetail {
    
    _cocahCarDetail = cocahCarDetail;
    
    [_imgview sd_setImageWithURL:[NSURL URLWithString:cocahCarDetail.pic.pic1] placeholderImage:[UIImage imageNamed:@"placeBanner"]];
    
    UITapGestureRecognizer *tapGestureRecognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scanBigImageClick1:)];
    [_imgview addGestureRecognizer:tapGestureRecognizer1];
    //让UIImageView和它的父类开启用户交互属性
    [_imgview setUserInteractionEnabled:YES];
}
#pragma mark - 浏览大图点击事件
-(void)scanBigImageClick1:(UITapGestureRecognizer *)tap{

    UIImageView *clickedImageView = (UIImageView *)tap.view;
    [XWScanImage scanBigImageWithImageView:clickedImageView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
