//
//  ValidateSchoolController.m
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/7/22.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import "ValidateSchoolController.h"
#import "ValidatetopCell.h"
#import "ValidateContentCell.h"
#import "TailorCell.h"
#import "SubmitAuthModel.h"

@interface ValidateSchoolController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>

@property(weak,nonatomic)UIScrollView *scroll;
@property(weak,nonatomic)UITableView *table;
@property (nonatomic, strong) SubmitAuthModel * submitAuth;
@property(nonatomic,strong)UIImage * selectImage;

@end

@implementation ValidateSchoolController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _submitAuth = [[SubmitAuthModel alloc] init];
    
    self.title = @"驾校认证";
    
    UIScrollView *locscroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight - 64)];
    locscroll.backgroundColor = RGBColor(247, 247, 247);
    self.scroll = locscroll;

    [self.view addSubview:locscroll];
    
    [self setupTable];
}

- (void)setupTable
{
    CGRect tableFream = CGRectMake(0, 10 , kWidth, 60+100+190*3+40+20);
    UITableView *loctable = [[UITableView alloc]initWithFrame:tableFream style:UITableViewStyleGrouped];
    
    loctable.backgroundColor = [UIColor whiteColor];
    loctable.scrollEnabled = NO;
    loctable.separatorStyle = UITableViewCellSeparatorStyleNone;
    loctable.dataSource = self;
    loctable.delegate = self;
    loctable.backgroundColor = RGBColor(247, 247, 247);
    self.table = loctable;
    
    [self.scroll addSubview:loctable];
    
    UIButton *keep = [[UIButton alloc]init];
    keep.tag = 103;
    [keep addTarget:self action:@selector(keepBtnClick) forControlEvents:UIControlEventTouchUpInside];
    keep.backgroundColor = CommonButtonBGColor;
    keep.layer.cornerRadius = ButtonH/2;
    [keep setTitle:@"提交认证" forState:UIControlStateNormal];
    [keep setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.scroll addSubview:keep];
    [keep mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(loctable.mas_bottom).offset(10);
        make.left.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(kWidth - 40, ButtonH));
    }];
    
    UILabel *tipstitle = [[UILabel alloc]init];
    tipstitle.font = fifteenFont;
    tipstitle.text = @"认证须知";
    tipstitle.textColor = ColorThree;
    [self.scroll addSubview:tipstitle];
    [tipstitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(keep.mas_bottom).offset(35);
        make.left.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(kWidth - 40, 15));
    }];
    

    UILabel *tipsone = [[UILabel alloc]init];
    
    tipsone.font = fourteenFont;
    tipsone.text = @"1、认证提交必须真实有效";
    tipsone.textColor = ColorSix;
    
    [self.scroll addSubview:tipsone];
    [tipsone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(tipstitle.mas_bottom).offset(15);
        make.left.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(kWidth - 40, 15));
    }];
    
    UILabel *tipstwo = [[UILabel alloc]init];
    
    tipstwo.font = fourteenFont;
    tipstwo.text = @"2、提交成功后将会在1个工作日内审核";
    tipstwo.textColor = ColorSix;
    
    [self.scroll addSubview:tipstwo];
    [tipstwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(tipsone.mas_bottom).offset(10);
        make.left.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(kWidth - 40, 15));
    }];
    
    self.scroll.contentSize = CGSizeMake(kWidth, loctable.height + 200);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (1 == section) {
        return 2;
    }
    else
    {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSInteger section = indexPath.section;
    
    NSInteger row = indexPath.row;
    
    if (1 == section) {
        static NSString *scrollID = @"TailorCellID";
        TailorCell *cell = [tableView dequeueReusableCellWithIdentifier:scrollID];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"TailorCell" owner:nil options:nil] firstObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        if (0 == row) {
            UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidth, 1)];
            line.backgroundColor = [UIColor colorWithHexString:@"#ececec"];
            [cell addSubview:line];
            cell.showKey.text = @"真实姓名";
            cell.showValue.tag = 1000;
            if (_isFromAlreadyAuth) {
                
                cell.showValue.text = _realName.trueName;
                _submitAuth.trueName = cell.showValue.text;
            }
            
        }else {
            cell.showKey.text = @"身份证号";
            cell.showValue.tag = 2000;
            //防止有的朋友身份证号带有X,一开始显示为数字可使用字母
            cell.showValue.keyboardType = UIKeyboardTypeASCIICapable;
            if (_isFromAlreadyAuth) {
                
                cell.showValue.text = _realName.IDNum;
                _submitAuth.IDNum = cell.showValue.text;
            }
        }
        
        cell.showValue.enabled = YES;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFielsChanged:) name:UITextFieldTextDidChangeNotification object:cell.showValue];
        
        
        return cell;
    }
    
    
    else if (0 == section) {
        static NSString *scrollID = @"ValidatetopCellID";
        ValidatetopCell *cell = [tableView dequeueReusableCellWithIdentifier:scrollID];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"ValidatetopCell" owner:nil options:nil] firstObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        if (_isFromAlreadyAuth) {
            
            cell.authStateLab.text = @"已认证";
        }else {
            cell.authStateLab.text = @"未认证";
        }
        [cell.headerImgView sd_setImageWithURL:[NSURL URLWithString:_personalInfo.face] placeholderImage:[UIImage imageNamed:@"placeHeader"]];
        cell.nickNameLab.text = _personalInfo.nickName;
        cell.phoneLab.text = _personalInfo.phone;
        
        return cell;
    }
    else
    {
        static NSString *scrollID = @"ValidateContentCellID";
        ValidateContentCell *cell = [tableView dequeueReusableCellWithIdentifier:scrollID];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"ValidateContentCell" owner:nil options:nil] firstObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if (indexPath.section == 2) {
            
            cell.titleLab.text = @"手持身份证照片";
        }if (indexPath.section == 3) {
            
            cell.titleLab.text = @"驾校营业执照照片";
        }if (indexPath.section == 4) {
            
            cell.titleLab.text = @"驾校办学资质照片";
        }
        
        cell.delegate = self;
        
  
        
        return cell;
        
    }
}
#pragma mark -- 一区输入框的通知方法
- (void)textFielsChanged:(NSNotification *)notification {
    
    UITextField * textField = (UITextField *)[notification object];
    textField.textColor = [UIColor colorWithHexString:@"#333333"];
    if (textField.tag == 1000) {
        
        _submitAuth.trueName = textField.text;
    }
    if (textField.tag == 2000) {
        
        _submitAuth.IDNum = textField.text;
    }
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    
    if (0 == section) {
        
        return 70;
    }else if(1 == section)
    {
        return 50;
    }else
    {
        return 190;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return CGFLOAT_MIN;
}


#pragma mark -- 提交实名认证的请求
- (void)keepBtnClick
{
        
    if ([_submitAuth.trueName isEqualToString:@""] || _submitAuth.trueName == nil) {
        
        [MBProgressHUD showError:@"请填写真实姓名"];
        return;
    }
    if ([_submitAuth.IDNum isEqualToString:@""] || _submitAuth.IDNum == nil) {
        
        [MBProgressHUD showError:@"请填写身份证号码"];
        return;
    }
    
    if (![ValidateHelper validateIdentityCard:_submitAuth.IDNum]) {
        [self.hudManager showErrorSVHudWithTitle:@"请输入正确的身份证号码" hideAfterDelay:1.0];
        return;
    }
    
    ValidateContentCell * IDPicCell = [_table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];
    if (IDPicCell.pictureBtn.imageView.image == nil ) {
        [MBProgressHUD showError:@"请上传身份证图片"];
        return;
    }
    ValidateContentCell * companyPicCell = [_table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:3]];
    if (companyPicCell.pictureBtn.imageView.image == nil) {
        [MBProgressHUD showError:@"请上传营业执照图片"];
        return;
    }
    ValidateContentCell * schoolPicCell = [_table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:4]];
    if (schoolPicCell.pictureBtn.imageView.image == nil) {
        [MBProgressHUD showError:@"请上传办学资质图"];
        return;
    }
    
    [GiFHUD setGifWithImageName:@"kangzhuang.gif"];
    [GiFHUD showWithOverlaytime:5.0 ];

    
    NSString * url = submitAuthentication;
    NSMutableDictionary * paramDict = [NSMutableDictionary dictionary];
    paramDict[@"uid"] = kUid;
    NSString * timeString = self.getcurrentTime;
    paramDict[@"time"] = timeString;
    paramDict[@"sign"] = [HttpsTools getSignWithIdentify:@"/userAuth/add" time:timeString];
    paramDict[@"trueName"] = _submitAuth.trueName;
    paramDict[@"IDNum"] = _submitAuth.IDNum;
    
    NSData * data1 = UIImageJPEGRepresentation(IDPicCell.pictureBtn.imageView.image, 0.5);
    NSData * data2 = UIImageJPEGRepresentation(companyPicCell.pictureBtn.imageView.image, 0.5);
    NSData * data3 = UIImageJPEGRepresentation(schoolPicCell.pictureBtn.imageView.image, 0.5);
        
  
 
    AFHTTPSessionManager *session =  [AFHTTPSessionManager manager];
    session.requestSerializer.timeoutInterval = 30;
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    
    [session POST:url parameters:paramDict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileData:data1 name:@"IDPic" fileName:@"IDPic.png" mimeType:@"image/jpeg"];
        [formData appendPartWithFileData:data2 name:@"companyPic" fileName:@"coachPic.png" mimeType:@"image/jpeg"];
        [formData appendPartWithFileData:data3 name:@"schoolPic" fileName:@"1.png" mimeType:@"image/jpeg"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
  
        NSLog(@"提交实名认证%@",responseObject);
        NSInteger code = [responseObject[@"code"] integerValue];
        NSString * msg = responseObject[@"msg"];
        if (code == 1) {
            
//            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提交成功" message:@"我们会在1个工作日内审核认证,请留意系统消息。" delegate:self cancelButtonTitle:@"朕知道了" otherButtonTitles:nil, nil];
//            [alert show];
            //发个通知吧,通知驾校认证下方的按钮为已提交资质
            [[NSNotificationCenter defaultCenter] postNotificationName:@"changeBtnState" object:self];
            
            [self.navigationController popViewControllerAnimated:YES];

            [GiFHUD dismiss];
            
        }else{
            [self.hudManager showErrorSVHudWithTitle:msg hideAfterDelay:1.0f];
        }
        

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self.hudManager showErrorSVHudWithTitle:@"保存失败" hideAfterDelay:1.0f];

    }];
    
    
    
    
}
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
//    
//    if (buttonIndex == 0) {
//        //发个通知吧,通知驾校认证下方的按钮为已提交资质
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"changeBtnState" object:self];
//        
//        [self.navigationController popViewControllerAnimated:YES];
//    }
//    
//    
//}
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
