//
//  AppDelegate.m
//  KZXC_Instructor
//
//  Created by 翁昌青 on 16/6/27.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import "AppDelegate.h"
#import "BasicTabBarController.h"
#import "LoginGuideController.h"
#import <BaiduMapAPI_Map/BMKMapView.h>//只引入所需的单个头文件
#import "GroundMapController.h"
#import "AddressManager.h"
#import "WMPPopView.h"
#import "PersonalTailorController.h"
#import "JPUSHService.h"
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import "GudiePageController.h"
#import "DrivingOrderController.h"
#import "MyCircleViewController.h"
#import "CircleDetailWebController.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"
#import "CheckVersionManager.h"
#import "LLAddress.h"
#import "CreateModifyMyCoachCarVC.h"
#import "CreateModifyMyVenueVC.h"
#import "CreateExamQuotaVC.h"
#import "MyCircleViewController.h"
#import "CircleViewController.h"

@interface AppDelegate ()<WXApiDelegate>
{
    BMKMapManager* _mapManager;
}
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [kUserDefault setBool:NO forKey:@"AreaStartUpdateFlag"];
    [kUserDefault synchronize];
    
    [self initBadiDuMapData];
    
    [self initUMSocialData];
    
    [self initJPUSHServiceOptions:launchOptions];
    
    [WXApi registerApp:@"wx23239d2bc3732964" withDescription:@"xiaozhangWeiPay"];
    
    //设置svb默认样式
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    
    //设置电池条为白色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    //开始定位
    [[LocationManager sharedLocationManager]startLocationWithFinishSuccessBlock:^(CGFloat longitude, CGFloat latitude, NSString *locationString, NSDictionary *addressDictionary, CLPlacemark *placeMark) {
        
        HJLog(@"%f-------%f--------%@-------%@",longitude,latitude,locationString,addressDictionary);
        
        NSString *province = addressDictionary[@"State"];
        
        NSString *str = [province substringToIndex:province.length - 1];
        
        [curDefaults setObject:str forKey:@"province"];
        
    }];
    
    //禁用IQKeyboardManager模块
    [[IQKeyboardManager sharedManager] disableDistanceHandlingInViewControllerClass:[WMPPopView class]];
    [[IQKeyboardManager sharedManager] disableDistanceHandlingInViewControllerClass:[CircleViewController class]];
    [[IQKeyboardManager sharedManager] disableDistanceHandlingInViewControllerClass:[MyCircleViewController class]];
    
    [[IQKeyboardManager sharedManager] removeDisableInViewControllerClass:[CreateModifyMyCoachCarVC class]];
    [[IQKeyboardManager sharedManager] removeDisableInViewControllerClass:[CreateModifyMyVenueVC class]];
    [[IQKeyboardManager sharedManager] removeDisableInViewControllerClass:[CreateExamQuotaVC class]];
    
    //进入应用
    [self joinApp];
    
    return YES;
}

//初始化百度地图模块数据
- (void)initBadiDuMapData
{
    // 要使用百度地图，请先启动BaiduMapManager
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:@"UQDPwGyNrDbRaLqHoO9TWkp7mISa7OVf"  generalDelegate:nil];
    if (!ret) {
//        NSLog(@"manager start failed!");
    }
}

//初始化友盟分享
- (void)initUMSocialData
{
    //设置友盟社会化组件appkey
    [UMSocialData setAppKey:@"57b169ffe0f55a46dd000e71"];
    //设置微信AppId、appSecret，分享url
    
    [UMSocialWechatHandler setWXAppId:@"wx23239d2bc3732964" appSecret:@"c8683929bf37668f24a16092fc6ecdb5" url:@"http://www.umeng.com/social"];
    //设置手机QQ 的AppId，Appkey，和分享URL，需要#import "UMSocialQQHandler.h"
    [UMSocialQQHandler setQQWithAppId:@"1105558163" appKey:@"pQTgXdIgpZXcwpII" url:@"http://www.umeng.com/social"];
}
//初始化极光推送数据
- (void)initJPUSHServiceOptions:(NSDictionary *)launchOptions
{
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    } else {
        //categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                          UIRemoteNotificationTypeSound |
                                                          UIRemoteNotificationTypeAlert)
                                              categories:nil];
    }
    //Required
    // 如需继续使用pushConfig.plist文件声明appKey等配置内容，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化。
    
    
    [JPUSHService setupWithOption:launchOptions appKey:@"05d7acc4f3294e2a07651e82" channel:@"0" apsForProduction:YES advertisingIdentifier:nil];
}
//进入应用
- (void)joinApp
{
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    //判断是不是第一次启动应用
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"])
    {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
//        NSLog(@"第一次启动");
            [kUserDefault setBool:NO forKey:cacheProvinceDataKey];
            [kUserDefault setBool:NO forKey:cacheCityDataKey];
            [kUserDefault setBool:NO forKey:cacheCountyDataKey];
//            [kUserDefault setBool:NO forKey:@"isUpdateDataBase"];
            [LLAddress loadAddress];
        GudiePageController *guide = [[GudiePageController alloc]init];
        self.window.rootViewController = guide;
    }
    else
    {
        BasicTabBarController *basic = [[BasicTabBarController alloc]init];
        self.window.rootViewController = basic;
    }
    
    [self.window makeKeyAndVisible];
}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
//    NSLog(@"%@",userInfo);
    
    // IOS 7 Support Required
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
    
    
//    NSLog(@"%ld",(long)[UIApplication sharedApplication].applicationState );
    if([UIApplication sharedApplication].applicationState == UIApplicationStateInactive)
    {
        BasicTabBarController *basic = [[BasicTabBarController alloc]init];
        self.window.rootViewController = basic;
        [NOTIFICATION_CENTER postNotificationName:@"ReceivePushMsg" object:self userInfo:userInfo];
    }
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
//    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == FALSE) {
        //调用其他SDK，例如支付宝SDK等
        if ([url.host isEqualToString:@"safepay"]) {
            // 支付跳转支付宝钱包进行支付，处理支付结果
             [self alipayWithUrl:url];
            return YES;
        }else
        {
             return [WXApi handleOpenURL:url delegate:self];
        }
        
    }
    return result;
}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [self alipayWithUrl:url];
    }else
    {
        return [WXApi handleOpenURL:url delegate:self];
    }
    return YES;
}

- (void)alipayWithUrl:(NSURL *)url
{
    [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
        NSLog(@"result = %@",resultDic);
        int code = [resultDic[@"resultStatus"] intValue];
        if (9000 == code) {
            [self.hudManager showSuccessSVHudWithTitle:@"赚豆充值成功" hideAfterDelay:2.0 animaton:YES];
            [NOTIFICATION_CENTER postNotificationName:@"UPDATEDOU" object:nil];
        }else
        {
            [self.hudManager showErrorSVHudWithTitle:@"赚豆充值失败" hideAfterDelay:2.0];
        }
    }];
}

//微信SDK自带的方法，处理从微信客户端完成操作后返回程序之后的回调方法,显示支付结果的
-(void) onResp:(BaseResp*)resp
{
    //启动微信支付的response
    NSString *payResoult = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
    if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        switch (resp.errCode) {
            case 0:
                [self.hudManager showSuccessSVHudWithTitle:@"赚豆充值成功" hideAfterDelay:2.0 animaton:YES];
                [NOTIFICATION_CENTER postNotificationName:@"UPDATEDOU" object:nil];
                break;
            case -1:
                [self.hudManager showErrorSVHudWithTitle:@"赚豆充值失败" hideAfterDelay:2.0];
                break;
            case -2:
                [self.hudManager showErrorSVHudWithTitle:@"赚豆充值失败" hideAfterDelay:2.0];
                break;
            default:
                payResoult = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
                break;
        }
    }
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [JPUSHService setBadge:0];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     [JPUSHService setBadge:0];
    //检查版本
    [[CheckVersionManager sharedCheckVersionManager] checkVersion];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
