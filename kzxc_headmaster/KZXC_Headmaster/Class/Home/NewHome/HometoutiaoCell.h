//
//  HometoutiaoCell.h
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/8/9.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BBCyclingLabel,ToutiaoModel,HometoutiaoCell;

@protocol HometoutiaoCellDelegate <NSObject>
@optional
- (void)toutiaoMoreClick:(HometoutiaoCell *)cell;

- (void)toutiaoClickpushWeb:(NSString *)url;
@end

@interface HometoutiaoCell : UITableViewCell
{
    int a;
    ToutiaoModel *model;
}
@property(strong,nonatomic)NSArray *titles;
@property (weak, nonatomic) IBOutlet UIButton *toumingbtn;
@property(strong,nonatomic)BBCyclingLabel *bbCyclingLable;
@property(weak,nonatomic)id <HometoutiaoCellDelegate> delegate;


@end
