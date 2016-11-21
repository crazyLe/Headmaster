//
//  MsgCenterCell.h
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/7/22.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MsgModel.h"
@interface MsgCenterCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *msgtitle;
@property (weak, nonatomic) IBOutlet UILabel *msgtime;
@property (weak, nonatomic) IBOutlet UILabel *msgcontent;

@property(strong,nonatomic)MsgModel *model;

@end
