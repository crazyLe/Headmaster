//
//  CheckVersionManager.m
//  学员端
//
//  Created by zuweizhong  on 16/8/26.
//  Copyright © 2016年 Anhui Shengshi Kangzhuang Network Technology Development Co., Ltd. All rights reserved.
//

#import "AddressManager.h"
#import "CheckVersionManager.h"
#import "HJHttpManager.h"
#import "HttpParamManager.h"
#import "XIAlertView.h"


@implementation CheckVersionManager

singletonImplementation(CheckVersionManager)

-(void)checkVersion
{
    [self loadVersion];
}
-(void)loadVersion
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
//    NSString *version = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
//    param[@"version"] = [NSString stringWithFormat:@"ios%@",version];
    param[@"version"] = @versioncode;
    param[@"channel"] = @"1";
    
    [HttpsTools kPOST:checkVersionUrl parameter:param progress:^(NSProgress *downloadProgress) {
        
    } succeed:^(id backdata, int code, NSString *msg) {
        NSLog(@"%@",backdata);
        
        // 当前时间
        NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];
        NSTimeInterval a=[date timeIntervalSince1970];
        NSString *timeString = [NSString stringWithFormat:@"%.0f", a];
        int timejiange = [backdata[@"serverTime"] intValue] - [timeString intValue];
        
        [curDefaults setValue:backdata[@"beans_show"] forKey:@"kShowState"];
        [curDefaults setValue:[NSString stringWithFormat:@"%d",timejiange] forKey:@"timejiange"];
        
        NSString *area_ver = backdata[@"area_ver"];
        
        area_ver = [NSString stringWithFormat:@"%@",area_ver];
        
        NSString *old_area_ver = [kUserDefault objectForKey:@"CoachAreaVersion"];
        
        BOOL isCacheProvinceData = [[kUserDefault objectForKey:cacheProvinceDataKey] boolValue];
        BOOL isCacheCityData = [[kUserDefault objectForKey:cacheCityDataKey] boolValue];
        BOOL isCacheCountyData = [[kUserDefault objectForKey:cacheCountyDataKey] boolValue];
        
        if ((!isStartUpdaeDB)&&(!old_area_ver || !isCacheProvinceData || !isCacheCityData || !isCacheCountyData || ![area_ver isEqualToString:old_area_ver])) {
            //更新地址数据
            [kUserDefault setBool:YES forKey:@"AreaStartUpdateFlag"];//标记地址开始更新
            [[AddressManager sharedAddressManager] updateAddressInfo];
        }
        [kUserDefault synchronize];
        
        
        
        
        //存储地区版本号
        [kUserDefault setObject:area_ver forKey:@"CoachAreaVersion"];
        int statue = [backdata[@"updateCode"] intValue];
        NSString *msgs = backdata[@"updateInfo"];
        NSString *updateUrl = backdata[@"updateUrl"];
        
        if (1 == statue) {//升级
            XIAlertView *alertView = [[XIAlertView alloc] initWithTitle:@"有新版本"
                                                                message:msgs
                                                      cancelButtonTitle:@"取消"];
            
            
            [alertView addDefaultStyleButtonWithTitle:@"立即更新" handler:^(XIAlertView *alertView, XIAlertButtonItem *buttonItem) {
                [alertView dismiss];
                // 通过获取到的url打开应用在appstore，并跳转到应用下载页面
                [[UIApplication sharedApplication]openURL:[NSURL URLWithString:updateUrl]];
            }];
            
            [alertView show];
        }else if ( 2 == statue)//强制升级
        {
            XIAlertView *alertView = [[XIAlertView alloc] initWithTitle:@"有新版本"
                                                                message:msgs
                                                      cancelButtonTitle:@"立即更新"];
            alertView.customCancelBtnHandler = ^(XIAlertView *alertView,XIAlertButtonItem *buttonItem){
                [alertView dismiss];
                // 通过获取到的url打开应用在appstore，并跳转到应用下载页面
                [[UIApplication sharedApplication]openURL:[NSURL URLWithString:updateUrl]];
            };
            
            [alertView show];
        }
    
    } failure:^(NSError *error) {
        
    }];
}



@end
