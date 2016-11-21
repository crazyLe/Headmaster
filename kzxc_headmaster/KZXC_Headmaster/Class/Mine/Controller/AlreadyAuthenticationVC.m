//
//  AlreadyAuthenticationVC.m
//  KZXC_Headmaster
//
//  Created by gaobin on 16/8/11.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import "AlreadyAuthenticationVC.h"
#import "ValidatetopCell.h"
#import "TailorCell.h"
#import "AlreadyAuthImgCell.h"
#import "ValidateSchoolController.h"

@interface AlreadyAuthenticationVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) UIButton * reauthBtn;

@end

@implementation AlreadyAuthenticationVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [_tableView reloadData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeBtnState) name:@"changeBtnState" object:nil];
}
- (void)changeBtnState {
    
    _isFromMineVC = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"驾校认证";

    [self createUI];
    
    
    
}
- (void)createUI {
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight -64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = RGBColor(247, 247, 247);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    //_tableView.tableFooterView = [self createFootView];
    [_tableView registerNib:[UINib nibWithNibName:@"ValidatetopCell" bundle:nil] forCellReuseIdentifier:@"ValidatetopCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"TailorCell" bundle:nil] forCellReuseIdentifier:@"TailorCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"AlreadyAuthImgCell" bundle:nil] forCellReuseIdentifier:@"AlreadyAuthImgCell"];
    
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 1) {
        
        return 2;
    }else {
        
        return 1;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        static NSString * identifier = @"ValidatetopCell";
        ValidatetopCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.rightImgView.hidden = YES;
        [cell.headerImgView sd_setImageWithURL:[NSURL URLWithString:_personalInfo.face] placeholderImage:[UIImage imageNamed:@"placeHeader"]];
        cell.phoneLab.text = _personalInfo.phone;
        cell.nickNameLab.text = _personalInfo.nickName;
        if (_isFromMineVC) {
            
            cell.authStateLab.text = @"已认证";
        }else {
            
            cell.authStateLab.text = @"资质已提交";
        }
        return cell;
    }
    if (indexPath.section == 1) {
        
        static NSString * identifier = @"TailorCell";
        TailorCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.rightImg.hidden = YES;
        if (indexPath.row == 0) {
            
            cell.showKey.text = @"真实姓名";
            cell.showValue.text = _realName.trueName;
        }else {
            
            cell.showKey.text = @"身份证号";
            cell.showValue.text = _realName.IDNum;
        }
        return cell;
        
    }
    if (indexPath.section == 2) {
        //身份证图片
        static NSString * identifier = @"AlreadyAuthImgCell";
        AlreadyAuthImgCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLab.text = @"手持身份证照片";
        [cell.detailImgView sd_setImageWithURL:[NSURL URLWithString:_realName.IDPic]placeholderImage:[UIImage imageNamed:@"placeholder"]];
        
        return cell;
    }
    if (indexPath.section == 3) {
        
        static NSString * identifier = @"AlreadyAuthImgCell";
        AlreadyAuthImgCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLab.text = @"营业执照";
        [cell.detailImgView sd_setImageWithURL:[NSURL URLWithString:_realName.companyPic]placeholderImage:[UIImage imageNamed:@"placeholder"]];
        
        return cell;
        
    }
    else {
        
        static NSString * identifier = @"AlreadyAuthImgCell";
        AlreadyAuthImgCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLab.text = @"办学资质";
        [cell.detailImgView sd_setImageWithURL:[NSURL URLWithString:_realName.schoolPic] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        
        return cell;
        
    }
 
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        return 70;
    }
    if (indexPath.section == 1) {
        
        return 50;
    }else {
        
        return 190;
    }
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 10;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    if (section == 4) {
        
        return 90;
        
    }else {
        
        return CGFLOAT_MIN;
    }
    
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    if (section == 4) {
        
        UIView * bgView = [[UIView alloc] init];
        
        _reauthBtn = [[UIButton alloc]init];
        [_reauthBtn addTarget:self action:@selector(reauthBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _reauthBtn.backgroundColor = CommonButtonBGColor;
        _reauthBtn.layer.cornerRadius = ButtonH/2;
        if (_isFromMineVC) {
            
            [_reauthBtn setTitle:@"重新认证" forState:UIControlStateNormal];
            
        }else {
            
            [_reauthBtn setTitle:@"资料已提交" forState:UIControlStateNormal];
            _reauthBtn.enabled = NO;
        }

        [_reauthBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [bgView addSubview:_reauthBtn];
        [_reauthBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(15);
            make.left.mas_equalTo(30);
            make.size.mas_equalTo(CGSizeMake(kWidth - 60, ButtonH));
        }];
        
        return bgView;
    }
    else {
        return nil;
    }
    
    
}
- (void)reauthBtnClick {
    
    ValidateSchoolController * vc = [[ValidateSchoolController alloc] init];
    
    vc.isFromAlreadyAuth = YES;
    vc.personalInfo = _personalInfo;
    vc.realName = _realName;
    
    [self.navigationController pushViewController:vc animated:YES];
    
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
