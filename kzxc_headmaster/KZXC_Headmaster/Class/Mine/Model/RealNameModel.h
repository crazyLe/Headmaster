//
//  RealNameModel.h
//  KZXC_Headmaster
//
//  Created by gaobin on 16/8/11.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RealNameModel : NSObject

@property (nonatomic, copy) NSString * trueName;
@property (nonatomic, copy) NSString * IDNum;       //身份证
@property (nonatomic, copy) NSString * IDPic;       //身份证照片
@property (nonatomic, copy) NSString * companyPic;  //营业执照图
@property (nonatomic, copy) NSString * schoolPic;   //办学资质图
@property (nonatomic, copy) NSString * state;       //判断认证状态




@end
