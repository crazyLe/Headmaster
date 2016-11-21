//
//  PurseCell.h
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/7/20.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MonthModel.h"

@interface PurseCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UIImageView *headimg;
@property (weak, nonatomic) IBOutlet UILabel *douzi;
@property (weak, nonatomic) IBOutlet UILabel *classtype;

@property(strong,nonatomic)MonthModel *model;
@end
