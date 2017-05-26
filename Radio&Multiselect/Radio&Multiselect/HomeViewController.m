//
//  ViewController.m
//  Radio&Multiselect
//
//  Created by ZL on 2017/3/24.
//  Copyright © 2017年 ZL. All rights reserved.
//

#import "HomeViewController.h"
#import "ZLRadioViewController.h"
#import "ZLMultiselectController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"首页";
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat btnW = 100;
    CGFloat btnH = 50;
    
    // 单选按钮
    UIButton *radioBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    radioBtn.frame = CGRectMake((width - btnW) * 0.5, 200, btnW, btnH);
    radioBtn.backgroundColor = [UIColor orangeColor];
    radioBtn.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    [radioBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [radioBtn addTarget:self action:@selector(radioBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [radioBtn setTitle:@"单选" forState:UIControlStateNormal];
    [self.view addSubview:radioBtn];
    
    // 多选按钮
    UIButton *multiselectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    multiselectBtn.frame = CGRectMake(radioBtn.frame.origin.x, CGRectGetMaxY(radioBtn.frame) + 20, btnW, btnH);
    multiselectBtn.backgroundColor = [UIColor orangeColor];
    multiselectBtn.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    [multiselectBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [multiselectBtn addTarget:self action:@selector(multiselectBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [multiselectBtn setTitle:@"多选" forState:UIControlStateNormal];
    [self.view addSubview:multiselectBtn];
}

#pragma mark - 按钮点击事件

- (void)radioBtnClick {
    NSLog(@"点击了单选按钮");
    
    ZLRadioViewController *vc = [[ZLRadioViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)multiselectBtnClick {
    NSLog(@"点击了多选按钮");
    
    ZLMultiselectController *vc = [[ZLMultiselectController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
