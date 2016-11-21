//
//  OrderListController.m
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/7/20.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import "OrderListController.h"
#import "PurseCell.h"
#import "MonthModel.h"


@interface OrderListController ()<UITableViewDataSource,UITableViewDelegate,CYLTableViewPlaceHolderDelegate>
{
    
    NSString *curmonth;
    NSString *nextmonth;
    NSString *nextTwomonth;
    
    NSArray *mouthArr;
//    总订单集合
    NSMutableArray *orderTotalArr;
//    当前月集合
    NSArray *orderArr;
}
@property(weak,nonatomic)UITableView *table;
@end

@implementation OrderListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if (0 == [_type intValue]) {
        self.title = @"账单";
    }else
    {
        self.title = @"招生收入";
    }
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    curmonth = [self getMonth];
    nextmonth = [self nextMonthArea:1];
    nextTwomonth = [self nextMonthArea:2];

    mouthArr = @[@"本月",[NSString stringWithFormat:@"%@月",nextmonth],[NSString stringWithFormat:@"%@月",nextTwomonth]];
    orderTotalArr = [NSMutableArray array];

    orderArr = [NSMutableArray array];
    
    
    [self setupTable];
    
    if ([kUid intValue] != 0) {
        
        [self loadDataMonth:curmonth];
//        [self loadDataMonth:nextmonth];
//        [self loadDataMonth:nextTwomonth];
    }

    
}

//获取当前月
- (NSString *)getMonth
{
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"beijing"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM"];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}
- (void)setupTable
{
    UITableView *loctable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight - 64)];
    loctable.tag = 201;
    loctable.dataSource = self;
    loctable.delegate = self;
    loctable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.table = loctable;
    [self.view addSubview:loctable];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return orderTotalArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [orderTotalArr[section] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"purseID";
    
    PurseCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"PurseCell" owner:nil options:nil]firstObject];
    }
    
    if (0 != indexPath.section) {
        cell.time.textColor = [UIColor colorWithHexString:@"#999999"];
    }
    
    cell.model = [orderTotalArr[indexPath.section] objectAtIndex:indexPath.row];
    
    return cell;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if([orderTotalArr[section] count] != 0)
    {  UIView *head = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidth, 35)];
        head.backgroundColor = [UIColor colorWithHexString:@"#f7f7f7"];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, kWidth, 35)];
        label.textColor = [UIColor colorWithHexString:@"#333333"];
        label.font = fifteenFont;
        label.text = mouthArr[section];
        [head addSubview:label];
        return head;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if([orderTotalArr[section] count] == 0)
    {
        return 0.01;
    }
    return 35;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UIView *)makePlaceHolderView
{
    UIView *view = [[UIView alloc]initWithFrame:self.view.bounds];
    UIImageView *bg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"iconfont-ku"]];
    bg.center = view.center;
    [view addSubview:bg];
    UILabel *msg = [[UILabel alloc]init];
    [view addSubview:msg];
    [msg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo((kWidth - 80)/2);
        make.top.mas_equalTo(bg.mas_bottom).offset(10);
        make.size.mas_offset(CGSizeMake(80, 20));
    }];
    msg.text = @"暂无数据";
    msg.textAlignment = NSTextAlignmentCenter;
    return view;
}


-(void) loadDataMonth:(NSString *)month
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
    param[@"uid"] = kUid;
    param[@"pageId"] = @"";
//    0账单 1招生收入
    param[@"orderOnly"] = _type;
    param[@"searchMonth"] = month;
    param[@"deviceInfo"] = deviceInfo;
    param[@"time"] = self.getcurrentTime;
    param[@"sign"] = [HttpsTools getSignWithIdentify:@"/Mypurse/bill" time:self.getcurrentTime];
    NSLog(@"%@",param);
    [self.hudManager showNormalStateSVHudWithTitle:@"加载中..." hideAfterDelay:100.0];
    [HttpsTools kPOST:myPirseUrlOrderUrl parameter:param progress:^(NSProgress *downloadProgress) {
    } succeed:^(id backdata, int code, NSString *msg) {
        NSLog(@"%@,%d",backdata,code);
        if (1 == code) {
                NSArray *curArr = backdata[@"order"];
                orderArr = [MonthModel mj_objectArrayWithKeyValuesArray:curArr];
                [orderTotalArr addObject:orderArr];
  
            if ([month isEqualToString:curmonth]) {
                [self loadDataMonth:nextmonth];
                
            }
            if ([month isEqualToString:nextmonth]) {
                     [self loadDataMonth:nextTwomonth];   
            }
            if (orderTotalArr.count == 3) {
                [self.hudManager dismissSVHud];
                [self.table cyl_reloadData];
                }
            }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (NSString *)nextMonthArea:(int)index
{
    NSString * zz = [curmonth stringByReplacingOccurrencesOfString:@"-" withString:@""];
    NSLog(@"%@",zz);
    int temp = [zz intValue] - index;
    
    NSMutableString *tempstr = [[NSMutableString alloc]initWithString:[NSString stringWithFormat:@"%d",temp]];
    [tempstr insertString:@"-" atIndex:4];
    
    return tempstr;
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
