//
//  MXVTabBarController.m
//  BTCMining
//
//  Created by Mike on 2021/6/24.
//  Copyright © 2021年 MXV. All rights reserved.
//

#import "MXVTabBarController.h"
#import "AppDelegate.h"

#import "HomeViewController.h"
#import "FunViewController.h"
#import "AppViewController.h"
#import "MeViewController.h"


@interface MXVTabBarController ()< UITabBarControllerDelegate, UITabBarDelegate >

@end

@implementation MXVTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    // 装载子视图控制器
    [self loadViewControllers];
    
    //添加突出按钮：（替换原位置Item，若不使用此句话，显示原item）
    //    [self addUpperButtonIndex:1];
    
    //通过注册 KVO 来观察选择器的改变，同时切换突出按钮 对属性赋值改的时候进行响应
    //    [self addObserver:self forKeyPath:@"selectedIndex" options:NSKeyValueObservingOptionNew context:nil];
    
    // 跳转 tabbar 通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(jumpTabbarIndex:) name:@"jumpTabbarIndex" object:nil];
    
    // 发送Tabbar通知
    //    [[NSNotificationCenter defaultCenter] postNotificationName:@"jumpTabbarIndex" object: @{@"index":@"3"}];
    
    
    // 发送跳转 tabbar 通知
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //        [[NSNotificationCenter defaultCenter] postNotificationName:kJumpTabbarIndex object: @{@"index":@"3"}];
    //    });
}


- (UIImage *)imageWithColor:(UIColor *)color {
   CGRect rect = CGRectMake(0.0f,0.0f, 1.0f,1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
   CGContextFillRect(context, rect);
    UIImage *image =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
   return image;
}



- (void)jumpTabbarIndex:(NSNotification *)notification
{
    NSDictionary *dict = (NSDictionary *)notification.object;
    
    if (dict) {
        NSInteger index = [dict[@"index"] integerValue];
        self.selectedIndex = index;
    }
}


#pragma mark ---" NSKeyValueObserving  观察者"---

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    //改变的内容: [change objectForKey:@"new"]、change 要改变的属性 keyPath
    //    NSLog(@"--->change: %@",change);
    NSLog(@"--->_upperIndex: %ld",_upperIndex);
    //    NSLog(@"--->new: %ld \n ",[[change objectForKey:@"new"] integerValue]);
    
    if ([keyPath isEqualToString:@"selectedIndex"])
    {
        if (_upperIndex == [[change objectForKey:@"new"] integerValue]) {
            self.mxvTabBar.UpperBtn.selected = YES;
        }else{
            self.mxvTabBar.UpperBtn.selected = NO;
        }
    }
}

#pragma mark- UITabBarControllerDelegate

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    //    NSLog(@"---> getCurrentVC_CC = %@",[[Common getCurrentVC] class]);
    //    NSLog(@"---> selectedIndex_11 = %ld",self.selectedIndex);
    //不可选
    //    if (viewController == self.viewControllers[3]) {
    //        return NO;
    //    }
    return YES;
    
}


/// 选中的TabBar
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    
    //NSLog(@"--> _upperIndex = %ld ",self.upperIndex);
    //    NSLog(@"--> didSelect = %ld \n ",self.selectedIndex);
    //    if (self.selectedIndex==2) {
    //        [self tabBarController:tabBarController shouldSelectViewController:viewController];
    //    }
    //    // 换页和 突出按钮 button的状态关联上
    //    if (self.selectedIndex==_upperIndex) {
    //        self.mxvTabBar.UpperBtn.selected=YES;
    //    }else{
    //        self.mxvTabBar.UpperBtn.selected=NO;
    //    }
    //
    //    if (self.selectedIndex == 2 || self.selectedIndex == 3) {
    //        if (![AppModel sharedInstance].isLogined) {
    //            AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    //            [delegate setRootViewController:YES];
    //        }
    //    }
}

#pragma mark- UITabBarDelegate
/// 上一次选中的TabBar
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    NSLog(@"--> selectedIndex = %ld ",self.selectedIndex);
}

#pragma mark- 装载子视图控制器

- (void)loadViewControllers {
    
    //1.
    HomeViewController *v1 = [[HomeViewController alloc] init];
    
    //2.
    FunViewController *v2= [[FunViewController alloc] init];
    //3.
    AppViewController *v3 = [[AppViewController alloc] init];
    //4.
    MeViewController *v4= [[MeViewController alloc] init];
    
    MXVNavController* navRootVC_1 = [[MXVNavController alloc] initWithRootViewController:v1];
    MXVNavController* navRootVC_2 = [[MXVNavController alloc] initWithRootViewController:v2];
    MXVNavController* navRootVC_3 = [[MXVNavController alloc] initWithRootViewController:v3];
    MXVNavController* navRootVC_4 = [[MXVNavController alloc] initWithRootViewController:v4];
    
    self.viewControllers = @[navRootVC_1,
                             navRootVC_2,
                             navRootVC_3,
                             navRootVC_4];
    
    UITabBarItem *tabBarItem_1 =[self getTabBarItemOfNavController:navRootVC_1  myVC:v1 title:@"首页"
                                                     normolImgName:@"tabbar_home_normal"
                                                     selectImgName:@"tabbar_home_press"];
    
    UITabBarItem *tabBarItem_2 =[self getTabBarItemOfNavController: navRootVC_2 myVC: v2 title:@"功能示例"
                                                     normolImgName:@"tabbar_info_normal"
                                                     selectImgName:@"tabbar_info_press"];
    
    UITabBarItem *tabBarItem_3 =[self getTabBarItemOfNavController: navRootVC_3 myVC: v3 title:@"App"
                                                     normolImgName:@"tabbar_myteam_normal"
                                                     selectImgName:@"tabbar_myteam_press"];
    
    UITabBarItem *tabBarItem_4 =[self getTabBarItemOfNavController: navRootVC_4 myVC: v4 title:@"我的"
                                                     normolImgName:@"tabbar_me_normal"
                                                     selectImgName:@"tabbar_me_press"];
    // 调整tabbar
    [self setUpTabBar];
    self.mxvTabBar.items = @[tabBarItem_1,
                             tabBarItem_2,
                             tabBarItem_3,
                             tabBarItem_4];
    //设置默认 显示项
    self.mxvTabBar.selectedItem = tabBarItem_1;
    /**
     *  更换系统自带的tabbar：利用 KVC 把系统的 tabBar 类型改为自定义类型。
     *  注意：替换的位置必须在 设置 items 的后面
     */
    [self setValue:self.mxvTabBar forKey:@"tabBar"];
}

#pragma mark- 自定义 UITabBar
- (void)setUpTabBar {
    // 设置背景   （有效）、设置代理
    self.mxvTabBar = [[MXVTabBar alloc] init];
//    self.mxvTabBar.barTintColor = [UIColor whiteColor];
    self.mxvTabBar.delegate = self;
    
    // iOS 13 tabbar背景透明化和去掉分割线
    if (@available(iOS 13, *)) {
        UITabBarAppearance *appearance = [self.tabBar.standardAppearance copy];
        
//        appearance.backgroundImage = [self imageWithColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
//        appearance.backgroundImage = [UIImage imageWithColor:[UIColor clearColor]];
        
        appearance.backgroundImage = [UIImage imageWithColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
        appearance.shadowImage = [UIImage imageWithColor:[UIColor clearColor]];
        
        
       
        
        // 官方文档写的是 重置背景和阴影为透明
        [appearance configureWithTransparentBackground];
        self.mxvTabBar.standardAppearance = appearance;
        
    } else {
        self.mxvTabBar.backgroundImage = [UIImage new];
        self.mxvTabBar.shadowImage = [UIImage new];
        
//        self.mxvTabBar.backgroundImage = [self imageWithColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.5]];
//        self.mxvTabBar.shadowImage = [UIImage new];
    }
}

- (UITabBarItem *)getTabBarItemOfNavController:(UINavigationController *)navVC
                                          myVC:(UIViewController *)myVC
                                         title:(NSString *)title
                                 normolImgName:(NSString *)normolImgName
                                 selectImgName:(NSString *)selectImgName    {
    myVC.title = title;
    myVC.tabBarItem.title= title;
    
    UIImage *normolImg = [UIImage imageNamed:normolImgName];
    UIImage *selectImg = [UIImage imageNamed:selectImgName];
    
    navVC.tabBarItem.image         = [normolImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navVC.tabBarItem.selectedImage = [selectImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [navVC.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],
                                               NSForegroundColorAttributeName:[UIColor grayColor]} forState:UIControlStateNormal];
    [navVC.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],
                                               NSForegroundColorAttributeName:[UIColor blueColor]} forState:UIControlStateSelected];
    //设置导航 标题
    [navVC.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                 [UIColor blackColor],NSForegroundColorAttributeName,
                                                 [UIFont boldSystemFontOfSize:17],NSFontAttributeName, nil]];
    return navVC.tabBarItem;
}


#pragma mark- 添加突出按钮 替换索引位置的Item
- (void)addUpperButtonIndex:(NSInteger)upperIndex
{
    self.upperIndex = upperIndex;
    [self addUpperButtonWithImage:[UIImage imageNamed:@"tabbar_games_normal"]
                    selectedImage:[UIImage imageNamed:@"tabbar_games_press"]
                       upperIndex:_upperIndex];
    //（覆盖原位置Item）应该把 UITabBarItem 的图片置空 @"" ,避免UpperBtn图片没有完全覆盖 UITabBarItem图
    self.mxvTabBar.items[_upperIndex].image = [UIImage imageNamed:@""];
    self.mxvTabBar.items[_upperIndex].selectedImage = [UIImage imageNamed:@""];
    // 设置代理：UITabBarControllerDelegate 为了换页和 突出按钮Btn的状态关联上
    self.delegate = self;
    
}

#pragma mark - addCenterButton // 创建一个自定义UIButton并将它添加到我们的标签栏中

-(void)addUpperButtonWithImage:(UIImage*)norImage
                 selectedImage:(UIImage*)selectedImage
                    upperIndex:(NSInteger)upperIndex
{
    self.mxvTabBar.UpperBtn = [MXVUpperButton buttonWithType:UIButtonTypeCustom];
    self.mxvTabBar.UpperBtn.adjustsImageWhenHighlighted = NO;
    [self.mxvTabBar.UpperBtn setImage:norImage forState:UIControlStateNormal];
    [self.mxvTabBar.UpperBtn setImage:selectedImage forState:UIControlStateSelected];
    [self.mxvTabBar.UpperBtn addTarget:self action:@selector(pressChange:) forControlEvents:UIControlEventTouchUpInside];
    /*
     *  核心代码：设置button的center，同时做出相对的上浮
     */
    CGFloat itemWidth = self.mxvTabBar.frame.size.width/self.mxvTabBar.items.count;
    self.mxvTabBar.UpperBtn.frame = CGRectMake(0, 0, itemWidth, self.mxvTabBar.frame.size.height+20);
    self.mxvTabBar.UpperBtn.center = CGPointMake(itemWidth * (upperIndex+ 0.5), self.mxvTabBar.frame.size.height/2-10);
    self.mxvTabBar.UpperBtn.backgroundColor = [UIColor clearColor];
    [self.mxvTabBar addSubview:self.mxvTabBar.UpperBtn];
    
}
#pragma mark- UpperBtn 的点击响应
-(void)pressChange:(id)sender {
    NSLog(@"--> self.mxvTabBar= %d",self.mxvTabBar.hidden);
    NSLog(@"--> self.mxvTabBar.UpperBtn.selected= %d",self.mxvTabBar.UpperBtn.selected);
    NSLog(@"--> _upperIndex = %ld \n ",self.upperIndex);
    //选择器显示 突出控制器
    self.selectedIndex = _upperIndex;
    //突显图片
    self.mxvTabBar.UpperBtn.selected = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
