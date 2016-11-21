//
//  CircleJSManager.m
//  Coach
//
//  Created by LL on 16/8/22.
//  Copyright © 2016年 sskz. All rights reserved.
//

#import "CircleDetailWebController.h"
#import <IQKeyboardManager.h>
#import "ChatBarContainer.h"
#import "CircleJSManager.h"

@implementation CircleJSManager
{
    ChatBarContainer *_chat_Bar;
}

- (id)init
{
    if (self = [super init]) {
        WeakObj(self)
        self.block = ^(UIViewController *webViewController){
            [selfWeak.bridge registerHandler:@"objcHander" handler:^(id data, WVJBResponseCallback responseCallback) {
//                NSLog(@"ObjC Echo called with: %@", data);
                responseCallback(data);
                NSDictionary *paraDic = data;
                NSArray *keyArr = paraDic.allKeys;
                if (keyArr.count>0) {
                    NSString *para = paraDic[keyArr[0]];
                    NSArray *paraArr = [para componentsSeparatedByString:@":"];
                    if (paraArr.count>0) {
                        NSString *typeStr = paraArr[0];
                        if ([typeStr isEqualToString:@"comment"]) {
                            //点击Web评论按钮
                            if (paraArr.count>1) {
                                NSString *circleId = [paraArr lastObject];
                                [selfWeak clickCommentWithCircleId:circleId webViewVC:(CircleDetailWebController *)webViewController];
                            }
                        }
                        else if([typeStr isEqualToString:@"like"])
                        {
                            //点击了点赞
                            NSString *circleId = [paraArr lastObject];
                            [selfWeak clickLikeWithCircleId:circleId webViewVC:(CircleDetailWebController *)webViewController];
                        }
                        else
                        {
                            
                        }
                    }
                }
            }];
        };
    }
    return self;
}

//点击评论
- (void)clickCommentWithCircleId:(NSString *)circleId webViewVC:(CircleDetailWebController *)webVC
{
    [self setComment_TextFieldWithVC:webVC];
    _chat_Bar.userInfo = @{@"circleId":circleId};
}

//点击赞
- (void)clickLikeWithCircleId:(NSString *)circleId webViewVC:(CircleDetailWebController *)webVC
{
    WeakObj(self)
    NSString *relativeAdd = @"/community/praise";
    
    [self.hudManager showNormalStateSVHUDWithTitle:nil];
    NSString * url = [NSString stringWithFormat:@"%@%@",basicUrl,relativeAdd];
    NSMutableDictionary * paramDict = [NSMutableDictionary dictionary];
    paramDict[@"uid"] = kUid;
    NSString * time = [HttpParamManager getTime];
    paramDict[@"time"] = time;
    paramDict[@"sign"] = [HttpParamManager getSignWithIdentify:relativeAdd time:time];
    paramDict[@"cityId"] = @([HttpParamManager getCurrentCityID]);
    paramDict[@"address"] = [NSString stringWithFormat:@"%@,%@",[HttpParamManager getLongitude],[HttpParamManager getLatitude]];
    paramDict[@"id"] =circleId;
    paramDict[@"deviceInfo"] = [HttpParamManager getDeviceInfo];
    
    [HJHttpManager PostRequestWithUrl:url param:paramDict finish:^(NSData *data) {
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//        NSLog(@">>>%@",dict);
        NSInteger code = [dict[@"code"] integerValue];
        NSString * msg = dict[@"msg"];
        if (code == 1) {
            
            [self.hudManager dismissSVHud];
            //成功
            //刷新页面
            NSURL *url = [NSURL URLWithString:webVC.urlString];
            [webVC.webView loadRequest:[NSURLRequest requestWithURL:url]];
            _needRefreshBlock(selfWeak);
        }
        else
        {
            [self.hudManager showErrorSVHudWithTitle:msg hideAfterDelay:1];
        }
    } failed:^(NSError *error) {
        
        [self.hudManager showErrorSVHudWithTitle:@"加载失败" hideAfterDelay:1.0];
    }];


}

- (void)setComment_TextFieldWithVC:(CircleDetailWebController *)webVC
{
    if (!_chat_Bar) {
        _chat_Bar = [[ChatBarContainer alloc]init];
        _chat_Bar.max_Count = 140;
        _chat_Bar.myDelegate = self;
        [webVC.view addSubview:_chat_Bar];
        [_chat_Bar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(webVC.view.mas_left);
            make.right.equalTo(webVC.view.mas_right);
            make.bottom.equalTo(webVC.view.mas_bottom);
            make.height.offset(44);
        }];
        [_chat_Bar setNeedsLayout];
        [_chat_Bar.layer layoutIfNeeded];
        _chat_Bar.object = webVC;
        
        IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
        manager.enable = NO;
        
        webVC.webView.scrollView.delegate = self;
    }
    
    [_chat_Bar.txtView becomeFirstResponder];
}

#pragma mark - ChatBarContainerDelegate

//点击评论发送按钮
- (void)ChatBarContainer:(ChatBarContainer *)chatBar clickSendWithContent:(NSString*)content;
{
    
    WeakObj(self)
    
    CircleDetailWebController *webVC = chatBar.object;
    
    NSString *circelId = chatBar.userInfo[@"circleId"];
    
    NSString *relativeAdd = @"/community/commentcreate";
    
    [self.hudManager showNormalStateSVHUDWithTitle:nil];
    NSString * url = [NSString stringWithFormat:@"%@%@",basicUrl,relativeAdd];
    NSMutableDictionary * paramDict = [NSMutableDictionary dictionary];
    paramDict[@"uid"] = kUid;
    NSString * time = [HttpParamManager getTime];
    paramDict[@"time"] = time;
    paramDict[@"sign"] = [HttpParamManager getSignWithIdentify:relativeAdd time:time];
    paramDict[@"cityId"] = @([HttpParamManager getCurrentCityID]);
    paramDict[@"address"] = [NSString stringWithFormat:@"%@,%@",[HttpParamManager getLongitude],[HttpParamManager getLatitude]];
    paramDict[@"id"] =circelId;
    paramDict[@"communityType"] =webVC.object;
    paramDict[@"content"] =chatBar.txtView.text;
    paramDict[@"deviceInfo"] = [HttpParamManager getDeviceInfo];
    
    [HJHttpManager PostRequestWithUrl:url param:paramDict finish:^(NSData *data) {
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//        NSLog(@">>>%@",dict);
        NSInteger code = [dict[@"code"] integerValue];
        NSString * msg = dict[@"msg"];
        if (code == 1) {
            
            [self.hudManager dismissSVHud];
            //成功
            //刷新页面
            NSURL *url = [NSURL URLWithString:webVC.urlString];

            [webVC.webView loadRequest:[NSURLRequest requestWithURL:url]];
            
            if (_needRefreshBlock) {
                _needRefreshBlock(selfWeak);
            }
        }
        else
        {
            [self.hudManager showErrorSVHudWithTitle:msg hideAfterDelay:1];
        }
    } failed:^(NSError *error) {
        
        [self.hudManager showErrorSVHudWithTitle:@"加载失败" hideAfterDelay:1.0];
    }];


    chatBar.alpha = 0;
    [chatBar.txtView resignFirstResponder];
}

- (void)chatBarDidBecomeActive;
{
    
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;
{
    [_chat_Bar.txtView resignFirstResponder];
}

@end
