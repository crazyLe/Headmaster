//
//  NewHomeController.m
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/8/6.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import "NewHomeController.h"
#import "HomeTopCell.h"
#import "HometoutiaoCell.h"
#import "HomeZhaoshengCell.h"
#import "HomeFuliCell.h"
#import "HomeBannerView.h"
#import "BannerModel.h"
#import "ToutiaoModel.h"
#import "HeadMsgController.h"
#import "LessonViewController.h"
#import "HeadCircleController.h"
#import "NewAttentionController.h"
#import "DrivingOrderController.h"
#import "BasicTabBarController.h"
#import "HomeBannerView.h"

#import "PersonalTailorController.h"
#import "RecruitTeamController.h"
#import "VouchersController.h"

#import "LeaseController.h"
#import "MEHZController.h"
#import "CarLeaseController.h"
#import "UIBarButtonItem+Badge.h"

#import "ScanningController.h"
#import "AreaButton.h"
#import "CommonWebController.h"
#import "WMPWebViewController.h"
#import "HttpParamManager.h"
#import "CitySelectController.h"
#import "BasicNavController.h"
#import "SystemDetailsvController.h"
#import "JpushManager.h"
#import "MessageDataBase.h"
#import "MyCircleViewController.h"
#import "CircleDetailWebController.h"
#import <CoreLocation/CoreLocation.h>
#import "LoginGuideController.h"
#import "HomeWebController.h"
#import "CircleTopLineController.h"
#import "RealNameModel.h"
#import "AddressManager.h"

@interface NewHomeController ()<UITableViewDataSource,UITableViewDelegate,HomeBannerViewDelegate,HomeTopCellDelegate,HometoutiaoCellDelegate,HomeZhaoshengCellDelegate,HomeFuliCellDelegate,CLLocationManagerDelegate,UIAlertViewDelegate>
{
    NSArray *heightArr;
    NSArray *bannerArr;
    NSArray *toutiaoArr;
}
@property(weak,nonatomic)UIImageView *bg;
@property(weak,nonatomic)UITableView *table;
@property(strong,nonatomic)HomeBannerView *bannerView;

@property(strong,nonatomic)AreaButton *area;

@property (nonatomic, strong) CLLocationManager  *locationManager;

@property(strong,nonatomic)UIBarButtonItem *navRightButton;

@property(strong,nonatomic)UIAlertView *outAlert;

@property (nonatomic, strong) RealNameModel * realName;

@end

@implementation NewHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGBColor(247, 247, 247);
 
    [self setupNav];
    
    _outAlert = [[UIAlertView alloc]initWithTitle:@"" message:@"您尚未登录!" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去登录", nil];
    _outAlert.tag = 808;
    
    heightArr = @[@95,@55,@(50+2*adBtnW*(95.0/90.0)),@(serBtnW+100)];
    
    _bannerView = [[HomeBannerView alloc]initWithFrame:CGRectMake(0, 0, kWidth, 110) placeImgName:@"placeBanner" isHomePage:YES];
    _bannerView.delegate = self;
    _bannerView.backgroundColor = [UIColor clearColor];
    
    [self setupTable];
    
    [self lodaHomeData];
    
    [self locate];
    
//    [NOTIFICATION_CENTER addObserver:self selector:@selector(loactionChange) name:kLocationChangeNotification object:nil];
    
    [NOTIFICATION_CENTER addObserver:self selector:@selector(msgRead) name:kMakeMsgIsReadNotification object:nil];
    
    [NOTIFICATION_CENTER addObserver:self selector:@selector(msgRead) name:kUpdateMainMsgRedPointNotification object:nil];
    
    [NOTIFICATION_CENTER addObserver:self selector:@selector(pushController:) name:@"ReceivePushMsg" object:nil];

    //jpush监听
    [[JpushManager sharedJpushManager] startMonitor];
    
//    [self checkVersion];
    
    if (0 != [kUid intValue]) {
        [self requestAuthenticationStateData];
    }
    
}


- (void)pushController:(NSNotification *)notification
{
    NSDictionary * userInfo = [notification userInfo];
    
    NSInteger index = [userInfo[@"msg_id"] integerValue];
    
//    [self.hudManager showErrorSVHudWithTitle:@"" hideAfterDelay:3.0];
//    [NSThread sleepForTimeInterval:2.0];
    
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
            
            top.urlString = [NSString stringWithFormat:@"%@/%d?app=1&uid=%@&cityId=%ld&address=%@,%@",basicCircleWebUrl,1000,kUid,[HttpParamManager getCurrentCityID],[HttpParamManager getLongitude],[HttpParamManager getLatitude]];
            
            [self.navigationController pushViewController:top animated:YES];
        }
            break;
        default:
        {
            SystemDetailsvController *sys = [[SystemDetailsvController alloc]init];
            [self.navigationController pushViewController:sys animated:YES];
        }
            break;
    }
}

- (void)msgRead
{
    NSInteger num = [[MessageDataBase shareInstance] queryAllUnRead].count;
    self.navigationItem.rightBarButtonItem.badgeValue = [NSString stringWithFormat:@"%d",(int)num];
}

-(void)loactionChange
{
    NSString *str = [curDefaults objectForKey:@"locationCity"];
    if (str.length > 0) {
        [_area setTitle:str forState:UIControlStateNormal];
    }
}

- (void)setupNav
{
    _area = [[AreaButton alloc]initWithFrame:CGRectMake(0, 0, 80, 24)];
    _area.imageView.image = [UIImage imageNamed:@"xiala_h"];
    _area.titleLabel.font = [UIFont systemFontOfSize:18.0];
    _area.titleLabel.textAlignment = NSTextAlignmentLeft;
    [_area addTarget:self action:@selector(secltedArea) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:_area];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"msg_n"] forState:UIControlStateNormal];
    button.frame = CGRectMake(0,100,button.currentImage.size.width, button.currentImage.size.height);
    [button addTarget:self action:@selector(seeMessage) forControlEvents:UIControlEventTouchDown];
    
    // 添加角标
    _navRightButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = _navRightButton;
    self.navigationItem.rightBarButtonItem.badgeBGColor = [UIColor whiteColor];
    
}

- (void)setupTable
{
    CGRect tableFream = CGRectMake(0, 0 , kWidth, kHeight-64);
    UITableView *loctable = [[UITableView alloc]initWithFrame:tableFream];
    loctable.tableHeaderView = _bannerView;
    loctable.separatorStyle = UITableViewCellSeparatorStyleNone;
    loctable.dataSource = self;
    loctable.delegate = self;
    self.table = loctable;
    [self.view addSubview:loctable];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSInteger section = indexPath.section;
    
//    NSInteger row = indexPath.row;
    
    
    switch (section) {
        case 0:
        {
            static NSString *identify = @"HomeTopCell";
            
            HomeTopCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
            
            if (!cell) {
                
                cell = [[[NSBundle mainBundle]loadNibNamed:@"HomeTopCell" owner:nil options:nil] firstObject];
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
            cell.delegate = self;
            
            return cell;
        }
            break;
            
        case 1:
        {
            static NSString *identify = @"HometoutiaoCell";
            
            HometoutiaoCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
            
            if (!cell) {
                
                cell = [[[NSBundle mainBundle]loadNibNamed:@"HometoutiaoCell" owner:nil options:nil] firstObject];
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
            if (0 != toutiaoArr.count) {
                cell.titles = toutiaoArr;
                cell.delegate = self;
            }
            
            UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(toutiaoClick)];
            [cell addGestureRecognizer:tap];
    
            return cell;
        }
            break;
        case 2:
        {
            static NSString *identify = @"HomeZhaoshengCell";
            
            HomeZhaoshengCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
            
            if (!cell) {
                
                cell = [[[NSBundle mainBundle]loadNibNamed:@"HomeZhaoshengCell" owner:nil options:nil] firstObject];
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
            cell.delegate = self;
            
            return cell;
        }
            break;
            
            case 3:
        {
            static NSString *identify = @"HomeFuliCell";
            
            HomeFuliCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
            
            if (!cell) {
                
                cell = [[[NSBundle mainBundle]loadNibNamed:@"HomeFuliCell" owner:nil options:nil] firstObject];
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
            cell.delegate = self;
            
            return cell;
        }
            break;
            
        default:
            break;
    }
    
    return nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [heightArr[indexPath.section] floatValue];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (3 == section) {
        return 0;
    }
    return 15;
}

-(void)topClickedBtn:(UIButton *)btn
{
    NSInteger tag = btn.tag;
//    NSLog(@"top ..");
    if (100 == tag)//校长课堂
    {
        LessonViewController *lesson = [[LessonViewController alloc]init];
        [self.navigationController pushViewController:lesson animated:YES];
        
    }else if (101 == tag)//校长圈
    {
        self.basicVC.selectedIndex = 2;
    }else if (102 == tag)//关注度
    {
        if(0 == [kUid intValue])
        {
            [_outAlert show];
        }else
        {
            NewAttentionController *attent = [[NewAttentionController alloc]init];
            [self.navigationController pushViewController:attent animated:YES];
        }
    }else if (103 == tag)//驾校订单
    {
        if(0 == [kUid intValue])
        {
            [_outAlert show];
        }else
        {
            DrivingOrderController *order = [[DrivingOrderController alloc]init];
            [self.navigationController pushViewController:order animated:YES];
        }
        
    }
}
- (void)toutiaoMoreClick:(HometoutiaoCell *)cell
{
    NSLog(@"more ..");
}
- (void)zhaoshengClickedBtn:(UIButton *)btn
{
    NSInteger tag = btn.tag;
    NSLog(@"zhaosheng ..");
    if (201 == tag)//招生微名片
    {
        if(0 == [kUid intValue])
        {
            [_outAlert show];
        }else
        {
            WMPWebViewController *wmpweb = [[WMPWebViewController alloc]init];
            wmpweb.urlStr = wmpUrl;
            [self.navigationController pushViewController:wmpweb animated:YES];
        }
    }
    else if (202 == tag)//教练招生团
    {
        if(0 == [kUid intValue])
        {
            [_outAlert show];
        }
        else
        {
            RecruitTeamController *recruit = [[RecruitTeamController alloc]init];
            [self.navigationController pushViewController:recruit animated:YES];
        }
    }
    else if (203 == tag)//代金劵
    {
        if(0 == [kUid intValue])
        {
            [_outAlert show];
        }else
        {
            VouchersController *voucher = [[VouchersController alloc]init];
            [self.navigationController pushViewController:voucher animated:YES];
        }
    }
    else if(204 == tag)//赏金猎人
    {
        HomeWebController *homeweb = [[HomeWebController alloc]init];
        homeweb.str = @"sjlr";
        [self.navigationController pushViewController:homeweb animated:YES];
    }
    else if(205 == tag)//招生推广
    {
        
        HomeWebController *homeweb = [[HomeWebController alloc]init];
        homeweb.str = @"zstg";
        [self.navigationController pushViewController:homeweb animated:YES];
    }
}

- (void)fuliClickedBtn:(UIButton *)btn
{
    NSInteger tag = btn.tag;
    
    if (301 == tag)//教练车租赁
    {
        CarLeaseController *carlease = [[CarLeaseController alloc]init];
        [self.navigationController pushViewController:carlease animated:YES];
        
    }
    else if (302 == tag)//训练场租赁
    {
        LeaseController *lease = [[LeaseController alloc]init];
        [self.navigationController pushViewController:lease animated:YES];
        
    }
    else if (303 == tag)//名额合作
    {
        MEHZController *mehz = [[MEHZController alloc]init];
        [self.navigationController pushViewController:mehz animated:YES];
       
    }
    else if (304 == tag)//驾校贷款
    {
        CommonWebController * vc = [[CommonWebController alloc] init];
        vc.urlStr = jxqdUrl;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)secltedArea
{
    NSLog(@"select area ...");
    /*
    __block BOOL isReturn = NO;
    while (isStartUpdaeDB) {
        //从数据库中读取，验证
        [[SCDBManager shareDatabaseQueue] inDatabase:^(FMDatabase *db) {
            if ([db open]) {
                
                NSString * countryArrCount = [NSString stringWithFormat:@"%@",[kUserDefault objectForKey:@"kCountryArrCount"]];
                FMResultSet *result = [db executeQuery:[NSString stringWithFormat:@"select * from %@ where %@ = ?",kCountyTableName,@"id"],countryArrCount];
                
                if ([result next]) {
                    [kUserDefault setBool:NO forKey:@"AreaStartUpdateFlag"];  //标记地区数据已经更新完毕
                    [kUserDefault synchronize];
                }
                else
                {
                    isReturn = YES;
                }
                
                [db close];
            }
            else
            {
                
            }
        }];
        if (isReturn) {
            [self.hudManager showSuccessSVHudWithTitle:@"数据库升级中,请稍等.." hideAfterDelay:1.0 animaton:YES];
            return;
        }
    }
     
     */
    
    CitySelectController *selArea = [[CitySelectController alloc]init];
    selArea.didSelectCityBlock = ^ (NSString *city){
        [_area setTitle:city forState:UIControlStateNormal];
        [curDefaults setObject:city forKey:@"locationCity"];
    };
    BasicNavController *cityNav = [[BasicNavController alloc]initWithRootViewController:selArea];
    [self presentViewController:cityNav animated:YES completion:nil];
}

- (void)seeMessage
{
    if ([kUid intValue] != 0) {
    
        SystemDetailsvController *msg = [[SystemDetailsvController alloc]init];
        [self.navigationController pushViewController:msg animated:YES];
    }else {
        
        LoginGuideController *login = [[LoginGuideController alloc]init];
        login.gologin = YES;
        UINavigationController *root = [[UINavigationController alloc]initWithRootViewController:login];
        [root.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg"] forBarMetrics:UIBarMetricsDefault];
        root.navigationBar.shadowImage =[UIImage imageNamed:@"nav_bg"];
        root.navigationBar.titleTextAttributes = NavTitleTextAttributes;
        
        [self presentViewController:root animated:YES completion:nil];
        
    }

}

- (void)lodaHomeData
{
//    [self.hudManager showNormalStateSVHudWithTitle:@"加载中..." hideAfterDelay:100.0];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"uid"] = kUid;
    param[@"deviceInfo"] = deviceInfo;
    param[@"time"] = self.getcurrentTime;
    param[@"sign"] = [HttpsTools getSignWithIdentify:@"/main" time:self.getcurrentTime];
    NSLog(@"%@,%@",param,homeUrl);
    [HttpsTools kPOST:homeUrl parameter:param progress:^(NSProgress *downloadProgress) {
    } succeed:^(id backdata, int code, NSString *msg) {
        NSLog(@"%@,%d",backdata,code);
        [MBProgressHUD showMessage:msg];
        if (1 == code) {
//            [self.hudManager dismissSVHud];
            
            bannerArr = [BannerModel mj_objectArrayWithKeyValuesArray:backdata[@"banners"]];
            
            [_bannerView refreshData:bannerArr];
            
            toutiaoArr = [ToutiaoModel mj_objectArrayWithKeyValuesArray:backdata[@"coachCommunity"]];
            
            if (toutiaoArr.count != 0) {
//                [self.table reloadSection:1 withRowAnimation:UITableViewRowAnimationNone];
                [self.table reloadData];
            }
        }
        
        [MBProgressHUD hideHUD];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
- (void)locate{
    // 判断定位操作是否被允许
    if([CLLocationManager locationServicesEnabled]) {
        //定位初始化
        _locationManager=[[CLLocationManager alloc] init];
        _locationManager.delegate=self;
        _locationManager.desiredAccuracy=kCLLocationAccuracyBest;
        if ([[UIDevice currentDevice].systemVersion intValue]>=8) {
            [_locationManager requestWhenInUseAuthorization];//使用程序其间允许访问位置数据（iOS8定位需要）
        }
        _locationManager.distanceFilter=10;
        [_locationManager startUpdatingLocation];//开启定位
    }else {
        //提示用户无法进行定位操作
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"定位不成功 ,请确认开启定位" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
    }
    // 开始定位
    [_locationManager startUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    //此处locations存储了持续更新的位置坐标值，取最后一个值为最新位置，如果不想让其持续更新位置，则在此方法中获取到一个值之后让locationManager stopUpdatingLocation
    CLLocation *currentLocation = [locations lastObject];
    // 获取当前所在的城市名
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    //根据经纬度反向地理编译出地址信息
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *array, NSError *error)
     {
         if (array.count > 0)
         {
             CLPlacemark *placemark = [array objectAtIndex:0];
             //NSLog(@%@,placemark.name);//具体位置
             //获取城市
             NSString *city = placemark.locality;
             [curDefaults setObject:city forKey:@"locationCity"];
             
             if (!city) {
                 //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                 city = placemark.administrativeArea;
             }
             [_area setTitle:city forState:UIControlStateNormal];
             
             //             cityName = city;
             //             NSLog(@定位完成:%@,cityName);
             //系统会一直更新数据，直到选择停止更新，因为我们只需要获得一次经纬度即可，所以获取之后就停止更新
             [manager stopUpdatingLocation];
         }else if (error == nil && [array count] == 0)
         {
             //             NSLog(@No results were returned.);
         }else if (error != nil)
         {
             //             NSLog(@An error occurred = %@, error);
         }
     }];
}
/**
 *定位失败，回调此方法
 */
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    if ([error code]==kCLErrorDenied) {
        NSLog(@"访问被拒绝");
    }
    if ([error code]==kCLErrorLocationUnknown) {
        NSLog(@"无法获取位置信息");
    }
}

#pragma mark - HomeBannerViewDelegate

//- (void)homeBannerView:(HomeBannerView*)View withindex:(NSString*)index{
//    NSLog(@"点击了轮播图");
//}
//- (void)homeBannerViewCilekedBanner:(BannerModel *)model
//{
//    NSLog(@"%@",model);
//    
//    CommonWebController *comm = [[CommonWebController alloc]init];
//    comm.urlStr = model.pageUrl;
//    [self.navigationController pushViewController:comm animated:YES];
//}

- (void)toutiaoClick
{
    CircleTopLineController * vc = [[CircleTopLineController alloc] init];
    vc.url = hometoutiaoUrl;
    vc.url2 = hometoutiaoUrl2;
    [self.navigationController pushViewController:vc animated:YES];
}
//- (void)toutiaoClickpushWeb:(NSString *)url
//{
//    if(0 == [kUid intValue])
//    {
//        [_outAlert show];
//    }else
//    {
//        CircleTopLineController * vc = [[CircleTopLineController alloc] init];
//        vc.url = @"https://www.kangzhuangxueche.com/index.php/wap/circle?circleId=3";
//        vc.url2 = @"https://www.kangzhuangxueche.com/index.php/wap/topic?circleId=3";
//        [self.navigationController pushViewController:vc animated:YES];
//    }
//}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
   NSInteger tag = alertView.tag;
    
    switch (tag) {
        case 101:
        {
            if (1 == buttonIndex) {
                NSString *str = [NSString stringWithFormat:
                                 @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%d",1144838119]; //appID 解释如下
                
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
            }
        }
            break;
        case 102:
        {
            if (0 == buttonIndex) {
                
                NSString *str = [NSString stringWithFormat:
                                 @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%d",1144838119]; //appID 解释如下
                
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
            }
        }
            break;
        case 808:
        {
            if (1 == buttonIndex) {
                LoginGuideController *login = [[LoginGuideController alloc]init];
                login.gologin = YES;
                UINavigationController *root = [[UINavigationController alloc]initWithRootViewController:login];

                [root.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg"] forBarMetrics:UIBarMetricsDefault];
                root.navigationBar.shadowImage =[UIImage imageNamed:@"nav_bg"];
                root.navigationBar.titleTextAttributes = NavTitleTextAttributes;
                
                [self presentViewController:root animated:YES completion:nil];
            }
        }
            break;
            
        default:
            break;
    }
}

//判断认证状态的请求
- (void)requestAuthenticationStateData {
    
    NSString * url = schoolAuthenticationState;
    NSMutableDictionary * paramDict = [NSMutableDictionary dictionary];
    paramDict[@"uid"] = kUid;
    NSString * timeString = self.getcurrentTime;
    paramDict[@"time"] = timeString;
    paramDict[@"sign"] = [HttpsTools getSignWithIdentify:@"/userAuth" time:timeString];
    
    [HttpsTools POST:url parameter:paramDict progress:^(NSProgress *downloadProgress) {
    } succeed:^(id responseObject) {
        NSLog(@"认证状态%@",responseObject);
        NSInteger code = [responseObject[@"code"] integerValue];
        NSString * msg = responseObject[@"msg"];
        if (code == 1) {
            NSDictionary * infoDict = responseObject[@"info"];
            _realName = [RealNameModel mj_objectWithKeyValues:infoDict];
            [curDefaults setObject:_realName.state forKey:@"kAuthState"];
        }else {
            [MBProgressHUD showError:msg];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"获取认证状态失败"];
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
