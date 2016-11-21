//
//  ManagerController.m
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/7/19.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import "ManagerController.h"
#import "UIColor+Hex.h"
#import "ManagerCell.h"
#import "RewardView.h"
#import "RecruitCoach.h"

@interface ManagerController ()<UITableViewDataSource,UITableViewDelegate,ManagerCellDelegate,UIAlertViewDelegate,CYLTableViewPlaceHolderDelegate>

{
    NSMutableArray *coachs;
    NSInteger cursec;
    NSString *curphone;
    NSString *curId;
    int curpage;
}
@property(weak,nonatomic)UITableView *table;

@end

@implementation ManagerController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"管理";
    self.view.backgroundColor = RGBColor(247, 247, 247);
    
    curpage = 1;
    
    CGRect tableFream = CGRectMake(0, 15 , kWidth, kHeight - 64);
    UITableView *loctable = [[UITableView alloc]initWithFrame:tableFream];
    
    loctable.backgroundColor = [UIColor whiteColor];

    loctable.separatorStyle = UITableViewCellSeparatorStyleNone;
    loctable.dataSource = self;
    loctable.delegate = self;
    self.table = loctable;
    
    [self.view addSubview:loctable];
    
//    loctable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//        curpage++;
//        [self loadData];
//        [loctable.mj_footer endRefreshing];
//    }];
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    MJRefreshAutoGifFooter *footer = [MJRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    // 设置尾部
    self.table.mj_footer = footer;
    
    // 设置文字
    [footer setTitle:@"" forState:MJRefreshStateIdle];
    
    [self loadData];
    
}

- (void)loadMoreData
{
    curpage++;
    [self loadData];
    [self.table.mj_footer endRefreshing];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return coachs.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"ManagerCell";
    
    ManagerCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    
    if (!cell) {
        
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ManagerCell" owner:nil options:nil] firstObject];
    
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.sec = indexPath.section;
    
    cell.coach = coachs[indexPath.section];
    
    cell.delegate = self;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 15;
}

- (UIView *)makePlaceHolderView
{
    UIView *view = [[UIView alloc]initWithFrame:self.view.bounds];
    UIImageView *bg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"null"]];
    bg.center = view.center;
    [view addSubview:bg];
    return view;
}


-(void)clickedButtontag:(NSInteger)tag andCell:(ManagerCell *)cell{
        switch (tag) {
            case 101:
            {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:cell.coach.phone message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"拨号", nil];
                alert.tag = 101;
                [alert show];
            }
                break;
            case 102:
            {
                RewardView *pop = [[RewardView alloc]init];
                [pop setName:cell.coach.userName andUserId:cell.coach.userId];
                [pop show];
            }
                break;
            case 103:
            {
                cursec = cell.sec;
                curphone = cell.coach.phone;
                curId = cell.coach.userId;
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"确定删除该用户？" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                alert.tag = 103;
                [alert show];
            }
                break;
                
            default:
                break;
        }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSInteger tag = alertView.tag;

    switch (tag) {
        case 101:
        {
            if (1 == buttonIndex) {
                NSString *tel = [NSString stringWithFormat:@"tel://%@",alertView.title];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:tel]];
            }
        }
            break;
        case 103:
        {
            if (1 == buttonIndex) {
                [self deleteCoach];
            }
        }
            break;

        default:
            break;
    }


}

- (void)loadData
{
    [self.hudManager showNormalStateSVHudWithTitle:@"加载中..." hideAfterDelay:100.0];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"uid"] = kUid;
    param[@"typeId"] = @2;
    param[@"pageId"] = @(curpage);
    param[@"time"] = self.getcurrentTime;
    param[@"sign"] = [HttpsTools getSignWithIdentify:@"/recruit/retrieve" time:self.getcurrentTime];
    
    [HttpsTools kPOST:managerUrl parameter:param progress:^(NSProgress *downloadProgress) {
    } succeed:^(id backdata, int code, NSString *msg) {
        [self.table.mj_footer endRefreshing];
//        [self.hudManager showSuccessSVHudWithTitle:msg hideAfterDelay:1.0 animaton:YES];
        if (1 == code) {
        
            [self.hudManager dismissSVHud];
            
            NSArray *recruits = backdata[@"recruit"];
            
            if (recruits.count == 0) {
                if (1 == curpage) {
                    [self.hudManager showSuccessSVHudWithTitle:@"无相关数据" hideAfterDelay:2.0 animaton:YES];
                     [self.table cyl_reloadData];
                    return ;
                }
                [self.hudManager showSuccessSVHudWithTitle:@"数据加载完了" hideAfterDelay:2.0 animaton:YES];
                 [self.table cyl_reloadData];
                return ;
            }
            
            NSMutableArray *temp = [NSMutableArray array];
            
            for (int i = 0; i < recruits.count; i++) {
                RecruitCoach *coach = [RecruitCoach mj_objectWithKeyValues:recruits[i]];
                [temp addObject:coach];
            }
            
            coachs = temp;
             [self.table cyl_reloadData];
        }
        
        NSLog(@"%@",backdata);
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)deleteCoach
{
    [self.hudManager showNormalStateSVHudWithTitle:@"加载中..." hideAfterDelay:5.0];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"uid"] = kUid;
    param[@"phone"] = curphone;
    param[@"time"] = self.getcurrentTime;
    param[@"sign"] = [HttpsTools getSignWithIdentify:@"/recruit/delete" time:self.getcurrentTime];
    
    [HttpsTools kPOST:zhaoshengDeleteUrl parameter:param progress:^(NSProgress *downloadProgress) {
    } succeed:^(id backdata, int code, NSString *msg) {
        
        [self.hudManager showSuccessSVHudWithTitle:msg hideAfterDelay:1.0 animaton:YES];
        
        if (1 == code) {
            
            [coachs removeObjectAtIndex:cursec];
            [self.table reloadData];
        }
        
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
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
