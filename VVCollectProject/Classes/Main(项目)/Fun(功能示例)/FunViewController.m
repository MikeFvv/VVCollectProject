//
//  GameViewController.m
//  VVCollectProject
//
//  Created by Admin on 2021/12/13.
//  Copyright © 2021 Mike. All rights reserved.
//

#import "FunViewController.h"
#import "FunModel.h"
#import "NSAttrViewController.h"


@interface FunViewController ()<UITableViewDataSource, UITableViewDelegate,UISearchBarDelegate>

/// 表单
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation FunViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)createUI {
    self.view.backgroundColor = [UIColor redColor];
    
    
    [self.view addSubview:self.tableView];
}

#pragma mark - Getters

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        FunModel *model1 = [[FunModel alloc] init];
        model1.title = @"NSAttributedStringManager";
        model1.des = @"改变一句话中的某些字的颜色，一种颜色、多种颜色";
        model1.iconName = @"com_ph_avatar";
        
        FunModel *model2 = [[FunModel alloc] init];
        model2.title = @"NSAttributedStringManager";
        model2.des = @"改变一句话中的某些字的颜色，一种颜色、多种颜色";
        model2.iconName = @"com_ph_avatar";
        
        FunModel *model3 = [[FunModel alloc] init];
        model3.title = @"NSAttributedStringManager";
        model3.des = @"改变一句话中的某些字的颜色，一种颜色、多种颜色";
        model3.iconName = @"com_ph_avatar";
        
        _dataArray = [NSMutableArray arrayWithArray:@[model1, model2, model3]];
    }
    return _dataArray;
}



#pragma mark -  UITableView 初始化
- (UITableView *)tableView {
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width , [UIScreen mainScreen].bounds.size.height - kiPhoneX_Top_Height) style:UITableViewStylePlain];
        //        _tableView.backgroundColor = [UIColor whiteColor];
        //        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.rowHeight=100;   //设置每一行的高度
        _tableView.tableHeaderView = nil;
        _tableView.tableFooterView = [UIView new];
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
    
    
    FunModel *model = [[self dataArray] objectAtIndex:indexPath.row];
    
    cell.textLabel.text = model.title;
    cell.detailTextLabel.text = model.des;
    
    UIImage *image = [UIImage imageNamed:model.iconName];
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
    
    //    NSInteger rowCount = [self filteredApps].count;
    //    return rowCount;
    
    return self.dataArray.count;
}

#pragma mark - UITableViewDelegate Methods
// 设置Cell行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 70.0;
}

-(void)dismiss
{
    [MBProgressHUD hideHUD];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        NSAttrViewController *vc = [[NSAttrViewController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 1) {
        //        BlackJackController *vc = [[BlackJackController alloc] init];
        //        [self.navigationController pushViewController:vc animated:YES];
    }  else if (indexPath.row == 3) {
        //        HackerViewController *vc = [HackerViewController new];
        //        [self.navigationController pushViewController:vc animated:YES];
        
    } else if (indexPath.row == 2 || indexPath.row == 4 || indexPath.row == 6) {
        //        [self goto_ChatController];
        
        //        [MBProgressHUD showActivityMessageInWindow:nil];
        //        [self performSelector:@selector(dismiss) withObject:nil afterDelay:2];
    } else if (indexPath.row == 5) {
        
        //        TestVS *vc = [TestVS new];
        //        [self.navigationController pushViewController:vc animated:YES];
        
    } else if (indexPath.row == 7) {
        //        [self goto_viewController];
    }
    
    else {
        //        [self doPush];
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

@end

