//
//  TinyCardModel.h
//  KZXC_Headmaster
//
//  Created by gaobin on 16/8/13.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TinySchoolModel.h"
#import "TinyClassCarModel.h"
#import "TinyClassTimeModel.h"
#import "TinyClassesModel.h"

@interface TinyCardModel : NSObject

@property (nonatomic, strong) TinySchoolModel * School;
@property (nonatomic, strong) NSMutableArray<TinyClassCarModel *> * classCar;
@property (nonatomic, strong) NSMutableArray<TinyClassTimeModel *> * classTime;
@property (nonatomic, strong) NSMutableArray<TinyClassesModel *> *classes;



@end
