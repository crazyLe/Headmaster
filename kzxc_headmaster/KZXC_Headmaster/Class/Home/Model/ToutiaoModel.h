//
//  ToutiaoModel.h
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/8/11.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToutiaoModel : NSObject
//头条编号
@property(copy,nonatomic)NSString *communityId;
//头条标题
@property(copy,nonatomic)NSString *communityTitle;
//头条路径
@property(copy,nonatomic)NSString *communityUrl;
@end
