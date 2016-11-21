//
//  TailorUploadCell.h
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/7/15.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TailorUploadCellDelegate <NSObject>

@optional
- (void)tailorUploadCellWithIndex:(NSInteger)index currentBtn:(UIButton *)currentBtn;

@end
@interface TailorUploadCell : UITableViewCell
@property(weak,nonatomic)id <TailorUploadCellDelegate> delegate;
@property(strong,nonatomic)NSArray *cerArray;
@end
