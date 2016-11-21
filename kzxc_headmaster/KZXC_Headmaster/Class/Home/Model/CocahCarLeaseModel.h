//
//  CocahCarLeaseModel.h
//  KZXC_Headmaster
//
//  Created by gaobin on 16/8/10.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PicModel.h"

@interface CocahCarLeaseModel : NSObject

//此model用于 教练车租赁列表, 教练车出租列表

@property (nonatomic, copy) NSString * idStr;           //教练车编号
@property (nonatomic, copy) NSString * picinfo;         //教练车图片
@property (nonatomic, copy) NSString * priceDay;        //日租金
@property (nonatomic, copy) NSString * priceWeek;       //周租金
@property (nonatomic, copy) NSString * priceMonth;      //月租金
@property (nonatomic, copy) NSString * priceQuarter;    //季租金
@property (nonatomic, copy) NSString * priceYear;       //年租金

@property (nonatomic, copy) NSString * carType;         //车型
@property (nonatomic, copy) NSString * carAge;          //车龄
@property (nonatomic, copy) NSString * carKm;           //公里数
@property (nonatomic, copy) NSString * carNum;          //车数

//训练场租赁
@property (nonatomic, copy) NSString * size;            //场地大小
@property (nonatomic, copy) NSString * address;         //详细地址

//@property (nonatomic, copy) NSString * money;           //教练车出租列表的日租金
@property (nonatomic, copy) NSString * other;           //备注

@property (nonatomic, copy) NSString * trueName;        //发布者
@property (nonatomic, copy) NSString * tel;

@property (nonatomic, copy) NSString * provinceId;
@property (nonatomic, copy) NSString * cityId;
@property (nonatomic, copy) NSString * areaId;

@property (nonatomic, copy) NSString * garageNum;       //车库数量
@property (nonatomic, copy) NSString * carMax;          //容量
@property (nonatomic, copy) NSString * subjectId;       //科目

@property (nonatomic, strong) PicModel * picModel;

@end
