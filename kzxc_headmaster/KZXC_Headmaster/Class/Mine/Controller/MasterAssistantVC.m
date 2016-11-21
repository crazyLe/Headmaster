//
//  MasterAssistantVC.m
//  KZXC_Headmaster
//
//  Created by gaobin on 16/8/25.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import "MasterAssistantVC.h"
#import "MasterAssistantCell.h"

@interface MasterAssistantVC ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>

@property (nonatomic, strong) UITableView * tableView;

@end

@implementation MasterAssistantVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"校长助理账号设置";
    
    [self createUI];
    
}
- (void)createUI {
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight - 64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = RGBColor(247, 247, 247);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    [_tableView registerNib:[UINib nibWithNibName:@"MasterAssistantCell" bundle:nil] forCellReuseIdentifier:@"MasterAssistantCell"];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * identifier = @"MasterAssistantCell";
    MasterAssistantCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {

        cell.contentTF.text = kPhone;
        cell.safeBtn.alpha = 0;
        
    }if (indexPath.row == 1) {
        
        cell.contentTF.placeholder = @"输入助理登录密码";
        cell.contentTF.keyboardType = UIKeyboardTypeASCIICapable;
        [cell.safeBtn setImage:[UIImage imageNamed:@"safe"] forState:UIControlStateNormal];
        [cell.safeBtn setImage:[UIImage imageNamed:@"nosafe"] forState:UIControlStateSelected];
        cell.safeBtn.tag = 1000;
        [cell.safeBtn addTarget:self action:@selector(safeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
    }if (indexPath.row == 2) {
        
        cell.contentTF.placeholder = @"请再次输入助理登录密码";
        cell.contentTF.keyboardType = UIKeyboardTypeASCIICapable;
        [cell.safeBtn setImage:[UIImage imageNamed:@"safe"] forState:UIControlStateNormal];
        [cell.safeBtn setImage:[UIImage imageNamed:@"nosafe"] forState:UIControlStateSelected];
        cell.safeBtn.tag = 2000;
        [cell.safeBtn addTarget:self action:@selector(safeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 45;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 100;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    UIView * bgView = [[UIView alloc] init];
    bgView.backgroundColor  = [UIColor clearColor];
    
    UIButton * saveBtn = [[UIButton alloc]init];
    [saveBtn addTarget:self action:@selector(saveBtnClick) forControlEvents:UIControlEventTouchUpInside];
    saveBtn.backgroundColor = CommonButtonBGColor;
    saveBtn.layer.cornerRadius = ButtonH/2;
    [saveBtn setTitle:@"确认设置" forState:UIControlStateNormal];
    [saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bgView addSubview:saveBtn];
    [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(20);
        make.left.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(kWidth - 40, ButtonH));
    }];
    
    return bgView;

    
}
- (void)safeBtnClick:(UIButton *)btn {
    
    btn.selected = !btn.selected;
 
    if (btn.tag == 1000) {
        
        MasterAssistantCell * cell = (MasterAssistantCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
        if (btn.isSelected) {
            
            cell.contentTF.secureTextEntry = YES;
            
        }else {
            cell.contentTF.secureTextEntry = NO;
        }
   
        
    }else {
        
        MasterAssistantCell * cell = (MasterAssistantCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
        if (btn.isSelected) {
            
            cell.contentTF.secureTextEntry = YES;
        }else {
            
            cell.contentTF.secureTextEntry = NO;
        }
    }
}
#pragma mark -- 校长助理账号设置的请求
- (void)saveBtnClick {
    
    
    NSString * url = setMasterAssistant;
    NSString * timeStr = self.getcurrentTime;
    
    NSMutableDictionary * paramDict = [NSMutableDictionary dictionary];
    paramDict[@"uid"] = kUid;
    paramDict[@"time"] = timeStr;
    paramDict[@"sign"] = [HttpsTools getSignWithIdentify:@"/member/setassistant" time:timeStr];
    paramDict[@"deviceInfo"] = deviceInfo;
    MasterAssistantCell * cell = (MasterAssistantCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    paramDict[@"pwd"] = cell.contentTF.text;
    MasterAssistantCell * cell1 = (MasterAssistantCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    paramDict[@"confirmPwd"] = cell1.contentTF.text;
    
    [HttpsTools POST:url parameter:paramDict progress:^(NSProgress *downloadProgress) {
    } succeed:^(id responseObject) {
        NSLog(@"校长助手账号设置%@",responseObject);
        NSInteger code = [responseObject[@"code"] integerValue];
        NSString * msg = responseObject[@"msg"];
        
        if (code == 1) {
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:msg message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            
            [alert show];
    
        }else {
            
            [self.hudManager showErrorSVHudWithTitle:msg hideAfterDelay:1.0];
        }
        
        
    } failure:^(NSError *error) {
        
        [self.hudManager showErrorSVHudWithTitle:@"设置失败" hideAfterDelay:1.0];
        
    }];
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.navigationController popViewControllerAnimated:YES];
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
