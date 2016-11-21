//
//  OrderCell.h
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/7/13.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OrderModel;

@interface OrderCell : UITableViewCell

@property(weak,nonatomic)UIView *orderMainView;

@property(weak,nonatomic)UIImageView *orderHeadImg;

@property(weak,nonatomic)UILabel *orderNameLabel;
@property(weak,nonatomic)UILabel *orderContentLabel;
@property(weak,nonatomic)UILabel *orderTimeLabel;

@property(weak,nonatomic)UIImageView *orderTypeBgImg;
@property(weak,nonatomic)UILabel *orderTypeName;

@property(strong,nonatomic)OrderModel *order;

@property(weak,nonatomic)UILabel *isFenQI;

- (void)setrightState:(NSString *)str andImage:(NSString *)name;

@end
