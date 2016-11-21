//
//  VenueLeaseController.m
//  KZXC_Headmaster
//
//  Created by gaobin on 16/8/11.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import "VenueLeaseController.h"
#import "LeaseScrollCell.h"
#import "ContentLeaseCell.h"
#import "CocahCarDetailModel.h"
@interface VenueLeaseController ()<UITableViewDelegate,UITableViewDataSource>
@property(weak,nonatomic)UIScrollView *scroll;
@property(weak,nonatomic)UITableView *table;
@property (nonatomic, strong) NSMutableArray * dataArray;
@property (nonatomic, strong) CocahCarDetailModel * cocahCarDetail ;
@end

@implementation VenueLeaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    _dataArray = [NSMutableArray array];
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIScrollView *locscroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight - 64)];
    
    self.scroll = locscroll;
    locscroll.contentSize = CGSizeMake(kWidth, 930);
    //    locscroll.scrollEnabled = YES;
    [self.view addSubview:locscroll];
   

    [self requestData];
    
}
- (void)requestData {
    
    [self.hudManager showNormalStateSVHUDWithTitle:@"加载中"];
    
    NSString * url = venueLeaseDetail;
    NSMutableDictionary * paramDict = [NSMutableDictionary dictionary];
    paramDict[@"uid"] = kUid;
    paramDict[@"deviceInfo"] = deviceInfo;
    NSString * timeString = self.getcurrentTime;
    paramDict[@"time"] = timeString;
    paramDict[@"sign"] = [HttpsTools getSignWithIdentify:@"/carHire/retrieve" time:timeString];
    paramDict[@"carId"] = _idString;
    
    [HttpsTools POST:url parameter:paramDict progress:^(NSProgress *downloadProgress) {
    } succeed:^(id responseObject) {
        NSLog(@"123%@",responseObject);
        NSInteger code = [responseObject[@"code"] integerValue];
        NSString * msg = responseObject[@"msg"];
        if (code == 1) {
            
            NSDictionary * infoDict = responseObject[@"info"];
            _cocahCarDetail = [CocahCarDetailModel mj_objectWithKeyValues:infoDict];
            
            [self setupTable];
            
            [_table reloadData];
            
            [self.hudManager dismissSVHud];
            
        }else {
            
            [MBProgressHUD showError:msg];
        }
        
        
        
    } failure:^(NSError *error) {
        
        [MBProgressHUD showError:@"加载失败"];
        
    }];

    
    
}
- (void)setupTable
{
    CGRect tableFream = CGRectMake(0, 0 , kWidth, 930);
    UITableView *loctable = [[UITableView alloc]initWithFrame:tableFream];
    
    loctable.backgroundColor = [UIColor whiteColor];
    loctable.scrollEnabled = NO;
    loctable.separatorStyle = UITableViewCellSeparatorStyleNone;
    loctable.dataSource = self;
    loctable.delegate = self;
    self.table = loctable;
    
    [self.scroll addSubview:loctable];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (0 == indexPath.section) {
        
        static NSString *scrollID = @"LeaseScrollID";
        LeaseScrollCell *cell = [tableView dequeueReusableCellWithIdentifier:scrollID];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle]loadNibNamed:@"LeaseScrollCell" owner:nil options:nil] firstObject];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        NSMutableAttributedString * attString = [[NSMutableAttributedString alloc] init];
        [attString appendText:@"本资源由" withAttributesArr:@[[UIColor colorWithHexString:@"#999999"]]];
        [attString appendText:[NSString stringWithFormat:@"%@",_cocahCarDetail.trueName] withAttributesArr:@[[UIColor colorWithHexString:@"#333333"],Font15]];
        [attString appendText:@"发布" withAttributesArr:@[[UIColor colorWithHexString:@"#999999"]]];
        
        cell.drivingname.attributedText = attString;
        
        cell.cocahCarDetail = _cocahCarDetail;
        
        
        return cell;
    }
    else if (1 == indexPath.section)
    {
        static NSString *contentID = @"ContentLeaseID";
        
        ContentLeaseCell  *cell = [tableView dequeueReusableCellWithIdentifier:contentID];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle]loadNibNamed:@"ContentLeaseCell" owner:nil options:nil] firstObject];
            
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.phone = _cocahCarDetail.tel;
        
        cell.imgtype.image = [UIImage imageNamed:@"section1"];
        cell.imgtitle.text = @"场地信息";
        
        NSMutableAttributedString * firstAttString = [[NSMutableAttributedString alloc] init];;
        [firstAttString appendText:@"面积: " withAttributesArr:@[[UIColor colorWithHexString:@"#999999"]]];
        [firstAttString appendText:[NSString stringWithFormat:@"%@亩",_cocahCarDetail.Size] withAttributesArr:@[[UIColor colorWithHexString:@"#333333"]]];
        cell.firlabel.attributedText = firstAttString;
        
        NSMutableAttributedString * secAttString = [[NSMutableAttributedString alloc] init];;
        [secAttString appendText:@"容量: " withAttributesArr:@[[UIColor colorWithHexString:@"#999999"]]];
        [secAttString appendText:[NSString stringWithFormat:@"%@辆车",_cocahCarDetail.CarMax] withAttributesArr:@[[UIColor colorWithHexString:@"#333333"]]];
        cell.seclabel.attributedText = secAttString;
        
        NSMutableAttributedString * thirdAttString = [[NSMutableAttributedString alloc] init];;
        [thirdAttString appendText:@"车库: " withAttributesArr:@[[UIColor colorWithHexString:@"#999999"]]];
        [thirdAttString appendText:[NSString stringWithFormat:@"%@个",_cocahCarDetail.garageNum] withAttributesArr:@[[UIColor colorWithHexString:@"#333333"]]];
        cell.thilabel.attributedText = thirdAttString;
        
        NSMutableAttributedString * dayAttString = [[NSMutableAttributedString alloc] init];;
        [dayAttString appendText:@"按天: " withAttributesArr:@[[UIColor colorWithHexString:@"#999999"]]];
        [dayAttString appendText:[NSString stringWithFormat:@"%@元/天",_cocahCarDetail.priceDay] withAttributesArr:@[[UIColor colorWithHexString:@"#333333"]]];
        cell.dayprice.attributedText = dayAttString;
        
        NSMutableAttributedString * weekAttString = [[NSMutableAttributedString alloc] init];;
        [weekAttString appendText:@"按周: " withAttributesArr:@[[UIColor colorWithHexString:@"#999999"]]];
        [weekAttString appendText:[NSString stringWithFormat:@"%@元/周",_cocahCarDetail.priceWeek] withAttributesArr:@[[UIColor colorWithHexString:@"#333333"]]];
        cell.weekprice.attributedText = weekAttString;
        
        NSMutableAttributedString * monthAttString = [[NSMutableAttributedString alloc] init];;
        [monthAttString appendText:@"按月: " withAttributesArr:@[[UIColor colorWithHexString:@"#999999"]]];
        [monthAttString appendText:[NSString stringWithFormat:@"%@元/月",_cocahCarDetail.priceMonth] withAttributesArr:@[[UIColor colorWithHexString:@"#333333"]]];
        cell.mouthprice.attributedText = monthAttString;
        
        NSMutableAttributedString * quarterAttString = [[NSMutableAttributedString alloc] init];;
        [quarterAttString appendText:@"按季: " withAttributesArr:@[[UIColor colorWithHexString:@"#999999"]]];
        [quarterAttString appendText:[NSString stringWithFormat:@"%@元/季",_cocahCarDetail.priceQuarter] withAttributesArr:@[[UIColor colorWithHexString:@"#333333"]]];
        cell.quarterprice.attributedText = quarterAttString;
        
        NSMutableAttributedString * yearAttString = [[NSMutableAttributedString alloc] init];;
        [yearAttString appendText:@"按年: " withAttributesArr:@[[UIColor colorWithHexString:@"#999999"]]];
        [yearAttString appendText:[NSString stringWithFormat:@"%@元/年",_cocahCarDetail.priceYear] withAttributesArr:@[[UIColor colorWithHexString:@"#333333"]]];
        cell.yearprice.attributedText = yearAttString;
        
 
        cell.address.text = _cocahCarDetail.address;
        
        cell.tips.text = _cocahCarDetail.Other;
        
        float weekhui = [_cocahCarDetail.priceDay floatValue] * 7 - [_cocahCarDetail.priceWeek floatValue];
        cell.weekhui.text = [NSString stringWithFormat:@"省%.f元",weekhui];
        
        float monthhui = [_cocahCarDetail.priceWeek floatValue] * 4 - [_cocahCarDetail.priceMonth floatValue];
        cell.mouthhui.text = [NSString stringWithFormat:@"省%.f元",monthhui];
        
        float quarterhui = [_cocahCarDetail.priceMonth floatValue] * 3 - [_cocahCarDetail.priceQuarter floatValue];
        cell.quarterhui.text = [NSString stringWithFormat:@"省%.f元",quarterhui];
        
        float yearhui = [_cocahCarDetail.priceQuarter floatValue] * 4 - [_cocahCarDetail.priceYear floatValue];
        cell.yearhui.text = [NSString stringWithFormat:@"省%.f元",yearhui];
        
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == indexPath.section) {
        return 200;
    }else
    {
        return 730;
    }
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
