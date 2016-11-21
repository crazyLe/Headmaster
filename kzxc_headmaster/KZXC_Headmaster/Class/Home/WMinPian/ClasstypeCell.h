//
//  ClasstypeCell.h
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/8/12.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TinyClassesModel.h"
@class ClasstypeCell;
@protocol   ClasstypeCellDelegate<NSObject>

-(void)classtypeCell:(ClasstypeCell *)cell didClickDeleteBtnModel:(TinyClassesModel *)model;

@end

@interface ClasstypeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *showmsg;

@property(strong,nonatomic)TinyClassesModel *model;

@property(assign,nonatomic)NSInteger row;

@property(nonatomic,weak)id<ClasstypeCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;


@end
