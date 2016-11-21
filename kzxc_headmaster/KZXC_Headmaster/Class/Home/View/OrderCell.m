//
//  OrderCell.m
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/7/13.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import "OrderCell.h"
#import "OrderModel.h"
#import "NSString+Size.h"

@implementation OrderCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) {
        return nil;
    }
    
    self.layer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
    self.layer.shadowOffset = CGSizeMake(0,2);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    self.layer.shadowOpacity = 0.8;//阴影透明度，默认0
    self.layer.shadowRadius = 2;//阴影半径，默认3

    self.backgroundColor = RGBColor(244, 244, 244);
    
    UIView *mainView = [[UIView alloc]initWithFrame:CGRectMake(15, 0, kWidth - 30, 90)];
    
    mainView.backgroundColor = [UIColor whiteColor];
    mainView.clipsToBounds = YES;
    mainView.layer.cornerRadius = 10;
    mainView.layer.borderWidth = 1.0;
    mainView.layer.borderColor = RGBColor(224, 224, 224).CGColor;
    self.orderMainView = mainView;
    
    [self.contentView addSubview:mainView];
    
    UIImageView *headImg = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 60, 60)];
    
    headImg.image = [UIImage imageNamed:@"icon"];
    self.orderHeadImg = headImg;
    [mainView addSubview:headImg];
    
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 15, 160, 20)];
//    nameLabel.attributedText = nameAttr;
    self.orderNameLabel = nameLabel;
    [mainView addSubview:nameLabel];
    
    CGSize size = [NSString string:@"C1 普通班 ¥4000元   " sizeWithFont:Font16 maxSize:CGSizeMake(200, 20)];
    UILabel *contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 35, size.width, 20)];
    contentLabel.text = @"C1 普通班 4000元";
    contentLabel.textColor = ColorNine;
    contentLabel.font = Font16;

    self.orderContentLabel = contentLabel;
    [mainView addSubview:contentLabel];
    
//    UILabel *fqLabel = [[UILabel alloc]initWithFrame:CGRectMake(80+size.width, 38, 35, 14)];
//    fqLabel.text = @"分期";
//    fqLabel.textAlignment = NSTextAlignmentCenter;
//    fqLabel.textColor = [UIColor colorWithHexString:@"#ff6969"];
//    fqLabel.font = twelveFont;
//    fqLabel.layer.borderWidth = 1;
//    fqLabel.layer.borderColor = [UIColor colorWithHexString:@"#ff6969"].CGColor;
//    fqLabel.layer.cornerRadius = 3;
//    
//    self.isFenQI = fqLabel;
//    [mainView addSubview:fqLabel];
    
    
    
    UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 55, 120, 20)];
    timeLabel.textColor = [UIColor colorWithHexString:@"#c8c8c8"];
    timeLabel.font = [UIFont systemFontOfSize:12.0];
    timeLabel.text = @"2016-07-13 09:00";
    self.orderTimeLabel = timeLabel;
    [mainView addSubview:timeLabel];
    
    UIImageView *typeView = [[UIImageView alloc]initWithFrame:CGRectMake(kWidth - 70, 15, 60, 20)];
    
    typeView.contentMode = UIViewContentModeScaleAspectFill;
    
    [typeView setImage:[UIImage imageNamed:@"type_one"]];

    
//    UIView *typeView = [[UIView alloc]initWithFrame:CGRectMake(kWidth - 80, 30, 70, 25)];
//    
//    typeView.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"type_one"] ];
    
    self.orderTypeBgImg = typeView;
    
    [self.contentView addSubview:typeView];
    
    UILabel *typeLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, -3, 50, 20)];
    
    typeLabel.text = @"已报道";
    typeLabel.textColor = [UIColor whiteColor];
    typeLabel.font = BoldFontWithSize(14);
    typeLabel.textAlignment = NSTextAlignmentCenter;
    
    self.orderTypeName = typeLabel;
    
    [typeView addSubview:typeLabel];
    
    return self;
}

- (void)setOrder:(OrderModel *)order
{
    _order = order;
    
    _orderNameLabel.attributedText = [self nameattr:order.userName];
    
    _orderContentLabel.text = order.productInfo;
    
    if (order.fenqi) {
        _isFenQI.hidden = YES;
    }

    _orderTimeLabel.text =[self getStamptimeWithString:order.addtime andSec:NO];

}


//-(void)

- (NSMutableAttributedString *)nameattr:(NSString *)name
{
    NSString *str = [NSString stringWithFormat:@"%@ 报名您的驾校",name];
    
    NSMutableAttributedString *nameAttr = [[NSMutableAttributedString alloc]initWithString:str];
    
    //设置字号
    [nameAttr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14.0] range:NSMakeRange(0, nameAttr.length)];
    //设置文字颜色
    [nameAttr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#82a4c3"] range:NSMakeRange(0, nameAttr.length)];
    
    [nameAttr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#999999"] range:NSMakeRange(nameAttr.length - 7, 7)];
    
    return nameAttr;
}


- (void)setrightState:(NSString *)str andImage:(NSString *)name
{
    _orderTypeName.text = str;

    _orderTypeBgImg.image = [UIImage imageNamed:name];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
