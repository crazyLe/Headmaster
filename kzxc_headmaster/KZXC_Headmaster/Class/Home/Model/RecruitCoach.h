//
//  RecruitCoach.h
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/8/9.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecruitCoach : NSObject
//用户编号（非注册反回0）
@property(copy,nonatomic)NSString *userId;
//教练姓名
@property(copy,nonatomic)NSString *userName;
//教练头像
@property(copy,nonatomic)NSString *face;
//日期
@property(copy,nonatomic)NSString *date;
//招生数量
@property(copy,nonatomic)NSString *peopleNum;
//手机号
@property(copy,nonatomic)NSString *phone;
//状态
@property (nonatomic, copy) NSString * state;

@end
