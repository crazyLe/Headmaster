//
//  RechargeViewController.h
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/7/21.
//  Copyright © 2016年 cqingw. All rights reserved.
//

typedef void(^dou_updateBlock)(NSString *);

#import <UIKit/UIKit.h>

@interface RechargeViewController : UIViewController

@property(copy,nonatomic)dou_updateBlock dou_update;

@end
