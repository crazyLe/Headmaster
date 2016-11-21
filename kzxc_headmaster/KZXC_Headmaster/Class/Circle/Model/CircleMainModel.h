//
//  CircleMainModel.h
//  学员端
//
//  Created by zuweizhong  on 16/7/26.
//  Copyright © 2016年 Anhui Shengshi Kangzhuang Network Technology Development Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CircleCommentModel.h"
@interface CircleMainModel : NSObject

@property(nonatomic,copy)NSString * face;

@property(nonatomic,copy)NSString * nickName;

@property(nonatomic,copy)NSString * content;

@property(nonatomic,strong)NSArray<NSDictionary *> * pic;

@property(nonatomic,copy)NSString * addtime;

@property(nonatomic,copy)NSString * area;

@property(nonatomic,strong)CircleCommentModel * comemnt;

@property(nonatomic,assign)int isTop;

@property(nonatomic,assign)int commentNum;

@property(nonatomic,assign)int idNum;

@property(nonatomic,assign)int likeNum;

@property(nonatomic,assign)int shareNum;

@property(nonatomic,copy)NSString * url;

@property(nonatomic,assign)int user_type;

@property(nonatomic,assign)int is_ver;

@property(nonatomic,assign)int is_praise;



@end
