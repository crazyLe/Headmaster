//
//  ContentLeaseCell.h
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/7/21.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NomalLeaseController.h"

@interface ContentLeaseCell : UITableViewCell<UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imgtype;
@property (weak, nonatomic) IBOutlet UILabel *imgtitle;
@property (weak, nonatomic) IBOutlet UILabel *firlabel;
@property (weak, nonatomic) IBOutlet UILabel *thilabel;
@property (weak, nonatomic) IBOutlet UILabel *seclabel;
@property (weak, nonatomic) IBOutlet UILabel *dayprice;
@property (weak, nonatomic) IBOutlet UILabel *weekprice;
@property (weak, nonatomic) IBOutlet UILabel *weekhui;

@property (weak, nonatomic) IBOutlet UILabel *mouthprice;
@property (weak, nonatomic) IBOutlet UILabel *mouthhui;
@property (weak, nonatomic) IBOutlet UILabel *quarterhui;

@property (weak, nonatomic) IBOutlet UILabel *quarterprice;
@property (weak, nonatomic) IBOutlet UILabel *yearprice;
@property (weak, nonatomic) IBOutlet UILabel *yearhui;

@property (weak, nonatomic) IBOutlet UILabel *address;

@property (weak, nonatomic) IBOutlet UILabel *tips;

@property(weak,nonatomic)NSString *phone;


@property (weak, nonatomic) IBOutlet UIView *firview;
@property (weak, nonatomic) IBOutlet UIView *secview;
@property (weak, nonatomic) IBOutlet UIView *thiview;
@property (weak, nonatomic) IBOutlet UIView *fourview;

@property (nonatomic, strong) NomalLeaseController * delegate;

@end







