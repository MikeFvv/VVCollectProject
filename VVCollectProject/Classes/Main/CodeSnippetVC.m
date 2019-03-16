//
//  CodeSnippetVC.m
//  VVCollectProject
//
//  Created by Mike on 2018/12/29.
//  Copyright © 2018 Mike. All rights reserved.
//

#import "CodeSnippetVC.h"

// 代码块控制器
@interface CodeSnippetVC ()

@end

@implementation CodeSnippetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}



- (void)property {
    /*
     
     // <#assign注释#>
     @property (nonatomic,assign) <#Class#> <#property#>;
     // <#block注释#>
     @property (nonatomic,copy) <#Block#> <#block#>;
     // <#copy注释#>
     @property (nonatomic,copy) NSString *<#string#>;
     // <#delegate注释#>
     @property (nonatomic,weak) id<<#protocol#>> <#delegate#>;
     // <#strong注释#>
     @property (nonatomic,strong) <#Class#> *<#object#>;
     // <#weak注释#>
     @property (nonatomic,weak) <#Class#> *<#object#>;
     
     #pragma mark -  <#要注释的内容#>
     
     */
}



#pragma mark - vvUITableView
//- (UITableView *)tableView{
//    if (!_tableView) {
//        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT) style:UITableViewStyleGrouped];
//        _tableView.backgroundColor = [UIColor whiteColor];
//        _tableView.dataSource = self;
//        _tableView.delegate = self;
//        self.tableView.tableHeaderView = self.headView;
//        if (@available(iOS 11.0, *)) {
//            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//        } else {
//            // Fallback on earlier versions
//        }
//
//        _tableView.estimatedRowHeight = 0;
//        _tableView.estimatedSectionHeaderHeight = 0;
//        _tableView.estimatedSectionFooterHeight = 0;
//    }
//    return _tableView;
//}
//
//#pragma mark - UITableViewDataSource
//// //返回列表每个分组section拥有cell行数
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//
//    return 0;
//}
//
//// //配置每个cell，随着用户拖拽列表，cell将要出现在屏幕上时此方法会不断调用返回cell
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    // 1.定义一个cell的标识
//    static NSString *ID = @"reuseIdentifier";
//    // 2.从缓存池中取出cell
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//    // 3.如果缓存池中没有cell
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
//    }
//    cell.textLabel.text = @"aaa";
//    cell.detailTextLabel.text = @"bbb";
//    // 4.设置cell的属性...
//    return cell;
//    return cell;
//}
#pragma mark - vvUILabel
//UILabel *nameLabel = [[UILabel alloc] init];
//nameLabel.text = @"闲赢";
//nameLabel.font = [UIFont systemFontOfSize:16];
//nameLabel.textColor = [UIColor darkGrayColor];
//nameLabel.numberOfLines = 0;
//nameLabel.textAlignment = NSTextAlignmentCenter;
//[self.view addSubview:nameLabel];
//_nameLabel = nameLabel;
//
//[nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//    make.top.mas_equalTo(self.view.mas_bottom).offset(10);
//    make.left.mas_equalTo(self.view.mas_left).offset(10);
//}];
#pragma mark - vvUIButton
//UIButton *confirmBtn = [[UIButton alloc] init];
//[confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
//confirmBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
//[confirmBtn addTarget:self action:@selector(confirmBtn:) forControlEvents:UIControlEventTouchUpInside];
//confirmBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
//[confirmBtn setImage:[UIImage imageNamed:@"dial_mute"] forState:UIControlStateNormal];
//confirmBtn.backgroundColor = [UIColor redColor];
//confirmBtn.layer.borderWidth = 1.0;
//confirmBtn.layer.borderColor = [UIColor whiteColor].CGColor;
//confirmBtn.layer.cornerRadius = 5;
//confirmBtn.tag = 103;
//[self.view addSubview:confirmBtn];
//
//[confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//    make.top.mas_equalTo(self.view.mas_bottom).offset(100);
//    make.left.mas_equalTo(self.view.mas_left).offset(100);
//    make.size.mas_equalTo(CGSizeMake(100, 50));
//}];
#pragma mark - vvUIView
//UIView *backView = [[UIView alloc] init];
//backView.backgroundColor = [UIColor greenColor];
//[self.view addSubview:backView];
//
//[backView mas_makeConstraints:^(MASConstraintMaker *make) {
//    make.top.mas_equalTo(self.view.mas_bottom).offset(10);
//    make.left.mas_equalTo(self.view.mas_left).offset(10);
//    make.right.mas_equalTo(self.view.mas_right).offset(-10);
//    make.height.mas_equalTo(100);
//}];



@end
