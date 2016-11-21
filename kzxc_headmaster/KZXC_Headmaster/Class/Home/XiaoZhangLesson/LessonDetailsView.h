//
//  LessonDetailsView.h
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/7/12.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeBannerView.h"
#import "ArticleModel.h"
#import "BannerModel.h"

@protocol LessonDetailsDelegate <NSObject>

@optional
//被点击的组数
- (void)LessonDetailsSectionCellisClick:(NSInteger)section andArticle:(ArticleModel *)model;
- (void)LessonDetailsBannerisClick:(BannerModel *)model;

@end

@interface LessonDetailsView : UIView <HomeBannerViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSInteger curpage;
}

@property(weak,nonatomic)id <LessonDetailsDelegate> delegate;

@property(weak,nonatomic)UITableView *lessonTable;

@property(strong,nonatomic)NSArray *modelarr;

@property(strong,nonatomic)NSArray *bannerArr;

@property(strong,nonatomic)HomeBannerView *bannerView;

//@property(assign,nonatomic)NSInteger tag;

//+(void)reloadtable;

@end
