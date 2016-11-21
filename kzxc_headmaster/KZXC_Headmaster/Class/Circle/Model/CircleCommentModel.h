//
//  CircleCommentModel.h
//  学员端
//
//  Created by zuweizhong  on 16/7/26.
//  Copyright © 2016年 Anhui Shengshi Kangzhuang Network Technology Development Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CircleCommentModel : NSObject

@property(nonatomic,copy)NSString * face;

@property(nonatomic,copy)NSString * nickname;

@property(nonatomic,copy)NSString * content;

@property(nonatomic,copy)NSString * addtime;

@property(nonatomic,assign)int  idNum;

@property(nonatomic,assign)int  isamazing;

@property(nonatomic,assign)int  likeNum;

@property(nonatomic,assign)int is_praise;

@end
