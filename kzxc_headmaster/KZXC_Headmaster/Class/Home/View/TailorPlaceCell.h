//
//  TailorPlaceCell.h
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/7/15.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TailorPlaceCell;

@protocol TailorPlaceCellDelegate <NSObject>

@optional
- (void)tailorPlaceCellTapImageViewWithSelf:(TailorPlaceCell *)cell index:(int)index;

@end

@interface TailorPlaceCell : UITableViewCell

@property(weak,nonatomic)id <TailorPlaceCellDelegate> delegate;

@property(nonatomic,strong)NSMutableArray * imageviewArray;

@end
