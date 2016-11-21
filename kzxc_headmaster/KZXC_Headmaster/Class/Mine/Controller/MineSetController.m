//
//  MineSetController.m
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/7/22.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import "MineSetController.h"
#import "TailorCell.h"
#import "HeaderImageCell.h"
#import "ZHPickView.h"
#import "ModifyController.h"
#import "OSAddressPickerView.h"
#import "GroundMapController.h"

@interface MineSetController ()<UITableViewDataSource,UITableViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UIAlertViewDelegate,ZHPickViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,GroundMapControllerDelegate>

@property(weak,nonatomic)UIScrollView *scroll;
@property(strong,nonatomic)UITableView *table;

//pickViewer
@property(nonatomic ,strong)UIPickerView * picker;
@property(nonatomic ,strong)NSArray * province;
@property(nonatomic ,strong)NSDictionary * city;
@property(nonatomic ,strong)NSDictionary * country;
@property (nonatomic,copy) NSString * provinceStr;
@property (nonatomic,copy) NSString * cityStr;
@property (nonatomic,copy) NSString * countryStr;
@property (nonatomic, strong) UIButton *clearBtn;
@property (nonatomic, strong) NSMutableArray * dataPickerArr;

@property (nonatomic, strong) UIAlertView * nickNameAlert;
@property (nonatomic, strong) UITextField * nickNameTF;
@property (nonatomic, strong) UITextField * phoneTF;
@property (nonatomic, strong) ZHPickView * agePickView;
@property (nonatomic, strong) ZHPickView * sexPickView;
@property (nonatomic, strong) UITextField * schoolNameTF;
@property (nonatomic, strong) OSAddressPickerView * pickerview;

@property(nonatomic,copy)NSString * address;

@property(nonatomic,copy)NSString * longtitude;

@property(nonatomic,copy)NSString * latitude;

@property (nonatomic, assign) BOOL isSelected;


@end

@implementation MineSetController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"个人设置";
    

    self.view.backgroundColor = RGBColor(247, 247, 247);
    
    [self setupTable];
}

- (void)setupTable
{
    CGRect tableFream = CGRectMake(0, 10 , kWidth, kHeight - 64);
    UITableView *loctable = [[UITableView alloc]initWithFrame:tableFream style:UITableViewStyleGrouped];
    
    loctable.backgroundColor = [UIColor whiteColor];
//    loctable.scrollEnabled = NO;
    loctable.separatorStyle = UITableViewCellSeparatorStyleNone;
    loctable.dataSource = self;
    loctable.delegate = self;
    loctable.backgroundColor = RGBColor(247, 247, 247);
    self.table = loctable;
    
    [self.view addSubview:loctable];
    [loctable registerNib:[UINib nibWithNibName:@"TailorCell" bundle:nil] forCellReuseIdentifier:@"TailorCell"];
    [loctable registerNib:[UINib nibWithNibName:@"HeaderImageCell" bundle:nil] forCellReuseIdentifier:@"HeaderImageCell"];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return MineSetArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [MineSetArray[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    
    
    if (indexPath.section == 0 ) {
        
        if (indexPath.row == 1) {
            
            static NSString * identifier = @"HeaderImageCell";
            HeaderImageCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
            cell.titleLab.text = @"头像";
            if (!_isSelected) {
                
                [cell.headerImgView sd_setImageWithURL:[NSURL URLWithString:_personalInfo.face] placeholderImage:[UIImage imageNamed:@"tailor_logo"]];
            }

            return cell;
            
        }else {
            static NSString * identifier = @"TailorCell";
            TailorCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];

            switch (indexPath.row) {
                case 0:
                {
                    cell.showKey.text = @"昵称";
                    cell.showValue.text = _personalInfo.nickName;
                }
                    break;
                    
                case 2:
                {
                    cell.showKey.text = @"性别";
                    if ([_personalInfo.sex isEqualToString:@"0"]) {
                        
                        cell.showValue.text = @"女";
                    }else {
                        cell.showValue.text = @"男";
                    }
                }
                    break;
                    
                case 3:
                {
                    cell.showKey.text = @"年龄";
                    cell.showValue.text = _personalInfo.age;
                }
                    break;
                    
                case 4:
                {
                    cell.showKey.text = @"手机号";
                    cell.showValue.text = _personalInfo.phone;
                }
                    break;
                    
                default:
                    break;
            }
            
            
            return cell;
            
            
        }
        
    }
    else {
        
        static NSString * identifier = @"TailorCell";
        TailorCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
        
        switch (indexPath.row) {
            case 0:
            {
                cell.showKey.text = @"驾校";
                cell.showValue.text = _personalInfo.schoolName;
                
            }
                break;
            case 1:
            {

                cell.showKey.text = @"地址";
                
                cell.showValue.text = _personalInfo.addressname;
                
                
            }
                break;
            default:
                break;
        }
        
        
        return cell;
    }
    

}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (1 == section) {
        return 90;
    }
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return CGFLOAT_MIN;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (1 == section) {
        
        UIView *foot = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidth, 90)];
        
        UIButton *keep = [[UIButton alloc]initWithFrame:CGRectMake(20, 26, kWidth - 40, ButtonH)];
        keep.tag = 103;
        [keep addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        keep.backgroundColor = CommonButtonBGColor;
        keep.layer.cornerRadius = ButtonH/2;
        [keep setTitle:@"保存" forState:UIControlStateNormal];
        [keep setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [foot addSubview:keep];
        
        return foot;
    }
    return nil;
}
- (void)click:(UIButton *)sender
{
    
    [self.hudManager showNormalStateSVHUDWithTitle:@"保存中"];
    
    NSString * url = submitMemberInfo;
    NSMutableDictionary * paramDict = [NSMutableDictionary dictionary];
    paramDict[@"uid"] = kUid;
    NSString * timeString = self.getcurrentTime;
    paramDict[@"time"] = timeString;
    paramDict[@"sign"] = [HttpsTools getSignWithIdentify:@"/member/update" time:timeString];
    //修改的参数
    paramDict[@"nickName"] = _personalInfo.nickName;
    paramDict[@"trueName"] = _personalInfo.trueName;
    paramDict[@"address"] = _personalInfo.address;
    paramDict[@"age"] = _personalInfo.age;
    paramDict[@"sex"] = _personalInfo.sex;
    paramDict[@"schoolName"] = _personalInfo.schoolName;
    paramDict[@"phone"] = _personalInfo.phone;
    //地图界面回调回来的经纬度
    paramDict[@"address"] = [NSString stringWithFormat:@"%@,%@",self.latitude,self.longtitude];
    paramDict[@"addressname"] = _personalInfo.addressname;
    
    [HttpsTools POST:url parameter:paramDict progress:^(NSProgress *downloadProgress) {
    } succeed:^(id responseObject) {
        NSLog(@"保存个人设置%@",responseObject);
        NSInteger code = [responseObject[@"code"] integerValue];
        NSString * msg = responseObject[@"msg"];
        if (code == 1) {
            
            [self.hudManager showSuccessSVHudWithTitle:@"保存成功" hideAfterDelay:2.0 animaton:YES];

            
        }else {
            
            [self.hudManager showErrorSVHudWithTitle:msg hideAfterDelay:1.0];
        }
        
    } failure:^(NSError *error) {
        
        [self.hudManager showErrorSVHudWithTitle:@"保存失败" hideAfterDelay:1.0];
        
    }];
    
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //wengchangqing
//    if (indexPath.section == 1 && indexPath.row == 0) {
//        [self chooseAddress];
//    }
    
    [_agePickView remove];
    [_sexPickView remove];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            //修改昵称
            _nickNameAlert = [[UIAlertView alloc] initWithTitle:@"修改昵称" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [_nickNameAlert setAlertViewStyle:UIAlertViewStylePlainTextInput];
            
            _nickNameAlert.tag = 1000;
            
            [_nickNameAlert show];
            
        }
        if (indexPath.row == 1) {
            //修改头像
            // _lastSelectCell = indexPath.row;
            UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择照片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册中选取",@"拍照", nil];
            [actionSheet showInView:self.view];
            
            
        }
        if (indexPath.row == 2) {
            //修改性别
            NSArray * sexArray = [NSArray arrayWithObjects:@"男",@"女", nil];
            _sexPickView = [[ZHPickView alloc] initPickviewWithArray:sexArray isHaveNavControler:NO];
            _sexPickView.tag = 200;
            _sexPickView.delegate = self;
            [_sexPickView setPickViewColer:[UIColor groupTableViewBackgroundColor]];
            [_sexPickView show];
            
            
        }
        if (indexPath.row == 3) {
            //修改年龄
            NSMutableArray * ageArray = [NSMutableArray array];
            for (int i = 0; i < 101; i++) {
                
                [ageArray addObject:[NSString stringWithFormat:@"%d",i]];
                
            }
            _agePickView = [[ZHPickView alloc] initPickviewWithArray:ageArray isHaveNavControler:NO];
            _agePickView.tag = 300;
            _agePickView.delegate = self;
            [_agePickView setPickViewColer:[UIColor groupTableViewBackgroundColor]];
            [_agePickView show];

            
            
        }
        if (indexPath.row == 4) {
            //修改手机号
            ModifyController * vc = [[ModifyController alloc] init];
            vc.isPersonalSetting = YES;
            [self.navigationController pushViewController:vc animated:YES];
            

        }
        
    }else {
        
        if (indexPath.row == 0) {
            
            UIAlertView * schoolAlert = [[UIAlertView alloc] initWithTitle:@"驾校名称" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            schoolAlert.alertViewStyle = UIAlertViewStylePlainTextInput;
            schoolAlert.tag = 1001;
            
            [schoolAlert show];
            
            
        }else {
            
            //修改地址
            GroundMapController *map = [[GroundMapController alloc]init];
            map.delegate = self;
            [self.navigationController pushViewController:map animated:YES];
        }
        
    }

    
}
-(void)getCityModel:(cityModel *)city andWeizhi:(CLLocationCoordinate2D)loc
{
    _personalInfo.addressname = city.name;
    
    self.address = city.name;
    
    self.latitude = [NSString stringWithFormat:@"%f",loc.latitude];
    
    self.longtitude = [NSString stringWithFormat:@"%f",loc.longitude];
    
    [self.table reloadData];
    
    
    
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) {
        //从相册选取
        UIImagePickerController * imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        [self presentViewController:imagePicker animated:YES completion:nil];
       
        
    }
    if (buttonIndex == 1) {
        //拍照
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
    
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    UIImage * image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
    HeaderImageCell * cell = (HeaderImageCell *)[_table cellForRowAtIndexPath:indexPath];
    cell.headerImgView.image = image;
    
    [self requestDataWithImage:image];
    
    [self dismissViewControllerAnimated:YES completion:nil];

}
- (void)requestDataWithImage:(UIImage *)image {
    
    [self.hudManager showNormalStateSVHUDWithTitle:nil];
    
    NSMutableDictionary * paramDic = [NSMutableDictionary dictionary];
    paramDic[@"uid"] = kUid;
    NSString * timeStr = [HttpParamManager getTime];
    paramDic[@"time"] = timeStr;
    paramDic[@"sign"] = [HttpParamManager getSignWithIdentify:@"/userPics" time:timeStr];
    paramDic[@"deviceInfo"] = [HttpParamManager getDeviceInfo];
    
//    UIImageJPEGRepresentation(image, 0.1)
    [HJHttpManager UploadFileWithUrl:uploadHeader param:paramDic serviceName:@"pics" fileName:@"0.png" mimeType:@"image/jpeg" fileData:UIImageJPEGRepresentation(image, 0.5) finish:^(NSData *data) {
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@"个人设置上传头像%@",dict);
        NSInteger code = [dict[@"code"] integerValue];
        NSString * msg = dict[@"msg"];
        if (code == 1) {
            
            _isSelected = YES;
            
            [self.hudManager showSuccessSVHudWithTitle:@"保存成功" hideAfterDelay:1.0 animaton:YES];
            
            
//            [self dismissViewControllerAnimated:YES completion:nil];
            
        }else {
            [self.hudManager showErrorSVHudWithTitle:msg hideAfterDelay:1.0f];
        }
        
        
    } failed:^(NSError *error) {
        
        [self.hudManager showErrorSVHudWithTitle:@"上传失败" hideAfterDelay:1.0f];
        
    }];

    
}
#pragma mark -- alertView的代理方法
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 1000) {
        if (buttonIndex == 1) {
            _nickNameTF = [alertView textFieldAtIndex:0];
            _personalInfo.nickName = _nickNameTF.text;
            
            [curDefaults setObject:_personalInfo.nickName forKey:@"kNickName"];
            
            NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
            [self.table reloadRowAtIndexPath:indexPath withRowAnimation:UITableViewRowAnimationNone];
            
        }
        
    }
    if (alertView.tag == 1001) {
        
        if (buttonIndex == 1) {
            
            _schoolNameTF = [alertView textFieldAtIndex:0];
            _personalInfo.schoolName = _schoolNameTF.text;
            
            NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:1];
            [self.table reloadRowAtIndexPath:indexPath withRowAnimation:UITableViewRowAnimationNone];
        }
    }

    
    
}

#pragma mark --  ZHPickView的代理方法
- (void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString {
    
    if (pickView.tag == 300) {
        
        _personalInfo.age = resultString;
        
        [_table reloadData];
        
    }
    if (pickView.tag == 200) {
        
        if ([resultString isEqualToString:@"女"]) {
            _personalInfo.sex = @"0";
        }else {
            _personalInfo.sex = @"1";
        }
        
        TailorCell * cell = (TailorCell *)[self.table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
        cell.showValue.text = resultString;
        
    }
    
    
}


/*  以下是pikerView的所有方法 */

- (void)chooseAddress
{
    NSURL * fileUrl = [[NSBundle mainBundle] URLForResource:@"city" withExtension:@"json"];
    NSData * jsonData = [[NSData alloc] initWithContentsOfURL:fileUrl];
    NSMutableDictionary * persons = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    _dataPickerArr = persons[@"citylist"];
    
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIButton *clearBtn = [[UIButton alloc] init];
    clearBtn.frame = CGRectMake(0, 64, kWidth, kHeight);
    clearBtn.backgroundColor = [UIColor colorWithRed:25/255.0 green: 25/255.0 blue:25/255.0 alpha:0.5];
    //    clearBtn.backgroundColor = [UIColor brownColor];
    [window addSubview:clearBtn];
    [clearBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.clearBtn = clearBtn;
    
    UIView *lineView = [[UIView alloc] init];
    [clearBtn addSubview:lineView];
    lineView.frame = CGRectMake(0, kHeight - 238 - 44 - 40-20, kWidth, 40);
    lineView.backgroundColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1];
    
    UIButton *cancelBtn = [[UIButton alloc] init];
    cancelBtn.frame = CGRectMake(0, 0, 100, 40);
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = Font16;
    [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [lineView addSubview:cancelBtn];
    [cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *ensureBtn = [[UIButton alloc] init];
    ensureBtn.frame = CGRectMake(kWidth - 100, 0, 100, 40);
    [ensureBtn setTitle:@"确定" forState:UIControlStateNormal];
    ensureBtn.titleLabel.font = Font16;
    [ensureBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [lineView addSubview:ensureBtn];
    [ensureBtn addTarget:self action:@selector(ensureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    _picker = [[UIPickerView alloc]initWithFrame:CGRectMake(0, kHeight-238-44-20, kWidth, 300)];
    [clearBtn addSubview:_picker];
    
    _picker.dataSource = self;
    _picker.delegate = self;
    //    _picker.hidden = YES;
    _picker.backgroundColor = RGBColor(242, 242, 242);
    _picker.showsSelectionIndicator=YES;
    
    
    _province = [[NSArray alloc]init];
    _city = [[NSDictionary alloc]init];
    _country = [[NSDictionary alloc]init];
    
}

- (void)ensureBtnClick{
    NSInteger rowOne = [_picker selectedRowInComponent:0];
    NSInteger rowTow = [_picker selectedRowInComponent:1];
    NSInteger rowThree = [_picker selectedRowInComponent:2];
    NSString * provinceName = [_dataPickerArr[rowOne] objectForKey:@"p"];
    
    NSDictionary *provinceDic = _dataPickerArr[rowOne];
    NSArray * arr = provinceDic[@"c"];
    NSMutableArray * cityArr = [[NSMutableArray alloc] init];
    
    NSMutableArray * countryArr = [[NSMutableArray alloc] init];
    if ([[arr[rowTow] allKeys] containsObject:@"a"]){
        [arr enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [cityArr addObject:obj[@"n"]];
        }];
        
        NSArray * detailArr = [arr[rowTow] objectForKey:@"a"];
        [detailArr enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [countryArr addObject:obj[@"s"]];
        }];
    }else{
        [arr enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [cityArr addObject:obj[@"n"]];
        }];
    }
    
    NSString * string = [[NSString alloc] init];
    if ([[arr[rowTow] allKeys] containsObject:@"a"]) {
        string = [NSString stringWithFormat:@"%@%@%@",provinceName,cityArr[rowTow],countryArr[rowThree]];
        _provinceStr = provinceName;
        _cityStr = cityArr[rowTow];
        _countryStr = countryArr[rowThree];
    }else{
        string = [NSString stringWithFormat:@"%@%@市%@",provinceName,provinceName,cityArr[rowThree]];
        _provinceStr = provinceName;
        _cityStr = provinceName;
        _countryStr = cityArr[rowThree];
    }
//    [_pickerBtn setTitle:string forState:UIControlStateNormal];
    [self.clearBtn removeFromSuperview];
}

- (void)cancelBtnClick{
    
    [self.clearBtn removeFromSuperview];
}


#pragma mark - 该方法的返回值决定该控件包含多少列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView
{
    return 3;
}
#pragma mark - 该方法的返回值决定该控件指定列包含多少个列表项
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0)
    {
        return _dataPickerArr.count;
        
    }else if (component == 1) {
        
        NSInteger rowProvince = [pickerView selectedRowInComponent:0];
        NSDictionary *provinceDic = _dataPickerArr[rowProvince];
        NSArray * arr = provinceDic[@"c"];
        
        NSMutableArray * cityArr = [[NSMutableArray alloc] init];
        [arr enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [cityArr addObject:obj[@"n"]];
        }];
        
        NSInteger count = 0;
        for (int i = 0; i<arr.count; i++) {
            if ([[arr[i] allKeys] containsObject:@"a"]) {
                count = cityArr.count;
            }else{
                count = 1;
            }
        }
        return count;
        
    }else{
        
        NSInteger rowProvince = [pickerView selectedRowInComponent:0];
        NSDictionary *provinceDic = _dataPickerArr[rowProvince];
        NSArray * arr = provinceDic[@"c"];
        
        NSInteger rowCity = [pickerView selectedRowInComponent:1];
        NSMutableArray * cityArr = [[NSMutableArray alloc] init];
        NSMutableArray * countryArr = [[NSMutableArray alloc] init];
        
        if ([[arr[rowCity] allKeys] containsObject:@"a"]){
            NSArray * detailArr = [arr[rowCity] objectForKey:@"a"];
            [detailArr enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [countryArr addObject:obj[@"s"]];
            }];
        }else{
            [arr enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [cityArr addObject:obj[@"n"]];
            }];
        }
        
        if ([[arr[rowCity] allKeys] containsObject:@"a"]) {
            return countryArr.count;
        }else{
            return cityArr.count;
        }
        
    }
}


#pragma mark - 该方法返回的NSString将作为UIPickerView中指定列和列表项的标题文本
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) {
        return [_dataPickerArr[row] objectForKey:@"p"];
        
    }else if(component == 1){
        NSInteger rowProvince = [pickerView selectedRowInComponent:0];
        NSDictionary *provinceDic = _dataPickerArr[rowProvince];
        NSArray * arr = provinceDic[@"c"];
        
        NSMutableArray * cityArr = [[NSMutableArray alloc] init];
        NSString * cityName = [[NSString alloc]init];
        [arr enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [cityArr addObject:obj[@"n"]];
        }];
        
        for (int i = 0; i<arr.count; i++) {
            if ([[arr[i] allKeys] containsObject:@"a"]) {
                cityName = cityArr[row];
            }else{
                cityName = [NSString stringWithFormat:@"%@市",provinceDic[@"p"]];
            }
        }
        return cityName;
        
    }else{
        
        NSInteger rowProvince = [pickerView selectedRowInComponent:0];
        NSDictionary *provinceDic = _dataPickerArr[rowProvince];
        NSArray * arr = provinceDic[@"c"];
        
        NSInteger rowCity = [pickerView selectedRowInComponent:1];
        NSMutableArray * cityArr = [[NSMutableArray alloc] init];
        NSMutableArray * countryArr = [[NSMutableArray alloc] init];
        
        if ([[arr[rowCity] allKeys] containsObject:@"a"]){
            NSArray * detailArr = [arr[rowCity] objectForKey:@"a"];
            [detailArr enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [countryArr addObject:obj[@"s"]];
            }];
        }else{
            [arr enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [cityArr addObject:obj[@"n"]];
            }];
        }
        
        if ([[arr[rowCity] allKeys] containsObject:@"a"]) {
            return countryArr[row];
        }else{
            return cityArr[row];
        }
    }
}

//当选中某行时，通过如下的代码即可获取到选中的城市地区，
#pragma mark - 当用户选中UIPickerViewDataSource中指定列和列表项时激发该方法
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if(component == 0){
        [pickerView reloadComponent:1];
        [pickerView reloadComponent:2];
    }
    if(component == 1)
        [pickerView reloadComponent:2];
    
}

@end
