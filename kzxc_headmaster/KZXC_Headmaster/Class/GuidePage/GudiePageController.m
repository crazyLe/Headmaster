//
//  GudiePageController.m
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/8/25.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import "GudiePageController.h"
#import "ZLCGuidePageView.h"
#import "BasicTabBarController.h"

@interface GudiePageController ()<ZLCGuidePageViewDelete>
@property(strong,nonatomic)ZLCGuidePageView *guideview;
@end

@implementation GudiePageController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //引导页图片数组
    NSArray *images =  @[[UIImage imageNamed:@"star1"],[UIImage imageNamed:@"star2"],[UIImage imageNamed:@"star3"]];
    //创建引导页视图
    _guideview = [[ZLCGuidePageView alloc]initWithFrame:[UIScreen mainScreen].bounds WithImages:images];
    _guideview.delegate = self;
    [self.view addSubview:_guideview];
}

- (void)joinHome
{
    [curDefaults setValue:@"0" forKey:@"kUid"];
    BasicTabBarController *basic = [[BasicTabBarController alloc]init];
    [self presentViewController:basic animated:YES completion:nil];
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
