//
//  EditVouchersController.m
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/7/19.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import "EditVouchersController.h"
#import "TailorCell.h"
#import "DDJModel.h"

@interface EditVouchersController ()<UITableViewDelegate,UITableViewDataSource,ZHPickViewDelegate,UIAlertViewDelegate>
{
    TailorCell *curcell;
    NSInteger currow;
    NSArray *titlearr;
    NSArray *modelvaluearr;
}
@property(strong,nonatomic)ZHPickView *pickview;
@property(strong,nonatomic)NSMutableArray *valuesArr;
@end

@implementation EditVouchersController

- (NSMutableArray *)valuesArr
{
    if (!_valuesArr) {
        _valuesArr = [NSMutableArray arrayWithObjects:@"",@"",@"",@"", nil];
    }
    return _valuesArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.title = @"编辑代金劵";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f7f7f7"];
    
    if (_model != nil) {
        
        modelvaluearr = @[_model.title,_model.money,[self getStamptimeWithString:_model.startTime andSec:NO],[self getStamptimeWithString:_model.endTime andSec:NO]];;
    }
    
    titlearr = @[@"请输入标题",@"请输入金额",@"请输入日期",@"请输入日期"];
    
    [self setupTable];
}

- (void)setupTable
{
    CGRect rect = CGRectMake(0, 15, kWidth, 200);
    UITableView *loctable = [[UITableView alloc]initWithFrame:rect];
    loctable.separatorStyle = UITableViewCellSeparatorStyleNone;
    loctable.dataSource = self;
    loctable.delegate = self;
    [self.view addSubview:loctable];
    
    
    UILabel *titleTag = [[UILabel alloc]initWithFrame:CGRectMake((kWidth - 120)/2, 215, 180, 20)];
    titleTag.text = @"*仅限对本校报名使用";
    titleTag.font = [UIFont systemFontOfSize:14.0];
    titleTag.textColor = [UIColor colorWithHexString:@"#c8c8c8"];
    [self.view addSubview:titleTag];
    
    UIButton *keep = [[UIButton alloc]initWithFrame:CGRectMake(20,255,kWidth - 40,ButtonH)];
    keep.backgroundColor = CommonButtonBGColor;
    keep.layer.cornerRadius = ButtonH/2;
    [keep setTitle:@"确认发布" forState:UIControlStateNormal];
    [keep setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [keep addTarget:self action:@selector(sendDDJ) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:keep];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"tailorID";
    
    
    TailorCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    
    if (!cell) {
        
        cell = [[[NSBundle mainBundle]loadNibNamed:@"TailorCell" owner:nil options:nil]firstObject];
    }
    
    if (0 == indexPath.row) {
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidth, 1)];
        line.backgroundColor = [UIColor colorWithHexString:@"#ececec"];
        [cell addSubview:line];
    }
    
    cell.showValue.placeholder = titlearr[indexPath.row];
    
    if (_model != nil) {
        cell.showValue.text = modelvaluearr[indexPath.row];
    }
    
    cell.showKey.text = editVoucherArray[indexPath.row];

    if (1 < indexPath.row) {
        cell.rightImg.image = [UIImage imageNamed:@"rili"];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.backgroundColor = [UIColor whiteColor];
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    curcell = [tableView cellForRowAtIndexPath:indexPath];
    if (0 == row && _model == nil) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"请输入标题" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
        alert.tag = 1001;
        
        [alert show];
    }
    if (1 == row && _model == nil)
    {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"请输入金额" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
        alert.tag = 1002;
    
        UITextField *tf = [alert textFieldAtIndex:0];
        tf.keyboardType = UIKeyboardTypeNumberPad;
        
        [alert show];
    }
    if (indexPath.row > 1) {
        currow = indexPath.row;
        
        [_pickview remove];
        
        NSDate *date=[NSDate dateWithTimeIntervalSinceNow:0];
        _pickview=[[ZHPickView alloc] initDatePickWithDate:date datePickerMode:UIDatePickerModeDate isHaveNavControler:NO];
        _pickview.delegate=self;
        
        [_pickview show];
    }
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSInteger tag = alertView.tag;
    switch (tag) {
        case 1001:
        {
            if (1 == buttonIndex) {
               NSString *str = [alertView textFieldAtIndex:0].text;
                NSLog(@"%@",str);
                curcell.showValue.text = str;
                self.valuesArr[0] = str;
            }
        }
            break;
        case 1002:
        {
            if (1 == buttonIndex) {
                NSString *str = [alertView textFieldAtIndex:0].text;
                curcell.showValue.text = str;
                self.valuesArr[1] = str;
                NSLog(@"%@",str);
            }
        }
            break;
            
        default:
            break;
    }
}

- (void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString
{
    curcell.showValue.text = resultString;
    
    NSLog(@"%@",[self getStamptimeWithTime:resultString]);
    if (2 == currow) {
        self.valuesArr[2] = resultString;
    }
    if (3 == currow) {
        self.valuesArr[3] = resultString;
    }
    NSLog(@"%@",resultString);
}

- (void)sendDDJ
{
    if (_model == nil) {
        [self addDDJ];
    }
    else
    {
        [self editDDJ:_model];
    }
}

/**
 *  新增代金劵
 */
- (void)addDDJ
{
    
     NSLog(@"%@,%@",[self getStamptimeWithTime:_valuesArr[2]],[self getStamptimeWithTime:_valuesArr[3]]);
    
    if ([_valuesArr[0] length] == 0) {
        [self.hudManager showErrorSVHudWithTitle:@"请输入标题" hideAfterDelay:1.0];
        return;
    }
    if ([_valuesArr[1] length] == 0) {
        [self.hudManager showErrorSVHudWithTitle:@"请输入金额" hideAfterDelay:1.0];
        return;
    }
    if ([_valuesArr[2] length] == 0 || [_valuesArr[3] length] == 0) {
        [self.hudManager showErrorSVHudWithTitle:@"请输入日期" hideAfterDelay:1.0];
        return;
    }
    
    int temp2 = [[_valuesArr[2] stringByReplacingOccurrencesOfString:@"/" withString:@""] intValue];
    int temp3 = [[_valuesArr[3] stringByReplacingOccurrencesOfString:@"/" withString:@""] intValue];
    
    if (temp2 > temp3) {
        [self.hudManager showErrorSVHudWithTitle:@"结束日期不能早于开始日期" hideAfterDelay:1.0];
        return;
    }
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"uid"] = kUid;
    param[@"title"] = _valuesArr[0];
    param[@"money"] = _valuesArr[1];
    param[@"startTime"] = [self getStamptimeWithTime:_valuesArr[2]];
    
    param[@"endTime"] = [self getStamptimeWithTime:_valuesArr[3]];
    param[@"time"] = self.getcurrentTime;
    param[@"sign"] = [HttpsTools getSignWithIdentify:@"/cashCoupon/create" time:self.getcurrentTime];

    [HttpsTools kPOST:ddjAddUrl parameter:param progress:^(NSProgress *downloadProgress) {
    } succeed:^(id backdata, int code, NSString *msg) {
        NSLog(@"%@,%d",backdata,code);
        
        if (1 == code) {
            [self.hudManager showSuccessSVHudWithTitle:@"发布成功" hideAfterDelay:1.0 animaton:YES];
            
            [self.navigationController popViewControllerAnimated:YES];
        }

    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

/**
 *  编辑代金劵接口
 *
 *  @param model 代金劵模型
 */
- (void)editDDJ:(DDJModel *)model
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"uid"] = kUid;
    param[@"coupon_id"] = model.bianhao;
    
    NSString *str2 = [self getStamptimeWithTime:_valuesArr[2]];
    NSString *str3 = [self getStamptimeWithTime:_valuesArr[3]];
    
    str2 = (0 == [str2 intValue])?model.startTime:str2;
    
    str3 = (0 == [str2 intValue])?model.endTime:str3;
    
    int temp2 = [[str2 stringByReplacingOccurrencesOfString:@"/" withString:@""] intValue];
    int temp3 = [[str3 stringByReplacingOccurrencesOfString:@"/" withString:@""] intValue];
    
    if (temp2 > temp3) {
        [self.hudManager showErrorSVHudWithTitle:@"结束日期不能早于开始日期" hideAfterDelay:1.0];
        return;
    }
    
    param[@"startTime"] = str2;
    param[@"endTime"] = str3;
    
    param[@"time"] = self.getcurrentTime;
    param[@"sign"] = [HttpsTools getSignWithIdentify:@"/cashCoupon/update" time:self.getcurrentTime];
    NSLog(@"%@",param);
    [HttpsTools kPOST:ddjEditUrl parameter:param progress:^(NSProgress *downloadProgress) {
    } succeed:^(id backdata, int code, NSString *msg) {
        NSLog(@"%@,%d,%@",backdata,code,msg);

        if (1 == code) {
            [self.hudManager showSuccessSVHudWithTitle:@"编辑成功" hideAfterDelay:1.0 animaton:YES];
            [self.navigationController popViewControllerAnimated:YES];
            
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [_pickview remove];
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
