//
//  PointListController.m
//  VVCollectProject
//
//  Created by lvan Lewis on 2019/8/30.
//  Copyright © 2019年 Mike. All rights reserved.
//

#import "PointListController.h"
#import "BaccaratCell.h"


#define kBtnHeight 35
#define kBuyBtnHeight 50
#define kBtnFontSize 16
#define kMarginHeight 10
// 边距
#define kMarginWidth 20
#define kTrendViewHeight 138
#define kLabelFontSize 12


@interface PointListController ()<UITableViewDataSource, UITableViewDelegate>

///
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation PointListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[BaccaratCell class] forCellReuseIdentifier:@"BaccaratCell"];
}



#pragma mark -  UITableView 初始化
- (UITableView *)tableView {
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width , [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor yellowColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.rowHeight=100;   //设置每一行的高度
    }
    
    return _tableView;
}


#pragma mark - UITableViewDataSource
// //返回列表每个分组section拥有cell行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.resultDataArray.count;
}

// //配置每个cell，随着用户拖拽列表，cell将要出现在屏幕上时此方法会不断调用返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BaccaratCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BaccaratCell"];
    if(cell == nil) {
        cell = [BaccaratCell cellWithTableView:tableView reusableId:@"BaccaratCell"];
    }
    // 倒序
    cell.model = self.resultDataArray[self.resultDataArray.count - indexPath.row -1];
    return cell;
    
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 35;
}

@end
