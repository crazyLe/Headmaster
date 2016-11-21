//
//  HomeBannerView.h
//  wills
//
//  Created by ai_ios on 16/4/18.
//  Copyright © 2016年 ai_ios. All rights reserved.
//定时器轮播图

#import <UIKit/UIKit.h>
@class HomeBannerView ,BannerModel;

@protocol HomeBannerViewDelegate <NSObject>
@optional
- (void)homeBannerView:(HomeBannerView*)View withindex:(NSString*)index ;
- (void)homeBannerViewCilekedBanner:(BannerModel *)model;
@end
@interface HomeBannerView : UIView

@property (nonatomic, retain) UIScrollView *scrollview;
@property (nonatomic, copy) NSString *scrollerFrom;
@property (nonatomic, weak) id<HomeBannerViewDelegate> delegate;
- (instancetype)initWithFrame:(CGRect)frame placeImgName:(NSString *)imgName isHomePage:(BOOL)isHomePage;
- (instancetype)initWithFrame:(CGRect)frame placeImgName:(NSString *)imgName scrollerFrom:(NSString*)scrollerFrom;
- (instancetype)initWithFrame:(CGRect)frame placeImgName:(NSString *)imgName;

/**
 *  刷新banner
 *
 *  @param array 数组参数：数组里存的数组，二层数组里存：图片的URL、跳转的URL、类型（可以没有，只有积分主页要用）
 */
- (void)refreshData:(NSArray *)array;

@end
