//
//  TailorPlaceCell.m
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/7/15.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#define cellW  (kWidth - 20 - 30)/3
#define cellH  70

#import "TailorPlaceCell.h"

@implementation TailorPlaceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _imageviewArray = [NSMutableArray array];
    
    for (int i = 0; i< 3; i++) {
        
        CGRect rect = CGRectMake(10+(cellW+15)*i, 65, cellW, cellH);
        
        UIImageView * imageview = [[UIImageView alloc]initWithFrame:rect];
        
        imageview.image = [UIImage imageNamed:@"placehold"];
        
        imageview.userInteractionEnabled = YES;
        
        imageview.tag = 400+i;
        
        [imageview addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTap:)]];
        [_imageviewArray addObject:imageview];
        
        [self addSubview:imageview];
    }
    
}

-(void)imageViewTap:(UITapGestureRecognizer *)tap
{
    int tag = (int)tap.view.tag;
    
    if ([self.delegate respondsToSelector:@selector(tailorPlaceCellTapImageViewWithSelf:index:)]) {
        [self.delegate tailorPlaceCellTapImageViewWithSelf:self index:tag-400];
    }


}



@end
