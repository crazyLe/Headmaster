//
//  PersonalInfoModel.h
//  KZXC_Headmaster
//
//  Created by gaobin on 16/8/9.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonalInfoModel : NSObject

@property (nonatomic, copy) NSString * address;     //经纬度
@property (nonatomic, copy) NSString * age;         //年龄
@property (nonatomic, copy) NSString * areaId;      //区/县 编号
@property (nonatomic, copy) NSString * cityId;      //城市号
@property (nonatomic, copy) NSString * face;        //头像
@property (nonatomic, copy) NSString * nickName;    //昵称
@property (nonatomic, copy) NSString * phone;       //手机号
@property (nonatomic, copy) NSString * provinceId;  //省编号
@property (nonatomic, copy) NSString * sex;         //性别
@property (nonatomic, copy) NSString * trueName;    //真实姓名
@property (nonatomic, copy) NSString * introduce;
@property (nonatomic, copy) NSString * schoolName;  //驾校名称
@property (nonatomic, copy) NSString * beans;       //赚豆余额
@property (nonatomic, copy) NSString * isver;       //是否已认证
@property (nonatomic, copy) NSString * addressname; //个人详细地址
@property (nonatomic, copy) NSString * isbindBack;  //银行卡是否绑定

@end
