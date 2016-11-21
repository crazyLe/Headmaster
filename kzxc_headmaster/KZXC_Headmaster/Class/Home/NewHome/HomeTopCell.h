//
//  HomeTopCell.h
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/8/6.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HomeTopCellDelegate <NSObject>
@optional
- (void)topClickedBtn:(UIButton *)btn;
@end

@interface HomeTopCell : UITableViewCell
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *firleft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *secleft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *thileft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *four;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;
@property (weak, nonatomic) IBOutlet UIButton *btn4;

@property(weak,nonatomic)id <HomeTopCellDelegate> delegate;

@end
