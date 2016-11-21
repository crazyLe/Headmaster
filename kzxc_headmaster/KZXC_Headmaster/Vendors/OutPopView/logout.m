//
//  logout.m
//  KKXC_Franchisee
//
//  Created by 翁昌青 on 16/8/18.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import "logout.h"
#import "BasicNavController.h"
#import "LoginGuideController.h"

@implementation logout


- (IBAction)sureClick:(UIButton *)sender {
    
    LoginGuideController *login = [[LoginGuideController alloc]init];
    UINavigationController *root = [[UINavigationController alloc]initWithRootViewController:login];
    [root.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg"] forBarMetrics:UIBarMetricsDefault];
    root.navigationBar.shadowImage =[UIImage imageNamed:@"nav_bg"];
    root.navigationBar.titleTextAttributes = NavTitleTextAttributes;
    self.window.rootViewController = root;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
