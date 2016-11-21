//
//  ArticleModel.h
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/8/12.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArticleModel : NSObject

@property(copy,nonatomic)NSString *articleContent;
@property(copy,nonatomic)NSString *articleId;
@property(copy,nonatomic)NSString *articleLike;
@property(copy,nonatomic)NSString *articleTitle;
@property(copy,nonatomic)NSString *articleUrl;
@property(copy,nonatomic)NSString *articleView;

@property(copy,nonatomic)NSString *image;
@property(copy,nonatomic)NSString *typeId;

@end
