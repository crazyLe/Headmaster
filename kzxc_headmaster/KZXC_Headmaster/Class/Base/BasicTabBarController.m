//
//  BasicTabBarController.m
//  KZXC_Instructor
//
//  Created by 翁昌青 on 16/6/27.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import "BasicTabBarController.h"
#import "BasicNavController.h"
#import "PurseViewController.h"
#import "CircleViewController.h"
#import "MineViewController.h"
#import "NewHomeController.h"


@interface BasicTabBarController ()

@end

@implementation BasicTabBarController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
//    [self.tabBar setTintColor:[UIColor colorWithRed:0.937 green:0.302 blue:0.212 alpha:1.000]];
//    
//    self.tabBar.barTintColor = [UIColor colorWithWhite:0.965 alpha:1.000];

    //首页
//    HomeViewController *home = [[HomeViewController alloc]init];
    NewHomeController *home = [[NewHomeController alloc]init];
    home.view.backgroundColor = [UIColor whiteColor];
    home.basicVC = self;
    [self steupChildViewController:home VCTitle:TabBarTitleArray[0] normalImg:TabBarNomalPicArray[0] SelectedImg:TabBarSelectedPicArray[0]];
    
    //钱袋
    PurseViewController *purse = [[PurseViewController alloc]init];
    [self steupChildViewController:purse VCTitle:TabBarTitleArray[1] normalImg:TabBarNomalPicArray[1] SelectedImg:TabBarSelectedPicArray[1]];
  
    //圈子
    CircleViewController *circle = [[CircleViewController alloc]init];
    [self steupChildViewController:circle VCTitle:TabBarTitleArray[2] normalImg:TabBarNomalPicArray[2] SelectedImg:TabBarSelectedPicArray[2]];
    
    //我的
    MineViewController *mine = [[MineViewController alloc]init];
    [self steupChildViewController:mine VCTitle:TabBarTitleArray[3] normalImg:TabBarNomalPicArray[3] SelectedImg:TabBarSelectedPicArray[3]];
    
    
    //默认展示第一个
    self.selectedIndex = tabbarIndex;
    
}

/**
 *  添加viewcontroller
 *
 *  @param child    子控制器名称
 *  @param titte    tabbarItem标题
 *  @param image    正常状态图片
 *  @param selImage 选中状态图片
 */
- (void)steupChildViewController:(UIViewController *)child VCTitle:(NSString *)title normalImg:(NSString *)image SelectedImg:(NSString *)selImage
{
    
    child.title = title;
    
    BasicNavController *childNav = [[BasicNavController alloc]initWithRootViewController:child];
    
    child.tabBarItem.title = title;
    
    child.tabBarItem.image = [UIImage imageWithRenderingMode:image];
    
    child.tabBarItem.selectedImage = [UIImage imageWithRenderingMode:selImage];
    
    //设置字体颜色
//    [child.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:RandomColor,NSForegroundColorAttributeName, [UIFont systemFontOfSize:16.0],NSFontAttributeName,nil] forState: UIControlStateNormal];
//
    
    [child.tabBarItem setTitleTextAttributes:TabBarTitleTextAttributes forState: UIControlStateSelected];
    
    [self addChildViewController:childNav];
    
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
