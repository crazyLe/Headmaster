//
//  DrivingOrderController.m
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/7/13.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import "DrivingOrderController.h"
#import "OrderCell.h"
#import "OrderModel.h"

@interface DrivingOrderController ()<UITableViewDataSource,UITableViewDelegate,CYLTableViewPlaceHolderDelegate>
{
    UIView *statueBG;
    NSInteger _lastTag;
    NSArray *rightimgArr;
    NSArray *righttitleArr;
    NSString *orderNum;
    int curpage;
    int state;
    int statebg;
}
@property(weak,nonatomic)UITableView *orderTable;

@property(weak,nonatomic)UIView *statueBtnView;

@property(strong,nonatomic)NSMutableArray *orderArr;

@property(strong,nonatomic)UILabel* numLabel;

@end

@implementation DrivingOrderController

- (NSMutableArray *)orderArr
{
    if (!_orderArr) {
        _orderArr = [NSMutableArray array];
    }
    return _orderArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"驾校订单";
    self.view.backgroundColor = RGBColor(244, 244, 244);
    
    rightimgArr = @[@"type_zero",@"type_one",@"type_two"];
    righttitleArr = @[@"未付款",@"已付款",@"已报到"];
    curpage = 1;
    state = 1;
    
    UIView *statueView = [[UIView alloc]init];
    statueView.layer.cornerRadius = 17.5;
    statueView.backgroundColor = [UIColor whiteColor];
    self.statueBtnView = statueView;
    [self.view addSubview:statueView];
    
    [statueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@25);
        make.left.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(kWidth - 30, 35));
    }];
    
    UIView *statueBg = [[UIView alloc]init];
    statueBg.layer.cornerRadius = 17.5;
    statueBg.backgroundColor = RGBColor(253, 106, 108);
    
    statueBg.layer.shadowColor = RGBColor(253, 106, 108).CGColor;//shadowColor阴影颜色
    statueBg.layer.shadowOffset = CGSizeMake(0,2);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    statueBg.layer.shadowOpacity = 0.8;//阴影透明度，默认0
    statueBg.layer.shadowRadius = 2;//阴影半径，默认3
    
    statueBG = statueBg;
    [statueView addSubview:statueBg];
    [statueBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake((kWidth - 30)/3, 35));
    }];
    
    UIButton *firButton = [[UIButton alloc]init];
    [firButton setTitle:@"已付款" forState:UIControlStateNormal];
    [firButton setTitleColor:ColorNine forState:UIControlStateNormal];
    [firButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [statueView addSubview:firButton];
    firButton.tag = 101;
    [firButton addTarget:self action:@selector(statueButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [firButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake((kWidth - 30)/3, 35));
    }];
    

    UIButton *secButton = [[UIButton alloc]init];
    [secButton setTitle:@"未付款" forState:UIControlStateNormal];
    [secButton setTitleColor:ColorNine forState:UIControlStateNormal];
    [secButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    secButton.tag = 102;
    [secButton addTarget:self action:@selector(statueButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [statueView addSubview:secButton];
    [secButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo((kWidth - 30)/3);
        make.size.mas_equalTo(CGSizeMake((kWidth - 30)/3, 35));
    }];
    
    UIButton *thiButton = [[UIButton alloc]init];
    [thiButton setTitle:@"已报到" forState:UIControlStateNormal];
    [thiButton setTitleColor:ColorNine forState:UIControlStateNormal];
    [thiButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    thiButton.tag = 103;
    [thiButton addTarget:self action:@selector(statueButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [statueView addSubview:thiButton];
    [thiButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(2*(kWidth - 30)/3);
        make.size.mas_equalTo(CGSizeMake((kWidth - 30)/3, 35));
    }];

    switch (_selectedIndex) {
        case 0:
        {
            firButton.selected = YES;
            state = 1;
            statebg = 101;
            
        }
            break;
        case 1:
        {
            secButton.selected = YES;
            state = 0;
            statebg = 102;
            [statueBg mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo((kWidth - 30)/3);
            }];
        }
            break;
        case 2:
        {
            thiButton.selected = YES;
            state = 2;
            statebg = 103;
            [statueBg mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(2*(kWidth - 30)/3);
            }];
        }
            break;
            
        default:
            break;
    }
    
    UITableView *order = [[UITableView alloc]init];
    order.backgroundColor = RGBColor(244, 244, 244);
    order.separatorStyle = UITableViewCellSeparatorStyleNone;
    order.delegate = self;
    order.dataSource = self;
    self.orderTable = order ;
    [self.view addSubview:order];
    [order mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@85);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(kWidth, kHeight - 90 - 64));
    }];
    
//    order.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//        curpage++;
//        [self loadDatastate];
//        [order.mj_footer endRefreshing];
//    }];
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    MJRefreshAutoGifFooter *footer = [MJRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    // 设置尾部
    self.orderTable.mj_footer = footer;
    
    // 设置文字
    [footer setTitle:@"" forState:MJRefreshStateIdle];

    
    self.numLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, kHeight - 64- 50, kWidth, 50)];
    self.numLabel.backgroundColor = RGBColor(244, 244, 244);
    self.numLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.numLabel];

    [self loadDatastate];
}

- (void)loadMoreData
{
    curpage++;
    [self loadDatastate];
    [self.orderTable.mj_footer endRefreshing];
}

-(void)statueButtonClick:(UIButton *)item
{
    if (0 == _lastTag) {
        UIButton *lastBtn = (id)[self.statueBtnView viewWithTag:statebg];
        lastBtn.selected = NO;
    }
    
    if (_lastTag >= 101) {
        UIButton *lastBtn = (id)[self.statueBtnView viewWithTag:_lastTag];
        lastBtn.selected = NO;
    }
    item.selected = YES;
    
    
    NSInteger tag = item.tag - 101;
    state = (tag == 0)?1:(tag == 2)?2:0;
    [UIView animateWithDuration:0.15 animations:^{
        CGRect frame = statueBG.frame;
        frame.origin.x = tag * (kWidth - 30)/3;
        statueBG.frame = frame;
    }];
    
    _lastTag = item.tag;
    
//    NSInteger index = (item.tag == 101)?1:(item.tag == 102)?0:2;
    
    [self.orderArr removeAllObjects];
    curpage = 1;
    [self loadDatastate];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.orderArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    
    static NSString *cellStr = @"identify";
    
    OrderCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    
    if (!cell) {
        
        cell = [[OrderCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];

    }
    
    cell.order = self.orderArr[section];
    
    [cell setrightState:righttitleArr[state] andImage:rightimgArr[state]];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if ((self.orderArr.count-1) == section) {
        return 50;
    }
    return 15;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
        UIView *bg = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidth, 15)];
        bg.backgroundColor = RGBColor(244, 244, 244);
        return bg;
}
- (UIView *)makePlaceHolderView
{
    UIView *view = [[UIView alloc]initWithFrame:self.view.bounds];
    UIImageView *bg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"null"]];
    bg.center = view.center;
    [view addSubview:bg];
    return view;
}
/**
 *  请求订单接口
 *
 *  @param state 1已付款 0未付款 2 已报到
 */
- (void)loadDatastate
{
    [self.hudManager showNormalStateSVHudWithTitle:@"加载中..." hideAfterDelay:5.0];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"uid"] = kUid;
    param[@"deviceInfo"] = deviceInfo;
    param[@"pageId"] = @(curpage);
    param[@"state"] = @(state);
    param[@"time"] = self.getcurrentTime;
    param[@"sign"] = [HttpsTools getSignWithIdentify:@"/Mypurse/Schoolorder" time:self.getcurrentTime];
    NSLog(@"%@",param);
    [HttpsTools kPOST:jiaxiaoOrderUrl parameter:param progress:^(NSProgress *downloadProgress) {
    } succeed:^(id backdata, int code, NSString *msg) {
        NSLog(@"%@,%d",backdata,code);
         [self.orderTable.mj_footer endRefreshing];
        if (1 == code) {
            
            if (1 == curpage) {
                self.orderArr = [OrderModel mj_objectArrayWithKeyValuesArray:backdata[@"Order"]];
            }else
            {
                NSArray *orders = backdata[@"Order"];
                if (0 == orders.count) {
                    [self.hudManager showSuccessSVHudWithTitle:@"没有更多订单了" hideAfterDelay:2.0 animaton:YES];
                     [self.orderTable cyl_reloadData];
                    return ;
                }
                for (int j = 0; j<orders.count; j++) {
                    OrderModel *model = [OrderModel mj_objectWithKeyValues:orders[j]];
                     [self.orderArr addObject:model];
                }
            }
            
            self.numLabel.attributedText = [self numAttr:backdata[@"orderNum"]];
            
            [self.orderTable cyl_reloadData];
//            [self.orderTable reloadData];
            
        }
        [self.hudManager dismissSVHud];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (NSMutableAttributedString *)numAttr:(NSString *)str
{
    NSString *orderNumStr = [NSString stringWithFormat:@"共%@份订单",str];
    
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:orderNumStr];
    [attr addAttributes:[NSDictionary dictionaryWithObjectsAndKeys:ColorNine,NSForegroundColorAttributeName,Font15,NSFontAttributeName, nil] range:NSMakeRange(0, attr.length)];
    [attr addAttributes:[NSDictionary dictionaryWithObjectsAndKeys:RGBColor(253, 106, 108),NSForegroundColorAttributeName,Font20,NSFontAttributeName, nil] range:NSMakeRange(1, attr.length - 4)];

    return attr;
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
