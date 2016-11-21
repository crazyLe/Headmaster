//
//  PayTools.h
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/9/20.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AlipaySDK/AlipaySDK.h>

typedef void(^paysucceedBlock)(NSDictionary *sucDict);
typedef void(^payfailurBlock)(NSDictionary *failDict);

@interface PayTools : NSObject

singletonInterface(PayTools)

+ (void)alipayWitnContent:(NSString *)content succeed:(void (^)(NSDictionary *sucDict))succeed failur:(void (^)(NSDictionary *failDict))failur;
@end
