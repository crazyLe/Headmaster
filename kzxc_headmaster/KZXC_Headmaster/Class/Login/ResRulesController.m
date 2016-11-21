//
//  ResRulesController.m
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/9/1.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import "ResRulesController.h"

@interface ResRulesController ()
@property(strong,nonatomic) UIWebView *web;
@end

@implementation ResRulesController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"注册协议";
    [self.navigationController.navigationBar setTranslucent:NO];
    
    self.navigationController.navigationBar.barTintColor = NavBackColor;
    
     self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageWithRenderingMode:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(leftAction)];

    
    _web = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight- 64)];
    [self.view addSubview:_web];
    [_web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_urlstr]]];
}

- (void)leftAction
{
  [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController.navigationBar setTranslucent:YES];
    self.navigationController.navigationBar.barTintColor = [UIColor clearColor];
    
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
