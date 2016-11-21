//
//  PersonalTailorController.m
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/7/14.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import "PersonalTailorController.h"
#import "TailorCell.h"
#import "UIColor+Hex.h"
#import "TailorPlaceCell.h"
#import "TailorUploadCell.h"
#import "ClasstypeCell.h"
#import "ClassTypeModel.h"
#import "TinyCardModel.h"
#import "GroundMapController.h"
#import "WMPPopView.h"
#import "ProvinceModel.h"
#import "CityModel.h"

@interface PersonalTailorController ()<UITableViewDataSource,UITableViewDelegate,TailorUploadCellDelegate,TailorPlaceCellDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,GroundMapControllerDelegate,WMPPopViewDelegate,ClasstypeCellDelegate,UIAlertViewDelegate>
{
    NSMutableArray *classArr;
    ProvinceModel * _provinceModel;
    CityModel * _cityModel;
    NSString * _provinceStr;
    NSString * _cityStr;
}
@property(strong,nonatomic)UITableView *table;

@property(strong,nonatomic)UIAlertController *alert;
@property (nonatomic, strong) UIImageView *logo ;
@property (nonatomic, strong) TinyCardModel * tinyCard ;
@property (nonatomic, strong) UIButton * currentBtn;
@property (nonatomic, assign) BOOL  isHeader;
@property (nonatomic, assign) BOOL  isHeadModify;
@property (nonatomic, strong) UIImage * image;

@property(nonatomic,copy)NSString * address;

@property(nonatomic,copy)NSString * longtitude;

@property(nonatomic,copy)NSString * latitude;

@property(nonatomic,assign)BOOL pic1Modify;

@property(nonatomic,assign)BOOL pic2Modify;

@property(nonatomic,assign)BOOL pic3Modify;

@property(nonatomic,strong)UIImage * pic1;

@property(nonatomic,strong)UIImage * pic2;

@property(nonatomic,strong)UIImage * pic3;

@property(nonatomic,strong)UIImagePickerController * picker1;

@property(nonatomic,strong)UIImagePickerController * picker2;

@property(nonatomic,strong)UIImagePickerController * picker3;

@property(nonatomic,strong)TinyClassesModel * currentInfoModel;

@property (nonatomic, strong) NSMutableArray * dataArray;//用于存放省份的数组

@end

@implementation PersonalTailorController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"编辑";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f7f7f7"];
    _dataArray = [NSMutableArray array];
    
    classArr = [NSMutableArray array];
    
    UIView *bg = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidth, 60+ButtonH)];
    UIButton *keepButton = [[UIButton alloc]init];
    keepButton.backgroundColor = CommonButtonBGColor;
    keepButton.layer.cornerRadius = ButtonH/2;
    [keepButton setTitle:@"保存" forState:UIControlStateNormal];
    [keepButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [keepButton addTarget:self action:@selector(keepButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [bg addSubview:keepButton];
    [keepButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(@20);
        make.left.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(kWidth - 40, ButtonH));
    }];
    [bg addSubview:keepButton];
    
    _table = [[UITableView alloc]init];
    _table.tableFooterView = bg;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.dataSource = self;
    _table.delegate = self;
    [self.view addSubview:_table];
    [_table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(kWidth,kHeight - 64));
    }];
    //[_table registerNib:[UINib nibWithNibName:@"TailorCell" bundle:nil] forCellReuseIdentifier:@"TailorCell"];
    
    [self loadData];
}
-(void)tailorPlaceCellTapImageViewWithSelf:(TailorPlaceCell *)cell index:(int)index
{
    //上传logo
    UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择照片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册中选取",@"拍照", nil];
    actionSheet.tag = 200+index;
    [actionSheet showInView:self.view];
    


}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (0 == section) {
        return  personTailorArr.count;
    }
    if (1 == section) {
        return _tinyCard.classes.count;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSInteger row = indexPath.row;
    NSInteger sec = indexPath.section;
    static NSString *cell1Str = @"TailorCell";
    static NSString *cell2Str = @"placecell";
    static NSString *cell3Str = @"uploadcell";
    static NSString *cell4Str = @"classtypeCell";
    
    if (0 == sec) {
        TailorCell *tailorcell = [tableView dequeueReusableCellWithIdentifier:cell1Str ];
        if (!tailorcell) {
            tailorcell = [[NSBundle mainBundle] loadNibNamed:@"TailorCell" owner:nil options:nil].firstObject;
        }
        
        
            tailorcell.selectionStyle = UITableViewCellSelectionStyleNone;
            tailorcell.showKey.text = personTailorArr[row];
            if (1 == row) {

                tailorcell.logoImageView.hidden = NO;
                
                tailorcell.showValue.alpha = 0;
                
                _logo = tailorcell.logoImageView;
                   

                if (_isHeadModify) {
                    
                    tailorcell.logoImageView.image = _image;
                    
                }else
                {
                    [tailorcell.logoImageView sd_setImageWithURL:[NSURL URLWithString:_tinyCard.School.logo] placeholderImage:[UIImage imageNamed:@"placeHeader"]];
                }
                
          
            }else
            {
                
                tailorcell.logoImageView.hidden = YES;

                if (row == 2 || row == 6 ) {
                     tailorcell.showValue.enabled = NO;
                }else {
                  tailorcell.showValue.enabled = YES;
                }
                if (row == 10) {
                    tailorcell.showValue.text = @"新增";
                    tailorcell.showValue.enabled = NO;
                }else
                {
                    tailorcell.showValue.hidden = NO;
                }
                switch (indexPath.row) {
                    case 0:
                    {
                        tailorcell.showValue.text = _tinyCard.School.schoolName;
                    }
                        break;
                    case 2:
                    {
                        tailorcell.showValue.text = _tinyCard.School.addressName;
                    }
                        break;
                    case 3:
                    {
                        tailorcell.showValue.keyboardType = UIKeyboardTypePhonePad;
                        tailorcell.showValue.text = _tinyCard.School.age;
                    }
                        break;
                    case 4:
                    {
                        tailorcell.showValue.keyboardType = UIKeyboardTypePhonePad;
                        tailorcell.showValue.text = _tinyCard.School.size;
                    }
                        break;
                    case 5:
                    {
                        tailorcell.showValue.keyboardType = UIKeyboardTypePhonePad;
                        tailorcell.showValue.text = _tinyCard.School.carNum;
                    }
                        break;
                    case 6:
                    {
                        tailorcell.showValue.text = _tinyCard.School.memo;
                    }
                        break;
                    case 7:
                    {
                        tailorcell.showValue.keyboardType = UIKeyboardTypePhonePad;
                        tailorcell.showValue.text = _tinyCard.School.average;
                    }
                        break;
                    case 8:
                    {
                        tailorcell.showValue.keyboardType = UIKeyboardTypePhonePad;
                        tailorcell.showValue.text = _tinyCard.School.percent2;
                    }
                        break;
                    case 9:
                    {
                        tailorcell.showValue.keyboardType = UIKeyboardTypePhonePad;
                        tailorcell.showValue.text = _tinyCard.School.percent3;
                    }
                        break;
                        
                    default:
                        break;
                }
                tailorcell.showValue.tag = indexPath.row;
                
               [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChanged:) name:UITextFieldTextDidChangeNotification object:tailorcell.showValue];
            }
        
        
        return tailorcell;
    }
    
    if (1 == sec) {
        ClasstypeCell *classcell = [tableView dequeueReusableCellWithIdentifier:cell4Str];
        if (!classcell) {
            classcell = [[NSBundle mainBundle] loadNibNamed:@"ClasstypeCell" owner:nil options:nil].firstObject;
            classcell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        TinyClassesModel *model = _tinyCard.classes[indexPath.row];
    
        
        classcell.model = model;
        
        classcell.row = indexPath.row;
        
//        if ([model.classId isEqualToString:@"0"]) {
//            [classcell.leftBtn setTitle:@"删除" forState:UIControlStateNormal];
//        }
//        else
//        {
            [classcell.leftBtn setTitle:@"修改" forState:UIControlStateNormal];
//        }
        
        classcell.delegate = self;
        
        return classcell;
    }
    if (2 == sec)
    {
        TailorPlaceCell *placecell = [tableView dequeueReusableCellWithIdentifier:cell2Str];
        if (!placecell) {
            placecell = [[NSBundle mainBundle] loadNibNamed:@"TailorPlaceCell" owner:nil options:nil].firstObject;
            placecell.delegate = self;
            placecell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        placecell.delegate = self;
        
        if (self.pic1Modify) {
            UIImageView *imageView = placecell.imageviewArray[0];
            imageView.image = self.pic1;
        }
        else
        {
            UIImageView *imageView = placecell.imageviewArray[0];
            [imageView sd_setImageWithURL:[NSURL URLWithString:self.tinyCard.School.userPic1] placeholderImage:[UIImage imageNamed:@"placeholder"]];

        }
        if (self.pic2Modify) {
            UIImageView *imageView = placecell.imageviewArray[1];
            imageView.image = self.pic2;
        }
        else
        {
            UIImageView *imageView = placecell.imageviewArray[1];
            [imageView sd_setImageWithURL:[NSURL URLWithString:self.tinyCard.School.userPic2] placeholderImage:[UIImage imageNamed:@"placeholder"]];
            
        }
        if (self.pic3Modify) {
            UIImageView *imageView = placecell.imageviewArray[2];
            imageView.image = self.pic3;
        }
        else
        {
            UIImageView *imageView = placecell.imageviewArray[2];
            [imageView sd_setImageWithURL:[NSURL URLWithString:self.tinyCard.School.userPic3] placeholderImage:[UIImage imageNamed:@"placeholder"]];
            
        }
        
        return placecell;
    }
    if (3 == sec)
    {
        TailorUploadCell *uploadcell = [tableView dequeueReusableCellWithIdentifier:cell3Str];
        if (!uploadcell) {
            uploadcell = [[NSBundle mainBundle] loadNibNamed:@"TailorUploadCell" owner:nil options:nil].firstObject;
            uploadcell.delegate = self;
            uploadcell.selectionStyle = UITableViewCellSelectionStyleNone;
            uploadcell.cerArray = @[@"tailor_upload_exp1",@"tailor_upload_exp1",@"tailor_upload_exp1"];
        }
        return uploadcell;
    }
    return nil;
}
-(void)classtypeCell:(ClasstypeCell *)cell didClickDeleteBtnModel:(TinyClassesModel *)model
{
    if ([cell.leftBtn.titleLabel.text isEqualToString:@"删除"]) {
        if (self.tinyCard.classes.count == 1) {
            UIAlertView *alertView =[[UIAlertView alloc]initWithTitle:@"至少选一个班型" message:nil delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
            [alertView show];
            return;
        }
        
        [self.tinyCard.classes removeObject:model];
        
        [self.table reloadData];
    }
    else
    {
        
        WMPPopView *pop = [WMPPopView PopViewWithTable];
        pop.delegate = self;
        pop.row = cell.row;
        pop.classesModel = cell.model;
        [pop showTable];
        
        
    }

}
- (void)textFieldChanged:(NSNotification *)notification {
    
    UITextField *textField = (UITextField *)[notification object];
    textField.textColor = [UIColor colorWithHexString:@"#333333"];
    switch (textField.tag) {
        case 0:
        {
            _tinyCard.School.schoolName = textField.text;

        }
            break;
        case 2:
        {
            _tinyCard.School.addressName = textField.text;
        }
            break;
        case 3:
        {
            _tinyCard.School.age =textField.text;
        }
            break;
        case 4:
        {
            _tinyCard.School.size = textField.text;
        }
            break;
        case 5:
        {
            _tinyCard.School.carNum = textField.text;
        }
            break;
        case 6:
        {
            _tinyCard.School.memo = textField.text;
            
        }
            break;
        case 7:
        {
            _tinyCard.School.average = textField.text;
        }
            break;
        case 8:
        {
            _tinyCard.School.percent2 = textField.text;
        }
            break;
        case 9:
        {
            _tinyCard.School.percent3 = textField.text;
            
        }
            break;
            
        default:
            break;
    }
    
    
    
    
    
}
#pragma mark -- 获取详细地址和经纬度的代理方法
-(void)getCityModel:(cityModel *)city andWeizhi:(CLLocationCoordinate2D)loc
{
    _tinyCard.School.addressName = city.name;
    
    self.address = city.name;
    
    self.latitude = [NSString stringWithFormat:@"%f",loc.latitude];
    
    self.longtitude = [NSString stringWithFormat:@"%f",loc.longitude];
    
    [self.table reloadData];

    
    CLLocation *location = [[CLLocation alloc] initWithLatitude:loc.latitude longitude:loc.longitude];
    
    // 获取当前所在的城市名
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    //根据经纬度反向地理编译出地址信息
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *array, NSError *error)
     {
         if (array.count > 0)
         {
             CLPlacemark *placemark = [array objectAtIndex:0];
             NSLog(@"\n name:%@\n  country:%@\n postalCode:%@\n ISOcountryCode:%@\n ocean:%@\n inlandWater:%@\n locality:%@\n subLocality:%@\n administrativeArea:%@\n subAdministrativeArea:%@\n thoroughfare:%@\n subThoroughfare:%@\n",
                   placemark.name,
                   placemark.country,
                   placemark.postalCode,
                   placemark.ISOcountryCode,
                   placemark.ocean,
                   placemark.inlandWater,
                   placemark.administrativeArea,
                   placemark.subAdministrativeArea,
                   placemark.locality,
                   placemark.subLocality,
                   placemark.thoroughfare,
                   placemark.subThoroughfare
                   
                );
             
             //获取省份
             _provinceStr = placemark.administrativeArea;
             //获取城市
             _cityStr = placemark.locality;

             NSArray *addressArr = kProvinceData;
             //NSMutableArray *dataArray = [NSMutableArray  array];
             for (NSData *data in addressArr) {
                 ProvinceModel *model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
                 [_dataArray addObject:model];
             }

             for (ProvinceModel * provinceModel in _dataArray) {
                 if ([_provinceStr isEqualToString:provinceModel.name]) {

                     _tinyCard.School.provinceId = [NSString stringWithFormat:@"%d",provinceModel.idNum] ;
                     _provinceModel = provinceModel;
                     
                     break;
                 }
                 
             }
            
              NSLog(@"city ====%@====%@", _cityStr,placemark.administrativeArea);
             if (!_cityStr) {
                 //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                 _cityStr = placemark.administrativeArea;
                 
             }
             
             for (CityModel * cityModel in _provinceModel.citys) {
                 
                 if ([_cityStr isEqualToString:cityModel.name]) {
                     
                     _tinyCard.School.cityId = [NSString stringWithFormat:@"%d",cityModel.idNum];
                     
                     break;
                 }
             }
             
         }
         else if (error == nil && [array count] == 0)
         {
             NSLog(@"No results were returned.");
         }
         else if (error != nil)
         {
             NSLog(@"An error occurred = %@", error);
         }
     }];





}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    
    NSInteger sec = indexPath.section;

    if (2 == row && 0 == sec) {
        
        [self.view endEditing:YES];
        
        GroundMapController *map = [[GroundMapController alloc]init];
        map.delegate = self;
        [self.navigationController pushViewController:map animated:YES];
    }
    
    if (6 == row && 0 == sec) {
//        PopView *pop = [PopView PopViewWithIntroduce];
//        [pop showIntroduce];
        
        [self.view endEditing:YES];
        
        WMPPopView *pop = [WMPPopView PopViewWithIntroduce];
        pop.delegate = self;
        
        [pop showIntroduce];
    }
    
    if (10 == row && 0 == sec) {
//        PopView *pop = [PopView PopViewWithTable];
//        [pop showTable];
        
        [self.view endEditing:YES];
        WMPPopView *pop = [WMPPopView PopViewWithTable];
        pop.delegate = self;
        pop.classesModel = nil;
        pop.row = -1;
        [pop showTable];
    }
    if (sec == 0 && row == 1) {
        
        [self.view endEditing:YES];
        //上传logo
        UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择照片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册中选取",@"拍照", nil];
        [actionSheet showInView:self.view];
        
        
    }
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (actionSheet.tag == 200) {
        if (buttonIndex == 0) {
            //从相册选取
            UIImagePickerController * imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            imagePicker.delegate = self;
            self.picker1 = imagePicker;
            imagePicker.allowsEditing = YES;
            [self presentViewController:imagePicker animated:YES completion:nil];
            
            
        }
        if (buttonIndex == 1) {
            //拍照
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePicker.delegate = self;
            self.pic1Modify = YES;
            self.picker1 = imagePicker;
            imagePicker.allowsEditing = YES;
            [self presentViewController:imagePicker animated:YES completion:nil];
        }
        
        return;
        

    }
    if (actionSheet.tag == 201) {
        if (buttonIndex == 0) {
            //从相册选取
            UIImagePickerController * imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            imagePicker.delegate = self;
            self.picker2 = imagePicker;

            imagePicker.allowsEditing = YES;
            [self presentViewController:imagePicker animated:YES completion:nil];
            
            
        }
        if (buttonIndex == 1) {
            //拍照
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePicker.delegate = self;
            self.pic2Modify = YES;
            self.picker2 = imagePicker;
            imagePicker.allowsEditing = YES;
            [self presentViewController:imagePicker animated:YES completion:nil];
        }
        
        return;
        
        
    }
    if (actionSheet.tag == 202) {
        if (buttonIndex == 0) {
            //从相册选取
            UIImagePickerController * imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            imagePicker.delegate = self;
            
            self.picker3 = imagePicker;

            imagePicker.allowsEditing = YES;
            [self presentViewController:imagePicker animated:YES completion:nil];
            
            
        }
        if (buttonIndex == 1) {
            //拍照
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePicker.delegate = self;
            self.pic3Modify = YES;
            self.picker3 = imagePicker;

            imagePicker.allowsEditing = YES;
            [self presentViewController:imagePicker animated:YES completion:nil];
        }
        
        return;
        
        
    }
    if (buttonIndex == 0) {
        //从相册选取
        UIImagePickerController * imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.delegate = self;
        _isHeader = YES;
        imagePicker.allowsEditing = YES;
        [self presentViewController:imagePicker animated:YES completion:nil];
        
        
    }
    if (buttonIndex == 1) {
        //拍照
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.delegate = self;
        _isHeader = YES;
        imagePicker.allowsEditing = YES;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
    
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    UIImage * image = [info objectForKey:@"UIImagePickerControllerEditedImage"];

    if (_isHeader) {
        _logo.image = image;
        _image = image;
        
        _isHeadModify =YES;
 
    }
    
    if (picker == self.picker1) {
        self.pic1Modify = YES;
        
        if (self.pic1Modify) {
            self.pic1 = image;
        }
    }
    if (picker == self.picker2) {
        self.pic2Modify = YES;
        if (self.pic2Modify) {
            self.pic2 = image;
        }
    }
    if (picker == self.picker3) {
        self.pic3Modify = YES;
        if (self.pic3Modify) {
            self.pic3 = image;
        }
    }

    [self.table reloadData];
   
   [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    CGFloat footerHeight = 15;
    if (0 == section) {
        return 0;
    }
    if (3 == section) {
        footerHeight = 0;
    }
    
    return footerHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat cellHeight;
    NSInteger sec = indexPath.section;
    if (0 == sec) {
        cellHeight = 50;
    }else if (1 == sec)
    {
        cellHeight = 40;
    }
    else if (2 == sec){
        cellHeight = 155;
    }
    else if (3 == sec)
    {
        cellHeight = 310;
    }
    
    return cellHeight;
}


-(void)tailorUploadCellWithIndex:(NSInteger)index currentBtn:(UIButton *)currentBtn
{
    
    UIAlertController *aa = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *act1 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        
        imagePicker.delegate = self;
        _isHeader = NO;
        imagePicker.allowsEditing = YES;
        [self presentViewController:imagePicker animated:YES completion:nil];
        
    }];
    
    [aa addAction:act1];
    
    UIAlertAction *act2 = [UIAlertAction actionWithTitle:@"从相册中选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UIImagePickerController * imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        imagePicker.delegate = self;
        _isHeader = NO;
        _currentBtn = currentBtn;
        imagePicker.allowsEditing = YES;
        [self presentViewController:imagePicker animated:YES completion:nil];
        
        
    }];
    [aa addAction:act2];
    
    UIAlertAction *act3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [aa addAction:act3];
    
    [self presentViewController:aa animated:YES completion:nil];

}

- (void)tailorPlaceCellWithSelf:(TailorPlaceCell *)cell
{
    UIAlertController *aa = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *act1 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [aa addAction:act1];
    
    UIAlertAction *act2 = [UIAlertAction actionWithTitle:@"从相册中选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [aa addAction:act2];
    
    UIAlertAction *act3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [aa addAction:act3];
    
    [self presentViewController:aa animated:YES completion:nil];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (1 == buttonIndex) {
        [self keepmsg];
        
        [self.hudManager showNormalStateSVHUDWithTitle:@"保存中"];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.hudManager dismissSVHud];
             [self.navigationController popViewControllerAnimated:YES];
        });
        
       
    }
}
#pragma mark -- 微名片编辑
- (void)keepButtonClick
{
    NSString *temp1 = _tinyCard.School.schoolName;
    NSString *temp2 = _tinyCard.School.age;
    NSString *temp3 = _tinyCard.School.size;
    NSString *temp4 = _tinyCard.School.carNum;
    NSString *temp5 = _tinyCard.School.memo;
    NSString *temp6 = _tinyCard.School.average;
    NSString *temp7 = _tinyCard.School.percent2;
    NSString *temp8 = _tinyCard.School.percent3;
    
    if (0 == temp1.length) {
        [MBProgressHUD showError:@"请输入驾校名称"];
        return;
    }
    
    if (0 == _tinyCard.School.addressName.length) {
        [MBProgressHUD showError:@"请输入地址"];
        return;
    }
    if (0 == temp2.length) {
        [MBProgressHUD showError:@"请输入年限"];
        return;
    }
    if (0 == temp3.length) {
        [MBProgressHUD showError:@"请输入场地规模"];
        return;
    }
    if (0 == temp4.length) {
        [MBProgressHUD showError:@"请输入车辆数"];
        return;
    }
    if (0 == temp5.length) {
        [MBProgressHUD showError:@"请输入介绍"];
        return;
    }
    if (0 == temp6.length) {
        [MBProgressHUD showError:@"请输入平均拿证天数"];
        return;
    }
    if (0 == temp7.length) {
        [MBProgressHUD showError:@"请输入科目二通过率"];
        return;
    }
    if (0 == temp8.length) {
        [MBProgressHUD showError:@"请输入科目三通过率"];
        return;
    }
    if (_tinyCard.classes.count == 0) {
        [MBProgressHUD showError:@"请选择班型"];
        return;
    }
    
    UIAlertView *keepalert = [[UIAlertView alloc]initWithTitle:@"是否保存" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [keepalert show];
}

- (void)keepmsg
{
    
    
    NSString * url = wmpEditUrl;
    NSString * timeString = self.getcurrentTime;
    
    NSMutableDictionary * paramDict = [NSMutableDictionary dictionary];
    paramDict[@"uid"] = kUid;
    paramDict[@"time"] = timeString;
    paramDict[@"cityId"] = @([HttpParamManager getCurrentCityID]);
    paramDict[@"sign"] = [HttpsTools getSignWithIdentify:@"/card/update" time:timeString];
    //待修改的参数
    paramDict[@"schoolName"] = _tinyCard.School.schoolName;
    paramDict[@"age"] = _tinyCard.School.age;
    paramDict[@"size"] = _tinyCard.School.size;
    paramDict[@"carNum"] = _tinyCard.School.carNum;
    paramDict[@"memo"] = _tinyCard.School.memo;
    paramDict[@"average"] = _tinyCard.School.average;
    paramDict[@"percent2"] = _tinyCard.School.percent2;
    paramDict[@"percent3"] = _tinyCard.School.percent3;
    //    paramDict[@"userPic1"] = _tinyCard.School.userPic1;
    //    paramDict[@"userPic2"] = _tinyCard.School.userPic2;
    //    paramDict[@"userPic3"] = _tinyCard.School.userPic3;
    
    //地图界面回调回来的经纬度

    if (0 == self.longtitude.length) {
        paramDict[@"address"] = @"";
    }else
    {
        paramDict[@"address"] = [NSString stringWithFormat:@"%@,%@",self.longtitude,self.latitude];
    }

    paramDict[@"addressName"] = self.address;
    paramDict[@"provinceId"] = _tinyCard.School.provinceId;
    paramDict[@"cityId"] = _tinyCard.School.cityId;
    
    NSMutableArray *arr = [NSMutableArray array];
    
    for (int i = 0; i<self.tinyCard.classes.count; i++) {
        TinyClassesModel *model = self.tinyCard.classes[i];
        
        NSDictionary *dict = nil;
        
        NSString *time = model.classDate;
        NSString *date_id = nil;
        if ([time isEqualToString:@"周一至周五"]) {
            date_id = @"12";
        }
        else if([time isEqualToString:@"晚上"])
        {
            date_id = @"2";
        }
        else if([time isEqualToString:@"周六至周日"])
        {
            date_id = @"3";
        }
        else if([time isEqualToString:@"周一至周日"])
        {
            date_id = @"4";
        }
        else
        {
            date_id = @"0";
        }
        
        dict = @{@"classId":model.classId,@"title":model.className,@"carClass":[model.classCar substringFromIndex:1],@"date_id":date_id,@"date":time,@"money":model.classMoney};
        
        [arr addObject:dict];
        
        
    }
    
    NSString *str = arr.mj_JSONString;
    
    paramDict[@"classes"] = arr.mj_JSONString;
    
    
    
    if (_isHeadModify) {
        
        //        NSData *fData = UIImageJPEGRepresentation(_logo.image, 1.0);
        
        
        [HJHttpManager UploadFileWithUrl:url param:paramDict serviceName:@"logo" fileName:@"0.png" mimeType:@"image/jpeg" fileData:UIImageJPEGRepresentation(_logo.image, 0.5) finish:^(NSData *data) {
            NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSLog(@"+++++%@",dict);
            NSInteger code = [dict[@"code"] integerValue];
            NSString * msg = dict[@"msg"];
            if (code == 1) {
                
                [self.hudManager dismissSVHud];
                
                
            }else {
                [self.hudManager showErrorSVHudWithTitle:msg hideAfterDelay:1.0f];
            }
            
            
        } failed:^(NSError *error) {
            
            [self.hudManager showErrorSVHudWithTitle:@"上传失败" hideAfterDelay:1.0f];
            
        }];
        
        
        
        
        
        
    }else {
        
        [HttpsTools POST:url parameter:paramDict progress:^(NSProgress *downloadProgress) {
        } succeed:^(id responseObject) {
            
            NSLog(@"微名片编辑%@",responseObject);
            NSInteger code = [responseObject[@"code"] integerValue];
            NSString * msg = responseObject[@"msg"];
            if (code == 1) {
                
                [_table reloadData];
                
            }else {
                
                [self.hudManager showErrorSVHudWithTitle:msg hideAfterDelay:1.0];
            }
            
        } failure:^(NSError *error) {
            
            [self.hudManager showErrorSVHudWithTitle:@"保存失败" hideAfterDelay:1.0];
            
        }];
        
    }
    
    
    
    //    UIImageJPEGRepresentation(self.pic1, 0.1)
    if (self.pic1Modify) {
        [HJHttpManager UploadFileWithUrl:url param:paramDict serviceName:@"userPic1" fileName:@"0.png" mimeType:@"image/jpeg" fileData:UIImageJPEGRepresentation(self.pic1, 0.5) finish:^(NSData *data) {
            NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSLog(@"+++++%@",dict);
            NSInteger code = [dict[@"code"] integerValue];
            NSString * msg = dict[@"msg"];
            NSLog(@"%@",@"111");
            if (code == 1) {
                [self.hudManager dismissSVHud];
                
            }
            
        } failed:^(NSError *error) {
            
            [self.hudManager showErrorSVHudWithTitle:@"上传失败" hideAfterDelay:1.0f];
            
        }];
    }
    if (self.pic2Modify) {
        [HJHttpManager UploadFileWithUrl:url param:paramDict serviceName:@"userPic2" fileName:@"0.png" mimeType:@"image/jpeg" fileData:UIImageJPEGRepresentation(self.pic2, 0.5) finish:^(NSData *data) {
            NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSLog(@"+++++%@",dict);
            NSInteger code = [dict[@"code"] integerValue];
            NSString * msg = dict[@"msg"];
            if (code == 1) {
                NSLog(@"%@",@"222");
                [self.hudManager dismissSVHud];
                
                
                
                
            }
            
        } failed:^(NSError *error) {
            
            [self.hudManager showErrorSVHudWithTitle:@"上传失败" hideAfterDelay:1.0f];
            
        }];
    }
    
    if (self.pic3Modify) {
        [HJHttpManager UploadFileWithUrl:url param:paramDict serviceName:@"userPic3" fileName:@"0.png" mimeType:@"image/jpeg" fileData:UIImageJPEGRepresentation(self.pic3, 0.5) finish:^(NSData *data) {
            NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSLog(@"+++++%@",dict);
            NSInteger code = [dict[@"code"] integerValue];
            NSString * msg = dict[@"msg"];
            if (code == 1) {
                NSLog(@"%@",@"333");
                [self.hudManager dismissSVHud];
                
            }
            
        } failed:^(NSError *error) {
            
            [self.hudManager showErrorSVHudWithTitle:@"上传失败" hideAfterDelay:1.0f];
            
        }];
    }
    
    [self.hudManager showSuccessSVHudWithTitle:@"信息编辑成功" hideAfterDelay:1.0 animaton:YES];
    
    
    
}

#pragma mark -- 微名片数据获取
-(void) loadData
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
    param[@"deviceInfo"] = deviceInfo;
    param[@"uid"] = kUid;
    param[@"time"] = self.getcurrentTime;
    param[@"sign"] = [HttpsTools getSignWithIdentify:@"/card/retrieve" time:self.getcurrentTime];
    NSLog(@"%@",param);
    
    [HttpsTools kPOST:getwmpMsgUrl parameter:param progress:^(NSProgress *downloadProgress) {
    } succeed:^(id backdata, int code, NSString *msg) {
        NSLog(@"%@,%d",backdata,code);
        [MBProgressHUD showMessage:msg];
        if (1 == code) {
            [MBProgressHUD hideHUD];
            
            _tinyCard= [TinyCardModel mj_objectWithKeyValues:backdata];
            
            [_table reloadData];
            
        }
        [MBProgressHUD hideHUD];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)surebtnClicked:(NSString *)content
{
    _tinyCard.School.memo = content;
    [self.table reloadRow:6 inSection:0 withRowAnimation:UITableViewRowAnimationNone];
}

- (void)surebtnClickedsendName:(NSString *)name andPrice:(NSString *)price andDrvingtype:(NSString *)type andXuetime:(NSString *)time andOthertime:(NSString *)othertime classesModelId:(NSString *)idNum
{
    if (idNum == 0) {
        NSLog(@"%@",type);
        TinyClassesModel *model = [[TinyClassesModel alloc]init];
        
        model.className  = name;
        
        model.classCar = [NSString stringWithFormat:@"C%@",type];
        
        model.classMoney = price;
        
        if ([time isEqualToString:@"12"]) {
            model.classDate = @"周一至周五";
        }
        else if([time isEqualToString:@"2"])
        {
            model.classDate = @"晚上";
        }
        else if([time isEqualToString:@"3"])
        {
            model.classDate = @"周六至周日";
        }
        else if([time isEqualToString:@"4"])
        {
            model.classDate = @"周一至周日";
        }
        else
        {
            model.classDate = othertime;
            
        }
        
        model.classId = @"0";
        
        model.otherTime = othertime;
        
        [self.tinyCard.classes addObject:model];
        
        [self.table reloadData];
    }
    else
    {
        TinyClassesModel *model = [[TinyClassesModel alloc]init];
        
        model.className  = name;
        
        model.classCar = [NSString stringWithFormat:@"C%@",type];
        
        model.classMoney = price;
        
        if ([time isEqualToString:@"12"]) {
            model.classDate = @"周一至周五";
        }
        else if([time isEqualToString:@"2"])
        {
            model.classDate = @"晚上";
        }
        else if([time isEqualToString:@"3"])
        {
            model.classDate = @"周六至周日";
        }
        else if([time isEqualToString:@"4"])
        {
            model.classDate = @"周一至周日";
        }
        else
        {
            model.classDate = othertime;
            
        }
        
        model.classId = idNum;
        
        model.otherTime = othertime;
        int index = 0;
        for (int i = 0; i<self.tinyCard.classes.count; i++) {
            TinyClassesModel *model1 = self.tinyCard.classes[i];
            if ([model1.classId isEqualToString:idNum]) {
                [self.tinyCard.classes removeObject:model1];
                index  = i ;
                break;
            }
        }
        [self.tinyCard.classes insertObject:model atIndex:index];
        
        [self.table reloadData];
    
    
    
    
    }
   

}
//删除
-(void)deleteselfrow:(NSInteger)row
{
    if (self.tinyCard.classes.count == 0) {
        [self.hudManager showErrorSVHudWithTitle:@"没有删除项了" hideAfterDelay:2.0];
        return;
    }
    [self.tinyCard.classes removeObjectAtIndex:row];
    
    [self.table reloadSection:1 withRowAnimation:UITableViewRowAnimationNone];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//
//- (void)viewWillAppear:(BOOL)animated{
//    
//    [super viewWillAppear:animated];
//    
//    [IQKeyboardManager sharedManager].enable = NO;
//    
//}
//
//- (void)viewWillDisappear:(BOOL)animated{
//    
//    [super viewWillDisappear:animated];
//    
//    [IQKeyboardManager sharedManager].enable = YES;
//    
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
