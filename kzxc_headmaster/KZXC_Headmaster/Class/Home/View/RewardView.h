//
//  RewardView.h
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/7/19.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RecruitCoach;
@interface RewardView : UIView


@property(weak,nonatomic)UILabel *name;
@property(weak,nonatomic)UILabel *dou;
@property(weak,nonatomic)UITextField *jiangliDou;
@property(strong,nonatomic)RecruitCoach *coach;
@property(copy,nonatomic)NSString *userid;

- (void)setName:(NSString *)name  andUserId:(NSString *)userid;
- (void)show;

@end
