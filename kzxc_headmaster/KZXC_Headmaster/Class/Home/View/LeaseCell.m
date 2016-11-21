//
//  LeaseCell.m
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/7/21.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#define conentw (kWidth - 30)/2

#import "LeaseCell.h"
#import "NSString+Size.h"

@implementation LeaseCell

- (instancetype)initWithFrame:(CGRect)frame
{
    
    
    self = [super initWithFrame:frame];
    if (self) {
        
        //示例图片
        UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, conentw - 20, conentw - 20)];
        
        imageview.image = [UIImage imageNamed:@"tailor_place"];
        
        self.icon = imageview;
        
        [self.contentView addSubview:imageview];
        
        
//        CGSize size = [NSString string:@"100/天" sizeWithFont:Font15 maxSize:CGSizeMake(conentw - 20, 15)];
        //价格
        UILabel *label1 = [[UILabel alloc]init];
        label1.text = @"100/天";
        label1.font = BoldFontWithSize(15);
        label1.textColor = [UIColor colorWithHexString:@"#d32026"];
        label1.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:label1];
        [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(imageview.mas_bottom).offset(10);
            make.left.mas_equalTo(imageview.mas_left);
//            make.size.mas_equalTo(CGSizeMake(size.width, 15));
            make.width.offset(100);
            make.height.offset(15);
        }];
        self.price = label1;
        
        //规模
        UILabel *label2 = [[UILabel alloc]init];
        label2.text = @"60亩";
        label2.font = fourteenFont;
        label2.textAlignment = NSTextAlignmentRight;
        label2.textColor = [UIColor colorWithHexString:@"#333333"];
        
        [self.contentView addSubview:label2];
        [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(imageview.mas_bottom).offset(10);
            make.right.mas_equalTo(imageview.mas_right);
            make.size.mas_equalTo(CGSizeMake(70, 15));
        }];
        self.scale = label2;
    
        //详细说明
        UILabel *label3 = [[UILabel alloc]init];
        label3.text = @"安徽省合肥市莲花路与石门路交叉口";
        label3.font = fourteenFont;
        label3.numberOfLines = 2;
        label3.lineBreakMode = NSLineBreakByTruncatingTail;
        label3.textColor = [UIColor colorWithHexString:@"#999999"];
        label3.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:label3];
        [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(label2.mas_bottom).offset(10);
            make.left.mas_equalTo(imageview.mas_left);
            make.size.mas_equalTo(CGSizeMake(conentw - 20, 40));
        }];
        self.details = label3;

    }
    
    self.layer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
    self.layer.shadowOffset = CGSizeMake(0,2);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    self.layer.shadowOpacity = 0.2;//阴影透明度，默认0
    self.layer.shadowRadius = 2;//阴影半径，默认3

    return self;
}

@end
