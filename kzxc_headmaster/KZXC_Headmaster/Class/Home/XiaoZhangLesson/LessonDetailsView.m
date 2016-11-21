//
//  LessonDetailsView.m
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/7/12.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import "LessonDetailsView.h"
#import "LessonDetailsController.h"
#import "LessonCell.h"

@implementation LessonDetailsView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _bannerView = [[HomeBannerView alloc]initWithFrame:CGRectMake(0, 0, kWidth, 110) placeImgName:@"placeBanner" isHomePage:YES];
        _bannerView.delegate = self;
        _bannerView.backgroundColor = [UIColor clearColor];
        
        
        UITableView *lesson = [[UITableView alloc]init];
        lesson.separatorStyle = UITableViewCellSeparatorStyleNone;
        lesson.tableHeaderView = _bannerView;
        lesson.delegate = self;
        lesson.dataSource = self;
        self.lessonTable = lesson ;
        [self addSubview:lesson];
        [lesson mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(@0);
            make.left.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(kWidth, kHeight - 64));
        }];
        
        lesson.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            curpage++;
            [NOTIFICATION_CENTER postNotificationName:@"articleLoadMore" object:self userInfo:@{@"curpage":@(curpage),@"table":lesson}];
        }];
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.modelarr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellStr = @"identify";
    
    LessonCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    
    if (!cell) {
        
        cell = [[NSBundle mainBundle] loadNibNamed:@"LessonCell" owner:nil options:nil].firstObject;
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.model = [self.modelarr objectAtIndex: indexPath.section];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    
    if ([_delegate respondsToSelector:@selector(LessonDetailsSectionCellisClick:andArticle:)]) {
        [self.delegate LessonDetailsSectionCellisClick:indexPath.section andArticle:_modelarr[indexPath.section]];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 105;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 15;
}

- (void)homeBannerViewCilekedBanner:(BannerModel *)model
{
    if ([_delegate respondsToSelector:@selector(LessonDetailsBannerisClick:)]) {
        [_delegate LessonDetailsBannerisClick:model];
    }
}

@end
