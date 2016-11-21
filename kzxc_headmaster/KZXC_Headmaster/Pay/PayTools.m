//
//  PayTools.m
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/9/20.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import "PayTools.h"


@implementation PayTools
singletonImplementation(PayTools)

+ (void)alipayWitnContent:(NSString *)content succeed:(void (^)(NSDictionary *sucDict))succeed failur:(void (^)(NSDictionary *failDict))failur
{
    [[AlipaySDK defaultService] payOrder:content fromScheme:@"xiaozhangAlipay" callback:^(NSDictionary *resultDic) {
        // 处理支付结果
        //        9000 订单支付成功
        //        8000 正在处理中
        //        4000 订单支付失败
        //        6001 用户中途取消
        //        6002 网络连接出错
        int code = [resultDic[@"resultStatus"] intValue];
        if (9000 == code) {
            succeed(resultDic);
        }else
        {
            NSDictionary *failDict = @{@"code":resultDic[@"resultStatus"],@"msg":@"支付失败"};
            failur(failDict);
        }
        
    }];
}

@end
