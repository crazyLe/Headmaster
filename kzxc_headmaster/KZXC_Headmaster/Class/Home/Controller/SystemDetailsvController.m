//
//  SystemDetailsvController.m
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/7/22.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import "SystemDetailsvController.h"
#import "MsgCenterCell.h"
#import "MsgModel.h"
#import "MessageDataBase.h"
#import "DrivingOrderController.h"
#import "MyCircleViewController.h"
#import "CircleDetailWebController.h"

@interface SystemDetailsvController ()<UITableViewDelegate,UITableViewDataSource,CYLTableViewPlaceHolderDelegate>

@property(nonatomic,assign)int maxid;

@property(weak,nonatomic)UITableView *table;

@property(nonatomic,strong)NSMutableArray * dataArray;
@end

@implementation SystemDetailsvController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"消息中心";

    self.view.backgroundColor = [UIColor colorWithHexString:@"#f7f7f7"];
    
    self.dataArray =[NSMutableArray array];
    
    self.maxid = [[MessageDataBase shareInstance]getMaxIdModel].idNum;
    
    [self setupTable];
    
    [self loaddata];
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [UIApplication  sharedApplication].applicationIconBadgeNumber = 0;
}
- (void)setupTable
{
    CGRect tableFream = CGRectMake(10, 10 , kWidth - 20, kHeight - 74);
    UITableView *loctable = [[UITableView alloc]initWithFrame:tableFream style:UITableViewStyleGrouped];
    
    loctable.backgroundColor = [UIColor colorWithHexString:@"#f7f7f7"];
//    loctable.scrollEnabled = NO;
    loctable.separatorStyle = UITableViewCellSeparatorStyleNone;
    loctable.dataSource = self;
    loctable.delegate = self;
    self.table = loctable;
    
    [self.view addSubview:loctable];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellID = @"syscenterID";
    
    MsgCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        
        cell = [[NSBundle mainBundle] loadNibNamed:@"MsgCenterCell" owner:nil options:nil].firstObject;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.backgroundColor = [UIColor whiteColor];
    MsgModel *model = self.dataArray[indexPath.section];

    cell.model = model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

    UIView *head = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidth-20, 45)];
    head.backgroundColor = [UIColor colorWithHexString:@"#f7f7f7"];
    UILabel *time = [[UILabel alloc]initWithFrame:CGRectMake((kWidth - 120)/2, 20, 100, 15)];
    time.font = fourteenFont;
    time.textColor = [UIColor whiteColor];
    time.backgroundColor = [UIColor colorWithHexString:@"#cccccc"];
    time.layer.masksToBounds = YES;
    time.layer.cornerRadius = 5;
    
    time.textAlignment = NSTextAlignmentCenter;
    MsgModel *model = self.dataArray[section];
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    df.dateFormat = @"MM-dd HH:mm";
    NSDate *lastDate = [NSDate dateWithTimeIntervalSince1970:model.addtime];
    NSString *timestr = [df stringFromDate:lastDate];
    
    time.text = timestr;
    [head addSubview:time];
    
    return head;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 45;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MsgModel *model = self.dataArray[indexPath.section];

    NSInteger index = model.msg_id;
    
    switch (index) {
        case 36:
            {
                DrivingOrderController *order = [[DrivingOrderController alloc]init];
                order.selectedIndex = 3;
                [self.navigationController pushViewController:order animated:YES];
            }
            break;
        case 37:
        {
            DrivingOrderController *order = [[DrivingOrderController alloc]init];
            order.selectedIndex = 1;
            [self.navigationController pushViewController:order animated:YES];
        }
            break;
        case 39:
        {
            MyCircleViewController *mycircle = [[MyCircleViewController alloc]init];
            [self.navigationController pushViewController:mycircle animated:YES];
        }
            break;
        case 40:
        {
            CircleDetailWebController *top = [[CircleDetailWebController alloc]init];
            
            top.urlString = [NSString stringWithFormat:@"%@/%d?app=1&uid=%@&cityId=%ld&address=%@,%@",basicCircleWebUrl,model.idNum,kUid,[HttpParamManager getCurrentCityID],[HttpParamManager getLongitude],[HttpParamManager getLatitude]];
            
            [self.navigationController pushViewController:top animated:YES];
        }
            break;
        default:
            break;
    }

}


- (void)loaddata
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"uid"] = kUid;
    param[@"maxId"] = @(self.maxid);
    param[@"time"] = self.getcurrentTime;
    param[@"deviceInfo"] = deviceInfo;
    param[@"sign"] = [HttpsTools getSignWithIdentify:@"/message" time:self.getcurrentTime];
    NSLog(@"%@",param);
    [self.hudManager showNormalStateSVHUDWithTitle:@"加载中..."];
    [HttpsTools kPOST:getAllMsgUrl parameter:param progress:^(NSProgress *downloadProgress) {
    } succeed:^(id backdata, int code, NSString *msg) {
        
        NSLog(@"%@===%d===%@",backdata,code,msg);
        
        if (code == 1)
        {
            NSArray *arr = [MsgModel mj_objectArrayWithKeyValuesArray:backdata[@"message"]];
            
            for (int i = 0; i<arr.count; i++) {
                MsgModel *model = arr[i];
                [[MessageDataBase shareInstance] insertDataWithModel:model];
            }
            if (self.isCircle) {
                self.dataArray = [[MessageDataBase shareInstance]queryCircleMessage].mutableCopy;
            }
            else
            {
                self.dataArray = [[MessageDataBase shareInstance]query].mutableCopy;
            }
            //设置所有信息已读
            for (int i = 0; i<self.dataArray.count ; i++) {
                MsgModel *model = self.dataArray[i];
                [[MessageDataBase shareInstance]setDataIsReadWithModel:model];
            }
            [NOTIFICATION_CENTER postNotificationName:kMakeMsgIsReadNotification object:nil];
            [self.hudManager dismissSVHud];
            
            [self.table cyl_reloadData];
            
        }
        else
        {
            [self.hudManager showErrorSVHudWithTitle:msg hideAfterDelay:1.0f];
        }
        
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
- (UIView *)makePlaceHolderView
{
    UIView *view = [[UIView alloc]initWithFrame:self.view.bounds];
    UIImageView *bg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"null"]];
    bg.center = view.center;
    [view addSubview:bg];
    return view;
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
