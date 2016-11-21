//
//  ContentLeaseCell.m
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/7/21.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import "ContentLeaseCell.h"
#import "LoginViewController.h"

@implementation ContentLeaseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self setline:_firview];
    [self setline:_secview];
    [self setline:_thiview];
    [self setline:_fourview];
    
}
- (void)setline:(UIView *)view
{
    view.layer.borderColor = RGBColor(230, 230, 230).CGColor;
    view.layer.borderWidth = 1.0;
}

- (IBAction)call:(id)sender {
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
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:_phone message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"呼叫", nil];
    alert.tag = 20000;
    [alert show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 10000) {
        
        if (buttonIndex == 1) {
            //去登陆
            LoginViewController * vc = [[LoginViewController alloc] init];
            
            [_delegate.navigationController pushViewController:vc animated:YES];
        }
    }
    if (alertView.tag == 20000) {
        
        if (1 == buttonIndex) {
            NSString *tel = [NSString stringWithFormat:@"tel://%@",alertView.title];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:tel]];
        }
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
