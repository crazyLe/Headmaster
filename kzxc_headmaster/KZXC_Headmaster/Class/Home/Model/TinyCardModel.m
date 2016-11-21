//
//  TinyCardModel.m
//  KZXC_Headmaster
//
//  Created by gaobin on 16/8/13.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import "TinyCardModel.h"

@implementation TinyCardModel

+ (NSDictionary *)mj_objectClassInArray {
    
    return @{@"classCar":[TinyClassCarModel class],@"classTime":[TinyClassTimeModel class],@"classes":[TinyClassesModel class]};
    
}


@end
