//
//  User.h
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/8/9.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

 + (instancetype)sharedUser;

@property(copy,nonatomic)NSString *token;
@property(copy,nonatomic)NSString *uid;
@property(copy,nonatomic)NSString *face;
@property(copy,nonatomic)NSString *nickName;

@property(assign,nonatomic)int phone;
@property(assign,nonatomic)int state;



+(instancetype)userWithDict:(NSDictionary *)dict;

@end
