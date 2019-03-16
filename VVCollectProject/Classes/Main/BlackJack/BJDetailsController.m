//
//  BJDetailsController.m
//  VVCollectProject
//
//  Created by 罗耀生 on 2019/3/11.
//  Copyright © 2019 Mike. All rights reserved.
//

#import "BJDetailsController.h"
#import "PlayCardModel.h"
#import "BlackJackCell.h"

@interface BJDetailsController ()<UITableViewDataSource, UITableViewDelegate>

// <#strong注释#>
@property (nonatomic,strong) UITableView *tableView;

@end

@implementation BJDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT - Height_NavBar) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor redColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
//        self.tableView.tableHeaderView = self.headView;
//        if (@available(iOS 11.0, *)) {
//            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//        } else {
//            // Fallback on earlier versions
//        }
        
        _tableView.estimatedRowHeight = 45;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
    }
    return _tableView;
}

#pragma mark - UITableViewDataSource
// //返回列表每个分组section拥有cell行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

// //配置每个cell，随着用户拖拽列表，cell将要出现在屏幕上时此方法会不断调用返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BlackJackCell *cell = [BlackJackCell cellWithTableView:tableView reusableId:@"BlackJackCell"];
    // 倒序
    cell.model = self.dataArray[self.dataArray.count - indexPath.row -1];
    cell.indexLabel.text = [NSString stringWithFormat:@"%zd", self.dataArray.count - indexPath.row -1];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
}


@end
