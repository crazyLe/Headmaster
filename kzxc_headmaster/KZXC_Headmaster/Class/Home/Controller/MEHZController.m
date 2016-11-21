//
//  MEHZController.m
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/7/20.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import "MEHZController.h"
#import "MEHZDeatilsController.h"
#import "TailorCell.h"
#import "MEHZCell.h"
#import "UIColor+Hex.h"
#import "ExamQuotaReleaseModel.h"
#import "CreateExamQuotaVC.h"
#import "ExamQuotaReleaseModel.h"

@interface MEHZController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger lastIndex;
}

@property(weak,nonatomic)UITableView *saletable;
@property (nonatomic, strong) NSMutableArray * dataArray;
@property (nonatomic, strong) ExamQuotaReleaseModel * examQuotaRelease;
@property (nonatomic, assign) int otherCurrentPage;
@property (nonatomic, assign) int myCurrentPage;
@property (nonatomic, assign) BOOL isMyExamQuota;
@property (nonatomic, strong) UISegmentedControl *seg;
@property (nonatomic, strong) ExamQuotaReleaseModel * recordModel;
@property (nonatomic, strong) UIView * bgView;

@end

@implementation MEHZController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadMyQuota) name:@"reloadMyQuota" object:nil];
    
}
- (void)reloadMyQuota {
    
    _isMyExamQuota = YES; //此处赋值为了上拉数据时防止展示了other的数据
    _seg.selectedSegmentIndex = 1;
    _myCurrentPage = 1;
    [self requestMyData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _otherCurrentPage = 1;
    _myCurrentPage = 1;
    
    _examQuotaRelease = [[ExamQuotaReleaseModel alloc] init];
    
    self.view.backgroundColor = RGBColor(247, 247, 247);
    
    [self setupNav];
    
    [self setupTable];
    
    [self requestOtherData];
}
#pragma mark -- 买入的界面数据
- (void)requestOtherData {
    
    [self.hudManager showNormalStateSVHUDWithTitle:@"加载中..."];
    
    NSString * url = MEHZUrl;
    
    NSMutableDictionary * paramDict = [NSMutableDictionary dictionary];
    paramDict[@"uid"] = kUid;
    paramDict[@"deviceInfo"] = deviceInfo;
    paramDict[@"cityId"] = @([HttpParamManager getCurrentCityID]);
    paramDict[@"address"] = [NSString stringWithFormat:@"%@,%@",[HttpParamManager getLatitude],[HttpParamManager getLongitude]];
    NSString * timeString = self.getcurrentTime;
    paramDict[@"time"] = timeString;
    paramDict[@"sign"] = [HttpParamManager getSignWithIdentify:@"/examinationQuota" time:timeString];
    paramDict[@"pageId"] = @(self.otherCurrentPage);
    
    [HttpsTools POST:url parameter:paramDict progress:^(NSProgress *downloadProgress) {
    } succeed:^(id responseObject) {
        NSLog(@"别人的名额合作%@",responseObject);
        NSInteger code = [responseObject[@"code"] integerValue];
        NSString * msg = responseObject[@"msg"];
        
        if (code == 1) {
            
            [self.hudManager dismissSVHud];
            
            [_dataArray removeAllObjects];
            
            NSDictionary * infoDict = responseObject[@"info"];
//            if ([infoDict isEqual:[NSNull null]]) {
//                
//                [self.hudManager showNormalStateSVHudWithTitle:@"无数据" hideAfterDelay:1.0];
//                return ;
//            }
            
            NSArray * examinationQuotaArray = infoDict[@"examinationQuota"];
            _dataArray = [ExamQuotaReleaseModel mj_objectArrayWithKeyValuesArray:examinationQuotaArray];
            
            [_saletable reloadData];
            
            [_saletable.mj_header endRefreshing];
            
        }else {
            
            [self.hudManager showErrorSVHudWithTitle:msg hideAfterDelay:1.0];
            
            [_saletable.mj_header endRefreshing];
        }
        
        
    } failure:^(NSError *error) {
       
        [MBProgressHUD showError:@"加载失败"];
        
        [_saletable.mj_header endRefreshing];
        
    }];
    
    
}
- (void)requestOtherMoreData {
    NSString * url = MEHZUrl;
    
    NSMutableDictionary * paramDict = [NSMutableDictionary dictionary];
    paramDict[@"uid"] = kUid;
    paramDict[@"deviceInfo"] = deviceInfo;
    paramDict[@"cityId"] = @([HttpParamManager getCurrentCityID]);
    paramDict[@"address"] = [NSString stringWithFormat:@"%@,%@",[HttpParamManager getLatitude],[HttpParamManager getLongitude]];
    NSString * timeString = self.getcurrentTime;
    paramDict[@"time"] = timeString;
    paramDict[@"sign"] = [HttpParamManager getSignWithIdentify:@"/examinationQuota" time:timeString];
    paramDict[@"pageId"] = @(self.otherCurrentPage);
    
    [HttpsTools POST:url parameter:paramDict progress:^(NSProgress *downloadProgress) {
    } succeed:^(id responseObject) {
        NSLog(@"别人的名额合作%@",responseObject);
        NSInteger code = [responseObject[@"code"] integerValue];
        NSString * msg = responseObject[@"msg"];
        
        if (code == 1) {
            
            NSDictionary * infoDict = responseObject[@"info"];
            if ([infoDict isEqual:[NSNull null]]) {
                
                [_saletable reloadData];
                
                [_saletable.mj_footer endRefreshing];
                
            }else {
            
                NSArray * examinationQuotaArray = infoDict[@"examinationQuota"];
                NSArray * newArray = [ExamQuotaReleaseModel mj_objectArrayWithKeyValuesArray:examinationQuotaArray];
                [_dataArray addObjectsFromArray:newArray];
                
                [_saletable reloadData];
                
                [_saletable.mj_footer endRefreshing];

            }
            
            
        }else {
            
            [MBProgressHUD showError:msg];
            
            [_saletable.mj_footer endRefreshing];
        }
        
        
    } failure:^(NSError *error) {
        
        [MBProgressHUD showError:@"加载失败"];
        
    }];

    
    
}
#pragma mark -- 我的考试名额的请求
- (void)requestMyData {
    
    [self.hudManager showNormalStateSVHUDWithTitle:@"加载中..."];
    
    NSString * url = myExamQuota;
    NSString * timeStr = self.getcurrentTime;
    
    NSMutableDictionary * paramDict = [NSMutableDictionary dictionary];
    paramDict[@"uid"] = kUid;
    paramDict[@"time"] = timeStr;
    paramDict[@"sign"] = [HttpsTools getSignWithIdentify:@"/myExaminationquota" time:timeStr];
    paramDict[@"pageId"] = @(self.myCurrentPage);
    
    [HttpsTools POST:url parameter:paramDict progress:^(NSProgress *downloadProgress) {
    } succeed:^(id responseObject) {
       
        NSLog(@"我的考试名额%@",responseObject);
        NSInteger code = [responseObject[@"code"] integerValue];
        //NSString * msg = responseObject[@"msg"];
        if (code == 1) {
            
            [self.hudManager dismissSVHud];
            
            _saletable.alpha = 1;
            _bgView.alpha = 0;
            
            [_dataArray removeAllObjects];
            
            NSDictionary * infoDict = responseObject[@"info"];

            NSArray * examinationQuotaArray = infoDict[@"myExaminationquota"];
            _dataArray = [ExamQuotaReleaseModel mj_objectArrayWithKeyValuesArray:examinationQuotaArray];
            [_saletable reloadData];
            
            [_saletable.mj_header endRefreshing];
            
        }else {
            
           // [self.hudManager showErrorSVHudWithTitle:msg hideAfterDelay:1.0];
            [self.hudManager dismissSVHud];
            //创建新增的那个"发布默认页界面"
            [self createDefaultRelease];
            
            [_dataArray removeAllObjects];

            [_saletable reloadData];

            [_saletable.mj_header endRefreshing];
        }
        
        
    } failure:^(NSError *error) {
        
        [self.hudManager showErrorSVHudWithTitle:@"加载失败" hideAfterDelay:1.0];
        [_saletable.mj_header endRefreshing];
        
    }];
    
    
}
- (void)requestMyMoreData {
    
    [self.hudManager showNormalStateSVHUDWithTitle:@"加载中..."];
    
    NSString * url = myExamQuota;
    NSString * timeStr = self.getcurrentTime;
    
    NSMutableDictionary * paramDict = [NSMutableDictionary dictionary];
    paramDict[@"uid"] = kUid;
    paramDict[@"time"] = timeStr;
    paramDict[@"sign"] = [HttpsTools getSignWithIdentify:@"/myExaminationquota" time:timeStr];
    paramDict[@"pageId"] = @(self.myCurrentPage);
    
    [HttpsTools POST:url parameter:paramDict progress:^(NSProgress *downloadProgress) {
    } succeed:^(id responseObject) {
        
        NSLog(@"我的考试名额%@",responseObject);
        NSInteger code = [responseObject[@"code"] integerValue];
        NSString * msg = responseObject[@"msg"];
        if (code == 1) {
            
            NSDictionary * infoDict = responseObject[@"info"];
            if ([infoDict isEqual:[NSNull null]]) {
                
                [self.hudManager showNormalStateSVHudWithTitle:@"无更多数据" hideAfterDelay:1.0];
                [_saletable reloadData];
                [_saletable.mj_footer endRefreshing];
                return;
            }
            
            NSArray * examinationQuotaArray = infoDict[@"myExaminationquota"];
            NSArray * newArray = [ExamQuotaReleaseModel mj_objectArrayWithKeyValuesArray:examinationQuotaArray];
            [_dataArray addObjectsFromArray:newArray];
            [_saletable reloadData];
            
            [self.hudManager dismissSVHud];
            [_saletable.mj_footer endRefreshing];
            
        }else {
            
            [self.hudManager showErrorSVHudWithTitle:msg hideAfterDelay:1.0];
            [_saletable.mj_footer endRefreshing];
        }
        
        
    } failure:^(NSError *error) {
        
        [self.hudManager showErrorSVHudWithTitle:@"加载失败" hideAfterDelay:1.0];
        [_saletable.mj_footer endRefreshing];
        
    }];
    
}
- (void)createDefaultRelease {
    
    [_bgView removeFromSuperview];
    self.saletable.alpha = 0;
    self.bgView.alpha = 1;
    
    _bgView = [[UIView alloc] initWithFrame:self.view.frame];
    _bgView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_bgView];
    
    UIImageView * cryImgView = [[UIImageView alloc] initWithFrame:CGRectMake(kWidth/2 - 30, 100, 60, 60)];
    cryImgView.image = [UIImage imageNamed:@"iconfont-ku"];
    [_bgView addSubview:cryImgView];
    
    UILabel * titleLab = [[UILabel alloc] init];
    titleLab.text = @"您的名额发布暂时为空\n点击按钮即刻发布";
    titleLab.textColor = [UIColor colorWithHexString:@"#666666"];
    titleLab.font = [UIFont systemFontOfSize:18];
    titleLab.numberOfLines = 0;
    titleLab.textAlignment = NSTextAlignmentCenter;
    [_bgView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.view);
        make.top.equalTo(cryImgView.mas_bottom).offset(10);
        
    }];
    
    UIButton * releaseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    releaseBtn.backgroundColor = CommonButtonBGColor;
    releaseBtn.layer.cornerRadius = ButtonH/2;
    [releaseBtn setTitle:@"发布" forState:UIControlStateNormal];
    [releaseBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [releaseBtn addTarget:self action:@selector(releaseBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_bgView addSubview:releaseBtn];
    [releaseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.width.offset(kWidth - 40);
        make.top.equalTo(titleLab.mas_bottom).offset(40);
        make.height.offset(50);
        
    }];

}
- (void)setupNav
{
    _seg = [[UISegmentedControl alloc]initWithItems:@[@"买 入",@"发 布"]];
    _seg.tintColor = [UIColor whiteColor];
    _seg.selectedSegmentIndex = 0;
    
    [_seg setTitleTextAttributes :[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,Font17,NSFontAttributeName, nil]forState:UIControlStateNormal];
    
    [_seg setTitleTextAttributes :[NSDictionary dictionaryWithObjectsAndKeys:NavBackColor,NSForegroundColorAttributeName,Font17,NSFontAttributeName, nil]forState:UIControlStateSelected];
    
    _seg.frame = CGRectMake(0, 0, 200, 30);
    [_seg addTarget:self action:@selector(segClick:) forControlEvents:UIControlEventValueChanged];
    
    self.navigationItem.titleView =  _seg;
    
    //创建导航栏右按钮
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 50, 30);
    [rightBtn setTitle:@"新增" forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:19];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn setBackgroundColor:[UIColor clearColor]];
    [rightBtn addTarget:self action:@selector(releaseBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightBut = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightBut;
}
- (void)releaseBtnClick {
    //判断是否登录
    if ([kUid isEqualToString:@"0"]){
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"您尚未登录,无法进行此操作!" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去登录", nil];
        alertView.tag = 10000;
        [alertView show];
        
        return;
    }
    //判断实名认证状态
    if (![kAuthState isEqualToString:@"1"]) {
        
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"您尚未通过实名认证,无法进行此操作!" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alertView show];
        
        return;
    }

    CreateExamQuotaVC * vc = [[CreateExamQuotaVC alloc] init];
    
    vc.isNewAdd = YES;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (void)segClick:(UISegmentedControl *)seg
{
    NSInteger tag = seg.selectedSegmentIndex;
    if (0 == tag) {
        
        _isMyExamQuota = NO;
        _otherCurrentPage = 1;
        self.saletable.alpha = 1;
        self.bgView.alpha = 0;
        [self requestOtherData];
        
    }else
    {
        //判断是否登录
        if ([kUid isEqualToString:@"0"]){
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"您尚未登录,无法进行此操作!" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去登录", nil];
            alertView.tag = 10000;
            [alertView show];
            
            return;
        }
        //判断实名认证状态
        if (![kAuthState isEqualToString:@"1"]) {
            
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"您尚未通过实名认证,无法进行此操作!" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alertView show];
            
            return;
        }

        _isMyExamQuota = YES;
        _myCurrentPage = 1;
//        self.saletable.alpha = 0;
        [self requestMyData];
    }
}
- (void)setupTable
{
    UITableView *loctable = [[UITableView alloc]initWithFrame:CGRectMake(0, 10, kWidth, kHeight - 64)];
    loctable.tag = 201;
    loctable.dataSource = self;
    loctable.delegate = self;
    loctable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.saletable = loctable;
    [self.view addSubview:loctable];
    
    __weak typeof(self) weakSelf = self;
    
    _saletable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.otherCurrentPage = 1;
        weakSelf.myCurrentPage = 1;
        if (_isMyExamQuota) {
            
            [weakSelf requestMyData];
        }else {
            
            [weakSelf requestOtherData];
        }
        
    }];
    
    _saletable.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        if (_isMyExamQuota) {
            
            weakSelf.myCurrentPage ++;
            [weakSelf requestMyMoreData];
            
        }else {
            
            weakSelf.otherCurrentPage ++;
            [weakSelf requestOtherMoreData];
        }
        
    } ];
    

    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return _dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *identify = @"mehzID";
    
    MEHZCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    
    if (!cell) {
        
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MEHZCell" owner:nil options:nil]firstObject];
    }
    
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (_isMyExamQuota) {
        
        cell.own.alpha = 0;
        
    }else {
        
        cell.push = ^(ExamQuotaReleaseModel *examQuotaRelease){
            
            MEHZDeatilsController *details = [[MEHZDeatilsController alloc]init];
            
            details.idString = examQuotaRelease.idStr;
            
            [self.navigationController pushViewController:details animated:YES];
        };

        
    }
   
    
    _examQuotaRelease = _dataArray[indexPath.section];
    
    cell.examQuotaRelease = _examQuotaRelease;

    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return 10;

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return CGFLOAT_MIN;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 105;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_isMyExamQuota) {
        
        CreateExamQuotaVC * vc = [[CreateExamQuotaVC alloc] init];
        
        vc.isNewAdd = NO;
        vc.examQuotaRelease = _dataArray[indexPath.section];
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }else {
        
        MEHZDeatilsController *details = [[MEHZDeatilsController alloc]init];
        
        _recordModel = _dataArray[indexPath.section];
        details.idString = _recordModel.idStr;
        
        [self.navigationController pushViewController:details animated:YES];
    }
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 10000) {
        
        if (buttonIndex == 1) {
            //去登陆
            LoginGuideController *login = [[LoginGuideController alloc]init];
            login.gologin = YES;
            UINavigationController *root = [[UINavigationController alloc]initWithRootViewController:login];
            
            [root.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg"] forBarMetrics:UIBarMetricsDefault];
            root.navigationBar.shadowImage =[UIImage imageNamed:@"nav_bg"];
            root.navigationBar.titleTextAttributes = NavTitleTextAttributes;
            
            [self presentViewController:root animated:YES completion:nil];
        }
    }
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
