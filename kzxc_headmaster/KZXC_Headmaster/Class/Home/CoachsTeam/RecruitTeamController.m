//
//  RecruitTeamController.m
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/7/18.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import "RecruitTeamController.h"
#import "ManagerController.h"
#import "InviteCoachController.h"
#import "RewardView.h"
#import "RecruitCell.h"
#import "UIColor+Hex.h"
#import "RecruitCoach.h"

@interface RecruitTeamController ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    int i ;
    
    NSString *dou;
}

@property(weak,nonatomic)UIScrollView *scroll;

@property(strong,nonatomic)NSMutableArray *coachs;

@property(weak,nonatomic)UILabel *bglabel;
@property(weak,nonatomic)UILabel *numlabel;
@property(weak,nonatomic)UILabel *bottomlabel;

@property(weak,nonatomic)UICollectionView *collection;

@end

@implementation RecruitTeamController

- (NSArray *)coachs
{
    if (!_coachs) {
        _coachs = [NSMutableArray array];
    }
    return _coachs;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    /**
     *  导航栏模块
     */
    [self setupNav];
    
    i = 0;
    
    UIScrollView *locscroll = [[UIScrollView alloc]init];
    
    locscroll.scrollEnabled = YES;
    locscroll.backgroundColor = [UIColor colorWithHexString:@"#f7f7f7"];
    [locscroll setContentSize:CGSizeMake(kWidth, 170+74)];
    
    self.scroll = locscroll;
    [self.view addSubview:locscroll];

    [locscroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(kWidth, kHeight - 64));
    }];
    
    /**
     *  顶部视图
     */
    [self setupTopView];
   
    [self setupCollection];
    
    [self loadData];
}

- (void)setupNav
{
    self.title = @"教练招生团";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *right = [UIButton buttonWithType:UIButtonTypeCustom];
    right.frame = CGRectMake(0, 0, 50, 50);
    right.titleLabel.font = [UIFont systemFontOfSize:18.0];
    [right addTarget:self action:@selector(managerClick) forControlEvents:UIControlEventTouchUpInside];
    [right setTitle:@"管理" forState:UIControlStateNormal];
    [right setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    UIBarButtonItem *rightBut = [[UIBarButtonItem alloc]initWithCustomView:right];
    self.navigationItem.rightBarButtonItem = rightBut;
    
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    
    [navigationBar setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault]; //此处使底部线条颜色为红色
    
    [navigationBar setShadowImage:[UIImage imageWithColor:NavBackColor]];
}

- (void)setupTopView
{
    UIView *bgview = [[UIView alloc]init];
    bgview.backgroundColor = NavBackColor;
    [self.scroll addSubview:bgview];
    
    [bgview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(kWidth, 170));
    }];
    
    UILabel *bgTitle = [[UILabel alloc]init];
    
    NSString *num1 = [NSString stringWithFormat:@"%d",i];
    NSString *num2 = [NSString stringWithFormat:@"%d",i];
    

    bgTitle.attributedText = [self titleOne:num1 andnum2:num2];
    bgTitle.textAlignment = NSTextAlignmentCenter;
    [bgview addSubview:bgTitle];
    
    [bgTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(25);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(kWidth, 20));
    }];
    
    self.bglabel = bgTitle;
    
    UILabel *numLabel = [[UILabel alloc]init];
    numLabel.attributedText = [self titleTwo:[NSString stringWithFormat:@"%d",i]];
    numLabel.textAlignment = NSTextAlignmentCenter;
    [bgview addSubview:numLabel];
    
    [numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgTitle.mas_bottom).offset(10);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(kWidth, 30));
    }];
    
    self.numlabel = numLabel;
    
    //邀请教练加入招生团
    UIButton *invited = [[UIButton alloc]init];
    invited.backgroundColor = NavBackColor;
    [invited setTitle:@"邀请教练加入招生团" forState:UIControlStateNormal];
    invited.titleLabel.font = [UIFont systemFontOfSize:18.0];
    [invited setTitleColor:NavBackColor forState:UIControlStateNormal];
    invited.layer.cornerRadius = 17.5;

    invited.backgroundColor = RGBColor(252, 169, 41);
    [invited addTarget:self action:@selector(invitedClick) forControlEvents:UIControlEventTouchUpInside];
    [bgview addSubview:invited];
    [invited mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(numLabel.mas_bottom).offset(20);
        make.left.mas_equalTo(30);
        make.size.mas_equalTo(CGSizeMake(kWidth - 60, 35));
    }];
    
    UIView *bg_bottomview = [[UIView alloc]init];
    bg_bottomview.backgroundColor = [UIColor colorWithHexString:@"bc1c21"];
    [self.scroll addSubview:bg_bottomview];
    [bg_bottomview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgview.mas_bottom).offset(0);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(kWidth, 65));
    }];
    
    //温馨提示:该数据仅为通过线上报名的招生数据,通过线上招生每达10人,将获得平台发放的赚豆奖励(可提现)

    UILabel *bottom_title = [[UILabel alloc]init];
    
    bottom_title.textAlignment = NSTextAlignmentCenter;
    bottom_title.text =@"温馨提示:该数据仅为通过线上报名的招生数据,通过线上招生每达10人,将获得平台发放的赚豆奖励(可提现)";
    bottom_title.textColor = [UIColor colorWithHexString:@"f18d90"];
    bottom_title.font = [UIFont systemFontOfSize:14.0];
    
    bottom_title.lineBreakMode = NSLineBreakByWordWrapping;
    bottom_title.numberOfLines = 2;
    
    [bg_bottomview addSubview:bottom_title];
    [bottom_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.left.mas_equalTo(30);
        make.size.mas_equalTo(CGSizeMake(kWidth - 60, 35));
    }];
    
    self.bottomlabel = bottom_title;
}

- (void)invitedClick
{
    InviteCoachController *invited = [[InviteCoachController alloc]init];
    [self.navigationController pushViewController:invited animated:YES];
}
- (void)setupCollection
{
    CGFloat conentw = (kWidth - 30)/3;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    layout.itemSize = CGSizeMake(conentw, 205);

//    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    ;
    UICollectionView *collect =[[UICollectionView alloc]initWithFrame:CGRectMake(0, 235, kWidth, 0) collectionViewLayout:layout];

    collect.scrollEnabled = NO;
    collect.backgroundColor = [UIColor colorWithHexString:@"#f7f7f7"];
    
    //    collect.backgroundColor =[UIColor whiteColor];
    
    collect.dataSource = self;
    
    collect.delegate = self;
    
    [collect registerNib:[UINib nibWithNibName:@"RecruitCell" bundle:nil] forCellWithReuseIdentifier:@"RecruitCell"];
    
    self.collection = collect;
    
    [self.scroll addSubview:collect];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.coachs.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"RecruitCell";
    
    RecruitCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor whiteColor];
    
    cell.layer.cornerRadius = 8;
    
    cell.coach = self.coachs[indexPath.row];
    
    
    cell.give = ^(RecruitCell *ruit){
        
        RewardView *pop = [[RewardView alloc]init];
    
        [pop setName:ruit.coach.userName andUserId:ruit.coach.userId];
        [pop show];
        
    };
    
    return cell;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 0, 0, 10);
}

- (void)managerClick
{
    NSLog(@"管理...");
    
    ManagerController *manager = [[ManagerController alloc ]init];
    
    [self.navigationController pushViewController:manager animated:YES];
    
}

- (void)loadData
{
    [self.hudManager showNormalStateSVHudWithTitle:@"加载中..." hideAfterDelay:100.0];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"uid"] = kUid;
    param[@"deviceInfo"] = deviceInfo;
    param[@"time"] = self.getcurrentTime;
    param[@"sign"] = [HttpsTools getSignWithIdentify:@"/recruit" time:self.getcurrentTime];
    
    [HttpsTools kPOST:zhaoshengUrl parameter:param progress:^(NSProgress *downloadProgress) {
    } succeed:^(id backdata, int code, NSString *msg) {
//        [self.hudManager showSuccessSVHudWithTitle:msg hideAfterDelay:1.0 animaton:YES];
        
        if (1 == code) {

        [self.hudManager dismissSVHud];
            
        NSArray *arr = @[backdata[@"studentNum"],backdata[@"recruitNum"],backdata[@"peopleNum"]];
        
        [self setNumbers:arr];
        
        [[NSUserDefaults standardUserDefaults]setValue:backdata[@"remainBeans"] forKey:@"douNum"];
        
        self.coachs = [RecruitCoach mj_objectArrayWithKeyValuesArray:backdata[@"recruitData"]];
        
        NSLog(@"%d",(int)self.coachs.count);
        
        CGFloat h;
        
        int j = (int)self.coachs.count / 3;
        h = 215 *(j+1);
        
        CGSize size = self.scroll.contentSize;
        size.height += h;
        self.scroll.contentSize = size;
        
        CGRect rect = self.collection.frame;
        rect.size.height = h;
        self.collection.frame = rect;
        
        
        [self.collection reloadData];
        
        [MBProgressHUD hideHUD];
        NSLog(@"%@",backdata);
        
       }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)setNumbers:(NSArray *)arr
{
    self.bglabel.attributedText = [self titleOne:[NSString stringWithFormat:@"%@",arr[0]] andnum2:[NSString stringWithFormat:@"%@",arr[1]]];
    self.numlabel.attributedText = [self titleTwo:[NSString stringWithFormat:@"%@",arr[2]]];
}

- (NSMutableAttributedString *)titleOne:(NSString *)num1 andnum2:(NSString *)num2
{
    NSString *str = [NSString stringWithFormat:@"共有教练%@人，加入招生团%@人",num1,num2];
    
    NSMutableAttributedString *attr1 = [[NSMutableAttributedString alloc]initWithString:str];
    [attr1 addAttributes:[NSDictionary dictionaryWithObjectsAndKeys:Font14,NSFontAttributeName,[UIColor colorWithHexString:@"ffa880"],NSForegroundColorAttributeName, nil] range:NSMakeRange(0, attr1.length)];
    [attr1 addAttributes:[NSDictionary dictionaryWithObjectsAndKeys:Font16,NSFontAttributeName, nil] range:NSMakeRange(4, attr1.length - 12 - num2.length)];
    [attr1 addAttributes:[NSDictionary dictionaryWithObjectsAndKeys:Font16,NSFontAttributeName, nil] range:NSMakeRange(11+ num1.length, attr1.length - 12 - num1.length)];
    return attr1;
}

- (NSMutableAttributedString *)titleTwo:(NSString *)num
{
    NSString *str = [NSString stringWithFormat:@"累积招生%@名",num];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:str];
    [attr addAttributes:[NSDictionary dictionaryWithObjectsAndKeys:Font18,NSFontAttributeName,[UIColor whiteColor],NSForegroundColorAttributeName, nil] range:NSMakeRange(0, attr.length)];
    [attr addAttributes:[NSDictionary dictionaryWithObjectsAndKeys:BoldFontWithSize(30),NSFontAttributeName,[UIColor colorWithHexString:@"#ffa800"],NSForegroundColorAttributeName, nil] range:NSMakeRange(4, str.length-5)];
    return attr;
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
