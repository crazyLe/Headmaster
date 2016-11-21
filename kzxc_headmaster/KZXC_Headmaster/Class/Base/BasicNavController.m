//
//  BasicNavController.m
//  KZXC_Instructor
//
//  Created by 翁昌青 on 16/6/27.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import "BasicNavController.h"

@interface BasicNavController ()

@end

@implementation BasicNavController

- (void)viewDidLoad {
   
    [super viewDidLoad];
    //navigationBar颜色
    self.navigationBar.barTintColor = NavBackColor;
    
    self.navigationBar.tintColor = [UIColor whiteColor];
    
    self.navigationBar.titleTextAttributes = NavTitleTextAttributes;
    
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:NavRightTitleTextAttributes forState:UIControlStateNormal];
    //y=0的位置是navigationbar底部
    self.navigationBar.translucent = NO;
    
//    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count != 0) {
        
        viewController.hidesBottomBarWhenPushed = YES;
        
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageWithRenderingMode:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(leftAction:)];
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)leftAction:(id)sender{
    
    [self popViewControllerAnimated:YES];
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
