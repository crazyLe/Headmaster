//
//  CircleDetailWebController.m
//  学员端
//
//  Created by zuweizhong  on 16/8/15.
//  Copyright © 2016年 Anhui Shengshi Kangzhuang Network Technology Development Co., Ltd. All rights reserved.
//

#import "CircleDetailWebController.h"

@interface CircleDetailWebController ()<UIWebViewDelegate>


@end

@implementation CircleDetailWebController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self createNavWithLeftBtnImageName:@"返回" leftHighlightImageName:nil leftBtnSelector:@selector(back) andCenterTitle:@"圈子详情"];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageWithRenderingMode:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    self.title = @"圈子详情";
    
    UIWebView *webView = [[UIWebView alloc]init];
    webView.backgroundColor = [UIColor whiteColor];
    self.webView = webView;
    self.webView.delegate = self;
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:self.urlString]];
    
    [webView loadRequest:request];
    
    webView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight-64);
    [self.view addSubview:webView];
    
    if (self.js_Manager) {
        self.js_Manager.bridge = [WebViewJavascriptBridge bridgeForWebView:_webView];
        self.js_Manager.block(self);
    }

    
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"weberror.html" ofType:nil];
    NSString *str = [[NSString alloc]initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    [self.webView loadHTMLString:str baseURL:nil];
    
}
- (void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
}


@end
