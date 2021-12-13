//
//  MXVNavController.m
//  BTCMining
//
//  Created by Mike on 20/9/23.
//  Copyright (c) 2021年 MXV. All rights reserved.
//

#import "MXVNavController.h"
#import "MXVBaseViewController.h"

//#import "UIImage+MXVAdd.h"
//#import "UIView+MXVFrame.h"

@interface MXVNavController ()<UIGestureRecognizerDelegate>

@end

@implementation MXVNavController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //self.title = @"首页";
    }
    return self;
}

+ (void)initialize
{
    //设置navigationBar样式
    [MXVNavController setNavigationBarAppearance];
}
- (void)viewDidLoad {
    [super viewDidLoad];

    //3.自适应  （ 去掉：UITableView 、UIScrollView 空白间隙问题 ）
//    self.automaticallyAdjustsScrollViewInsets = NO;
    //4.右滑返回的代理
    self.interactivePopGestureRecognizer.delegate = self;
    
    // 添加 通知：恢复_滑动返回功能
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"recoverSlideBack" object:nil];
    // 接收 通知：恢复_滑动返回功能
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recoverSlideBack) name:@"recoverSlideBack" object:nil];
}

- (void)recoverSlideBack {
    //右滑返回的代理
    self.interactivePopGestureRecognizer.delegate = self;
    self.interactivePopGestureRecognizer.enabled = YES;
}

//系统方法：右滑返回
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    BOOL isBack = YES; // 默认为支持右滑返回
    //如果继承 ZMBaseViewController 也支持右滑返回 （//其他继承，根据要求另作处理）
    if ([self.topViewController isKindOfClass:[MXVBaseViewController class]]) {
        isBack = YES;
    }
    return isBack;
}

#pragma mark - Public Method
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        [self setBackBtnItemNavVC:viewController];
    }
    [super pushViewController:viewController animated:YES];
}
//设置：默认返回按钮
- (void)setBackBtnItemNavVC:(UIViewController *)viewController {

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.backgroundColor = [UIColor greenColor];

//    UIImage * imageNormal = [UIImage imageNamed:@"nav_back"];
//    UIImage * imageSelect = [UIImage imageNamed:@"gray_Back@2x"];
//    [btn setBackgroundImage:imageNormal forState:UIControlStateNormal];
//    [btn setBackgroundImage:imageSelect forState:UIControlStateHighlighted];
    
    [btn setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    
//    [btn setTitle:@"" forState:UIControlStateNormal];
//    [btn setTitle:@"" forState:UIControlStateHighlighted];
    
    [btn setContentHorizontalAlignment:YES];
    
    [btn addTarget:self action:@selector(leftBarBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    btn.size = imageNormal.size;
    btn.size = CGSizeMake(45, 35);
    
    UIBarButtonItem * BarBtnItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    viewController.navigationItem.leftBarButtonItem = BarBtnItem;
    
}

- (void)leftBarBtnClick:(UIButton *)Btn
{
    [self popViewControllerAnimated:YES];
}

/**
 *  设置navigationBar样式
 */
+ (void)setNavigationBarAppearance {
    // 设置导航栏的主题
    UINavigationBar *navBar = [UINavigationBar appearance];
//    [navBar setBarTintColor: [[FHThemeConfig shareManager] CO_Main_Common_Color]];
//    [navBar setBarTintColor: [UIColor clearColor]];
    [navBar setBarTintColor: [UIColor whiteColor]];
    navBar.barTintColor = [UIColor greenColor];
    
    [navBar setBackgroundImage:[UIImage imageNamed:@"com_ph_banner"] forBarMetrics:UIBarMetricsDefault];
    
//    navBar.backgroundColor = [UIColor redColor];
    if ([AppModel sharedInstance].isDebugMode) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, mxwNavBarHeight - 16, mxwScreenWidth(), 16)];
        label.text = [NSString stringWithFormat:@"测试服:%@",[AppModel sharedInstance].serverApiUrl];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:12];
        [navBar addSubview:label];
        label.textColor = [UIColor redColor];
    }
}

#pragma mark 初始化导航栏主题
- (void)setNavTheme
{
//    // 1.设置导航栏背景
//    UINavigationBar *bar = [UINavigationBar appearance];
//    [bar setBackgroundImage:[UIImage zm_resizeImage:@"NavigationBar_Background.png"] forBarMetrics:UIBarMetricsDefault];
//    // 状态栏
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
//    
//    // 2.设置导航栏文字属性
//    NSMutableDictionary *barAttrs = [NSMutableDictionary dictionary];
//    [barAttrs setObject:[UIColor darkGrayColor] forKey:NSForegroundColorAttributeName];
//    [barAttrs setObject:[NSValue valueWithUIOffset:UIOffsetMake(0, 0)] forKey:NSShadowAttributeName];
//    [bar setTitleTextAttributes:barAttrs];
//    
//    // 3.按钮
//    UIBarButtonItem *item = [UIBarButtonItem appearance];
//    [item setBackgroundImage:[UIImage zm_stretchableImage:@"BarButtonItem_Normal.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
//    [item setBackgroundImage:[UIImage zm_stretchableImage:@"BarButtonItem_Pressed.png"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
//    
//    NSMutableDictionary *itemAttrs = [NSMutableDictionary dictionaryWithDictionary:barAttrs];
//    [itemAttrs setObject:[UIFont boldSystemFontOfSize:13] forKey:NSFontAttributeName];
//    [item setTitleTextAttributes:itemAttrs forState:UIControlStateNormal];
//    [item setTitleTextAttributes:itemAttrs forState:UIControlStateHighlighted];
//    [item setTitleTextAttributes:itemAttrs forState:UIControlStateDisabled];
//    
//    // 4.返回按钮
//    [item setBackButtonBackgroundImage:[UIImage zm_stretchableImage:@"BarButtonItem_Back_Normal.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
//    [item setBackButtonBackgroundImage:[UIImage zm_stretchableImage:@"BarButtonItem_Back_Pressed.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
}

- (void)contactMenu {
    
}

@end
