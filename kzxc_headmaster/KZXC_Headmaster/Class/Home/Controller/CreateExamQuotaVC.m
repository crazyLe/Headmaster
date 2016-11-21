//
//  CreateExamQuotaVC.m
//  KZXC_Headmaster
//
//  Created by gaobin on 16/8/22.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import "CreateExamQuotaVC.h"
#import "ExamQuotaReleaseModel.h"
#import "TailorCell.h"
#import "OSAddressPickerView.h"
#import "RemarkCell.h"
#import "LoginViewController.h"

@interface CreateExamQuotaVC ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,UIAlertViewDelegate,ZHPickViewDelegate>

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) OSAddressPickerView * pickerview;
@property (nonatomic, strong) ZHPickView * regionPickView;


@end

@implementation CreateExamQuotaVC
- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    [_regionPickView remove];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"新增名额";
    
    self.view.backgroundColor = RGBColor(247, 247, 247);
    
    if (_isNewAdd) {
        
        _examQuotaRelease = [[ExamQuotaReleaseModel alloc]init];
    }
    
    [self createUI];
    
}
- (void)createUI {
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight - 64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = RGBColor(247, 247, 247);
    [self.view addSubview:_tableView];
    
    [_tableView registerNib:[UINib nibWithNibName:@"TailorCell" bundle:nil] forCellReuseIdentifier:@"TailorCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"RemarkCell" bundle:nil] forCellReuseIdentifier:@"RemarkCell"];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0 || section == 1) {
        
        return [HZMEKeyArray[section] count];
    }else {
        
        return 1;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.section == 0 || indexPath.section == 1) {
        
        static NSString * identifier = @"TailorCell";
        
        TailorCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
        
        if (0 == indexPath.row) {
            UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidth, 1)];
            line.backgroundColor = [UIColor colorWithHexString:@"#ececec"];
            [cell addSubview:line];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSInteger section = [indexPath section];
        
        NSInteger row = [indexPath row];
        
        cell.showKey.text = [HZMEKeyArray[section] objectAtIndex:row];
        
        cell.showValue.placeholder = [HZMEValueArray[section] objectAtIndex:row];
        
        if (indexPath.section == 0 && indexPath.row == 2) {
            
            cell.showValue.enabled = NO;
        }else {
            cell.showValue.enabled = YES;
        }
        if (indexPath.section == 1 && indexPath.row == 2) {
            cell.showValue.enabled = NO;
        }
        if (indexPath.section == 0) {
            
            cell.showValue.tag = indexPath.row;
        }if (indexPath.section == 1) {
            
            cell.showValue.tag = indexPath.row + 10;
        }
        
        if (indexPath.section == 0) {
            switch (indexPath.row) {
                case 0:
                {
//                    cell.showValue.text = _examQuotaRelease.trueName;
//                    
//                    if (!_isNewAdd) {
//                        
//                        cell.showValue.enabled = NO;
//                    }
                    cell.showValue.text = kNickName;
                    _examQuotaRelease.trueName = kNickName;
                    cell.showValue.enabled = NO;
                    cell.rightImg.alpha = 0;
                }
                    break;
                case 1:
                {
                    cell.showValue.keyboardType = UIKeyboardTypeNumberPad;
                    cell.showValue.text = _examQuotaRelease.tel;
                }
                    break;
                case 2:
                {
                    cell.showValue.enabled = NO;
                    
                    if (_examQuotaRelease.provinceId == nil) {
                        
                        cell.showValue.text = @"";
                    }else {
                        
                        NSArray * provinceArr = kProvinceDict;
                        NSString * provinceStr = nil;
                        for (NSDictionary * dic in provinceArr) {
                            if ([dic[@"id"] isEqualToString:_examQuotaRelease.provinceId]) {
                                provinceStr = dic[@"title"];
                            }
                        }
                        NSArray *cityArr = kCityDict;
                        NSString * cityStr = nil;
                        for (NSDictionary *dic in cityArr) {
                            if ([dic[@"id"] isEqualToString:_examQuotaRelease.cityId]) {
                                cityStr = dic[@"title"];
                            }
                        }
                        NSArray * countryArr = kCountryDict;
                        NSString * countryStr = nil;
                        for (NSDictionary * dict in countryArr) {
                            if ([dict[@"id"] isEqualToString:_examQuotaRelease.areaId]) {
                                countryStr = dict[@"title"];
                            }
                        }
                        
                        cell.showValue.text = [NSString stringWithFormat:@"%@ %@ %@",provinceStr,cityStr,countryStr];
         
                        }
                        
                    }
                    break;
                    
                case 3:
                    {
                       
                        cell.showValue.text = _examQuotaRelease.adress;
                    }
                    break;
                default:
                    break;

                    }

        }
        if (indexPath.section == 1) {
            switch (indexPath.row) {
                case 0:
                {
                    cell.showValue.keyboardType = UIKeyboardTypeNumberPad;
                    cell.showValue.text = _examQuotaRelease.peopleNum;
                }
                    break;
                case 1:
                {
                    cell.showValue.keyboardType = UIKeyboardTypeNumberPad;
                    cell.showValue.text = _examQuotaRelease.holdingTime;
                }
                    break;
                case 2:
                {
                    cell.showValue.text = _examQuotaRelease.region;
                }
                    break;
                case 3:
                {
                    cell.showValue.keyboardType = UIKeyboardTypeNumberPad;
                    cell.showValue.text = _examQuotaRelease.price;
                }
                    break;
                    
                default:
                    break;
            }
            
        }
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChanged:) name:UITextFieldTextDidChangeNotification object:cell.showValue];
        
        
        return cell;

        
    }else {
        //备注content
        static NSString * identifier = @"RemarkCell";
        RemarkCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
        cell.backgroundColor = RGBColor(247,247,247);
        cell.myTextView.backgroundColor = [UIColor whiteColor];
        cell.myTextView.text = _examQuotaRelease.content;
        cell.myTextView.delegate = self;
        
        return  cell;
    }
    
}
#pragma mark -- textView的代理方法
- (void)textViewDidChange:(UITextView *)textView {
    
    _examQuotaRelease.content = textView.text;
    
}
- (void)textFieldChanged:(NSNotification *)notification {
    
    UITextField * textField = (UITextField *)[notification object];
    textField.textColor = [UIColor colorWithHexString:@"#333333"];
    
    switch (textField.tag) {
//        case 0:
//        {
//            _examQuotaRelease.trueName = textField.text;
//
//        }
//            break;
        case 1:
        {
            _examQuotaRelease.tel = textField.text;
        }
            break;

        case 3:
        {
            _examQuotaRelease.adress = textField.text;
        }
            break;
        case 10:
        {
            _examQuotaRelease.peopleNum = textField.text;
        }
            break;
        case 11:
        {
            _examQuotaRelease.holdingTime = textField.text;
        }
            break;
//        case 12:
//        {
//            _examQuotaRelease.region = textField.text;
//        }
//            break;
        case 13:
        {
            _examQuotaRelease.price = textField.text;
            
        }
            break;
        default:
            break;
    }
    
        
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 1) {
        
        UIView *headview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidth, 50)];
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(15, 19, 12, 12)];
        img.image = [UIImage imageNamed:@"mehz_head"];
        [headview addSubview:img];
        
        UILabel *headtitle = [[UILabel alloc]initWithFrame:CGRectMake(30, 0, 80, 50)];
        headtitle.font = [UIFont fontWithName:@"Helvetica-Bold" size:15.0];
        headtitle.textColor = [UIColor colorWithHexString:@"#ff6969"];
        headtitle.text = @"名额信息";
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 49, kWidth, 1)];
        line.backgroundColor = [UIColor colorWithHexString:@"#ececec"];
        [headview addSubview:line];
        [headview addSubview:headtitle];
        
        return headview;
    }if (section == 2) {
        
        
        UIView *headview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidth, 50)];
        headview.backgroundColor = RGBColor(247, 247, 247);
        
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(15, 19, 12, 12)];
        img.image = [UIImage imageNamed:LeaseHeadImgArrar[section - 1]];
        [headview addSubview:img];
        
        UILabel *headtitle = [[UILabel alloc]initWithFrame:CGRectMake(30, 0, 80, 50)];
        headtitle.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
        headtitle.textColor = [UIColor colorWithHexString:@"#ff6969"];
        headtitle.text = @"备注";
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 49, kWidth, 1)];
        line.backgroundColor = [UIColor colorWithHexString:@"#ececec"];
        [headview addSubview:line];
        
        [headview addSubview:headtitle];
        
        return headview;
    }
    
    return nil;

}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    if (section == 2) {
        
        UIView * bgView = [[UIView alloc] init];
        bgView.backgroundColor = [UIColor clearColor];
        
        UIButton *keep = [[UIButton alloc]initWithFrame:CGRectMake(20, 30, kWidth- 40, ButtonH)];
        [keep setTitle:@"保存并发布" forState:UIControlStateNormal];
        [keep setTitleColor:[UIColor whiteColor] forState: UIControlStateNormal];
        keep.layer.cornerRadius = ButtonH/2;
        keep.backgroundColor = CommonButtonBGColor;
        [keep addTarget:self action:@selector(keepClick) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:keep];
        
        return bgView;
        
    }
    return nil;
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (1 == section || 2 == section) {
        return 50;
    }
    return CGFLOAT_MIN;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    if (section == 0 || section == 1) {
        
        return CGFLOAT_MIN;
    }else {
        
        return 120;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0 || indexPath.section == 1) {
        
        return 50;
    }else {
        
        return 110;
    }
}
#pragma mark -- 保存并发布考试名额请求
- (void)keepClick
{

    //判断是否登录
    if ([kUid isEqualToString:@"0"]){
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"您尚未登录,无法进行此操作!" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去登录", nil];
        alertView.tag = 10000;
        [alertView show];
        
        return;
    }
    //判断实名认证状态
    if (![kAuthState isEqualToString:@"1"]) {
        
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"您尚未通过实名认证,无法进行此操作!" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alertView show];
        
        return;
    }


    if (_examQuotaRelease.provinceId.length == 0) {
        [self.hudManager showErrorSVHudWithTitle:@"请选择地址" hideAfterDelay:1.0];
        return;
    }
    
    NSString * url = examinationQuataRelease;
    NSMutableDictionary * paramDict = [NSMutableDictionary dictionary];
    paramDict[@"uid"] = kUid;
    NSString * timeString = self.getcurrentTime;
    paramDict[@"time"] = timeString;
    paramDict[@"sign"] = [HttpsTools getSignWithIdentify:@"/examinationQuota/create" time:timeString];
    //选填的参数
    paramDict[@"trueName"] = _examQuotaRelease.trueName;
    paramDict[@"tel"] = _examQuotaRelease.tel;
    paramDict[@"provinceId"] = _examQuotaRelease.provinceId;
    paramDict[@"cityId"] = _examQuotaRelease.cityId;
    paramDict[@"areaId"] = _examQuotaRelease.areaId;
    paramDict[@"address"] = _examQuotaRelease.adress;
    paramDict[@"peopleNum"] = _examQuotaRelease.peopleNum;
    paramDict[@"holdingTime"] = _examQuotaRelease.holdingTime;
    paramDict[@"region"] = _examQuotaRelease.region;
    paramDict[@"content"] = _examQuotaRelease.content;
    paramDict[@"price"] = _examQuotaRelease.price;
    
    if (_isNewAdd) {
        paramDict[@"examinaId"] = @"0";
    }else {
        paramDict[@"examinaId"] = self.examQuotaRelease.idStr;
    }

    [HttpsTools POST:url parameter:paramDict progress:^(NSProgress *downloadProgress) {
    } succeed:^(id responseObject) {

        NSLog(@"发布或修改我的名额%@",responseObject);
        NSInteger code = [responseObject[@"code"] integerValue];
        NSString * msg = responseObject[@"msg"];
        if (code == 1) {
            
            //添加或者编辑成功跳回前一页面,发送通知刷新页面
            [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadMyQuota" object:self];
            
            
            [self.navigationController popViewControllerAnimated:YES];
        }else {
            
            [MBProgressHUD showError:msg];
        }
        
        
    } failure:^(NSError *error) {
        
        [MBProgressHUD showError:@"发布失败"];
        
    }];
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 10000) {
        
        if (buttonIndex == 1) {
            //去登陆
            LoginViewController * vc = [[LoginViewController alloc] init];
            
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [_regionPickView remove];
    
    if (indexPath.section == 0 && indexPath.row == 2) {
        
        [self.view endEditing:YES];
        
        _pickerview = [OSAddressPickerView shareInstance];
        
        NSArray *addressArr = kProvinceData;
        
        NSMutableArray *dataArray = [NSMutableArray  array];
        
        for (NSData *data in addressArr) {
            ProvinceModel *model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            [dataArray addObject:model];
        }
        _pickerview.dataArray = dataArray;
        
        [_pickerview showBottomView];
        
        [self.view addSubview:_pickerview];
        
        WeakObj(self);
        
        _pickerview.block = ^(ProvinceModel *provinceModel,CityModel *cityModel,CountryModel *districtModel)
        {
            
            selfWeak.examQuotaRelease.provinceId = [NSString stringWithFormat:@"%d",provinceModel.idNum];
            
            selfWeak.examQuotaRelease.cityId = [NSString stringWithFormat:@"%d",cityModel.idNum];
            
            selfWeak.examQuotaRelease.areaId = [NSString stringWithFormat:@"%d",districtModel.idNum];
            
            [selfWeak.tableView reloadData];
            
        };

    }
    
    if (indexPath.section == 1 && indexPath.row == 2) {
        
        [self.view endEditing:YES];
        
        NSArray * regionArray = [NSArray arrayWithObjects:@"限本省",@"限本市",@"不限",nil];
        _regionPickView = [[ZHPickView alloc] initPickviewWithArray:regionArray isHaveNavControler:NO];
        _regionPickView.delegate = self;
        [_regionPickView setPickViewColer:[UIColor groupTableViewBackgroundColor]];
        [_regionPickView show];
    }

}
#pragma mark --  ZHPickView的代理方法
- (void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString {
    
    _examQuotaRelease.region = resultString;
    
    [_tableView reloadData];
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
