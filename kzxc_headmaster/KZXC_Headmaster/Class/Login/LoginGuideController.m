//
//  LoginGuideController.m
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/7/26.
//  Copyright © 2016年 cqingw. All rights reserved.
//


#import "LoginGuideController.h"
#import "LoginViewController.h"
#import "RegisterController.h"


@interface LoginGuideController ()

@end

@implementation LoginGuideController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIImageView *bg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"lg_bg"]];
    bg.userInteractionEnabled = YES;
    bg.frame = self.view.bounds;
    [self.view addSubview:bg];
    
    UIImageView *log = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"learn_log"]];
    log.frame = CGRectMake((kWidth - 200)/2, 75, 200, 135);
    [bg addSubview:log];
    
    UIButton *registerBtn = [[UIButton alloc]init];
    
    registerBtn.layer.masksToBounds = YES;
    registerBtn.layer.cornerRadius = 50/2;
    registerBtn.layer.borderColor = [UIColor colorWithHexString:@"#ececec"].CGColor;
    registerBtn.layer.borderWidth = 1;
    
    registerBtn.titleLabel.font = Font22;
    
    [registerBtn setTitle:@"注   册" forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(registerClick) forControlEvents:UIControlEventTouchUpInside ];
    [bg addSubview:registerBtn];
    [registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-50);
        make.left.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(kWidth - 30, 50));
    }];
    
    UIButton *loginBtn = [[UIButton alloc]init];
    loginBtn.backgroundColor = [UIColor colorWithHexString:@"#d32026"];
    loginBtn.layer.masksToBounds = YES;
    loginBtn.layer.cornerRadius = 50/2;
    [loginBtn setTitle:@"登  录" forState:UIControlStateNormal];
    loginBtn.titleLabel.font = Font22;
    [loginBtn addTarget:self action:@selector(loginClick) forControlEvents:UIControlEventTouchUpInside ];
    [bg addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(registerBtn.mas_top).offset(-10);
        make.left.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(kWidth - 30, 50));
    }];
}
- (void)viewWillAppear:(BOOL)animated
{
    if (_gologin) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageWithRenderingMode:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(leftAction)];
    }else
    {
        self.navigationItem.leftBarButtonItem = nil;
    }
}

- (void)leftAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)registerClick
{
    _gologin = NO;
    RegisterController *reg = [[RegisterController alloc]init];
    [self.navigationController pushViewController:reg animated:YES];
}
- (void)loginClick
{
    _gologin = NO;
    LoginViewController *login = [[LoginViewController alloc]init];
    [self.navigationController pushViewController:login animated:YES];
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
