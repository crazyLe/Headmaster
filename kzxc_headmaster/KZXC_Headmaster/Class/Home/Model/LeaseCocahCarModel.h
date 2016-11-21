//
//  LeaseCocahCarModel.h
//  KZXC_Headmaster
//
//  Created by gaobin on 16/8/10.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LeaseCocahCarModel : NSObject

//此model用于 教练车,训练场地的编辑保存
@property (nonatomic, copy) NSString * address;     //地址
@property (nonatomic, copy) NSString * priceDay;
@property (nonatomic, copy) NSString * priceWeek;
@property (nonatomic, copy) NSString * priceMonth;
@property (nonatomic, copy) NSString * priceQuarter;
@property (nonatomic, copy) NSString * priceYear;
@property (nonatomic, copy) NSString * carType;
@property (nonatomic, copy) NSString * carAge;
@property (nonatomic, copy) NSString * carKm;
@property (nonatomic, copy) NSString * carNum;
@property (nonatomic, copy) NSString * trueName;    //发布者
@property (nonatomic, copy) NSString * tel;
@property (nonatomic, copy) NSString * provinceId;
@property (nonatomic, copy) NSString * cityId;
@property (nonatomic, copy) NSString * areaId;


//场地字段
@property (nonatomic, copy) NSString * size;         //面积
@property (nonatomic, copy) NSString * garageNum;    //车库数量
@property (nonatomic, copy) NSString * carMax;       //容量
@property (nonatomic, copy) NSString * subjectId;    //科目

@end
