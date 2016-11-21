//
//  MineCell.h
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/7/21.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UIImageView *jiantou;
@property (weak, nonatomic) IBOutlet UILabel *detailLab;

@end
