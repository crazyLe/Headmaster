//
//  InvitationCell.h
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/7/20.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import <UIKit/UIKit.h>

@class InvitationCell,RecruitCoach;
@protocol InvitationCellDelegate <NSObject>

@optional

-(void)clickedButtontag:(NSInteger)tag andCell:(InvitationCell *)cell;

@end

@interface InvitationCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *headimg;
@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;

@property(assign,nonatomic)NSInteger sec;

@property(weak,nonatomic)id<InvitationCellDelegate> delegate;

@property(strong,nonatomic)RecruitCoach *coach;

@end
