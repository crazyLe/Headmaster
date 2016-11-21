//
//  HomeWebController.m
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/8/29.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import "HomeWebController.h"

@interface HomeWebController ()<UIWebViewDelegate>

@property(strong,nonatomic)UIWebView *web;
@end

@implementation HomeWebController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    _web = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight -64)];
    _web.backgroundColor = [UIColor whiteColor];
    _web.delegate = self;
    
    [self.view addSubview:_web];
    NSString * htmlPath = [[NSBundle mainBundle] pathForResource:_str ofType:@"html"];
    NSString * htmlCont = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
    
    // 获取当前应用的根目录
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    
    // 通过baseURL的方式加载的HTML
    // 可以在HTML内通过相对目录的方式加载js,css,img等文件
    [_web loadHTMLString:htmlCont baseURL:baseURL];
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    
    self.title = (self.title.length == 0)?@"详情":self.title;
    [GiFHUD dismiss];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self.hudManager showErrorSVHudWithTitle:@"加载失败..." hideAfterDelay:1.0];
    
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    NSString * htmlPath = [[NSBundle mainBundle] pathForResource:@"weberror"
                                                          ofType:@"html"];
    NSString * htmlCont = [NSString stringWithContentsOfFile:htmlPath
                                                    encoding:NSUTF8StringEncoding
                                                       error:nil];
    [_web loadHTMLString:htmlCont baseURL:baseURL];
    
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
