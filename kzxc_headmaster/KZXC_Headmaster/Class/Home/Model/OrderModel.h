//
//  OrderModel.h
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/7/14.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderModel : NSObject
//订单编号
@property(copy,nonatomic)NSString *order_id;
//用户名称
@property(copy,nonatomic)NSString *userName;
//时间
@property(copy,nonatomic)NSString *addtime;
//是否分期
@property(assign,nonatomic,getter=isFenqi)BOOL fenqi;
//详情
@property(copy,nonatomic)NSString *productInfo;
//头像
@property(copy,nonatomic)NSString *face;


@end
