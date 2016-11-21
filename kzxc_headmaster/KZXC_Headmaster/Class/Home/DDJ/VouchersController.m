//
//  VouchersController.m
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/7/19.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import "VouchersController.h"
#import "EditVouchersController.h"
#import "VouchersCell.h"
#import "UIColor+Hex.h"
#import "DDJModel.h"

@interface VouchersController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate,VouchersCellDelegate>

{
    NSMutableArray *Coupons;
    NSMutableArray *CouponOlds;
    NSInteger cursec;
    NSString *cur_id;
}
//@property(weak,nonatomic)UIScrollView *scroll;
@property(weak,nonatomic)UITableView *table;
@property(strong,nonatomic)UIView *bgview;
@property(strong,nonatomic)UILabel *bgTitle;

@property(strong,nonatomic)NSMutableArray *ddjArr;
@end

@implementation VouchersController


- (NSMutableArray *)ddjArr
{
    if (!_ddjArr) {
        _ddjArr = [NSMutableArray array];
    }
    return _ddjArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"代金劵";
    
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    
    [navigationBar setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault]; //此处使底部线条颜色为红色
    
    [navigationBar setShadowImage:[UIImage imageWithColor:NavBackColor]];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupTopView];
    
    [self setupTable];
}

- (void)setupTopView
{
    _bgview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidth, 180)];
    _bgview.backgroundColor = NavBackColor;

    _bgTitle = [[UILabel alloc]init];
    _bgTitle.textAlignment = NSTextAlignmentCenter;
    [_bgview addSubview:_bgTitle];
    [_bgTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(25);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(kWidth, 25));
    }];
    

    //发布代金劵
    UIButton *invited = [[UIButton alloc]init];
    invited.backgroundColor = [UIColor colorWithHexString:@"#feaa00"];
    [invited setImage:[UIImage imageNamed:@"voucher_add"] forState:UIControlStateNormal];
    [invited setTitle:@"发布代金劵" forState:UIControlStateNormal];
    invited.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [invited setTitleColor:[UIColor colorWithHexString:@"#d32026"] forState:UIControlStateNormal];
    invited.layer.cornerRadius = ButtonH/2;
    
    [invited addTarget:self action:@selector(sendVouchers) forControlEvents:UIControlEventTouchUpInside];
    [_bgview addSubview:invited];
    [invited mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(65);
        make.left.mas_equalTo(60);
        make.size.mas_equalTo(CGSizeMake(kWidth - 120, ButtonH));
    }];
    
    UIView *bg_bottomview = [[UIView alloc]init];
    bg_bottomview.backgroundColor = [UIColor colorWithHexString:@"bc1c21"];
//    [self.scroll addSubview:bg_bottomview];
    [_bgview addSubview:bg_bottomview];
    [bg_bottomview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(@120);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(kWidth, 60));
    }];
    
    //温馨提示:该数据仅为通过线上报名的招生数据,通过线上招生每达10人,将获得平台发放的赚豆奖励(可提现)
    UILabel *bottom_title = [[UILabel alloc]init];
    
    bottom_title.textAlignment = NSTextAlignmentCenter;
    bottom_title.text = @"温馨提示:代金劵发布成功后将自动同步到微名片，通过在线报名时将自动减免优惠金额。";
    bottom_title.textColor = [UIColor colorWithHexString:@"f18d90"];
    bottom_title.font = [UIFont systemFontOfSize:14.0];
    
    bottom_title.lineBreakMode = NSLineBreakByWordWrapping;
    bottom_title.numberOfLines = 2;
    
    [bg_bottomview addSubview:bottom_title];
    [bottom_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(30);
        make.size.mas_equalTo(CGSizeMake(kWidth - 60, 40));
    }];
}

- (void)sendVouchers
{
    EditVouchersController *edit = [[EditVouchersController alloc]init];
    [self.navigationController pushViewController:edit animated:YES];
}

- (void)setupTable
{
//    UIView *asd = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidth, 100)];
//    asd.backgroundColor = NavBackColor;
    CGRect rect = CGRectMake(0, 0, kWidth, kHeight - 64);
    UITableView *loctable = [[UITableView alloc]initWithFrame:rect];
    loctable.separatorStyle = UITableViewCellSeparatorStyleNone;
    loctable.dataSource = self;
    loctable.delegate = self;
    loctable.tableHeaderView = _bgview;
    self.table = loctable;
    [self.view addSubview:loctable];
    

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _ddjArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"vouchersID";
    
    VouchersCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    
    if (!cell) {
        
        cell = [[[NSBundle mainBundle]loadNibNamed:@"VouchersCell" owner:nil options:nil]firstObject];
    }
    
    cell.delegate = self;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    cell.model = _ddjArr[indexPath.section];
    
    if (Coupons.count < indexPath.section+1) {
        cell.leftbg.image = [UIImage imageNamed:@"juanleft_n"];
        cell.rightbg.image = [UIImage imageNamed:@"un_juan"];
    }else
    {
        cell.send.hidden = YES;
    }

    
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (0 == section) {
        return 25;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
        if (Coupons.count - 1 == section) {
            return 45;
        }
          return 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{

        
    if (section == Coupons.count - 1) {
        
        UIView *foot = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidth - 40, 45)];
        
        [foot setBackgroundColor:RGBColor(247, 247, 247)];
        
        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, 100, 20)];
        title.font = BoldFontWithSize(16);
        title.textColor = [UIColor colorWithHexString:@"#999999"];
        title.text = @"往期优惠";
        
        [foot addSubview:title];
        
        UILabel *title2 = [[UILabel alloc]initWithFrame:CGRectMake(kWidth - 20 - 50, 5, 100, 20)];
        title2.font = [UIFont systemFontOfSize:14.0];
        title2.textColor = [UIColor colorWithHexString:@"#999999"];
        title2.text = @"侧划删除";
        
        [foot addSubview:title2];
        
        return foot;
        
    }

    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        DDJModel *model = _ddjArr[indexPath.section];
        cur_id = model.bianhao;
        cursec = indexPath.section;
        if (indexPath.section < Coupons.count) {
            
            [Coupons removeObjectAtIndex:indexPath.section];
            
        }else {
            
            [CouponOlds removeObjectAtIndex:(indexPath.section - Coupons.count)];
        }
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"是否删除" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
        
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (1 == buttonIndex) {
        [self deleteDDJ];
    }
}
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (void)clickedCell:(VouchersCell *)cell
{
    
    EditVouchersController *edit = [[EditVouchersController alloc]init];
    edit.model = cell.model;
    [self.navigationController pushViewController:edit animated:YES];
//    [self sendDDJ:cell.model];
}

- (void)loadData
{
    [self.hudManager showNormalStateSVHudWithTitle:@"加载中..." hideAfterDelay:5.0];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"uid"] = kUid;
    param[@"deviceInfo"] = deviceInfo;
    param[@"time"] = self.getcurrentTime;
    param[@"sign"] = [HttpsTools getSignWithIdentify:@"/cashCoupon" time:self.getcurrentTime];
    NSLog(@"%@",param);
    [HttpsTools kPOST:ddjUrl parameter:param progress:^(NSProgress *downloadProgress) {
    } succeed:^(id backdata, int code, NSString *msg) {
//        [self.hudManager showSuccessSVHudWithTitle:msg hideAfterDelay:1.0 animaton:YES];
        if (1 == code) {
            Coupons = backdata[@"couponon"];
            CouponOlds = backdata[@"couponOld"];
            NSMutableArray *temp = [NSMutableArray array];
            for (int i = 0; i < Coupons.count; i++) {
                DDJModel *model = [DDJModel mj_objectWithKeyValues:Coupons[i]];
                [temp addObject:model];
            }
            for (int i = 0; i < CouponOlds.count; i++) {
                DDJModel *model = [DDJModel mj_objectWithKeyValues:CouponOlds[i]];
                [temp addObject:model];
            }
            _ddjArr = temp;
            _bgTitle.attributedText = [self youhuiStr:[backdata[@"studentNum"] intValue]];
            [self.table reloadData];
            [self.hudManager dismissSVHud];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)deleteDDJ
{
    [self.hudManager showNormalStateSVHudWithTitle:@"加载中..." hideAfterDelay:5.0];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"uid"] = kUid;
    param[@"coupon_id"] = cur_id;
    param[@"time"] = self.getcurrentTime;
    param[@"sign"] = [HttpsTools getSignWithIdentify:@"/cashCoupon/delete" time:self.getcurrentTime];
    NSLog(@"%@",param);
    [HttpsTools kPOST:ddjDeleteUrl parameter:param progress:^(NSProgress *downloadProgress) {
    } succeed:^(id backdata, int code, NSString *msg) {
        [self.hudManager showSuccessSVHudWithTitle:msg hideAfterDelay:1.0 animaton:YES];
        if (1 == code) {
            [_ddjArr removeObjectAtIndex:cursec];
            [self.table reloadData];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (NSAttributedString *)youhuiStr:(int)num
{
    NSString *youhui = [NSString stringWithFormat:@"当前累积%d名学员报名优惠",num];
    
    NSMutableAttributedString *youhuiAttr = [[NSMutableAttributedString alloc]initWithString:youhui];
    
    [youhuiAttr addAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:16.0],NSFontAttributeName,[UIColor whiteColor],NSForegroundColorAttributeName, nil] range:NSMakeRange(0, youhui.length)];
    
    [youhuiAttr addAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:20],NSFontAttributeName,[UIColor colorWithHexString:@"ffaa00"],NSForegroundColorAttributeName, nil] range:NSMakeRange(4, youhui.length - 11)];
  
    return youhuiAttr;
}


- (void)viewDidAppear:(BOOL)animated
{
    [self loadData];
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

