//
//  JpushManager.m
//  学员端
//
//  Created by zuweizhong  on 16/8/19.
//  Copyright © 2016年 Anhui Shengshi Kangzhuang Network Technology Development Co., Ltd. All rights reserved.
//

#import "JpushManager.h"
#import "JPUSHService.h"
#import "MsgModel.h"
#import "MessageDataBase.h"
@implementation JpushManager

singletonImplementation(JpushManager)

-(void)startMonitor
{
    
    if (![kUid isEqualToString:@"0"]) {
        
        [JPUSHService setTags:nil alias:kUid callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:nil];
    }
    
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    
    [defaultCenter addObserver:self selector:@selector(networkDidReceiveMessage:) name:kJPFNetworkDidReceiveMessageNotification object:nil];

}

- (void)networkDidReceiveMessage:(NSNotification *)notification
{
    NSDictionary * userInfo = [notification userInfo];

    NSLog(@"%@",userInfo);
    
    int maxid = [[MessageDataBase shareInstance]getMaxIdModel].idNum;

    NSString *time = [HttpParamManager getTime];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"uid"] = kUid;
    param[@"maxId"] = @(maxid);
    param[@"time"] = time;
    param[@"sign"] = [HttpParamManager getSignWithIdentify:@"/message" time:time];
    param[@"deviceInfo"] = [HttpParamManager getDeviceInfo];
    
    [HttpsTools kPOST:getAllMsgUrl parameter:param progress:^(NSProgress *downloadProgress) {
        
    } succeed:^(id backdata, int code, NSString *msg) {
        
        if (code == 1)
        {
            NSArray *arr = [MsgModel mj_objectArrayWithKeyValuesArray:backdata[@"message"]];

            for (int i = 0; i<arr.count; i++) {
                MsgModel *model = arr[i];
                [[MessageDataBase shareInstance] insertDataWithModel:model];
            }
            [NOTIFICATION_CENTER postNotificationName:kUpdateMainMsgRedPointNotification object:nil];

        }
        
    } failure:^(NSError *error) {
        
    }];
    
//    [HJHttpManager PostRequestWithUrl:url param:param finish:^(NSData *data) {
//        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//        HJLog(@"%@",dict);
//        NSInteger code = [dict[@"code"] integerValue];
//        if (code == 1)
//        {
//            NSArray *arr = [MsgModel mj_objectArrayWithKeyValuesArray:dict[@"info"][@"message"]];
//            
//            for (int i = 0; i<arr.count; i++) {
//                MsgModel *model = arr[i];
//                [[MessageDataBase shareInstance] insertDataWithModel:model];
//            }
//            [NOTIFICATION_CENTER postNotificationName:kUpdateMainMsgRedPointNotification object:nil];
//
//        }
//    } failed:^(NSError *error) {
//    }];

}

-(void)tagsAliasCallback:(int)iResCode
                    tags:(NSSet*)tags
                   alias:(NSString*)alias
{
    NSLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, tags , alias);
}



@end
