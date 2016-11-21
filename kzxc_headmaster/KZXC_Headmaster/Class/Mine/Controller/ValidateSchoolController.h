//
//  ValidateSchoolController.h
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/7/22.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RealNameModel.h"
#import "PersonalInfoModel.h"

@interface ValidateSchoolController : UIViewController

//声明BOOL类型,判断是否是从已认证界面跳转进来的
@property (nonatomic, assign) BOOL isFromAlreadyAuth;

@property (nonatomic, strong) RealNameModel * realName ;
@property (nonatomic, strong) PersonalInfoModel *  personalInfo;

@end
