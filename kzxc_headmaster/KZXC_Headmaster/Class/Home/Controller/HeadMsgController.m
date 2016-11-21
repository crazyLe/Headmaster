//
//  HeadMsgController.m
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/7/14.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import "HeadMsgController.h"
#import "SystemDetailsvController.h"
#import "SysMsgCell.h"

@interface HeadMsgController ()<UITableViewDataSource,UITableViewDelegate>
@property(weak,nonatomic)UITableView *table;
@end

@implementation HeadMsgController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"系统消息";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f7f7f7"];
    // Do any additional setup after loading the view.
    [self setupTable];
}
- (void)setupTable
{
    CGRect tableFream = CGRectMake(0, 10 , kWidth, kHeight - 64);
    UITableView *loctable = [[UITableView alloc]initWithFrame:tableFream];
    
    loctable.backgroundColor = [UIColor whiteColor];
//    loctable.scrollEnabled = NO;
    loctable.separatorStyle = UITableViewCellSeparatorStyleNone;
    loctable.dataSource = self;
    loctable.delegate = self;
    self.table = loctable;
    
    [self.view addSubview:loctable];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellID = @"sysmsgID";
    
    SysMsgCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        
        cell = [[NSBundle mainBundle] loadNibNamed:@"SysMsgCell" owner:nil options:nil].firstObject;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SystemDetailsvController *sysDetails = [[SystemDetailsvController alloc]init];
    [self.navigationController pushViewController:sysDetails animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
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
