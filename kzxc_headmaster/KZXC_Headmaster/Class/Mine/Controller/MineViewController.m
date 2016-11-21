//
//  MineViewController.m
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/7/8.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import "MineViewController.h"
#import "RechargeViewController.h"
#import "TXViewController.h"
#import "MineMsgController.h"
#import "MineSetController.h"
#import "ModifyController.h"
#import "ValidateSchoolController.h"
#import "LoginGuideController.h"
#import "HeadMsgController.h"

#import "MineCell.h"
#import "NSString+Size.h"
#import "PersonalInfoModel.h"
#import "AlreadyAuthenticationVC.h"
#import "RealNameModel.h"
#import "MyCircleViewController.h"
#import "AboutKZController.h"
#import "MasterAssistantVC.h"

#import "SystemDetailsvController.h"
#import "LoginViewController.h"
#import "MessageDataBase.h"
#import "BindBankCardVC.h"
#import "AlreadyBindBankCardVC.h"

#define imageview_h 230.0f
@interface MineViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UIAlertViewDelegate,UIActionSheetDelegate>
{
    CGRect _tableFream;
    NSArray *arr1;
    NSArray *arr2;
}
@property(weak,nonatomic)UIImageView *bg;
@property(weak,nonatomic)UIScrollView *scroll;
@property(weak,nonatomic)UITableView *table;
@property(assign,nonatomic)CGFloat scale;
@property (nonatomic, strong) UIImageView * enImageview;
@property (nonatomic, strong) PersonalInfoModel * personalInfo;
@property (nonatomic, strong) RealNameModel * realName ;
@property (nonatomic, strong) UIImageView *imageview ;
@property (nonatomic, strong) UILabel *name_label;
@property (nonatomic, strong) UIImageView *isvip;
@property(strong,nonatomic)UIAlertView *outAlert;
@property (nonatomic, strong) UIButton *keep;

@end

@implementation MineViewController

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];

    [self setupNav];
    
    arr1 = @[@[@"赚豆："],@[@"我的消息",@"我的圈子",@"驾校认证",@"校长助理",@"账号设置",@"账号安全",@"绑定银行卡"],@[@"关于"]];
    arr2 = @[@[@"mine_list_dou"],@[@"mine_list_xiaoxi",@"mine_list_quanzi",@"mine_list_renzheng",@"xzzl",@"mine_list_shezhi",@"mine_list_anquan",@"mine_bind"],@[@"mine_list_guanyu"]];
 
    if (0 != [kUid intValue]) {
        
        [self requestData];
        
        [self requestAuthenticationStateData];

    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"个人中心";
    
    _outAlert = [[UIAlertView alloc]initWithTitle:@"" message:@"您尚未登录!" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去登录", nil];
    _outAlert.tag = 808;
    
    
    [self setupTable];
    _table.contentInset = UIEdgeInsetsMake(imageview_h, 0,0,0);
    
    
    _enImageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, -imageview_h, kWidth, imageview_h )];
    _enImageview.image = [UIImage imageNamed:@"mine_bg"];
    /**
     *  这里是为了放大能按比例
     */
    _enImageview.contentMode = UIViewContentModeScaleAspectFill;
    _enImageview.autoresizesSubviews = YES;
    [self.table addSubview:_enImageview];
    
    
    
    
}
//判断认证状态的请求
- (void)requestAuthenticationStateData {
    
    NSString * url = schoolAuthenticationState;
    NSMutableDictionary * paramDict = [NSMutableDictionary dictionary];
    paramDict[@"uid"] = kUid;
    NSString * timeString = self.getcurrentTime;
    paramDict[@"time"] = timeString;
    paramDict[@"sign"] = [HttpsTools getSignWithIdentify:@"/userAuth" time:timeString];
    

    [HttpsTools POST:url parameter:paramDict progress:^(NSProgress *downloadProgress) {
    } succeed:^(id responseObject) {
        NSLog(@"认证状态%@",responseObject);
        NSInteger code = [responseObject[@"code"] integerValue];
        NSString * msg = responseObject[@"msg"];
        if (code == 1) {
            
            NSDictionary * infoDict = responseObject[@"info"];
            
            _realName = [RealNameModel mj_objectWithKeyValues:infoDict];
            
            [curDefaults setObject:_realName.state forKey:@"kAuthState"];
            
            [_table reloadData];
            
        }else {
            
            [MBProgressHUD showError:msg];
        }
        
        
        
    } failure:^(NSError *error) {
        
        [MBProgressHUD showError:@"获取认证状态失败"];
        
    }];

    
}
#pragma mark -- 获取个人信息的请求
- (void)requestData {
    
    [self.hudManager showNormalStateSVHUDWithTitle:@"加载中"];
    
    NSString * url = getMemberInfo;
    
    NSMutableDictionary * paramDict = [NSMutableDictionary dictionary];
    paramDict[@"uid"] = kUid;
    NSString * timeString = self.getcurrentTime;
    paramDict[@"time"] = timeString;
    paramDict[@"deviceInfo"] = deviceInfo;
    paramDict[@"sign"] = [HttpsTools getSignWithIdentify:@"/member/info" time:timeString];
 
    [HttpsTools kPOST:url parameter:paramDict progress:^(NSProgress *downloadProgress) {
    } succeed:^(id backdata, int code, NSString *msg) {
        NSLog(@"个人信息%@",backdata);
        if (code == 1) {
            
            [self.hudManager dismissSVHud];
            
            _personalInfo = [PersonalInfoModel mj_objectWithKeyValues:backdata];
            
            [curDefaults setValue:_personalInfo.face forKey:@"kFace"];
            
            [self setPersonalUI];
            
            [_table reloadData];
            
           
        }else {
            
            [self.hudManager showErrorSVHudWithTitle:msg hideAfterDelay:1.0];
        }
        
        
    } failure:^(NSError *error) {
        
        [self.hudManager showErrorSVHudWithTitle:@"加载失败" hideAfterDelay:1.0];
        
    }];
    
    
}
- (void)setPersonalUI {
    
    [_imageview removeFromSuperview];
    _imageview = [[UIImageView alloc]init];
    _imageview.layer.borderColor = RGBColor(50, 84, 104).CGColor;
    _imageview.layer.borderWidth = 3;
    _imageview.layer.masksToBounds = YES;
    _imageview.layer.cornerRadius = 37.5;
    [_imageview sd_setImageWithURL:[NSURL URLWithString:_personalInfo.face] placeholderImage:[UIImage imageNamed:@"placeHeader"]];

    [_table addSubview:_imageview];
    [_imageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(-150);
        make.left.mas_equalTo((kWidth - 75)/2);
        make.size.mas_equalTo(CGSizeMake(75, 75));
    }];

    
    [_name_label removeFromSuperview];
    _name_label = [[UILabel alloc]init];
    _name_label.text = _personalInfo.nickName;
    _name_label.font = Font16;
    _name_label.textColor = [UIColor whiteColor];
    [_table addSubview:_name_label];
    [_name_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imageview.mas_bottom).offset(10);
        make.centerX.equalTo(_imageview.mas_centerX);
    }];
    
    [_isvip removeFromSuperview];
    _isvip = [[UIImageView alloc]init];
    if ([_personalInfo.isver isEqualToString:@"1"]) {
        
         _isvip.image = [UIImage imageNamed:@"purse_vip"];
    }
    [_table addSubview:_isvip];
    [_isvip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imageview.mas_bottom).offset(12);
        make.left.equalTo(_name_label.mas_right).offset(5);
        make.size.mas_equalTo(CGSizeMake(13, 15));
    }];

    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat y = scrollView.contentOffset.y;
    
    //kHeadImageHeight-64是为了向上拉倒导航栏底部时alpha = 1
    CGFloat alpha = (294+y)/64;
    
   // NSLog(@"%falpha%f",y,alpha);
    
    if (alpha>=1) {
        alpha = 0.99;
    }
    UIImage *image = [UIImage imageWithColor:[UIColor colorWithHexString:@"#d1232d" alpha:alpha]];
    
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    /**
     *  这里的偏移量是纵向从contentInset算起，则一开始偏移就是imageview_h，向下为负，上为正，下拉则会增加，反弹会上移，-y会变小直到=imageview_h停止变化
     */
    if (y < -imageview_h - 40) {
        CGRect frame = _enImageview.frame;
        frame.origin.y = y;
        frame.size.height = -y;
        _enImageview.frame = frame;
        
    }
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:0];
    self.navigationController.navigationBar.barTintColor = NavBackColor;
    [self.navigationController.navigationBar setTranslucent:NO];
}


- (void)setupNav
{
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    [navigationBar setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    //此处使底部线条颜色为红色
    
    [navigationBar setShadowImage:[UIImage imageWithColor:NavBackColor]];
    
    self.navigationController.navigationBar.translucent = YES;
    
    [navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg"] forBarMetrics:UIBarMetricsDefault];
    
    navigationBar.shadowImage =[UIImage imageNamed:@"nav_bg"];
    
//    self.navigationController.navigationBar.barTintColor = [UIColor clearColor];
////    导航栏变为透明
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:0];
////    让黑线消失的方法
//    self.navigationController.navigationBar.shadowImage=[UIImage new];
    
}

- (void)setupTable
{
    if ([kUid isEqualToString:@"0"]) {
        
        _tableFream = CGRectMake(0, 0 , kWidth, kHeight);
        
    }else {
        _tableFream = CGRectMake(0, -64 , kWidth, kHeight+64 );

    }
    UITableView *loctable = [[UITableView alloc]initWithFrame:_tableFream style:UITableViewStyleGrouped];
    
    loctable.backgroundColor = [UIColor whiteColor];
    
    loctable.separatorStyle = UITableViewCellSeparatorStyleNone;
    loctable.dataSource = self;
    loctable.delegate = self;
    self.table = loctable;
    
    [self.view addSubview:loctable];
    
    
    UIView *foot = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidth, 64)];
    
    foot.backgroundColor = RGBColor(247, 247, 247);
    
    _keep = [[UIButton alloc]initWithFrame:CGRectMake(20, 0, kWidth - 40, 44)];
    _keep.tag = 103;
   // [keep addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    _keep.backgroundColor = RGBColor(235, 105, 106);
    _keep.layer.cornerRadius = 22.5;
    

    if ([kUid isEqualToString:@"0"]) {
        [_keep setTitle:@"去登录" forState:UIControlStateNormal];
        [_keep addTarget:self action:@selector(loginClick) forControlEvents:UIControlEventTouchUpInside];
        
    }else {
        
        [_keep setTitle:@"安全退出" forState:UIControlStateNormal];
        [_keep addTarget:self action:@selector(outClick) forControlEvents:UIControlEventTouchUpInside];
    }
        
    
    [_keep setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"#fbfbfb"]] forState:UIControlStateHighlighted];
    [_keep setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
    [foot addSubview:_keep];
    
    loctable.tableFooterView = foot;
    
//    if(0 == [kUid intValue])
//    {
//        UITapGestureRecognizer *showtap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gologin)];
//        [loctable addGestureRecognizer:showtap];
//    }

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return arr1.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arr1[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSInteger section = indexPath.section;
    
    NSInteger row = indexPath.row;
        
    static NSString *scrollID = @"MineCellID";
    
    MineCell *cell = [tableView dequeueReusableCellWithIdentifier:scrollID];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MineCell" owner:nil options:nil] firstObject];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (0 == section) {
        
        cell.jiantou.hidden = YES;
        
        UILabel *balance = [[UILabel alloc]init];
        balance.text = _personalInfo.beans;
        balance.textColor = [UIColor colorWithHexString:@"fe8d90"];
        balance.font = fifteenFont;
        [cell addSubview:balance];
        [balance mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.equalTo(cell.content.mas_right).offset(5);
            make.size.mas_equalTo(CGSizeMake(120, 50));
        }];
        UIButton *btn2 = [[UIButton alloc]init];
        btn2.tag = 102;
        [btn2 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [btn2 setTitle:@"提现" forState:UIControlStateNormal];
        [btn2 setTitleColor:[UIColor colorWithHexString:@"#ff6866"] forState:UIControlStateNormal];
        btn2.titleLabel.font = fourteenFont;
        btn2.layer.masksToBounds = YES;
        btn2.layer.cornerRadius = 5;
        btn2.layer.borderWidth = 1;
        btn2.layer.borderColor = [UIColor colorWithHexString:@"#ff6866"].CGColor;
        btn2.titleLabel.font = thirteenfont;
        [cell addSubview:btn2];
        [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.right.mas_equalTo(-15);
            make.size.mas_equalTo(CGSizeMake(50, 30));
        }];

        UIButton *btn1 = [[UIButton alloc]init];
        btn1.tag = 101;
        [btn1 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [btn1 setTitle:@"充值" forState:UIControlStateNormal];
        [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn1.titleLabel.font = fourteenFont;
        [btn1 setBackgroundColor:[UIColor colorWithHexString:@"#ff6866"]];
        btn1.layer.masksToBounds = YES;
        btn1.layer.cornerRadius = 5;
        btn1.titleLabel.font = thirteenfont;
        [cell addSubview:btn1];
        [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.right.equalTo(btn2.mas_left).offset(-5);
            make.size.mas_equalTo(CGSizeMake(50, 30));
        }];
        
        if (0 == [kShowState intValue]) {
            btn1.hidden = YES;
        }
    }
    if (0 == [kShowState intValue] && indexPath.row == 0 && indexPath.section == 0) {
        cell.hidden = YES;
    }
    if (0 == row && (1 == section || 2 == section)) {
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidth, 1)];
        line.backgroundColor = [UIColor colorWithHexString:@"#ececec"];
        [cell addSubview:line];
    }
    NSString *icon_name = [arr2[section] objectAtIndex:row];

    NSString *content_str = [arr1[section] objectAtIndex:row];
    
    cell.icon.image = [UIImage imageNamed:icon_name];
    
    cell.content.text = content_str;
    
//    if (indexPath.section == 1) {
//        if (indexPath.row == 0) {
//            NSInteger num = [[MessageDataBase shareInstance] queryCircleUnRead].count;
//            if (num != 0) {
//                cell.detailLab.text = [NSString stringWithFormat:@"%lu",num];
//                
//            }
//
//        }
//    }
    
    if (indexPath.section == 1) {
    
        if (indexPath.row == 2) {
            
            if([_realName.state isEqualToString:@"1"])//已认证
            {
                cell.detailLab.text = @"已认证";
            }
            else if([_realName.state isEqualToString:@"0"])//正在认证
            {
                cell.detailLab.text = @"正在审核";
            }
            else if([_realName.state isEqualToString:@"2"])//重新认证
            {
                cell.detailLab.text = @"重新认证";
            }
            else if([_realName.state isEqualToString:@"-1"])//未认证
            {
                cell.detailLab.text = @"未认证";
            }
            
        }
    }
    
        return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == [kShowState intValue] && indexPath.row == 0 && indexPath.section == 0) {
        return 0;
    }
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return CGFLOAT_MIN;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSInteger sec = indexPath.section;
    
    NSInteger row = indexPath.row;
    
    if (0 == sec && 0 == row) {
        
        return;
    }
    if (0 == [kUid intValue]) {
        [_outAlert show];
        return;
    }

//    self.navigationController.navigationBar.translucent = YES;

    if (1 == sec && 0 == row) {
        
        SystemDetailsvController *msg = [[SystemDetailsvController alloc]init];
//        HeadMsgController *msg = [[HeadMsgController alloc]init];
        
        [self.navigationController pushViewController:msg animated:YES];
    }
    
    if (1 == sec && 1 == row) {
        MyCircleViewController *minemsg = [[MyCircleViewController alloc]init];
        [self.navigationController pushViewController:minemsg animated:YES];
//        MineMsgController *minemsg = [[MineMsgController alloc]init];
//        [self.navigationController pushViewController:minemsg animated:YES];
        
    }
    
    else if (1 == sec && 2 == row) {
        
        //根据返回数据判断是否已经实名认证过,根据状态进入对应的界面
        if([_realName.state isEqualToString:@"1"])//已认证
        {
            AlreadyAuthenticationVC * vc = [[AlreadyAuthenticationVC alloc] init];
            
            vc.realName = _realName;
            vc.personalInfo = _personalInfo;
            vc.isFromMineVC = YES;
            
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if([_realName.state isEqualToString:@"0"])//正在认证
        {
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您的实名认证正在审核中..." delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alertView show];
        }
        else if([_realName.state isEqualToString:@"2"])//重新认证,审核失败
        {
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您的实名认证审核失败,请重新认证" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"重新认证", nil];
            alertView.tag = 1000;
            [alertView show];
        }
        else if([_realName.state isEqualToString:@"-1"])//未认证
        {
            ValidateSchoolController *vc = [[ValidateSchoolController alloc]init];
            
            vc.personalInfo = _personalInfo;
            
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    }
    else if (1 == sec && 3 == row)
    {
        //校长助理
        MasterAssistantVC * vc = [[MasterAssistantVC alloc] init];
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    else if (1 == sec && 4 == row)
    {
        //账号设置
        MineSetController *mineset = [[MineSetController alloc]init];
        
        mineset.personalInfo = _personalInfo;
        
        [self.navigationController pushViewController:mineset animated:YES];
        
    }else if (1 == sec && 5 == row)
    {
        //账号安全
        ModifyController *modify = [[ModifyController alloc]init];
        
        [self.navigationController pushViewController:modify animated:YES];
       
    }
    else if (1 == sec && 6 == row)
    {
        
        //绑定银行卡
        if ([_personalInfo.isbindBack isEqualToString:@"0"]) {
            
            BindBankCardVC * vc = [[BindBankCardVC alloc]init];
            
            [self.navigationController pushViewController:vc animated:YES];

        }
        if ([_personalInfo.isbindBack isEqualToString:@"1"]){
            
            AlreadyBindBankCardVC * vc = [[AlreadyBindBankCardVC alloc] init];
            
            [self.navigationController pushViewController:vc animated:YES];

        }
        
    }
    else if(2 == sec)
    {
        AboutKZController *about = [[AboutKZController alloc]init];
        [self.navigationController pushViewController:about animated:YES];
    }

}
#pragma mark -- alertView的代理方法
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    
    NSInteger tag = alertView.tag;
    
    switch (tag) {
            
        case 1000:
        {
            if (buttonIndex == 1) {
                
                //审核失败,重新进去认证界面
                ValidateSchoolController *vc = [[ValidateSchoolController alloc]init];
                
                vc.personalInfo = _personalInfo;
                
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
            break;
            
        case 808:
        {
            if (1 == buttonIndex) {
                LoginGuideController *login = [[LoginGuideController alloc]init];
                login.gologin = YES;
                UINavigationController *root = [[UINavigationController alloc]initWithRootViewController:login];
                [root.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg"] forBarMetrics:UIBarMetricsDefault];
                root.navigationBar.shadowImage =[UIImage imageNamed:@"nav_bg"];
                root.navigationBar.titleTextAttributes = NavTitleTextAttributes;
                
                [self presentViewController:root animated:YES completion:nil];
            }
        }
            break;
            
        default:
            break;
    }
}

- (void)click:(UIButton *)sender
{
    if (0 == [kUid intValue]) {
        [_outAlert show];
        return;
    }
    
    if (101 == sender.tag) {
        RechargeViewController *recharge = [[RechargeViewController alloc]init];
        [self.navigationController pushViewController:recharge animated:YES];
    }else if (102 == sender.tag)
    {
        TXViewController *tx = [[TXViewController alloc]init];
        tx.dounum = _personalInfo.beans;
        [self.navigationController pushViewController:tx animated:YES];
    }
   
}

- (void)outClick
{
    if (0 == [kUid intValue]) {
       
        [self loginClick];
        
        return;
    }
    
    UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:@"退出登录" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"确定", nil];
    
    [actionSheet showInView:self.view];


}
- (void)loginClick {
    
    //确定退出
    
    LoginGuideController *login = [[LoginGuideController alloc]init];
    login.gologin = YES;
    UINavigationController *root = [[UINavigationController alloc]initWithRootViewController:login];
    //加上返回按钮
    login.gologin = YES;
    [root.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg"] forBarMetrics:UIBarMetricsDefault];
    
    root.navigationBar.shadowImage =[UIImage imageNamed:@"nav_bg"];
    
    root.navigationBar.titleTextAttributes = NavTitleTextAttributes;
    
    [self presentViewController:root animated:YES completion:nil];
    
}
- (void)loginOutConfigeration {
    
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
        if ([key isEqualToString:@"kFace"]) {
            [curDefaults removeObjectForKey:key];
        }
        if ([key isEqualToString:@"kAuthState"]) {
            [curDefaults removeObjectForKey:key];
        }
        if ([key isEqualToString:@"douNum"]) {
            [curDefaults removeObjectForKey:key];
        }
        if ([key isEqualToString:@"isLogin"]) {
            [curDefaults removeObjectForKey:key];
        }
       
    }
    [curDefaults synchronize];
    
    
    
   
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) {
        
        //确定退出
        
        [self loginOutConfigeration];
        
        [_keep setTitle:@"去登录" forState:UIControlStateNormal];

        _realName.state = nil;
        _personalInfo.face = nil;
        _personalInfo.nickName = nil;
        _personalInfo.isver = nil;
        [self setPersonalUI];
        
        [_table reloadData];
        
       
    }else {
        
        //取消
        
    }
}
- (void)gologin
{
    [_outAlert show];
}
- (void)leftAction
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
