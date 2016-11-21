//
//  SendCircleMessegeController.h
//  学员端
//
//  Created by zuweizhong  on 16/7/29.
//  Copyright © 2016年 Anhui Shengshi Kangzhuang Network Technology Development Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HClTextView.h"
@interface SendCircleMessegeController : UIViewController

@property (weak, nonatomic) HClTextView *textView;

@property(nonatomic,copy)NSString * communityType;


@end
