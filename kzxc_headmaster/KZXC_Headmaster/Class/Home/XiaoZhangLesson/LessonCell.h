//
//  LessonCell.h
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/7/12.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticleModel.h"

@interface LessonCell : UITableViewCell
//左侧主图片
@property (weak, nonatomic) IBOutlet UIImageView *leftmainImg;
//课程标题
@property (weak, nonatomic) IBOutlet UILabel *lessonTitle;
//课程简要内容
@property (weak, nonatomic) IBOutlet UILabel *lessonContent;
//好评数
@property (weak, nonatomic) IBOutlet UILabel *goodNum;
//查看数
@property (weak, nonatomic) IBOutlet UILabel *seeNum;
@property (weak, nonatomic) IBOutlet UIButton *zan;

@property(strong,nonatomic)ArticleModel *model;

@end
