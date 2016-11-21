//
//  LessonDetailsController.m
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/7/12.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import "LessonDetailsController.h"

@interface LessonDetailsController ()

@end

@implementation LessonDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"课程详情";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageWithRenderingMode:@"nav_more"] style:UIBarButtonItemStylePlain target:self action:@selector(nav_moreClick)];
}

-(void)nav_moreClick
{
    NSLog(@"nav_more Click ...");
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
