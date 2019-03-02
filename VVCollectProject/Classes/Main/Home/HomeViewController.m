//
//  HomeViewController.m
//  VVCollectProject
//
//  Created by Mike on 2019/1/16.
//  Copyright © 2019 Mike. All rights reserved.
//

#import "HomeViewController.h"
#import "ViewController.h"
#import "BaccaratController.h"
#import "Application.h"
#import "UIColor+Hexadecimal.h"
#import "BlackJackController.h"

@interface HomeViewController ()<UITableViewDataSource, UITableViewDelegate,UISearchBarDelegate>

@property (nonatomic, strong) NSArray *applications;
// 定时器
@property (nonatomic,strong) NSTimer *timerView;
// <#strong注释#>
@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic,strong) UISearchBar *searchBar;


@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    [self initUI];
    
    //    [self navigationBar];
    //    // 导航栏 代码实现  代码实现，维护时可操作性强  可实现渐变色效果
    //    [self navigationBackColor];
    
    // 定时器
    //    [self pressStart];
    //    [self bulidView];
    
    self.title = @"Applications";
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:NULL];
    
    self.tableView.tableFooterView = [UIView new];
    
    //    self.searchDisplayController.searchResultsTableView.emptyDataSetSource = self;
    //    self.searchDisplayController.searchResultsTableView.emptyDataSetDelegate = self;
    self.searchDisplayController.searchResultsTableView.tableFooterView = [UIView new];
    [self.searchDisplayController setValue:@"" forKey:@"noResultsMessage"];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"applications" ofType:@"json"];
    self.applications = [Application applicationsFromJSONAtPath:path];
    
    [self.view addSubview:self.tableView];
//    [self searchBarInit];
}


- (void)searchBarInit {
    //    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];// 初始化
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectZero];// 初始化
    [self.searchBar setShowsCancelButton:YES animated:YES];
    [self.searchBar setShowsCancelButton:YES];// 是否显示取消按钮
    [self.searchBar setPlaceholder:@"Search"];// 搜索框的占位符
    [self.searchBar setBarStyle:UIBarMetricsDefault];
    [self.searchBar setTranslucent:YES];// 设置是否透明
    
    [self.searchBar setBarStyle:UIBarMetricsDefault];// 搜索框样式
    self.searchBar.delegate = self;// 设置代理
    [self.tableView addSubview:self.searchBar];
    [self.searchBar sizeToFit];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Resets styling
    self.navigationController.navigationBar.titleTextAttributes = nil;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHex:@"f8f8f8"];;
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
}



-(void)bulidView{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.bounds = CGRectMake(0, 0, 80, 40);
    btn.center = self.view.center;
    [btn setTitle:@"yyyy下发js脚本" forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(jsScriptRun:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

-(void)jsScriptRun:(id)sender{
    
    ViewController *vc = [[ViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)initUI {
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    label.text = @"测试";
    label.backgroundColor = [UIColor redColor];
    [self.view addSubview:label];
}

- (void)initUI2 {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    label.text = @"测试下载更新";
    label.backgroundColor = [UIColor redColor];
    [self.view addSubview:label];
}

- (void)navigationBar {
    // https://www.jianshu.com/p/011fe3c2df66
    // 导航栏 背景颜色 UI直接切图 实现
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"msg3"] forBarMetrics:UIBarMetricsDefault];
}


#pragma mark - Getters

- (NSArray *)filteredApps
{
    UISearchBar *searchBar = self.searchDisplayController.searchBar;
    
    if ([searchBar isFirstResponder] && searchBar.text.length > 0)
    {
        NSPredicate *precidate = [NSPredicate predicateWithFormat:@"displayName CONTAINS[cd] %@", searchBar.text];
        return [self.applications filteredArrayUsingPredicate:precidate];
    }
    return self.applications;
}



- (void)navigationBackColor {
    CGRect frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 64);
    
    UIImageView *imgview = [[UIImageView alloc]initWithFrame:frame];
    
    UIGraphicsBeginImageContext(imgview.frame.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
    
    CGContextScaleCTM(context, frame.size.width, frame.size.height);
    
    CGFloat colors[] = {
        
        50.0/255.0, 117.0/255.0, 224.0/255.0, 1.0,
        
        63.0/255.0, 163.0/255.0, 238.0/255.0, 1.0,
        
    };
    
    CGGradientRef backGradient = CGGradientCreateWithColorComponents(rgb, colors, NULL, sizeof(colors)/(sizeof(colors[0])*4));
    
    CGColorSpaceRelease(rgb);
    
    //设置颜色渐变的方向，范围在(0,0)与(1.0,1.0)之间，如(0,0)(1.0,0)代表水平方向渐变,(0,0)(0,1.0)代表竖直方向渐变
    
    CGContextDrawLinearGradient(context, backGradient, CGPointMake(0, 0), CGPointMake(1.0, 0), kCGGradientDrawsBeforeStartLocation);
    
    [self.navigationController.navigationBar setBackgroundImage:UIGraphicsGetImageFromCurrentImageContext()  forBarMetrics:UIBarMetricsDefault];
}


- (UIImage *)createImageWithColor:(UIColor *)color size:(CGSize)size {
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}



#pragma mark -  定时器功能
// ******** 定时器  计时器  **********
-(void)pressStart {
    
    
    // 01 手动添加到runloop运行循环中
    //    NSTimer *timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(doSomething) userInfo:nil repeats:NO];
    //    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    
    // 02 由系统自动添加到运行循环中
    //NSTimer的类方法创建一个定时器并且启动这个定时器
    //P1:每隔多长时间调用定时器函数，以秒为单位
    //P2:实现定时器函数的对象（指针）
    //P3：定时器函数对象
    //P4：可以定时器函数中一个参数，无参数可以传nil
    //P5:定时器是否重复操作YES为重复，NO只完成一次函数调用
    //返回一个新建好的定时器对象
    //    _timerView = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(uploadTimer:) userInfo:nil repeats:YES];
    
    _timerView=[NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(uploadTimer:) userInfo:@"小明" repeats:YES];
}

-(void)pressStop {
    if (_timerView!=nil) {
        //停止计时器
        [_timerView invalidate];
    }
}

//定时器函数
-(void)uploadTimer:(NSTimer*)timer {
    NSLog(@"test......name=%@",timer.userInfo);
    UIView* view=[self.view viewWithTag:103];
    view.frame=CGRectMake(view.frame.origin.x+5, view.frame.origin.y+5, 80, 80);
}


#pragma mark -  UITableView 初始化
- (UITableView *)tableView {
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width , [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
        //        _tableView.backgroundColor = [UIColor whiteColor];
        //        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.rowHeight=100;   //设置每一行的高度
//        _tableView.scrollEnabled = NO;  //设置tableview 不能滚动
    }
    
    return _tableView;
}


#pragma mark - UITableViewDataSource Methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"app_cell_identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    Application *app = [[self filteredApps] objectAtIndex:indexPath.row];
    
    cell.textLabel.text = app.displayName;
    cell.detailTextLabel.text = app.developerName;
    
    UIImage *image = [UIImage imageNamed:app.iconName];
    cell.imageView.image = image;
    
    cell.imageView.layer.cornerRadius = image.size.width*0.2;
    cell.imageView.layer.masksToBounds = YES;
    cell.imageView.layer.borderColor = [UIColor colorWithWhite:0.0 alpha:0.2].CGColor;
    cell.imageView.layer.borderWidth = 0.5;
    cell.imageView.layer.shouldRasterize = YES;
    cell.imageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;  // 右箭头
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSInteger rowCount = [self filteredApps].count;
    return rowCount;
}

#pragma mark - UITableViewDelegate Methods
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 70.0;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        BaccaratController *vc = [[BaccaratController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } if (indexPath.row == 1) {
        
        BlackJackController *vc = [[BlackJackController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        [self doPush];
    }
    
    //    Application *app = [[self filteredApps] objectAtIndex:indexPath.row];
    //    DetailViewController *controller = [[DetailViewController alloc] initWithApplication:app];
    //    controller.applications = self.applications;
    //    controller.allowShuffling = YES;
    //
    //    if ([controller preferredStatusBarStyle] == UIStatusBarStyleLightContent) {
    //        self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    //    }
    //
    //    [self.navigationController pushViewController:controller animated:YES];
    
}



// 防止多次push   RepeatPush 文件夹类
- (void)doPush {
    ViewController *vc = [[ViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    vc = [[ViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    vc = [[ViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    //    vc = [[ViewController alloc] init];
    //    [self.navigationController pushViewController:vc animated:YES];
    //    vc = [[ViewController alloc] init];
    //    [self.navigationController pushViewController:vc animated:YES];
    //    vc = [[ViewController alloc] init];
    //    [self.navigationController pushViewController:vc animated:YES];
}



#pragma mark - UISearchBarDelegate Methods

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    return YES;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    return YES;
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    // Do something
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    // Do something
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    // Do something
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    // Do something
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    // Do something
}


#pragma mark - UISearchDisplayDelegate Methods

- (void)searchDisplayControllerDidBeginSearch:(UISearchDisplayController *)controller
{
    // Do something
}

- (void)searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller
{
    // Do something
}

- (void)searchDisplayController:(UISearchDisplayController *)controller didShowSearchResultsTableView:(UITableView *)tableView
{
    // Do something
}

- (void)searchDisplayController:(UISearchDisplayController *)controller didLoadSearchResultsTableView:(UITableView *)tableView
{
    // Do something
}


@end

