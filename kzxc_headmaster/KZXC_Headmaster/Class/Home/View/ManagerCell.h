//
//  ManagerCell.h
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/7/19.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RecruitCoach,ManagerCell;

@protocol ManagerCellDelegate <NSObject>

@optional

-(void)clickedButtontag:(NSInteger)tag andCell:(ManagerCell *)cell;

@end


@interface ManagerCell : UITableViewCell<UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *headimg;

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *totalnum;
@property (weak, nonatomic) IBOutlet UIButton *phone;
@property (weak, nonatomic) IBOutlet UIButton *reward;
@property (weak, nonatomic) IBOutlet UIButton *btndelete;

@property(assign,nonatomic)NSInteger sec;

@property(weak,nonatomic)id<ManagerCellDelegate> delegate;

@property(strong,nonatomic)RecruitCoach *coach;


@end
