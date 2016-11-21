//
//  ValidationSuccessController.m
//  KZXC_Headmaster
//
//  Created by apple on 16/7/25.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import "ValidationSuccessController.h"
#import "ValidationFirstTableCell.h"
#import "ValidationSecondTableCell.h"
#import "TXViewController.h"

@interface ValidationSuccessController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray * _dataContentArr;
}

@property (nonatomic,strong)UIScrollView * backScrollView;
@property (nonatomic,strong)UITableView * topTableView;
//@property (nonatomic,strong)NSMutableArray * dataContentArr;
@property (nonatomic,strong)NSMutableArray * dataMessageArr;

@property (nonatomic,strong)UIImageView * downImageView;

@end

@implementation ValidationSuccessController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupNav:@"验证成功"];
    
    [self initWithUI];
    [self initWithData];
    
}
- (void)setupNav:(NSString *)title
{
    UIView *barview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidth, 64)];
    barview.backgroundColor = NavBackColor;
    [self.view addSubview:barview];
    
    UIButton *back = [[UIButton alloc]initWithFrame:CGRectMake(15, 20, 44, 44)];
    [back setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [barview addSubview:back];
    
    UILabel *bartitle = [[UILabel alloc]initWithFrame:CGRectMake((kWidth-100)/2, 20, 100, 44)];
    bartitle.textColor = [UIColor whiteColor];
    bartitle.text = title;
    bartitle.textAlignment = NSTextAlignmentCenter;
    bartitle.font = Font22;
    [barview addSubview:bartitle];
    
}
- (void)initWithUI
{
    _backScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, kWidth, kHeight)];
    _backScrollView.backgroundColor = [UIColor colorWithHexString:@"eaeaea"];
//    _backScrollView.backgroundColor = [UIColor whiteColor];
    _backScrollView.delegate = self;
    _backScrollView.showsVerticalScrollIndicator =  NO;
    _backScrollView.contentSize = CGSizeMake(kWidth, 667+280);
    [self.view addSubview:_backScrollView];

    
    UIImageView * markImageV = [[UIImageView alloc]initWithFrame:CGRectMake((kWidth-40-7-140)/2, 23, 40, 40)];
//        markImageV.backgroundColor = [UIColor redColor];
    markImageV.image = [UIImage imageNamed:@"iconfont-chenggong"];
    [_backScrollView addSubview:markImageV];
    
    UILabel * remindLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(markImageV.frame)+7, CGRectGetMinY(markImageV.frame), 140, 40)];
//        remindLabel.backgroundColor = [UIColor orangeColor];
    NSMutableAttributedString * remindStr = nil;
    remindStr = [[NSMutableAttributedString alloc]initWithString:@"验证成功" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#6ed020"],NSFontAttributeName:[UIFont fontWithName:@"Helvetica-Bold" size:15]}];
    [remindStr  appendAttributedString:[[NSAttributedString  alloc] initWithString:@"\n\n"attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:2]}]];
    [remindStr appendAttributedString:[[NSAttributedString alloc]initWithString:@"请带学员办理报名手续" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#999999"],NSFontAttributeName:[UIFont systemFontOfSize:14]}]];
    remindLabel.attributedText = remindStr;
    remindLabel.numberOfLines = 0;
    [_backScrollView addSubview:remindLabel];
    
    
    //创建上部的tableView
    _topTableView = [[UITableView alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(markImageV.frame)+20, kWidth-30, 352) style:UITableViewStylePlain];
    _topTableView.backgroundColor = [UIColor yellowColor];
    _topTableView.delegate = self;
    _topTableView.dataSource = self;
    _topTableView.scrollEnabled = NO;
    _topTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _topTableView.layer.cornerRadius = 3.0;
    [_backScrollView addSubview:_topTableView];

    _downImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_topTableView.frame)+15, kWidth-20, 368+20)];
    _downImageView = [[UIImageView alloc]initWithFrame:CGRectMake(11, CGRectGetMaxY(_topTableView.frame)+15, kWidth-22, 368+20)];
//    _downImageView.backgroundColor = [UIColor redColor];
    _downImageView.contentMode = UIViewContentModeScaleToFill;
    _downImageView.image = [UIImage imageNamed:@"tuceng_2"];
    _downImageView.userInteractionEnabled = YES;
    [_backScrollView addSubview:_downImageView];
    
    [self createDownView];
    
}

- (void)initWithData
{
    _dataMessageArr = [[NSMutableArray alloc]initWithObjects:@"真实姓名",@"报名驾校",@"报名班型",@"报名价格",@"代 金 券",@"支付方式",nil];
    
    NSMutableAttributedString * customStr = nil;
    customStr = [[NSMutableAttributedString alloc]initWithString:_model.trueName attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#666666"],NSFontAttributeName:[UIFont systemFontOfSize:16]}];
    [customStr appendAttributedString:[[NSMutableAttributedString alloc]initWithString:@"(已验证)" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#6cd020"],NSFontAttributeName:[UIFont systemFontOfSize:16]}]];
//    _dataContentArr = [[NSMutableArray alloc]initWithObjects:customStr,@"张小开教练",@"C1普通班 4200元",@"¥4000.00元",@"¥200.00元",@"线上支付 全款 分期支付",nil];
    
    _dataContentArr = [NSMutableArray arrayWithObjects:_model.nickName,_model.trueName,_model.schoolName,_model.className,_model.money,_model.vouchers,_model.payType, nil];
}

- (void)createDownView
{
    UIImageView * costImageView = [[UIImageView alloc]initWithFrame:CGRectMake((_downImageView.frame.size.width-80)/2.0, 15, 80, 35)];
    costImageView.image = [UIImage imageNamed:@"feemsg"];
    costImageView.contentMode = UIViewContentModeScaleAspectFit;
//    costImageView.backgroundColor = [UIColor orangeColor];
    [_downImageView addSubview:costImageView];
    
    UIImageView * lineImageView = [[UIImageView alloc]initWithFrame:CGRectMake(27.5, CGRectGetMaxY(costImageView.frame)+20, kWidth-39*2, 1)];
//    lineImageView.image = [UIImage imageNamed:@"feemsg"];
    lineImageView.backgroundColor = [UIColor colorWithHexString:@"#e9e5d7"];
    [_downImageView addSubview:lineImageView];
    
    NSArray * arr1 = @[@"报名费用",@"平台费用",@"收  益"];
    
    //    NSArray * arr2 = @[@"¥4000.00元",@"¥500.00元",@"4000-500=3500元"];
    NSArray * arr2 = @[[NSString stringWithFormat:@"¥%@元",_model.money],[NSString stringWithFormat:@"¥%@元",_model.commission],[NSString stringWithFormat:@"%@-%@=%.2f元",_model.money,_model.commission,([_model.money doubleValue] - [_model.commission doubleValue])]];
//    for (int i=0; i<2; i++) {
        for (int j=0; j<3; j++) {
            UILabel * introduceLabel = [[UILabel alloc]initWithFrame:CGRectMake(28, CGRectGetMaxY(lineImageView.frame)+10+35*j, 70, 17)];
//            introduceLabel.backgroundColor = [UIColor yellowColor];
            introduceLabel.text = arr1[j];
            introduceLabel.textColor = [UIColor colorWithHexString:@"#c2b2a1"];
            introduceLabel.font = Font16;
            [_downImageView addSubview:introduceLabel];
            
            UILabel * priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(28+70, CGRectGetMaxY(lineImageView.frame)+10+35*j, kWidth-39*2-70, 17)];
//            priceLabel.backgroundColor = [UIColor greenColor];
            priceLabel.text = arr2[j];
            priceLabel.textAlignment = NSTextAlignmentRight;
            priceLabel.textColor = [UIColor colorWithHexString:@"#9a8a79"];
            priceLabel.font = Font16;
            [_downImageView addSubview:priceLabel];
            
        }
//    }
    UIImageView * middleLineImageV = [[UIImageView alloc]initWithFrame:CGRectMake(27.5, CGRectGetMaxY(lineImageView.frame)+10+17*3+18*2+28, kWidth-39*2, 1)];
    //    lineImageView.image = [UIImage imageNamed:@"feemsg"];
    middleLineImageV.backgroundColor = [UIColor colorWithHexString:@"#e9e5d7"];
    [_downImageView addSubview:middleLineImageV];
//    UILabel * withdrawLabel = [[UILabel alloc]initWithFrame:CGRectMake((kWidth -210)/2, CGRectGetMaxY(middleLineImageV.frame)+18, 130, 17)];
    
//    NSMutableAttributedString * attStr = nil;
//    attStr = [[NSMutableAttributedString alloc]initWithString:@"折合" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#c1b1a0"],NSFontAttributeName:[UIFont systemFontOfSize:17]}];
//   [attStr appendAttributedString:[[NSMutableAttributedString alloc]initWithString:@"35000" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#9a8a78"],NSFontAttributeName:[UIFont fontWithName:@"Helvetica-Bold" size:17]}]];
//    [attStr appendAttributedString:[[NSMutableAttributedString alloc]initWithString:@"赚豆" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#c1b1a0"],NSFontAttributeName:[UIFont systemFontOfSize:17]}]];
//    
//    withdrawLabel.attributedText = attStr;
////    withdrawLabel.backgroundColor = [UIColor greenColor];
//    withdrawLabel.textAlignment = NSTextAlignmentCenter;
//    [_downImageView addSubview:withdrawLabel];
//
////    加下划线
//    NSMutableAttributedString *txStr = [[NSMutableAttributedString alloc] initWithString:@"去提现"];
//    NSRange strRange = {0,[txStr length]};
//
//    [txStr addAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:NSUnderlineStyleSingle],NSUnderlineStyleAttributeName,[UIColor colorWithHexString:@"#ffb667"],NSForegroundColorAttributeName ,Font17,NSFontAttributeName,nil] range:strRange];
//    
//    UIButton *tixian = [[UIButton alloc]init];
//    tixian.frame = CGRectMake(CGRectGetMaxX(withdrawLabel.frame), CGRectGetMaxY(middleLineImageV.frame)+18, 60, 17);
//    [tixian setAttributedTitle:txStr forState:UIControlStateNormal];
//    [tixian addTarget:self action:@selector(TXClick) forControlEvents:UIControlEventTouchUpInside];
//    [_downImageView addSubview:tixian];
//    
//    UILabel * remindLabel = [[UILabel alloc]initWithFrame:CGRectMake(28, CGRectGetMaxY(withdrawLabel.frame)+10, kWidth-43*2, 17)];
////    remindLabel.backgroundColor = [UIColor blueColor];
//    remindLabel.textAlignment = NSTextAlignmentCenter;
//    remindLabel.text = @"(赚豆将于2小时内到账，请注意查收)";
//    remindLabel.font = Font15;
//    remindLabel.textColor = [UIColor colorWithHexString:@"#c1b1a0"];
//    [_downImageView addSubview:remindLabel];
    
    UIButton * phoneNumBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    phoneNumBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    phoneNumBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    phoneNumBtn.frame = CGRectMake(28, CGRectGetMaxY(middleLineImageV.frame)+35, kWidth-43*2, ButtonH);
    phoneNumBtn.backgroundColor = [UIColor whiteColor];
    phoneNumBtn.layer.borderWidth = 1;
    phoneNumBtn.layer.borderColor = [UIColor colorWithHexString:@"#ffb766"].CGColor;
    phoneNumBtn.layer.cornerRadius = ButtonH/2;
    [phoneNumBtn setTitle:validationPhoneNum forState:UIControlStateNormal];
    [phoneNumBtn setImage:[UIImage imageNamed:@"iconfont-dianhua-1"] forState:UIControlStateNormal];
    [phoneNumBtn setTitleColor:[UIColor colorWithHexString:@"ffb766"] forState:UIControlStateNormal];
    [phoneNumBtn addTarget:self action:@selector(pressPhoneNumBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_downImageView addSubview:phoneNumBtn];
    
    UILabel * warnLabel = [[UILabel alloc]initWithFrame:CGRectMake(27.5, CGRectGetMaxY(phoneNumBtn.frame)+12, kWidth-39*2, 11)];
    warnLabel.text = @"如有疑问请联系客服(点击按钮一键拨号)";
    //    warnLabel.backgroundColor = [UIColor orangeColor];
    warnLabel.font = Font15;
    warnLabel.textColor = [UIColor colorWithHexString:@"bfb19f"];
    warnLabel.textAlignment = NSTextAlignmentCenter;
    [_downImageView addSubview:warnLabel];

}

- (void)pressPhoneNumBtn:(UIButton *)sender
{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 94;
    }else if(indexPath.row == 6){
        return 53;
    }else{
        return 41;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        static NSString * string = @"cell";
        ValidationFirstTableCell * cell = [tableView dequeueReusableCellWithIdentifier:string];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"ValidationFirstTableCell" owner:self options:nil] lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.contentLabel.text = _dataContentArr[0];
        return cell;
    }else{
        static NSString * string = @"cell";
        ValidationSecondTableCell * cell = [tableView dequeueReusableCellWithIdentifier:string];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"ValidationSecondTableCell" owner:self options:nil] lastObject];
        }
        cell.MessageLabel.text = _dataMessageArr[indexPath.row-1];
       
        if (1 == indexPath.row) {
            cell.ContentLabel.attributedText = [self yzAttrStrWithString:[NSString stringWithFormat:@"%@(已认证)",_model.trueName]];
        }else
        {
            NSLog(@"%lu==%@",_dataContentArr.count,_dataContentArr[indexPath.row]);
            cell.ContentLabel.text = _dataContentArr[indexPath.row];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == 6) {
            cell.LineLabel.hidden = YES;
        }
        return cell;
    }
    return nil;
}

- (NSMutableAttributedString *)yzAttrStrWithString:(NSString *)str
{
    if(!str)
    {
        str = @"用户(已认证)";
    }
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:str];
    
    [attr addAttributes:[NSDictionary dictionaryWithObjectsAndKeys:ColorSix,NSForegroundColorAttributeName,[UIFont systemFontOfSize:16],NSFontAttributeName, nil] range:NSMakeRange(0, str.length)];
    
    [attr addAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithHexString:@"#6cd0202"],NSForegroundColorAttributeName,[UIFont systemFontOfSize:16],NSFontAttributeName, nil]range:NSMakeRange(str.length - 5, 4)];
    
    return attr;
}

-(void)TXClick
{
    TXViewController *tx = [[TXViewController alloc]init];
    [self.navigationController pushViewController:tx animated:YES];
}

-(void)backClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
