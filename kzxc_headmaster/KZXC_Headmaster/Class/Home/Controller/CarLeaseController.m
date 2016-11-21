//
//  CarLeaseController.m
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/7/21.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import "CarLeaseController.h"
#import "NomalLeaseController.h"
#import "LeaseCell.h"
#import "UIColor+Hex.h"
#import "CocahCarLeaseModel.h"
#import "LeaseCocahCarModel.h"
#import "CreateModifyMyCoachCarVC.h"
#import "PicModel.h"
#import "LoginGuideController.h"

@interface CarLeaseController ()<UICollectionViewDataSource,UICollectionViewDelegate,UITextFieldDelegate,UIAlertViewDelegate>

@property(weak,nonatomic)UICollectionView *collection;
@property (nonatomic, strong) NSMutableArray * dataArray;
@property (nonatomic, strong) LeaseCocahCarModel * leaseCocahCar;
@property (nonatomic, assign) int otherCurrentPage;
@property (nonatomic, assign) int myCurrentPage;
@property (nonatomic, strong) UIView * bgView;
@property (nonatomic, assign) BOOL isMineCoachCar;
@property (nonatomic, strong) UISegmentedControl *seg;
@end

@implementation CarLeaseController


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadMyCoachCar) name:@"reloadMyCoachCar" object:nil];
    
}
- (void)reloadMyCoachCar {
    
    _isMineCoachCar = YES;
    _seg.selectedSegmentIndex = 1;
    _myCurrentPage = 1;
    [self requestMyData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.otherCurrentPage = 1;
    self.myCurrentPage = 1;
    
    _leaseCocahCar = [[LeaseCocahCarModel alloc] init];
    
    self.view.backgroundColor = RGBColor(247,247,247);
                                         
    [self setupNav];
    
    [self setupCollection];
    
    _bgView.alpha = 0;
    
    //教练车租赁--承租
    [self requestOthersData];

    _bgView.alpha = 0;
    _collection.alpha = 1;
}

- (void)requestOthersData {
    
    [self.hudManager showNormalStateSVHUDWithTitle:@"加载中"];
    NSString * url = coachCarLease;
    
    NSMutableDictionary * paramDict = [NSMutableDictionary dictionary];
    paramDict[@"uid"] = kUid;
    NSString * timeString = self.getcurrentTime;
    paramDict[@"time"] = timeString;
    paramDict[@"sign"] = [HttpsTools getSignWithIdentify:@"/carHire" time:timeString];
    paramDict[@"deviceInfo"] = deviceInfo;
    paramDict[@"address"] = [NSString stringWithFormat:@"%@,%@",[HttpsTools getLatitude],[HttpsTools getLongitude]];
    paramDict[@"cityId"] = @([HttpParamManager getCurrentCityID]);
    paramDict[@"pageId"] = @(self.otherCurrentPage);
    
    
    [HttpsTools POST:url parameter:paramDict progress:^(NSProgress *downloadProgress) {
    } succeed:^(id responseObject) {
        NSLog(@"别人的教练车%@",responseObject);
        NSInteger code = [responseObject[@"code"] integerValue];
        NSString * msg = responseObject[@"msg"];
        if (code == 1) {
            [self.hudManager dismissSVHud];
            
            [_dataArray removeAllObjects];
            NSDictionary * infoDict = responseObject[@"info"];
            NSArray * carListAray = infoDict[@"carList"];
            
            _dataArray = [CocahCarLeaseModel mj_objectArrayWithKeyValuesArray:carListAray];
            
            [_collection reloadData];
            
            
            [self.collection.mj_header endRefreshing];
            
        }else {
            
            [_dataArray removeAllObjects];
            [_collection reloadData];
            [self.hudManager showErrorSVHudWithTitle:msg hideAfterDelay:1.0];
            [self.collection.mj_header endRefreshing];
        }
        
        
        
    } failure:^(NSError *error) {
        
        [self.hudManager showErrorSVHudWithTitle:@"加载失败" hideAfterDelay:1.0];
        [self.collection.mj_header endRefreshing];
    }];
    
    
}
- (void)requestMoreOtherData {
    
    
    NSString * url = coachCarLease;
    
    NSMutableDictionary * paramDict = [NSMutableDictionary dictionary];
    paramDict[@"uid"] = kUid;
    NSString * timeString = self.getcurrentTime;
    paramDict[@"time"] = timeString;
    paramDict[@"sign"] = [HttpsTools getSignWithIdentify:@"/carHire" time:timeString];
    paramDict[@"deviceInfo"] = deviceInfo;
    paramDict[@"address"] = [NSString stringWithFormat:@"%@,%@",[HttpsTools getLatitude],[HttpsTools getLongitude]];
    paramDict[@"cityId"] = [NSString stringWithFormat:@"%ld",(long)[HttpParamManager getCurrentCityID]];
    
    paramDict[@"pageId"] = @(self.otherCurrentPage);
    
    
    [HttpsTools POST:url parameter:paramDict progress:^(NSProgress *downloadProgress) {
    } succeed:^(id responseObject) {
//        NSLog(@"+++%@",responseObject);
        NSInteger code = [responseObject[@"code"] integerValue];
        NSString * msg = responseObject[@"msg"];
        if (code == 1) {
            
            NSDictionary * infoDict = responseObject[@"info"];
            NSArray * carListAray = infoDict[@"carList"];
            
            NSArray * newArray = [CocahCarLeaseModel mj_objectArrayWithKeyValuesArray:carListAray];
            [_dataArray addObjectsFromArray:newArray];
            
            [_collection reloadData];
            
            [self.collection.mj_footer endRefreshing];
            
        }else {
            
            [MBProgressHUD showError:msg];
            [self.collection.mj_footer endRefreshing];
        }
        
        
        
    } failure:^(NSError *error) {
        
        [MBProgressHUD showError:@"加载失败"];
        [self.collection.mj_footer endRefreshing];
    }];
    
    
}

- (void)setupNav
{
    _seg = [[UISegmentedControl alloc]initWithItems:@[@"我要承租",@"我要出租"]];
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
- (void)segClick:(UISegmentedControl *)seg
{
    NSInteger tag = seg.selectedSegmentIndex;
    if (0 == tag) {
        
        self.otherCurrentPage = 1;
        _isMineCoachCar = NO;
        [self requestOthersData];
        self.collection.alpha = 1;
        self.bgView.alpha = 0;
     
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
       
        self.myCurrentPage = 1;
        _isMineCoachCar = YES;
        //教练车出租--出租
        [self requestMyData];

    }
}
- (void)requestMyData {
    
    
    [self.hudManager showNormalStateSVHUDWithTitle:@"加载中..."];
    
    NSString * url = coachCarMyLease;
    NSString * timeString = self.getcurrentTime;
    
    NSMutableDictionary * paramDict = [NSMutableDictionary dictionary];
    paramDict[@"uid"] = kUid;
    paramDict[@"time"] = timeString;
    paramDict[@"deviceInfo"] = deviceInfo;
    paramDict[@"sign"] = [HttpsTools getSignWithIdentify:@"/myCarHire" time:timeString];
    paramDict[@"pageId"] = @(self.myCurrentPage);
    
    [HttpsTools POST:url parameter:paramDict progress:^(NSProgress *downloadProgress) {
    } succeed:^(id responseObject) {
        
        NSLog(@"我的教练车租赁%@",responseObject);
        NSInteger code = [responseObject[@"code"] integerValue];
        //NSString * msg = responseObject[@"msg"];
  
        if (code == 1 ) {
            
            [self.hudManager dismissSVHud];
            
            self.collection.alpha = 1;
            self.bgView.alpha = 0;
            
            [_dataArray removeAllObjects];
            
            NSDictionary * infoDict = responseObject[@"info"];
            NSArray * carListAray = infoDict[@"carList"];
            _dataArray = [CocahCarLeaseModel mj_objectArrayWithKeyValuesArray:carListAray];
            [_collection reloadData];

            [self.collection.mj_header endRefreshing];
            
        }else {
            
//            [self.hudManager showNormalStateSVHudWithTitle:msg hideAfterDelay:1.0];
            [self.hudManager dismissSVHud];
            //创建新增的那个"发布默认页界面"
            [self createDefaultRelease];
            
            [self.collection.mj_header endRefreshing];
        }
        
        
        
    } failure:^(NSError *error) {
        
        [self.hudManager showErrorSVHudWithTitle:@"教练车出租列表加载失败" hideAfterDelay:1.0];
        
        [self.collection.mj_header endRefreshing];
    }];
    
    
}
- (void)requestMoreMyData {
    
    NSString * url = coachCarMyLease;
    NSString * timeString = self.getcurrentTime;
    
    NSMutableDictionary * paramDict = [NSMutableDictionary dictionary];
    paramDict[@"uid"] = kUid;
    paramDict[@"time"] = timeString;
    paramDict[@"deviceInfo"] = deviceInfo;
    paramDict[@"sign"] = [HttpsTools getSignWithIdentify:@"/myCarHire" time:timeString];
    paramDict[@"pageId"] = @(self.myCurrentPage);
    
    [HttpsTools POST:url parameter:paramDict progress:^(NSProgress *downloadProgress) {
    } succeed:^(id responseObject) {
        
//        NSLog(@"<><>%@",responseObject);
        NSInteger code = [responseObject[@"code"] integerValue];
        //NSString * msg = responseObject[@"msg"];
        if (code == 1 ) {
            
            NSDictionary * infoDict = responseObject[@"info"];
            NSArray * carListAray = infoDict[@"carList"];
            
            NSArray * newArray = [CocahCarLeaseModel mj_objectArrayWithKeyValuesArray:carListAray];
            [_dataArray addObjectsFromArray:newArray];
            
            [_collection reloadData];
            
            [self.collection.mj_footer endRefreshing];
        }else {
            
            [self.hudManager showNormalStateSVHudWithTitle:@"没有更多数据" hideAfterDelay:1.0];
            [self.collection.mj_footer endRefreshing];
        }
        
        
    } failure:^(NSError *error) {
        
        [self.hudManager showErrorSVHudWithTitle:@"教练车出租列表加载失败" hideAfterDelay:1.0];
        [self.collection.mj_footer endRefreshing];
    }];

  
}
- (void)createDefaultRelease {
    
    [_bgView removeFromSuperview];
    self.collection.alpha = 0;
    self.bgView.alpha = 1;
    
    _bgView = [[UIView alloc] initWithFrame:self.view.frame];
    _bgView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_bgView];
    
    UIImageView * cryImgView = [[UIImageView alloc] initWithFrame:CGRectMake(kWidth/2 - 30, 100, 60, 60)];
    cryImgView.image = [UIImage imageNamed:@"iconfont-ku"];
    [_bgView addSubview:cryImgView];
    
    UILabel * titleLab = [[UILabel alloc] init];
    titleLab.text = @"您的出租项暂时为空\n点击按钮即刻发布";
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
#pragma mark -- 新增发布教练车出租信息
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
    
    CreateModifyMyCoachCarVC * vc = [[CreateModifyMyCoachCarVC alloc] init];
    vc.isNewAdd = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
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
- (void)setupCollection
{
    
    CGFloat conentw = (kWidth - 30)/2;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    layout.itemSize = CGSizeMake(conentw, conentw + 80);
    
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    ;
    UICollectionView *collect =[[UICollectionView alloc]initWithFrame:CGRectMake(0, 15, kWidth, kHeight - 64 - 20) collectionViewLayout:layout];
    
    collect.backgroundColor = [UIColor colorWithHexString:@"#f7f7f7"];
    
    //    collect.backgroundColor =[UIColor whiteColor];
    
    collect.dataSource = self;
    
    collect.delegate = self;
    
    [collect registerClass:[LeaseCell class] forCellWithReuseIdentifier:@"LeaseCellID"];
    
    self.collection = collect;
    
    [self.view addSubview:collect];
    
    __weak typeof(self) weakSelf = self;
    _collection.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        weakSelf.otherCurrentPage = 1;
        weakSelf.myCurrentPage = 1;
        
        if (_isMineCoachCar) {
            
            [weakSelf requestMyData];
        }else {
            
            [weakSelf requestOthersData];
        }
        
        
    }];
    
    _collection.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
       
        if (_isMineCoachCar) {
            
            weakSelf.myCurrentPage ++;
            [weakSelf requestMoreMyData];
            
        }else {
            weakSelf.otherCurrentPage ++;
            [weakSelf requestMoreOtherData];
        }
        
    }];
    
    self.collection.mj_footer.automaticallyHidden = YES;

}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return _dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"LeaseCellID";
    
    LeaseCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    
    CocahCarLeaseModel * cocahCar = _dataArray[indexPath.row];
    
    
    if (_isMineCoachCar) {
        
        [cell.icon sd_setImageWithURL:[NSURL URLWithString:cocahCar.picModel.pic1] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    }else {
        [cell.icon sd_setImageWithURL:[NSURL URLWithString:cocahCar.picinfo] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    }
    
    cell.price.text = [NSString stringWithFormat:@"%@/天",cocahCar.priceDay];
    cell.scale.text = [NSString stringWithFormat:@"%@辆",cocahCar.carNum];
    cell.details.text = [NSString stringWithFormat:@"%@ %@年 %@万公里",cocahCar.carType,cocahCar.carAge,cocahCar.carKm];
    
    cell.backgroundColor = [UIColor whiteColor];
    
    return cell;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 0, 10);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (_isMineCoachCar) {
        
        CreateModifyMyCoachCarVC * vc = [[CreateModifyMyCoachCarVC alloc] init];
        CocahCarLeaseModel * cocahCarLease = _dataArray[indexPath.row];
        vc.isNewAdd = NO;
        vc.coachCarLeasee = cocahCarLease;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else {
        
//        NSLog(@"row%lu,sec:%lu",(long)indexPath.row,(long)indexPath.section);
        NomalLeaseController *nomal = [[NomalLeaseController alloc]init];
        
        CocahCarLeaseModel * cocahCar = _dataArray[indexPath.row];
        
        nomal.idString = cocahCar.idStr;
        
        nomal.title = @"教练车租赁";
        
        [self.navigationController pushViewController:nomal animated:YES];
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
