//
//  MineMsgController.m
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/7/22.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import "MineMsgController.h"
#import "MineMsgCell.h"

@interface MineMsgController ()<UITableViewDataSource,UITableViewDelegate>
{
    int lastIndex;
}
@property(weak,nonatomic)UITableView *table;

@end

@implementation MineMsgController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGBColor(247,247,247);
    
    [self setupNav];
    
    [self setupTable];
}

- (void)setupNav
{
    
    UIView *segview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 30)];
    segview.layer.cornerRadius = 3;
    segview.layer.borderWidth = 1;
    segview.layer.borderColor = [UIColor whiteColor].CGColor;
    
    UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100 ,30)];
    btn1.tag = 101;
    lastIndex = 101;
    [btn1 setTitle:@"新消息" forState:UIControlStateNormal];
    btn1.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [btn1 setTitleColor:NavBackColor forState:UIControlStateSelected];
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [btn1 setBackgroundImage:[UIImage imageNamed:@"seg_left_s"] forState:UIControlStateSelected];
    [btn1 setBackgroundImage:[UIImage imageNamed:@"seg_left_n"] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(segBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    btn1.selected = YES;
    [segview addSubview:btn1];
    
    UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(100, 0, 100, 30)];
    btn2.tag = 102;
    [btn2 setTitle:@"已发布" forState:UIControlStateNormal];
    btn2.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [btn2 setTitleColor:NavBackColor forState:UIControlStateSelected];
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [btn2 setBackgroundImage:[UIImage imageNamed:@"seg_right_s"] forState:UIControlStateSelected];
    [btn2 setBackgroundImage:[UIImage imageNamed:@"seg_right_n"] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(segBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [segview addSubview:btn2];
    
    self.navigationItem.titleView = segview;
    
}

- (void)segBtnClick:(UIButton *)sender
{
    NSInteger tag = sender.tag;
    
    if (0 != lastIndex) {
        UIButton *btn = [self.navigationItem.titleView viewWithTag:lastIndex];
        btn.selected = NO;
    }
    
    sender.selected = YES;
    lastIndex = (int)tag;
}

- (void)setupTable
{
    CGRect tableFream = CGRectMake(0, 10 , kWidth, 85 * 4);
    UITableView *loctable = [[UITableView alloc]initWithFrame:tableFream];
    
    loctable.backgroundColor = [UIColor whiteColor];
    loctable.scrollEnabled = NO;
    loctable.separatorStyle = UITableViewCellSeparatorStyleNone;
    loctable.dataSource = self;
    loctable.delegate = self;
    self.table = loctable;
    
    [self.view addSubview:loctable];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    NSInteger section = indexPath.section;
//    
//    NSInteger row = indexPath.row;
    
    static NSString *cellID = @"minemsgID";
    
    MineMsgCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        
        cell = [[NSBundle mainBundle] loadNibNamed:@"MineMsgCell" owner:nil options:nil].firstObject;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
