//
//  WMPPopView.h
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/8/16.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TinyClassesModel.h"
@protocol WMPPopViewDelegate <NSObject>

@optional
- (void)surebtnClicked:(NSString *)content;

- (void)surebtnClickedsendName:(NSString *)name andPrice:(NSString *)price andDrvingtype:(NSString *)type andXuetime:(NSString *)time andOthertime:(NSString *)othertime classesModelId:(NSString *)idNum;

- (void)deleteselfrow:(NSInteger)row;
@end

@interface WMPPopView : UIView<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>

@property(weak,nonatomic)UITableView *table;

@property(strong,nonatomic)UIView *introduce;

@property(strong,nonatomic)UITextView *textview;
@property(assign,nonatomic)NSInteger row;

@property (nonatomic, strong) UILabel * placeLab;
@property(weak,nonatomic)id <WMPPopViewDelegate> delegate;

+(instancetype)PopViewWithIntroduce;

+(instancetype)PopViewWithTable;

- (void)showIntroduce;
-(void)showTable;

-(void)hidden;

@property(nonatomic,strong)TinyClassesModel *classesModel;


@end
