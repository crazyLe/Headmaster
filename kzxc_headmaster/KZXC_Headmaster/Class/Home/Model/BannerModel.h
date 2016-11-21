//
//  BannerModel.h
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/8/11.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BannerModel : NSObject
//图片地址
@property(copy,nonatomic)NSString *imgUrl;
//1不能点击、2跳转到原生页面、3跳转到wap
@property(copy,nonatomic)NSString *pageType;
//Wap页面地址或原生页面标签
@property(copy,nonatomic)NSString *pageUrl;
@end
