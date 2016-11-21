//
//  CocahCarDetailModel.h
//  KZXC_Headmaster
//
//  Created by gaobin on 16/8/10.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PicModel.h"

@interface CocahCarDetailModel : NSObject

//此model用于 教练车详情,训练场详情
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
@property (nonatomic, copy) NSString * Other;       //其他信息,备注
@property (nonatomic, strong) PicModel * pic;         //图片
@property (nonatomic, copy) NSString * trueName;    //发布者
@property (nonatomic, copy) NSString * tel;         //联系方式

@property (nonatomic, copy) NSString * Size;        //面积
@property (nonatomic, copy) NSString * garageNum;   //车库数量
@property (nonatomic, copy) NSString * CarMax;      //车数量
@property (nonatomic, copy) NSString * subjectId;   //科目编号：1,2
@property (nonatomic, copy) NSString * Address;     //场地地址
@property (nonatomic, copy) NSString * size;         //面积
@property (nonatomic, copy) NSString * carMax;       //容量


@end
