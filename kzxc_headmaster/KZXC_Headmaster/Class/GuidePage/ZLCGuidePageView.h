//
//  ZLCGuidePageView.h
//  GuidePage_Test
//
//  Created by shining3d on 16/6/7.
//  Copyright © 2016年 shining3d. All rights reserved.
//

#import <UIKit/UIKit.h>


//typedef void(^joinLogin)();

@protocol ZLCGuidePageViewDelete <NSObject>

@optional
- (void)joinHome;

@end


@interface ZLCGuidePageView : UIView<UIScrollViewDelegate>



@property UIPageControl *imagePageControl;
@property UIScrollView  *guidePageView;
@property(weak,nonatomic)id <ZLCGuidePageViewDelete >delegate;

//@property(copy,nonatomic)joinLogin join;

- (instancetype)initWithFrame:(CGRect)frame WithImages:(NSArray *)images;


@end
