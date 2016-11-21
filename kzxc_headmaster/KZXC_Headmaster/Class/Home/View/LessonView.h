//
//  LessonView.h
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/7/12.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LessonViewDelegate <NSObject>

@optional 

- (void)lessonViewWithIndex:(NSInteger)index title:(NSString *)title;

@end

@interface LessonView : UIView

@property(weak,nonatomic)id<LessonViewDelegate> delegate;

- (void)LessonViewWithTitleArrays:(NSArray *)titleArray;

- (void)updateLesssonViewStatueWithTag:(NSInteger)tag;

@end
