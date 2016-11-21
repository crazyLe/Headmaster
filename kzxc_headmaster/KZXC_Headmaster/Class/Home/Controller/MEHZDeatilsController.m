//
//  MEHZDeatilsController.m
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/7/20.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import "MEHZDeatilsController.h"
#import "ExamQuotaDetailModel.h"
#import "LoginViewController.h"

@interface MEHZDeatilsController ()<UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *personNumLab;
@property (weak, nonatomic) IBOutlet UILabel *releaseManLab;
@property (weak, nonatomic) IBOutlet UILabel *holdingTimeLab;
@property (weak, nonatomic) IBOutlet UILabel *regionLab;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;

@property (nonatomic, strong) ExamQuotaDetailModel * examQuota;

@end

@implementation MEHZDeatilsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"考试名额";
    
    [self requestData];
    
    
    
}
- (void)setUIdata {
    
    _personNumLab.text = [NSString stringWithFormat:@"%@人(%@)",_examQuota.userMax,_examQuota.adress];
    _releaseManLab.text = _examQuota.trueName;
    _holdingTimeLab.text = [NSString stringWithFormat:@"%@天拿证",_examQuota.holdingTime];
    _regionLab.text = _examQuota.region;
    _priceLab.text = [NSString stringWithFormat:@"%@元",_examQuota.price];
    _contentLab.text = _examQuota.content;
    
}


- (void)requestData {
    
    [self.hudManager showNormalStateSVHUDWithTitle:@"加载中..."];
    
    NSString * url = examinationQuataDetail;
    NSMutableDictionary * paramDict = [NSMutableDictionary dictionary];
    paramDict[@"uid"] = kUid;
    paramDict[@"devideInfo"] = deviceInfo;
    paramDict[@"eqId"] = _idString;
    NSString * timeString = self.getcurrentTime;
    paramDict[@"time"] = timeString;
    paramDict[@"sign"] = [HttpsTools getSignWithIdentify:@"/examinationQuota/retrieve" time:timeString];
    [HttpsTools POST:url parameter:paramDict progress:^(NSProgress *downloadProgress) {
    } succeed:^(id responseObject) {
       
        NSLog(@">>>%@",responseObject);
        NSInteger code = [responseObject[@"code"] integerValue];
        NSString * msg = responseObject[@"msg"];
        if (code == 1) {
            
            NSDictionary * infoDict = responseObject[@"info"];
            _examQuota = [ExamQuotaDetailModel mj_objectWithKeyValues:infoDict];
            
            [self setUIdata];
            
            [self.hudManager dismissSVHud];
        }else {
            
            [MBProgressHUD showError:msg];
        }
        
        
    } failure:^(NSError *error) {
        
        [MBProgressHUD showError:@"加载失败"];
        
    }];
    
    
    
    
}
- (IBAction)phoneBtnClick:(id)sender {
    
    //判断是否登录
    if ([kUid isEqualToString:@"0"]){
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"您尚未登录,无法进行此操作!" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去登录", nil];
        alertView.tag = 10000;
        [alertView show];
        
        return;
    }
    
    if (![kAuthState isEqualToString:@"1"]) {
        
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"您尚未通过实名认证,无法进行此操作!" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alertView show];
        
        return;
    }
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:_examQuota.phone message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"拨号", nil];
    alert.tag = 20000;
    [alert show];
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 10000) {
        
        if (buttonIndex == 1) {
            //去登陆
            LoginViewController * vc = [[LoginViewController alloc] init];
            
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    }
    if (alertView.tag == 20000) {
        if (buttonIndex == 1) {
            
            NSString *tel = [NSString stringWithFormat:@"tel://%@",_examQuota.phone];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:tel]];
        }
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
