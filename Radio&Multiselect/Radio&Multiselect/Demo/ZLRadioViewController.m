//
//  ZLRadioViewController.m
//  Radio&Multiselect
//
//  Created by ZL on 2017/3/24.
//  Copyright © 2017年 ZL. All rights reserved.
//

#import "ZLRadioViewController.h"
#import "UIView+ZLExtension.h"

#define ZLUnselectedColor [UIColor colorWithRed:(241)/255.0 green:(242)/255.0 blue:(243)/255.0 alpha:1.0]
#define ZLSelectedColor [UIColor colorWithRed:(108)/255.0 green:(187)/255.0 blue:(82)/255.0 alpha:1.0]

@interface ZLRadioViewController ()

// 标签数组(按钮文字)
@property (nonatomic, strong) NSArray *markArray;

// 按钮数组
@property (nonatomic, strong) NSMutableArray *btnArray;

// 选中按钮
@property (nonatomic, strong) UIButton *selectedBtn;

@end

@implementation ZLRadioViewController

#pragma mark - 懒加载

- (NSArray *)markArray {
    if (!_markArray) {
        NSArray *array = [NSArray array];
        array = @[@"14", @"15", @"16", @"17", @"18"];
        _markArray = array;
    }
    return _markArray;
}

- (NSMutableArray *)btnArray {
    if (!_btnArray) {
        NSMutableArray *array = [NSMutableArray array];
        _btnArray = array;
        
    }
    return _btnArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"单选";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupRadioBtnView];
    
}

// 设置单选视图
- (void)setupRadioBtnView {
    
    CGFloat UI_View_Width = [UIScreen mainScreen].bounds.size.width;
    CGFloat marginX = 15;
    CGFloat top = 100;
    CGFloat btnH = 30;
    CGFloat width = (250 - marginX * 4) / 3;
    
    
    // 按钮背景
    UIView *btnsBgView = [[UIView alloc] initWithFrame:CGRectMake((UI_View_Width - 250) * 0.5, 50, 250, 300)];
    btnsBgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:btnsBgView];
    
    // 循环创建按钮
    NSInteger maxCol = 3;
    for (NSInteger i = 0; i < 5; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = ZLUnselectedColor;
        btn.layer.cornerRadius = 3.0; // 按钮的边框弧度
        btn.clipsToBounds = YES;
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:12];
        [btn setTitleColor:[UIColor colorWithRed:(102)/255.0 green:(102)/255.0 blue:(102)/255.0 alpha:1.0] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(chooseMark:) forControlEvents:UIControlEventTouchUpInside];
        NSInteger col = i % maxCol; //列
        btn.x = marginX + col * (width + marginX);
        NSInteger row = i / maxCol; //行
        btn.y = top + row * (btnH + marginX);
        btn.width = width;
        btn.height = btnH;
        [btn setTitle:self.markArray[i] forState:UIControlStateNormal];
        [btnsBgView addSubview:btn];
        btn.tag = i;
        [self.btnArray addObject:btn];
    }
    
    // 创建完btn后再判断是否能选择(之前是已经选取过的)
    // 假数据:之前已经上传16时,则回显16
    for (UIButton *btn in btnsBgView.subviews) {
        if ([@"16" isEqualToString:btn.titleLabel.text]) {
            btn.selected = YES;
            btn.backgroundColor = ZLSelectedColor;
            break;
        }
    }
}

/**
 * 数字按钮单选处理
 */
- (void)chooseMark:(UIButton *)sender {
    NSLog(@"点击了%@", sender.titleLabel.text);
    
    self.selectedBtn = sender;
    
    sender.selected = !sender.selected;
    
    for (NSInteger j = 0; j < [self.btnArray count]; j++) {
        UIButton *btn = self.btnArray[j] ;
        if (sender.tag == j) {
            btn.selected = sender.selected;
        } else {
            btn.selected = NO;
        }
        
        btn.backgroundColor = ZLUnselectedColor;
    }
    
    // 根据tag值去判断
    UIButton *btn = self.btnArray[sender.tag];
    if (btn.selected) {
        
        btn.backgroundColor = ZLSelectedColor;
    } else {
        
        btn.backgroundColor = ZLUnselectedColor;
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
