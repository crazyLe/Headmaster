//
//  RegisterController.h
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/7/26.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterController : UIViewController
@property (weak, nonatomic)  UITextField *phone;
@property (weak, nonatomic)  UITextField *code;
@property (weak, nonatomic)  UITextField *psw;
@property (weak, nonatomic)  UITextField *surepsw;
@property (weak, nonatomic)  UIButton *commit;
@property (weak, nonatomic)  UIButton *getcode;

@end
