//
//  RecruitCell.h
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/7/18.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RecruitCoach,RecruitCell;
typedef void(^giveReward)(RecruitCell *cell);

@interface RecruitCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headimg;
@property (weak, nonatomic) IBOutlet UILabel *time;

@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UILabel *personnum;

@property (weak, nonatomic) IBOutlet UIButton *giveBtn;

@property(copy,nonatomic)giveReward give;

@property(strong,nonatomic)RecruitCoach *coach;

@end
