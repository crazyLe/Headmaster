//
//  LessonViewController.m
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/7/12.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import "LessonViewController.h"
#import "LessonDetailsController.h"
#import "WJSegmentMenuVc.h"
#import "LessonTypeController.h"
#import "LessonDetailsView.h"
#import "LessonView.h"
#import "UIColor+Hex.h"

@interface LessonViewController ()
{
    UILabel *_lb;
    NSInteger _curTag;
}
@property(weak,nonatomic)UITableView *lessonTable;

@end

@implementation LessonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"校长课堂";
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f7f7f7"];
    
    /* 创建WJSegmentMenuVc */
    WJSegmentMenuVc *segmentMenuVc = [[WJSegmentMenuVc alloc]initWithFrame:CGRectMake(0, 0, kWidth - 15, 55)];
    [self.view addSubview:segmentMenuVc];
    
    /* 自定义设置(可不设置为默认值) */
    segmentMenuVc.backgroundColor = [UIColor colorWithRed:240/250.0 green:240/250.0 blue:240/250.0 alpha:1];
    segmentMenuVc.titleFont = [UIFont systemFontOfSize:20];
    segmentMenuVc.unlSelectedColor = [UIColor colorWithHexString:@"#333333"];
    segmentMenuVc.selectedColor = [UIColor colorWithHexString:@"#ff6866"];
    segmentMenuVc.MenuVcSlideType = WJSegmentMenuVcSlideTypeSlide;
    segmentMenuVc.SlideColor = [UIColor whiteColor];
    segmentMenuVc.advanceLoadNextVc = YES;
    
    /* 创建测试数据 */
    NSArray *titles = @[@"全部",@"经营管理",@"政策法规",@"招生宣传"];
    LessonTypeController      *vc1 = [[LessonTypeController alloc]init];
    LessonTypeController      *vc2 = [[LessonTypeController alloc]init];
    LessonTypeController    *vc3 = [[LessonTypeController alloc]init];
    LessonTypeController     *vc4 = [[LessonTypeController alloc]init];
//    LessonTypeController     *vc5 = [[LessonTypeController alloc]init];

//    NSArray *vcArr = @[vc1,vc2,vc3,vc4,vc5];
    NSArray *vcArr = @[vc1,vc2,vc3,vc4];
    
    /* 导入数据 */
    [segmentMenuVc addSubVc:vcArr subTitles:titles];
    
 
    UIImageView *jiantou = [[UIImageView alloc]initWithFrame:CGRectMake(kWidth - 15, 20, 15, 15)];
    jiantou.image = [UIImage imageNamed:@"tailor_jiantou"];
    
    [self.view addSubview:jiantou];
    
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
