//
//  PopView.h
//  KKXC_Franchisee
//
//  Created by 翁昌青 on 16/8/18.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "logout.h"

@interface PopView : UIView

@property(strong,nonatomic)logout *logoutview;

+ (instancetype)logoutWithPopview;

- (void)show;

@end
