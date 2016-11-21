//
//  ScanningController.m
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/7/25.
//  Copyright © 2016年 cqingw. All rights reserved.
//

//距离上间距
#define scanningTop 75
//扫描框宽
#define scanningW 240
//扫描框高
#define scanningH 250
//返回按钮名称
#define backStr @"back"


#import "ScanningController.h"
#import "ValidationFailureController.h"
#import "ValidationSuccessController.h"
#import <ZBarSDK/ZBarSDK.h>
#import "UIColor+Hex.h"
#import "saomaModel.h"

@interface ScanningController ()<ZBarReaderViewDelegate,UITextFieldDelegate,UIActionSheetDelegate>
{
    CGFloat jianju;
    CGFloat scale;
}
@property(weak,nonatomic)ZBarReaderView *readerview;
@property(weak,nonatomic)UIImageView *bgimg;
@property(weak,nonatomic)UIView *bootomview;
@property(weak,nonatomic)UITextField *filed;

@end

@implementation ScanningController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    if (isIPhpne4) {
        jianju = 20;
        scale = 170;
    }else if (isIPhone5)
    {
        jianju = 15;
        scale = 100;
    }else if (isIPhone6)
    {
        scale = 50;
    }
    
    NSLog(@"%f",kHeight);
    
    ZBarReaderView *readerView = [[ZBarReaderView alloc]init];
    readerView.frame = CGRectMake(0, 0, kWidth , kHeight);
    readerView.readerDelegate = self;
    //关闭闪光灯
    readerView.torchMode = 0;
    //扫描区域
    CGRect scanMaskRect = CGRectMake(0, 80-jianju, kWidth, 250);
    
    //处理模拟器
    if (TARGET_IPHONE_SIMULATOR) {
        ZBarCameraSimulator *cameraSimulator
        = [[ZBarCameraSimulator alloc]initWithViewController:self];
        cameraSimulator.readerView = readerView;
    }
    
    NSLog(@"%@",NSStringFromCGRect(readerView.bounds));
    //扫描区域计算
//    readerView.scanCrop = CGRectMake(0, 0, 1, 1);
    readerView.scanCrop = [self getScanCrop:scanMaskRect readerViewBounds:readerView.bounds];
    //扫描开始
    [readerView start];
    [self.view addSubview:readerView];
    self.readerview = readerView;
    
    UIImageView *bg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"scanning_bg"]];
    bg.userInteractionEnabled = YES;
    bg.frame = CGRectMake(0, 0, kWidth, kHeight);
    
    [self.view addSubview:bg];
    self.bgimg = bg;
    
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 35, 20, 20)];
    [backBtn setImage:[UIImage imageNamed:backStr] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtn) forControlEvents:UIControlEventTouchUpInside];
    [bg addSubview:backBtn];
    
    NSString *str = @"请扫描学员二维码扫描凭证";
    UILabel *title = [[UILabel alloc]init];
    title.text = str;
    title.font = Font17;
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor colorWithHexString:@"#999999"];
    [bg addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(scanningTop - jianju);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(kWidth,15));
    }];
    
    UIView *bottom = [[UIView alloc]init];
//    bottom.backgroundColor = [UIColor yellowColor];
    [bg addSubview:bottom];
    [bottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(500 - scale);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(kWidth,200));
    }];
    self.bootomview = bottom;
    
    NSString *str2 = @"若无法扫描请输入12位验证码";
    UILabel *title2 = [[UILabel alloc]init];
    title2.text = str2;
    title2.font = Font17;
    title2.textAlignment = NSTextAlignmentCenter;
    title2.textColor = [UIColor colorWithHexString:@"#999999"];
    [bottom addSubview:title2];
    [title2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(kWidth,15));
    }];

    UITextField *text = [[UITextField alloc]init];
    text.keyboardType = UIKeyboardTypeASCIICapable;
    //设置文字内容显示位置
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 40)];
    text.leftView = paddingView;
    text.leftViewMode = UITextFieldViewModeAlways;
    
    text.delegate = self;
    text.font = Font17;
    text.textColor = [UIColor whiteColor];
    text.layer.cornerRadius = 5;
    
    text.layer.borderWidth = 1;
    text.layer.borderColor = [UIColor whiteColor].CGColor;
    [bottom addSubview:text];
    [text mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(title2.mas_bottom).offset(15);
        make.left.mas_equalTo(40);
        make.size.mas_equalTo(CGSizeMake(kWidth - 80,40));
    }];

    self.filed = text;
    UIButton *keep = [[UIButton alloc]init];
    [keep addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    keep.backgroundColor = RGBColor(235, 105, 106);
    keep.layer.cornerRadius = 7;
    keep.titleLabel.font = Font19;
    [keep setTitle:@"验 证" forState:UIControlStateNormal];
    [keep setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bottom addSubview:keep];
    [keep mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(text.mas_bottom).offset(20);
        make.left.mas_equalTo(60);
        make.size.mas_equalTo(CGSizeMake(kWidth - 120, 45));
    }];
}

- (void)backBtn
{
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"退出助理登录" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"确定" otherButtonTitles: nil];
    [sheet showInView:self.view];
   
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (0 == buttonIndex) {
        
        NSDictionary * defaultDict = [curDefaults dictionaryRepresentation];
        for (NSString * key  in [defaultDict allKeys]) {
            
            if ([key isEqualToString:@"kUid"]) {
                [curDefaults setObject:@"0" forKey:@"kUid"];
            }
            if ([key isEqualToString:@"kToken"]) {
                [curDefaults removeObjectForKey:key];
            }
            if ([key isEqualToString:@"phone"]) {
                [curDefaults removeObjectForKey:key];
            }
            if ([key isEqualToString:@"kNickName"]) {
                [curDefaults removeObjectForKey:key];
            }
            if ([key isEqualToString:@"kAuthState"]) {
                [curDefaults removeObjectForKey:key];
            }
            if ([key isEqualToString:@"douNum"]) {
                [curDefaults removeObjectForKey:key];
            }if ([key isEqualToString:@"isLogin"]) {
                [curDefaults removeObjectForKey:key];
            }
        }
        [curDefaults synchronize];
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

-(CGRect)getScanCrop:(CGRect)rect readerViewBounds:(CGRect)readerViewBounds
{
    CGFloat x,y,width,height;
    x = rect.origin.y / readerViewBounds.size.height;
    y = 1 - (rect.origin.x + rect.size.width) / readerViewBounds.size.width;
    width = (rect.origin.y + rect.size.height) / readerViewBounds.size.height;
    height = 1 - rect.origin.x / readerViewBounds.size.width;
    return CGRectMake(x, y, width, height);
}

-(void)readerView:(ZBarReaderView *)readerView didReadSymbols:(ZBarSymbolSet *)symbols fromImage:(UIImage *)image
{
//    [SVProgressHUD showSuccessWithStatus:@"扫描成功"];
    ZBarSymbol *zbarsymol;
    for (zbarsymol in symbols) {
        NSLog(@"%@",zbarsymol.data);
//        https://www.kangzhuangxueche.com/index.php/school
//        NSString *code = [zbarsymol.data stringByReplacingOccurrencesOfString:@"http://192.168.5.216/index.php/student/Orderinfo/code2?code=" withString:@""];
        NSString *code = [zbarsymol.data stringByReplacingOccurrencesOfString:@"https://www.kangzhuangxueche.com/index.php/school/Orderinfo/code2?code=" withString:@""];

        [self getsaomaMsg:code];
//        break;
    }
}

- (void)click
{
    NSString *code = self.filed.text;
    [self getsaomaMsg:code];
}

- (void)getsaomaMsg:(NSString *)code
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"uid"] = kUid;
    NSString * timeStr = self.getcurrentTime;
    param[@"time"] = timeStr;
//    param[@"code"] = @"";
    param[@"code"] = code;
//    param[@"sign"] = [HttpsTools getSignWithIdentify:@"/qrcode" time:self.getcurrentTime];
    param[@"sign"] = [HttpParamManager getSignWithIdentify:@"/qrcode" time:timeStr addExtraStr:code];
    NSLog(@"%@",param);
    [SVProgressHUD showWithStatus:@"加载中..."];
    [HttpsTools kPOST:saomaUrl parameter:param progress:^(NSProgress *downloadProgress) {
    } succeed:^(id backdata, int code, NSString *msg) {
        [self.hudManager dismissSVHud];
        if (1 == code) {
//            [self.hudManager showSuccessSVHudWithTitle:@"扫码成功" hideAfterDelay:1.0 animaton:YES];
            ValidationSuccessController *vc = [[ValidationSuccessController alloc]init];
            saomaModel *model = [saomaModel mj_objectWithKeyValues:backdata];
            
            vc.model = model;
            
            [self presentViewController:vc animated:YES completion:nil];
        }
        else
        {
//            [self.hudManager showErrorSVHudWithTitle:msg hideAfterDelay:2.0];
    
            ValidationFailureController * validationFailureVC= [[ValidationFailureController alloc]init];
            [self presentViewController:validationFailureVC animated:YES completion:nil];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
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
