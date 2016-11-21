//
//  WMPWebViewController.m
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/8/12.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import "WMPWebViewController.h"
#import "PersonalTailorController.h"
#import "UMSocial.h"
#import "WebViewJavascriptBridge.h"

@interface WMPWebViewController ()<UIWebViewDelegate,UMSocialUIDelegate>
@property(strong,nonatomic)UIWebView *web;

@property(strong,nonatomic) WebViewJavascriptBridge* bridge;
@end

@implementation WMPWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

//    [self.hudManager showNormalStateSVHudWithTitle:@"加载中..." hideAfterDelay:5];
    
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStyleDone target:self action:@selector(editWMP)];
    
    _web = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight -64)];
    
    _web.delegate = self;
    
    [self.view addSubview:_web];
    
    //开启调试信息
    [WebViewJavascriptBridge enableLogging];
    
    // 给哪个webview建立JS与OjbC的沟通桥梁
    _bridge = [WebViewJavascriptBridge bridgeForWebView:_web];
    
    // 设置代理，如果不需要实现，可以不设置
    [self.bridge setWebViewDelegate:self];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self loadWeb];
}


- (void)loadWeb

{
    [GiFHUD setGifWithImageName:@"kangzhuang.gif"];
    [GiFHUD showWithOverlaytime:5.0 ];
    _urlStr = [NSString stringWithFormat:wmpUrl,kUid,kUid,[HttpParamManager getLongitude],[HttpParamManager getLatitude],[NSString stringWithFormat:@"%lu",(long)[HttpParamManager getCurrentCityID]]];
    
    if (_urlStr.length == 0) {
        _urlStr = @"http://www.kangzhuangxueche.com";
    }
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_urlStr]];
    //    [self.hudManager showNormalStateSVHudWithTitle:@"加载中..." hideAfterDelay:5];
    [_web loadRequest:request];
    
   
}

- (void)editWMP
{
    PersonalTailorController *person = [[PersonalTailorController alloc]init];
    [self.navigationController pushViewController:person animated:YES];
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{

    [_bridge registerHandler:@"objcHander" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSDictionary *dict = data;
        NSString *share = dict[@"parame"];
        
        if ([share hasPrefix:@"Share:"]) {
            share = [share stringByReplacingOccurrencesOfString:@"Share:" withString:@""];
            [self share:share];
        }
        
    }];
    
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
//    [self.hudManager dismissSVHud];
    [GiFHUD dismiss];
    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
//    [self.hudManager showErrorSVHudWithTitle:@"加载失败..." hideAfterDelay:2.0];
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    NSString * htmlPath = [[NSBundle mainBundle] pathForResource:@"weberror"
                                                          ofType:@"html"];
    NSString * htmlCont = [NSString stringWithContentsOfFile:htmlPath
                                                    encoding:NSUTF8StringEncoding
                                                       error:nil];
    [_web loadHTMLString:htmlCont baseURL:baseURL];
}

- (void)share:(NSString *)str
{
    //如果需要分享回调，请将delegate对象设置self，并实现下面的回调方法
//    @[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToSina,UMShareToQQ,UMShareToQzone]
    
    [UMSocialData defaultData].extConfig.title = @"康庄校长微名片";
    [UMSocialData defaultData].extConfig.qqData.url = str;
    [UMSocialData defaultData].extConfig.qzoneData.url = str;
    [UMSocialData defaultData].extConfig.wechatSessionData.url = str;
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = str;
    
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"57b169ffe0f55a46dd000e71"
                                      shareText:str
                                     shareImage:[UIImage imageNamed:@"shareicon"]
                                shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQQ,UMShareToQzone]
                                       delegate:self];
    
}



-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }

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
