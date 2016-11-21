//
//  CommonWebController.m
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/8/12.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import "CommonWebController.h"
#import "GiFHUD.h"

@interface CommonWebController ()<UIWebViewDelegate>
@property(strong,nonatomic)UIWebView *web;
@end

@implementation CommonWebController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setupNav];
    [GiFHUD setGifWithImageName:@"kangzhuang.gif"];
    [GiFHUD showWithOverlaytime:100.0 ];
    
    _web = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight -64)];
    
    if (_urlStr.length == 0) {
        _urlStr = @"http://www.kangzhuangxueche.com";
    }
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:_urlStr]];
    
    [_web loadRequest:request];
    
    _web.delegate = self;
    
    request.timeoutInterval = 10.0f;
    
    [self.view addSubview:_web];
    
}

- (void)setupNav
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageWithRenderingMode:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(leftAction)];
}

- (void)leftAction
{
    if (_isArticel) {
        
        [NOTIFICATION_CENTER postNotificationName:@"refreshZanNum" object:nil];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    
    self.title = (self.title.length == 0)?@"详情":self.title;
    [GiFHUD dismiss];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [GiFHUD dismiss];
    
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
