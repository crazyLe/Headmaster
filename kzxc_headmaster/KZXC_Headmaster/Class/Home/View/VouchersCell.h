//
//  VouchersCell.h
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/7/19.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DDJModel,VouchersCell;

@protocol VouchersCellDelegate <NSObject>

@optional
- (void)clickedCell:(VouchersCell *)cell;

@end

@interface VouchersCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *leftbg;
@property (weak, nonatomic) IBOutlet UIImageView *rightbg;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UIButton *send;

@property (weak, nonatomic) IBOutlet UILabel *juan;

@property(weak,nonatomic)id<VouchersCellDelegate> delegate;

@property(strong,nonatomic)DDJModel *model;

@end
