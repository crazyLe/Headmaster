//
//  LeaseScrollCell.h
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/7/21.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CocahCarDetailModel.h"


@interface LeaseScrollCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIScrollView *banner;
@property (weak, nonatomic) IBOutlet UILabel *drivingname;


@property (nonatomic, strong) UIImageView *imgview;

@property (nonatomic, strong) CocahCarDetailModel * cocahCarDetail;



@end
