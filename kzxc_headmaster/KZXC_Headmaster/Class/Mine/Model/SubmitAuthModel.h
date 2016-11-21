//
//  SubmitAuthModel.h
//  KZXC_Headmaster
//
//  Created by gaobin on 16/8/12.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SubmitAuthModel : NSObject

@property (nonatomic, copy) NSString * trueName;
@property (nonatomic, copy) NSString * IDNum;
@property (nonatomic, copy) NSString * IDPic;       //身份证本地图片
@property (nonatomic, copy) NSString * companyPic;  //营业执照图
@property (nonatomic, copy) NSString * schoolPic;   //办学资质图

@end
