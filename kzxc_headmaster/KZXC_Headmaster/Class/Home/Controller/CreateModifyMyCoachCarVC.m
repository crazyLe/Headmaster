//
//  CreateModifyMyCoachCarVC.m
//  KZXC_Headmaster
//
//  Created by gaobin on 16/8/15.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import "CreateModifyMyCoachCarVC.h"
#import "TailorCell.h"
#import "UploadCoachCarPicCell.h"
#import "RemarkCell.h"
#import "GroundMapController.h"
#import "CarTypeModel.h"
#import "ZHPickView.h"
#import "OSAddressPickerView.h"
#import "LoginViewController.h"

@interface CreateModifyMyCoachCarVC ()<UITableViewDelegate,UITableViewDataSource,GroundMapControllerDelegate,UITextViewDelegate,UploadCoachCarPicCellDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,ZHPickViewDelegate,UIAlertViewDelegate>
{
    NSData * _leftData;
    NSData * _middleData;
    NSData * _rightData;
}

@property(weak,nonatomic)UITableView *table;
@property (nonatomic, copy) NSString * longitude;
@property (nonatomic, copy) NSString * latitude;

@property (nonatomic, strong) UIButton * currentBtn;
@property (nonatomic, assign) BOOL  isSelectLeft;
@property (nonatomic, assign) BOOL  isSelectMiddle;
@property (nonatomic, assign) BOOL  isSelectRight;
@property (nonatomic, strong) NSMutableArray * carTypeDataArray;
@property (nonatomic, strong) ZHPickView * carTypePickView;
@property (nonatomic, strong) OSAddressPickerView * pickerView;
@property(strong,nonatomic)UIAlertView *outAlert;
@property (nonatomic, strong) NSArray * carArray;

@end

@implementation CreateModifyMyCoachCarVC
- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    if ([kUid intValue] == 0) {
        [_outAlert show];
    }else {
        [_carTypePickView remove];
    }

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _outAlert = [[UIAlertView alloc]initWithTitle:@"" message:@"您尚未登录!" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去登录", nil];
    _outAlert.tag = 808;
    
    
    _carTypeDataArray = [NSMutableArray array];

    self.title = @"发布";
    
    self.view.backgroundColor = RGBColor(247,247,247);
    
    if (_isNewAdd) {
        
        _coachCarLeasee = [[CocahCarLeaseModel alloc]init];
    }
    [self setupTable];
    
    //获取所有的车型CarType
    [self requestData];
}
#pragma mark -- 获取所有车型的请求
- (void)requestData {
    
    NSString * url = getCarTypeUrl;
    NSString * timeStr = self.getcurrentTime;
    
    NSMutableDictionary * paramDict = [NSMutableDictionary dictionary];
    paramDict[@"uid"] = kUid;
    paramDict[@"time"] = timeStr;
    paramDict[@"deviceInfo"] = deviceInfo;
    paramDict[@"sign"] = [HttpsTools getSignWithIdentify:@"/getCar" time:timeStr];
    
    [HttpsTools POST:url parameter:paramDict progress:^(NSProgress *downloadProgress) {
    } succeed:^(id responseObject) {
        NSLog(@"获取所有的车型%@",responseObject);
        NSInteger code = [responseObject[@"code"] integerValue];
        NSString * msg = responseObject[@"msg"];
        if (code ==1) {
            
            NSDictionary * infoDict = responseObject[@"info"];
            NSArray * carTypeArray = infoDict[@"carType"];
            _carArray = [CarTypeModel mj_objectArrayWithKeyValuesArray:carTypeArray];
            for (CarTypeModel * carType in _carArray) {
                
                [_carTypeDataArray addObject:carType.carName];
            }
            
        }else {
            
            [self.hudManager showErrorSVHudWithTitle:msg hideAfterDelay:1.0];
        }
        
    } failure:^(NSError *error) {
        
        [self.hudManager showErrorSVHudWithTitle:@"加载失败" hideAfterDelay:1.0];
        
    }];
}
- (void)setupTable
{
    
    CGRect tableFream = CGRectMake(0, 10, kWidth, kHeight-64 -10 );
    UITableView *loctable = [[UITableView alloc]initWithFrame:tableFream style:UITableViewStyleGrouped];
    
    loctable.backgroundColor = RGBColor(247, 247, 247);
    loctable.separatorStyle = UITableViewCellSeparatorStyleNone;
    loctable.dataSource = self;
    loctable.delegate = self;
    self.table = loctable;
    
    [self.view addSubview:loctable];
    [loctable registerNib:[UINib nibWithNibName:@"TailorCell" bundle:nil] forCellReuseIdentifier:@"TailorCell"];
    [loctable registerNib:[UINib nibWithNibName:@"UploadCoachCarPicCell" bundle:nil] forCellReuseIdentifier:@"UploadCoachCarPicCell"];
    [loctable registerNib:[UINib nibWithNibName:@"RemarkCell" bundle:nil] forCellReuseIdentifier:@"RemarkCell"];
    
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return LeaseArray.count + 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 4;
    }if (section == 1) {
        return 4;
    }if (section == 2) {
        return 5;
    }else {
        return 1;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"TailorCell";
    
    TailorCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    
    if (!cell) {
        
        cell =  [[NSBundle mainBundle] loadNibNamed:@"TailorCell" owner:nil options:nil].firstObject;
    }
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.section == 0 || indexPath.section == 1 || indexPath.section == 2 ) {
        
        NSArray *temp = LeaseCocahCarArray[indexPath.section];
        
        NSArray *tempa = LeaseCocahValueArray[indexPath.section];
        cell.showKey.text = [temp objectAtIndex:indexPath.row];
        
        cell.showValue.enabled = YES;
        //设置textfield的占位字符的颜色
        [cell.showValue setValue:[UIColor colorWithHexString:@"#c8c8c8"] forKeyPath:@"_placeholderLabel.textColor"];
        cell.showValue.placeholder = [tempa objectAtIndex:indexPath.row];
        
    }
    if (indexPath.section == 1 && indexPath.row == 0) {
        
        cell.showValue.enabled = NO;
    }

    if (indexPath.section == 0) {
        
        switch (indexPath.row) {
            case 0:
            {
                cell.showValue.text = kNickName;
                cell.showValue.enabled = NO;
                cell.rightImg.alpha = 0;
            }
                break;
            case 1:
            {
                cell.showValue.keyboardType = UIKeyboardTypeNumberPad;
                cell.showValue.text = _coachCarLeasee.tel;
                
            }
                break;
            case 2:
            {
                
                cell.showValue.enabled = NO;
              
                if (_coachCarLeasee.provinceId == nil) {
                    
                      cell.showValue.text = @"";
                }else {
            
                    NSArray * provinceArr = kProvinceDict;
                    NSString * provinceStr = nil;
                    for (NSDictionary * dic in provinceArr) {
                        if ([dic[@"id"] isEqualToString:_coachCarLeasee.provinceId]) {
                            provinceStr = dic[@"title"];
                        }
                    }
                    
                    NSArray *cityArr = kCityDict;
                    NSString * cityStr = nil;
                    for (NSDictionary *dic in cityArr) {
                        if ([dic[@"id"] isEqualToString:_coachCarLeasee.cityId]) {
                            cityStr = dic[@"title"];
                        }
                    }
                    NSArray * countryArr = kCountryDict;
                    NSString * countryStr = nil;
                    for (NSDictionary * dict in countryArr) {
                        if ([dict[@"id"] isEqualToString:_coachCarLeasee.areaId]) {
                            countryStr = dict[@"title"];
                        }
                    }
                    
                    cell.showValue.text = [NSString stringWithFormat:@"%@ %@ %@",provinceStr,cityStr,countryStr];

                }
               
                
 }
                break;
            case 3:
            {
                
                cell.showValue.text = _coachCarLeasee.address;
                
            }
                break;
            default:
                break;

      }
                

        
     }if (indexPath.section == 1) {
        
        switch (indexPath.row) {
            case 0:
            {
                cell.showValue.text = _coachCarLeasee.carType;
            }
                break;
            case 1:
            {
                cell.showValue.keyboardType = UIKeyboardTypeNumberPad;
                cell.showValue.text = _coachCarLeasee.carNum;

            }
                break;
            case 2:
            {
                cell.showValue.keyboardType = UIKeyboardTypeNumberPad;
                cell.showValue.text = _coachCarLeasee.carAge;
            }
                break;
            case 3:
            {
                cell.showValue.keyboardType = UIKeyboardTypeNumberPad;
                cell.showValue.text = _coachCarLeasee.carKm;
            }
                break;
            default:
                break;
        }
        
        
    }if (indexPath.section == 2) {
        
        cell.showValue.keyboardType = UIKeyboardTypeNumberPad;
        
        switch (indexPath.row) {
            case 0:
            {
                cell.showValue.text = _coachCarLeasee.priceDay;
            }
                break;
            case 1:
            {
                cell.showValue.text = _coachCarLeasee.priceWeek;
            }
                break;
            case 2:
            {
                cell.showValue.text = _coachCarLeasee.priceMonth;
            }
                break;
            case 3:
            {
                cell.showValue.text = _coachCarLeasee.priceQuarter;
            }
                break;
            case 4:
            {
                cell.showValue.text = _coachCarLeasee.priceYear;
            }
                break;
            default:
                break;
        }
    }if (indexPath.section == 3) {
        static NSString * identifier = @"RemarkCell";
        RemarkCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
        cell.backgroundColor = RGBColor(247,247,247);
        cell.myTextView.backgroundColor = [UIColor whiteColor];
        cell.myTextView.text = _coachCarLeasee.other;
        cell.myTextView.delegate = self;
        
        return  cell;
        
    }if (indexPath.section == 4) {
        
        
        static NSString * identifier = @"UploadCoachCarPicCell";
        UploadCoachCarPicCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
        cell.delegate = self;
        if (!_isSelectLeft) {
            [cell.leftImgBtn sd_setImageWithURL:[NSURL URLWithString:_coachCarLeasee.picModel.pic1] forState:UIControlStateNormal];
        }if (!_isSelectMiddle) {
            [cell.middleImgBtn sd_setImageWithURL:[NSURL URLWithString:_coachCarLeasee.picModel.pic2] forState:UIControlStateNormal];
        }if (!_isSelectRight) {
            [cell.rightImgBtn sd_setImageWithURL:[NSURL URLWithString:_coachCarLeasee.picModel.pic3] forState:UIControlStateNormal];
        }
        
        
        return cell;
    }
    
    
    if (indexPath.section == 0) {
        
        cell.showValue.tag = indexPath.row;
        
    }if (indexPath.section == 1) {
        
        cell.showValue.tag = indexPath.row + 10;
    }if (indexPath.section == 2) {
        
        cell.showValue.tag = indexPath.row + 100;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChanged:) name:UITextFieldTextDidChangeNotification object:cell.showValue];
    
    
    return cell;
}


- (void)textFieldChanged:(NSNotification *)notification {
    
    UITextField *textField = (UITextField *)[notification object];
    textField.textColor = [UIColor colorWithHexString:@"#333333"];
    
    switch (textField.tag) {

        case 1:
        {
            
            _coachCarLeasee.tel = textField.text;
            
        }
            break;

        case 3:
        {
            
            _coachCarLeasee.address = textField.text;
            
        }
            break;
        case 10:
        {
            _coachCarLeasee.carType = textField.text;
        }
            break;
        case 11:
        {
            _coachCarLeasee.carNum = textField.text;

        }
            break;
        case 12:
        {
            _coachCarLeasee.carAge = textField.text;

        }
            break;
        case 13:
        {
            _coachCarLeasee.carKm = textField.text;
        }
            break;
        case 100:
        {
            _coachCarLeasee.priceDay = textField.text;

        }
            break;
        case 101:
        {
            _coachCarLeasee.priceWeek = textField.text;

        }
            break;
        case 102:
        {
            _coachCarLeasee.priceMonth = textField.text;

        }
            break;
        case 103:
        {
            _coachCarLeasee.priceQuarter = textField.text;

        }
            break;
        case 104:
        {
            _coachCarLeasee.priceYear = textField.text;
 
        }
            break;
            
            
        default:
            break;
    }
    
    
    
    
}
#pragma mark -- textView的代理方法
- (void)textViewDidChange:(UITextView *)textView {
    
    _coachCarLeasee.other = textView.text;
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 ||indexPath.section == 1 || indexPath.section == 2) {
        
        return 50;
    }else {
        
        return 110;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (0 == section) {
        return CGFLOAT_MIN;
    }
    return 50;
}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (0 == section) {
        return nil;
    }else
    {
        
        UIView *headview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidth, 50)];
        
        headview.backgroundColor = RGBColor(247, 247, 247);
        
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(15, 19, 12, 12)];
        
        img.image = [UIImage imageNamed:LeaseHeadImgArrar[section - 1]];
        
        [headview addSubview:img];
        
        UILabel *headtitle = [[UILabel alloc]initWithFrame:CGRectMake(30, 0, 80, 50)];
        
        headtitle.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
        
        headtitle.textColor = [UIColor colorWithHexString:@"#ff6969"];
        
        headtitle.text = LeaseHeadTitleArray[section - 1];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 49, kWidth, 1)];
        line.backgroundColor = [UIColor colorWithHexString:@"#ececec"];
        [headview addSubview:line];
        
        [headview addSubview:headtitle];
        
        return headview;
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (2 == section) {
        
        return 50;
    }if (section == 4) {
        
        return 80;
    }
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (2 == section) {
        
        UIView *footview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidth, 115)];
        
        footview.backgroundColor = [UIColor whiteColor];
        
        UIImageView *icon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tishi"]];
        icon.frame = CGRectMake(15, 10, 12, 12)
        ;
        [footview addSubview:icon];
        
        UILabel *icontitle = [[UILabel alloc]initWithFrame:CGRectMake(30, 0, kWidth - 30 -15, 45)];
        icontitle.numberOfLines = 2;
        NSString *str = @"温馨提示:费用可按天、周、月、季(三个月)、年物种方式计费，可多选设置";
        
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:str];
        
        [attr addAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithHexString:@"#999999"],NSForegroundColorAttributeName, [UIFont fontWithName:@"Helvetica-Bold" size:12.0],NSFontAttributeName,nil] range:NSMakeRange(0, 5)];
        
        [attr addAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithHexString:@"#999999"],NSForegroundColorAttributeName, [UIFont fontWithName:@"Helvetica" size:12.0],NSFontAttributeName,nil] range:NSMakeRange(5, str.length - 5)];
        
        icontitle.attributedText = attr;
        
        [footview addSubview:icontitle];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 49, kWidth, 1)];
        line.backgroundColor = [UIColor colorWithHexString:@"#ececec"];
        [footview addSubview:line];
        
        
        return footview;
    }
    if (section == 4) {
        
        UIView * bgView = [[UIView alloc] init];
        
        UIButton *keep = [[UIButton alloc]init];
        keep.backgroundColor = CommonButtonBGColor;
        keep.layer.cornerRadius = ButtonH/2;
        [keep setTitle:@"保存并发布" forState:UIControlStateNormal];
        [keep setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [keep addTarget:self action:@selector(saveBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:keep];
        [keep mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(20);
            make.right.offset(-20);
            make.centerY.equalTo(bgView);
            make.height.offset(ButtonH);
        }];
        return bgView;
        
    }
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0 && indexPath.row == 2) {
        
//        GroundMapController *map = [[GroundMapController alloc]init];
//        map.delegate = self;
//        [self.navigationController pushViewController:map animated:YES];
        [self.view endEditing:YES];
        
        _pickerView = [OSAddressPickerView shareInstance];
        
        NSArray *addressArr = kProvinceData;
        
        NSMutableArray *dataArray = [NSMutableArray  array];
        
        for (NSData *data in addressArr) {
            ProvinceModel *model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            [dataArray addObject:model];
        }
        _pickerView.dataArray = dataArray;
        
        [_pickerView showBottomView];
        
        [self.view addSubview:_pickerView];
        
        WeakObj(self);
        
        _pickerView.block = ^(ProvinceModel *provinceModel,CityModel *cityModel,CountryModel *districtModel)
        {
            
            selfWeak.coachCarLeasee.provinceId = [NSString stringWithFormat:@"%d",provinceModel.idNum];
            
            selfWeak.coachCarLeasee.cityId = [NSString stringWithFormat:@"%d",cityModel.idNum];
            
            selfWeak.coachCarLeasee.areaId = [NSString stringWithFormat:@"%d",districtModel.idNum];
            
            [selfWeak.table reloadData];
            
        };

        
    }
    if (indexPath.section == 1 && indexPath.row == 0) {
        
        [self.view endEditing:YES];
        
        [_carTypePickView remove];
        
        _carTypePickView = [[ZHPickView alloc] initPickviewWithArray:_carTypeDataArray isHaveNavControler:NO];
        _carTypePickView.delegate = self;
        [_carTypePickView setPickViewColer:[UIColor groupTableViewBackgroundColor]];
        [_carTypePickView show];
    }
    
}
#pragma mark -- ZHPickView的代理方法
- (void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString {
    
    _coachCarLeasee.carType = resultString;
    
    TailorCell * cell = (TailorCell *)[_table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    cell.showValue.text = resultString;
    
}
- (void)getCityModel:(cityModel *)city andWeizhi:(CLLocationCoordinate2D)loc {
    
    TailorCell * cell = (TailorCell *)[_table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    cell.showValue.text = city.address;
    _coachCarLeasee.address = city.address;
    
    _longitude = [NSString stringWithFormat:@"%f",loc.longitude];
    _latitude = [NSString stringWithFormat:@"%f",loc.latitude];
    
    
}
- (void)saveBtnClick {
    

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
        
    
    if (_coachCarLeasee.provinceId.length == 0) {
        [self.hudManager showErrorSVHudWithTitle:@"请选择地址" hideAfterDelay:1.0];
        return;
    }
    if (_coachCarLeasee.carType.length == 0) {
        [self.hudManager showErrorSVHudWithTitle:@"请选择车型" hideAfterDelay:1.0];
        return;
    }
    if (_leftData == nil) {
        [self.hudManager showErrorSVHudWithTitle:@"请上传图片" hideAfterDelay:1.0];
        return;
    }
    
    NSString * url = addCocahCar;
    NSMutableDictionary * paramDict = [NSMutableDictionary dictionary];
    paramDict[@"uid"] = kUid;
    NSString * timeString = self.getcurrentTime;
    paramDict[@"time"] = timeString;
    paramDict[@"sign"] = [HttpsTools getSignWithIdentify:@"/myCarHire/cu" time:timeString];
    if (_isNewAdd) {
        paramDict[@"carHireId"] = @"0";
    }else {
        paramDict[@"carHireId"] = _coachCarLeasee.idStr;
    }
    
    for (CarTypeModel * carType in _carArray) {
        if ([_coachCarLeasee.carType isEqualToString:carType.carName]) {
            
            _coachCarLeasee.carType = carType.carId;
        }
        
    }

    //选传参数
    paramDict[@"tel"] = _coachCarLeasee.tel;
    paramDict[@"provinceId"] = _coachCarLeasee.provinceId;
    paramDict[@"cityId"] = _coachCarLeasee.cityId;
    paramDict[@"areaId"] = _coachCarLeasee.areaId;
    paramDict[@"carTyle"] = _coachCarLeasee.carType;
    paramDict[@"carNum"] = _coachCarLeasee.carNum;
    paramDict[@"carAge"] = _coachCarLeasee.carAge;
    paramDict[@"carKm"] = _coachCarLeasee.carKm;
    paramDict[@"priceDay"] = _coachCarLeasee.priceDay;
    paramDict[@"priceWeek"] = _coachCarLeasee.priceWeek;
    paramDict[@"priceMonth"] = _coachCarLeasee.priceMonth;
    paramDict[@"priceQuarter"] = _coachCarLeasee.priceQuarter;
    paramDict[@"priceYear"] = _coachCarLeasee.priceYear;
    paramDict[@"other"] = _coachCarLeasee.other;
    paramDict[@"address"] =_coachCarLeasee.address;
    paramDict[@"trueName"] = kNickName;
    
    AFHTTPSessionManager *session =  [AFHTTPSessionManager manager];
    session.requestSerializer.timeoutInterval = 30;
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    
    [session POST:url parameters:paramDict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (_leftData) {
            
           [formData appendPartWithFileData:_leftData name:@"pic1" fileName:@"0.png" mimeType:@"image/jpeg"];
        }
        if (_middleData) {
            
            [formData appendPartWithFileData:_middleData name:@"pic2" fileName:@"1.png" mimeType:@"image/jpeg"];
        }
        if (_rightData) {
            
            [formData appendPartWithFileData:_rightData name:@"pic3" fileName:@"2.png" mimeType:@"image/jpeg"];
        }
        

        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        NSLog(@"编辑OR新增教练车租赁%@",responseObject);
        NSInteger code = [responseObject[@"code"] integerValue];
        NSString * msg = responseObject[@"msg"];
        if (code == 1) {
            
            //添加或者编辑成功跳回前一页面,发送通知刷新页面
            [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadMyCoachCar" object:self];
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }else{
            [self.hudManager showErrorSVHudWithTitle:msg hideAfterDelay:1.0f];
        }
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self.hudManager showErrorSVHudWithTitle:@"保存失败" hideAfterDelay:1.0f];
        
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
- (void)UploadCoachCarPicCellDidClickBtnWithBtnType:(UploadCoachCarPicCellBtnType)btnType withBtn:(UIButton *)btn {
    
    [self.view endEditing:YES];
    
    switch (btnType) {
        case UploadCoachCarPicCellLeftBtn:
        {
            _currentBtn = btn;
            
        }
            break;
        case UploadCoachCarPicCellMiddleBtn:
        {
            _currentBtn = btn;
            
        }
            break;
        case UploadCoachCarPicCellRightBtn:
        {
            _currentBtn = btn;
            
        }
            break;
        default:
            break;
    }
    
    
    UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择照片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册中选取",@"拍照", nil];
    
    [actionSheet showInView:self.view];
    
    
    
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) {
        
        //从相册中选取
        UIImagePickerController * imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        [self presentViewController:imagePicker animated:YES completion:nil];
        
        
    }if (buttonIndex == 1) {
        
        //拍照
        UIImagePickerController * imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        [self presentViewController:imagePicker animated:YES completion:nil];
        
    }
    
    
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    UIImage * image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    
    [_currentBtn setImage:image forState:UIControlStateNormal];
    
    
    if (_currentBtn.tag == 1000) {
        
        _leftData = UIImageJPEGRepresentation(image, 0.5);
        _isSelectLeft = YES;
        
        
    }if (_currentBtn.tag == 2000) {
        
        _middleData = UIImageJPEGRepresentation(image, 0.5);
        _isSelectMiddle = YES;
        
        
    }if (_currentBtn.tag == 3000) {
        
        _rightData = UIImageJPEGRepresentation(image, 0.5);
        _isSelectLeft = YES;
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
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
