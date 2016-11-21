//
//  InviteCoachController.m
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/7/20.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import "InviteCoachController.h"
#import "InvitationCell.h"
#import "RecruitCoach.h"


@interface InviteCoachController ()<UITableViewDelegate,UITableViewDataSource,InvitationCellDelegate,UIAlertViewDelegate,CYLTableViewPlaceHolderDelegate>
{
    NSMutableArray *coachs;
    NSString *curphone;
    int curpage;
    NSInteger cursec;
}
@property(weak,nonatomic)UITableView *table;
@end

@implementation InviteCoachController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"邀请教练";
    self.view.backgroundColor = RGBColor(247, 247, 247);
    
    curpage = 1;
    
    UIImageView *head = [[UIImageView alloc]initWithFrame:CGRectMake((kWidth - 290)/2, 5, 290, 30)];
    head.image = [UIImage imageNamed:@"tips"];
    
    
    [self.view addSubview:head];
    
    UITableView *loctable = [[UITableView alloc]initWithFrame:CGRectMake(10, 40, kWidth - 20, kHeight - 64 - 40)];
    loctable.showsVerticalScrollIndicator = NO;
    loctable.backgroundColor = RGBColor(247, 247, 247);
    loctable.tag = 201;
    loctable.dataSource = self;
    loctable.delegate = self;
    loctable.separatorStyle = UITableViewCellSeparatorStyleNone;
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


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return coachs.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

        static NSString *identify = @"invitationID";
        
        InvitationCell  *cell = [tableView dequeueReusableCellWithIdentifier:identify];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle]loadNibNamed:@"InvitationCell" owner:nil options:nil]firstObject];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
        cell.coach = coachs[indexPath.section];
    
        cell.sec = indexPath.section;
    
        cell.delegate =self;

        return cell;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *foot = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidth - 20, 10)];
    foot.backgroundColor = RGBColor(247, 247, 247);
    return foot;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}

- (UIView *)makePlaceHolderView
{
    UIView *view = [[UIView alloc]initWithFrame:self.view.bounds];
    UIImageView *bg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"null"]];
    bg.center = view.center;
    [view addSubview:bg];
    return view;
}

-(void)clickedButtontag:(NSInteger)tag andCell:(InvitationCell *)cell{
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
            curphone = cell.coach.phone;
            cursec = cell.sec;

            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"是否邀请?" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
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
                [self yaoqingCoach];
            }
        }
            break;
            
        default:
            break;
    }
    
    
}
/**
 *  加载未被邀请的教练
 */
- (void)loadData
{
    [self.hudManager showNormalStateSVHudWithTitle:@"加载中..." hideAfterDelay:100.0];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"uid"] = kUid;
    param[@"typeId"] = @1;
    param[@"pageId"] = @(curpage);
    param[@"time"] = self.getcurrentTime;
    param[@"sign"] = [HttpsTools getSignWithIdentify:@"/recruit/retrieve" time:self.getcurrentTime];
    
    [HttpsTools kPOST:managerUrl parameter:param progress:^(NSProgress *downloadProgress) {
    } succeed:^(id backdata, int code, NSString *msg) {
        [self.table.mj_footer endRefreshing];
        NSLog(@"未被邀请的教练%@",backdata);
        if (1 == code) {
            [self.hudManager dismissSVHud];
            NSArray *temp = backdata[@"recruit"];
            
            if (0 == temp.count) {
                if (1 == curpage) {
//                    [self.hudManager showSuccessSVHudWithTitle:@"无相关数据" hideAfterDelay:2.0 animaton:YES];
                     [self.table cyl_reloadData];
                    return ;
                }
//                [self.hudManager showSuccessSVHudWithTitle:@"数据加载完了" hideAfterDelay:2.0 animaton:YES];
                [self.table cyl_reloadData];
                return ;
            }
            
            NSMutableArray *tempcoach = [NSMutableArray array];
            for (NSDictionary *dict in temp) {
                RecruitCoach *coach = [RecruitCoach mj_objectWithKeyValues:dict];
                [tempcoach addObject:coach];
            }
            coachs = tempcoach;
            
            [self.table cyl_reloadData];
        }
        
        [self.hudManager dismissSVHud];
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

-  (void) yaoqingCoach
{
   [self.hudManager showNormalStateSVHudWithTitle:@"加载中..." hideAfterDelay:100.0];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"uid"] = kUid;
    param[@"phone"] = curphone;
    param[@"time"] = self.getcurrentTime;
    param[@"sign"] = [HttpsTools getSignWithIdentify:@"/recruit/create" time:self.getcurrentTime];
    
    [HttpsTools kPOST:yaoqingUrl parameter:param progress:^(NSProgress *downloadProgress) {
    } succeed:^(id backdata, int code, NSString *msg) {
        

        NSLog(@"邀请%@",backdata);
        
        if (1 == code) {
            
            [self.hudManager dismissSVHud];
            
            [self.hudManager showSuccessSVHudWithTitle:msg hideAfterDelay:1.0 animaton:YES];
            
            curpage = 1;
            
            [self loadData];
//            [coachs removeObjectAtIndex:cursec];
//            
//            [_table reloadData];
        }
        
        [self.hudManager dismissSVHud];
        
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
