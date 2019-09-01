//
//  BaccaratConfigController.m
//  VVCollectProject
//
//  Created by lvan Lewis on 2019/9/1.
//  Copyright © 2019年 Mike. All rights reserved.
//

#import "BaccaratConfigController.h"

// 边距
#define kMarginWidth 15
#define kBtnHeight 35

@interface BaccaratConfigController ()

/// 全部牌的数组
@property (nonatomic, strong) UITextView *pokerArrayTextView;
/// 本金初始额度
@property (nonatomic, strong) UITextField *amountTextField;

@end

@implementation BaccaratConfigController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSMutableArray*buttons=[[NSMutableArray alloc]initWithCapacity:2];
    UIBarButtonItem *rightBtn1 = [[UIBarButtonItem alloc]initWithTitle:@"保存配置" style:(UIBarButtonItemStylePlain) target:self action:@selector(saveBtnAction)];
    UIBarButtonItem *rightBtn2 = [[UIBarButtonItem alloc]initWithTitle:@"初始化" style:(UIBarButtonItemStylePlain) target:self action:@selector(initDataBtnAction)];
//    UIBarButtonItem *rightBtn3 = [[UIBarButtonItem alloc]initWithTitle:@"消键盘" style:(UIBarButtonItemStylePlain) target:self action:@selector(onDisKeyboardButton)];
    
    rightBtn1.tintColor=[UIColor blackColor];
    rightBtn2.tintColor=[UIColor blackColor];
//    rightBtn3.tintColor=[UIColor blackColor];
    [rightBtn1 setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:12], NSFontAttributeName,nil] forState:(UIControlStateNormal)];
    [rightBtn2 setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:12], NSFontAttributeName,nil] forState:(UIControlStateNormal)];
//    [rightBtn3 setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:12], NSFontAttributeName,nil] forState:(UIControlStateNormal)];
    [buttons addObject:rightBtn1];
    [buttons addObject:rightBtn2];
//    [buttons addObject:rightBtn3];
    //    [tools setItems:buttons animated:NO];
    //    UIBarButtonItem*btn=[[UIBarButtonItem alloc]initWithCustomView:tools];
    self.navigationItem.rightBarButtonItems=buttons;
    
    [self setupUI];
    [self getSaveData];
}
- (void)saveBtnAction {
    
    // 分隔字符串
    NSString *string = self.pokerArrayTextView.text;
    NSArray *array = [string componentsSeparatedByString:@","];
//    NSLog(@"array:%@",array);
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:self.amountTextField.text.integerValue forKey:@"BaccaratBetAmount"];
    [userDefaults setObject:array forKey:@"BaccaratPokerArray"];
    [userDefaults synchronize];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)getSaveData {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSInteger amount = [userDefaults integerForKey:@"BaccaratBetAmount"];
    NSArray *tempArray = [userDefaults objectForKey:@"BaccaratPokerArray"];

    if (tempArray) {
        NSString *string = [tempArray componentsJoinedByString:@","];
        self.amountTextField.text = [NSString stringWithFormat:@"%ld",amount];
        self.pokerArrayTextView.text = string;
    } else {
        [self initDataBtnAction];
    }
}

- (void)initDataBtnAction {
    self.amountTextField.text = @"20000";
    self.pokerArrayTextView.text = @"1,2,3,4,5,6,7,8,9,10,11,12,13,1,2,3,4,5,6,7,8,9,10,11,12,13,1,2,3,4,5,6,7,8,9,10,11,12,13,1,2,3,4,5,6,7,8,9,10,11,12,13";
}

- (void)setupUI {
    UILabel *amountLabel = [[UILabel alloc] init];
    amountLabel.text = @"本金初始额度";
    amountLabel.font = [UIFont systemFontOfSize:14];
    amountLabel.textColor = [UIColor darkGrayColor];
    amountLabel.numberOfLines = 0;
    amountLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:amountLabel];
    
    [amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(kMarginWidth);
        make.left.equalTo(self.view.mas_left).offset(5);
    }];
    
    UITextField *amountTextField = [[UITextField alloc] init];
//    amountTextField.text = @"20000";
    amountTextField.keyboardType = UIKeyboardTypeNumberPad;
    amountTextField.textColor = [UIColor grayColor];
    amountTextField.layer.cornerRadius = 5;
    amountTextField.layer.borderColor = [UIColor grayColor].CGColor;
    amountTextField.layer.borderWidth = 1;
    [self.view addSubview:amountTextField];
    _amountTextField  = amountTextField;
    
    [amountTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(amountLabel.mas_centerY);
        make.left.equalTo(amountLabel.mas_right).offset(5);
        make.size.mas_equalTo(CGSizeMake(70, kBtnHeight));
    }];
    
#pragma mark - vvTextView
    UITextView* textView = [[UITextView alloc] initWithFrame:CGRectMake(5, 50, kSCREEN_WIDTH -5*2, 200)];
    textView.backgroundColor = [UIColor whiteColor];
    
//    NSArray *pokerArray = @[ @(1),@(2),@(3),@(4),@(5),@(6),@(7),@(8),@(9),@(10),@(11),@(12),@(13),
//                             @(1),@(2),@(3),@(4),@(5),@(6),@(7),@(8),@(9),@(10),@(11),@(12),@(13),
//                             @(1),@(2),@(3),@(4),@(5),@(6),@(7),@(8),@(9),@(10),@(11),@(12),@(13),
//                             @(1),@(2),@(3),@(4),@(5),@(6),@(7),@(8),@(9),@(10),@(11),@(12),@(13)
//                             ];
    
    //文本
//    textView.text = @"@(1),@(2),@(3),@(4),@(5),@(6),@(7),@(8),@(9),@(10),@(11),@(12),@(13),@(1),@(2),@(3),@(4),@(5),@(6),@(7),@(8),@(9),@(10),@(11),@(12),@(13),@(1),@(2),@(3),@(4),@(5),@(6),@(7),@(8),@(9),@(10),@(11),@(12),@(13),@(1),@(2),@(3),@(4),@(5),@(6),@(7),@(8),@(9),@(10),@(11),@(12),@(13)";
    //字体
    textView.font = [UIFont boldSystemFontOfSize:16.0];
    //对齐
    textView.textAlignment = NSTextAlignmentCenter;
    //字体颜色
    textView.textColor = [UIColor redColor];
    //允许编辑
    textView.editable = YES;
    //用户交互     ///////若想有滚动条 不能交互 上为No，下为Yes
    textView.userInteractionEnabled = YES; ///
    //自定义键盘
    //textView.inputView = view;//自定义输入区域
    //textView.inputAccessoryView = view;//键盘上加view
    textView.delegate = self;
    [self.view addSubview:textView];
    
    textView.scrollEnabled = YES;//滑动
    textView.returnKeyType = UIReturnKeyDone;//返回键类型
    textView.keyboardType = UIKeyboardTypeDefault;//键盘类型
//    textView.autoresizingMask = UIViewAutoresizingFlexibleHeight;//自适应
    textView.dataDetectorTypes = UIDataDetectorTypeAll;//数据类型连接模式
    textView.autocorrectionType = UITextAutocorrectionTypeNo;//自动纠错方式
    textView.autocapitalizationType = UITextAutocapitalizationTypeNone;//自动大写方式
    _pokerArrayTextView = textView;
    textView.layer.borderColor = [UIColor greenColor].CGColor;
    textView.layer.borderWidth = 1;
    
    //禁止文字居中或下移64，因为avigationController下scrollView自动适应屏幕，而UITextView继承自UIScrollView
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }

}

@end
