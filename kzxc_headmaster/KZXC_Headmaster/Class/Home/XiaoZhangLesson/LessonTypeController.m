//
//  LessonTypeController.m
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/7/22.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import "LessonTypeController.h"
#import "LessonDetailsController.h"
#import "LessonDetailsView.h"
#import "CommonWebController.h"
#import "BannerModel.h"

@interface LessonTypeController ()<LessonDetailsDelegate>


@end

@implementation LessonTypeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.view.backgroundColor = RandomColor;
    
    self.view.backgroundColor = [UIColor whiteColor];

    self.lessview = [[LessonDetailsView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight - 64)];
    
    self.lessview.delegate = self;
    
    [self.view addSubview:self.lessview];
}

- (void)LessonDetailsSectionCellisClick:(NSInteger)section andArticle:(ArticleModel *)model
{
    CommonWebController *comm = [[CommonWebController alloc]init];
    comm.isArticel = YES;
    comm.urlStr = model.articleUrl;
    [self.navigationController pushViewController:comm animated:YES];
}

//- (void)LessonDetailsBannerisClick:(BannerModel *)model
//{
//    CommonWebController *comm = [[CommonWebController alloc]init];
//    comm.urlStr = model.pageUrl;
//    [self.navigationController pushViewController:comm animated:YES];
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
