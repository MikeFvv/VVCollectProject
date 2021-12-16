//
//  BJDetailsController.m
//  VVCollectProject
//
//  Created by Mike on 2019/3/11.
//  Copyright © 2019 Mike. All rights reserved.
//

#import "BJDetailsController.h"
#import "PokerCardModel.h"
#import "BlackJackCell.h"

@interface BJDetailsController ()<UITableViewDataSource, UITableViewDelegate>

/// <#strong注释#>
@property (nonatomic, strong) UITableView *tableView;

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
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
//        self.tableView.tableHeaderView = self.headView;
//        if (@available(iOS 11.0, *)) {
//            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//        } else {
//            // Fallback on earlier versions
//        }
        
        _tableView.estimatedRowHeight = 50;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        
        [_tableView registerClass:[BlackJackCell class] forCellReuseIdentifier:@"BlackJackCell"];
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

    BlackJackCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BlackJackCell"];
    if(cell == nil) {
        cell = [BlackJackCell cellWithTableView:tableView reusableId:@"BlackJackCell"];
    }
    
    // 倒序
    cell.model = self.dataArray[self.dataArray.count - indexPath.row -1];
    cell.indexLabel.text = [NSString stringWithFormat:@"%zd", self.dataArray.count - indexPath.row -1];
    return cell;
}

#pragma mark - UITableViewDelegate
// 设置Cell行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
}


// 节头和页脚信息。 如果您决定提供两者，则视图优先于标题  2个
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    // custom view for header. will be adjusted to default or specified header height
    //标题的自定义视图。 将被调整为默认或指定的标题高度
    UIView *backView = [[UIView alloc] init];
    
    
    UILabel *titLabel = [[UILabel alloc] init];
    titLabel.text = @"玩家牌型/庄家牌型";
    titLabel.font = [UIFont systemFontOfSize:9];
    titLabel.textColor = [UIColor darkGrayColor];
    titLabel.textAlignment = NSTextAlignmentCenter;
    [backView addSubview:titLabel];
    
    [titLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(backView.mas_centerY);
        make.left.equalTo(backView.mas_left).offset(30);
    }];
    
    

    UILabel *dLabel = [[UILabel alloc] init];
    dLabel.text = @"是否加倍";
    dLabel.font = [UIFont systemFontOfSize:10];
    dLabel.textColor = [UIColor darkGrayColor];
    dLabel.textAlignment = NSTextAlignmentCenter;
    [backView addSubview:dLabel];
    
    [dLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(backView.mas_centerY);
        make.left.equalTo(backView.mas_centerX).offset(30);
    }];
    
    
    UILabel *aLabel = [[UILabel alloc] init];
    aLabel.text = @"是否有A";
    aLabel.font = [UIFont systemFontOfSize:10];
    aLabel.textColor = [UIColor darkGrayColor];
    aLabel.textAlignment = NSTextAlignmentCenter;
    [backView addSubview:aLabel];
    
    [aLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(backView.mas_centerY);
        make.left.equalTo(backView.mas_centerX).offset(100);
    }];
    
    return backView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

@end
