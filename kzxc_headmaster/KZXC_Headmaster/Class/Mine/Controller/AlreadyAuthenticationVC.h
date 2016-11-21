//
//  AlreadyAuthenticationVC.h
//  KZXC_Headmaster
//
//  Created by gaobin on 16/8/11.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RealNameModel.h"
#import "PersonalInfoModel.h"

@interface AlreadyAuthenticationVC : UIViewController

@property (nonatomic, strong) RealNameModel * realName ;
@property (nonatomic, strong) PersonalInfoModel *  personalInfo;

//声明bool类型,判断是从哪里跳转来的(前后两个界面)
@property (nonatomic, assign) BOOL isFromMineVC;

@end
