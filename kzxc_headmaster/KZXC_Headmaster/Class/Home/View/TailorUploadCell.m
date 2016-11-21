//
//  TailorUploadCell.m
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/7/15.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#define cellW  90
#define cellH  70
#define jianju (kWidth - 40 - 270)/2

#import "TailorUploadCell.h"
#import "UIColor+Hex.h"

@implementation TailorUploadCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

    
    for (int i = 0; i< 3; i++) {
        
        CGRect rect = CGRectMake(20+(cellW + jianju)*i, 65, cellW, cellH);
        
        UIButton * uploadBtn = [[UIButton alloc]initWithFrame:rect];
        
        [uploadBtn setImage:[UIImage imageNamed:@"tailor_upload"] forState:UIControlStateNormal];
        if (0 == i) {
            [uploadBtn setImage:[UIImage imageNamed:@"tailor_cer"] forState:UIControlStateNormal];
        }
        
        uploadBtn.tag = 100+i;
        [uploadBtn addTarget:self action:@selector(uploadBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:uploadBtn];
    }
    
    //虚线
    CAShapeLayer *dotteShapeLayer = [CAShapeLayer layer];
    CGMutablePathRef dotteShapePath =  CGPathCreateMutable();
    [dotteShapeLayer setFillColor:[[UIColor clearColor] CGColor]];
    [dotteShapeLayer setStrokeColor:[UIColor colorWithHexString:@"ececec"].CGColor];
    dotteShapeLayer.lineWidth = 1.0f ;
    NSArray *dotteShapeArr = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:5],[NSNumber numberWithInt:2], nil];
    [dotteShapeLayer setLineDashPattern:dotteShapeArr];
    //设置虚线的起位置
    CGPathMoveToPoint(dotteShapePath, NULL, 0,155);
    //设置虚线的末位置
    CGPathAddLineToPoint(dotteShapePath, NULL, kWidth, 155);
    [dotteShapeLayer setPath:dotteShapePath];
    CGPathRelease(dotteShapePath);
    [self.layer addSublayer:dotteShapeLayer];
}



- (void)uploadBtnClick:(UIButton *)uploadBtn
{
    NSInteger index = uploadBtn.tag - 100;
    if ([self.delegate respondsToSelector:@selector(tailorUploadCellWithIndex:currentBtn:)]) {
        [self.delegate tailorUploadCellWithIndex:index currentBtn:uploadBtn];
    }
}

-(void)setCerArray:(NSArray *)cerArray
{
    for (int i = 0; i< cerArray.count; i++) {
        
        CGRect rect = CGRectMake(20+(cellW+jianju)*i, 65+90+20, cellW, cellH);
        
        UIImageView * imageview = [[UIImageView alloc]initWithFrame:rect];
        
        imageview.image = [UIImage imageNamed:cerArray[i]];
        
        [self addSubview:imageview];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
