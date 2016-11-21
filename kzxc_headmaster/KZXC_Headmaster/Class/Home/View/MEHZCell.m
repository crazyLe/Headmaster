//
//  MEHZCell.m
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/7/20.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import "MEHZCell.h"
#import "UIColor+Hex.h"
#import "NSString+Size.h"

@implementation MEHZCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
  
    _personnum.layer.cornerRadius = 5;
    _personnum.layer.borderColor = [UIColor colorWithHexString:@"#fea700"].CGColor;
    _personnum.layer.borderWidth = 1.0;
    
    _placestatue.layer.cornerRadius = 5;
    _placestatue.layer.borderColor = [UIColor colorWithHexString:@"#ff6866"].CGColor;
    _placestatue.layer.borderWidth = 1.0;
}
- (IBAction)ownClick:(UIButton *)sender {
    
    self.push(_examQuotaRelease);
}
- (void)setExamQuotaRelease:(ExamQuotaReleaseModel *)examQuotaRelease {
    
    _examQuotaRelease = examQuotaRelease;
    //填省市
    //self.place.text = examQuotaRelease.adress;
    NSArray * provinceArr = kProvinceDict;
    NSString * provinceStr = nil;
    for (NSDictionary * dic in provinceArr) {
        if ([dic[@"id"] isEqualToString:examQuotaRelease.provinceId]) {
            provinceStr = dic[@"title"];
        }
    }
    NSArray *cityArr = kCityDict;
    NSString * cityStr = nil;
    for (NSDictionary *dic in cityArr) {
        if ([dic[@"id"] isEqualToString:examQuotaRelease.cityId]) {
            cityStr = dic[@"title"];
        }
    }

    self.place.text = [NSString stringWithFormat:@"%@ %@",provinceStr,cityStr];
    
    self.personnum.text = [examQuotaRelease.peopleNum isEqualToString:@"0"]?nil:[NSString stringWithFormat:@"%@人",examQuotaRelease.peopleNum];
    self.personnum.text = [NSString stringWithFormat:@"%@人",examQuotaRelease.peopleNum];
    CGSize personNumSize = [NSString string:self.personnum.text sizeWithFont:[UIFont systemFontOfSize:14] maxSize:CGSizeMake(100, CGFLOAT_MAX)];
    _personNumWidth.constant = personNumSize.width + 10;
    
    self.placestatue.text = examQuotaRelease.region;
    CGSize placeStatueSize = [NSString string:self.placestatue.text sizeWithFont:[UIFont systemFontOfSize:14] maxSize:CGSizeMake(150, CGFLOAT_MAX)];
    _placeStatueWidth.constant = placeStatueSize.width + 10;
    
    self.explain.text = examQuotaRelease.content;
    NSString * timeString = [Utilities calculateTimeWithFaceTimeDayTarget:examQuotaRelease.addtime];
    self.time.text = timeString;
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
