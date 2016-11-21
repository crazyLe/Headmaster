//
//  PurseViewController.h
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/7/20.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PurseViewController : UIViewController


@property (weak, nonatomic) IBOutlet UIImageView *mineImg;
@property (weak, nonatomic)  UILabel *myName;
@property (weak, nonatomic)  UIImageView *vip;
@property (weak, nonatomic) IBOutlet UIImageView *xin;
@property (weak, nonatomic) IBOutlet UILabel *money;

@property (weak, nonatomic) IBOutlet UIButton *chingzhi;

@property (weak, nonatomic) IBOutlet UIButton *tixian;
@property (weak, nonatomic) IBOutlet UILabel *orderNum;

@property (weak, nonatomic) IBOutlet UILabel *ownMoney;
@property (weak, nonatomic) IBOutlet UIView *topView;


@end
