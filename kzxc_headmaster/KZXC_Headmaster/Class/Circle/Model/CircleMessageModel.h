//
//  CircleMessageModel.h
//  学员端
//
//  Created by zuweizhong  on 16/8/19.
//  Copyright © 2016年 Anhui Shengshi Kangzhuang Network Technology Development Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CircleMessageModel : NSObject

@property(nonatomic,copy)NSString * communityUrl;

@property(nonatomic,assign)long addtime;

@property(nonatomic,assign)int communityId;

@property(nonatomic,copy)NSString * content;

@property(nonatomic,copy)NSString * desc;

@property(nonatomic,copy)NSString * imgUrl;

@property(nonatomic,assign)int is_read;

@property(nonatomic,copy)NSString * name;

@property(nonatomic,assign)int type;

@end
