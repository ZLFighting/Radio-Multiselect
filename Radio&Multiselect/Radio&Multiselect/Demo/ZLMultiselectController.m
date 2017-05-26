//
//  ZLMultiselectController.m
//  Radio&Multiselect
//
//  Created by ZL on 2017/3/24.
//  Copyright © 2017年 ZL. All rights reserved.
//

#import "ZLMultiselectController.h"
#import "UIView+ZLExtension.h"


#define ZLUnselectedColor [UIColor colorWithRed:(241)/255.0 green:(242)/255.0 blue:(243)/255.0 alpha:1.0]
#define ZLSelectedColor [UIColor colorWithRed:(128)/255.0 green:(177)/255.0 blue:(34)/255.0 alpha:1.0]

@interface ZLMultiselectController ()

// 标签数组
@property (nonatomic, strong) NSArray *markArray;

// 标签字典
@property (nonatomic, strong) NSDictionary *markDict;

// 选中标签数组(数字)
@property (nonatomic, strong) NSMutableArray *selectedMarkArray;

// 选中标签数组(文字字符串)
@property (nonatomic, strong) NSMutableArray *selectedMarkStrArray;

@end

@implementation ZLMultiselectController

#pragma mark - 懒加载

- (NSArray *)markArray {
    if (!_markArray) {
        NSArray *array = [NSArray array];
        array = @[@"导购", @"客服", @"家教", @"礼仪", @"主持"];
        _markArray = array;
    }
    return _markArray;
}

// 上传通过文字key取数字value发送数字
- (NSDictionary *)markDict {
    if (!_markDict) {
        NSDictionary *dict = [NSDictionary dictionary];
        dict = @{
                 @"导购" : @"3" ,
                 @"客服" : @"7",
                 @"家教" : @"9",
                 @"礼仪" : @"10",
                 @"主持" : @"11",
                 };
        _markDict = dict;
    }
    return _markDict;
}

- (NSMutableArray *)selectedMarkArray {
    if (!_selectedMarkArray) {
        _selectedMarkArray = [NSMutableArray array];
    }
    return _selectedMarkArray;
}

- (NSMutableArray *)selectedMarkStrArray {
    if (!_selectedMarkStrArray) {
        _selectedMarkStrArray = [NSMutableArray array];
    }
    return _selectedMarkStrArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"多选";
    self.view.backgroundColor = [UIColor whiteColor];

    // 设置多选视图
    [self setupMultiselectView];
    
}

// 设置多选视图
- (void)setupMultiselectView {
    
    CGFloat UI_View_Width = [UIScreen mainScreen].bounds.size.width;
    CGFloat marginX = 15;
    CGFloat top = 19;
    CGFloat btnH = 35;
    CGFloat marginH = 40;
    CGFloat height = 130;
    CGFloat width = (UI_View_Width - marginX * 4) / 3;
    
    // 按钮背景
    UIView *btnsBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 100, UI_View_Width, height)];
    btnsBgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:btnsBgView];
    
    // 循环创建按钮
    NSInteger maxCol = 3;
    for (NSInteger i = 0; i < 5; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = ZLUnselectedColor;
        btn.layer.cornerRadius = 3.0; // 按钮的边框弧度
        btn.clipsToBounds = YES;
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [btn setTitleColor:[UIColor colorWithRed:(102)/255.0 green:(102)/255.0 blue:(102)/255.0 alpha:1.0] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(chooseMark:) forControlEvents:UIControlEventTouchUpInside];
        NSInteger col = i % maxCol; //列
        btn.x  = marginX + col * (width + marginX);
        NSInteger row = i / maxCol; //行
        btn.y = top + row * (btnH + marginX);
        btn.width = width;
        btn.height = btnH;
        [btn setTitle:self.markArray[i] forState:UIControlStateNormal];
        [btnsBgView addSubview:btn];
    }
    
    // 确定按钮
    UIButton *surebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [surebtn setTitle:@"确定" forState:UIControlStateNormal];
    surebtn.frame = CGRectMake(marginX * 2, CGRectGetMaxY(btnsBgView.frame) + marginH, UI_View_Width - marginX * 4, 40);
    surebtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [surebtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    surebtn.backgroundColor = [UIColor orangeColor];
    surebtn.layer.cornerRadius = 3.0;
    surebtn.clipsToBounds = YES;
    [self.view addSubview:surebtn];
}

/**
 * 按钮多选处理
 */
- (void)chooseMark:(UIButton *)btn {
    
    btn.selected = !btn.selected;
    
    if (btn.isSelected) {
        btn.backgroundColor = ZLSelectedColor;
        [self.selectedMarkArray addObject:self.markDict[btn.titleLabel.text]];
        [self.selectedMarkStrArray addObject:btn.titleLabel.text];
    } else {
        btn.backgroundColor = ZLUnselectedColor;
        [self.selectedMarkArray removeObject:self.markDict[btn.titleLabel.text]];
        [self.selectedMarkStrArray removeObject:btn.titleLabel.text];
    }
}

/**
 * 确认接口请求处理
 */
- (void)sureBtnClick {
    // 用户选择标签后就把值上传, 也要传给服务器下次直接请求回来
    // 按钮数字标识字符串
    NSString *numStr = [self.selectedMarkArray componentsJoinedByString:@","];
    // 按钮文字字符串
    NSString *str = [self.selectedMarkStrArray componentsJoinedByString:@","];
    
    // 测试:拼接请求参数
    NSLog(@"按钮数字标识字符串:%@", numStr);
    NSLog(@"按钮文字字符串:%@", str);
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
