//
//  CreateModifyMyCoachCarVC.h
//  KZXC_Headmaster
//
//  Created by gaobin on 16/8/15.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CocahCarLeaseModel.h"

@interface CreateModifyMyCoachCarVC : UIViewController

@property (nonatomic, assign) BOOL isNewAdd;

@property (nonatomic, strong) CocahCarLeaseModel * coachCarLeasee;

@end
