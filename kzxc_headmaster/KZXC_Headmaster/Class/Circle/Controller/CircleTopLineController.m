//
//  CircleTopLineController.m
//  学员端
//
//  Created by zuweizhong  on 16/8/23.
//  Copyright © 2016年 Anhui Shengshi Kangzhuang Network Technology Development Co., Ltd. All rights reserved.
//

#import "CircleTopLineController.h"

@interface CircleTopLineController ()<UIWebViewDelegate>
@property(nonatomic,strong)UISegmentedControl * segmentControl;
@property(nonatomic,strong)UIWebView * webView;

@end

@implementation CircleTopLineController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configNav];
    [self createSegment];
    
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64)];
    
//    _webView.delegate = self;
    _webView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:_webView];
    
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@&app=1&uid=%@",self.url,kUid]]];
    
    NSLog(@"%@",request.URL.absoluteString);
    
    [_webView loadRequest:request];
    
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"加载失败.html" ofType:nil];
    NSString *str = [[NSString alloc]initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    [self.webView loadHTMLString:str baseURL:nil];
    
}
- (void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)configNav
{
//    [self createNavWithLeftBtnImageName:@"返回" leftHighlightImageName:nil leftBtnSelector:@selector(back) andCenterTitle:nil andRightBtnImageName:@"" rightHighlightImageName:nil rightBtnSelector:nil];
     self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageWithRenderingMode:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    
}
- (void)createSegment
{
    NSArray * segmentArray = @[@"头条",@"话题"];
    _segmentControl = [[UISegmentedControl alloc] initWithItems:segmentArray];
    _segmentControl.selectedSegmentIndex = 0;
    //设置segment的选中背景颜色
    _segmentControl.tintColor = [UIColor whiteColor];
    [_segmentControl setTitleTextAttributes:@{NSFontAttributeName:kFont13} forState:UIControlStateNormal];
    _segmentControl.frame = CGRectMake(100, 0, kScreenWidth -200, 30);
    [_segmentControl addTarget:self action:@selector(segmentValueChanged:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = _segmentControl;
}
-(void)segmentValueChanged:(UISegmentedControl *)segmentControl
{
    if (segmentControl.selectedSegmentIndex == 0)
    {

        NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@&app=1&uid=%@",self.url,kUid]]];
        
        [_webView loadRequest:request];
      
        
    }
    else
    {

        NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@&app=1&uid=%@",self.url2,kUid]]];
        
        [_webView loadRequest:request];
        
    }
    
}
@end
