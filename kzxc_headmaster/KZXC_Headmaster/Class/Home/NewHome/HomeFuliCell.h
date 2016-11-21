//
//  HomeFuliCell.h
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/8/9.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HomeFuliCellDelegate <NSObject>
@optional
- (void)fuliClickedBtn:(UIButton *)btn;
@end

@interface HomeFuliCell : UITableViewCell
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *left;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *left2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnW;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;
@property (weak, nonatomic) IBOutlet UIButton *btn4;

@property(weak,nonatomic)id <HomeFuliCellDelegate> delegate;

@end
