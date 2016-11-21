//
//  User.m
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/8/9.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import "User.h"

@implementation User

static User *_instance;

+ (instancetype)sharedUser
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}
- (instancetype)init
{
    if (self = [super init])
    {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            // 加载资源
        });
    }
    return self;
}

+(instancetype)userWithDict:(NSDictionary *)dict
{
    User *user = [User sharedUser];
    user.uid = dict[@"uid"];
    user.token = dict[@"token"];

    user.face = dict[@"face"];
    user.state = [dict[@"state"] intValue];
    user.nickName = dict[@"nickname"];
    user.phone = [dict[@"phone"] intValue];

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:user.uid forKey:@"kUid"];
    [defaults setValue:user.token forKey:@"kToken"];
    [defaults setValue:user.nickName forKey:@"kNickName"];
    [defaults setValue:user.face forKey:@"kFace"];
    [defaults setValue:@(user.state) forKey:@"kState"];
    
    [defaults setObject:@"1" forKey:@"isLogin"];

    [defaults synchronize];
    return user;
}

@end
