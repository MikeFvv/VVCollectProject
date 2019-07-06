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
     @property (nonatomic, assign) <#Class#> <#property#>;
     // <#block注释#>
     @property (nonatomic, copy) <#Block#> <#block#>;
     // <#copy注释#>
     @property (nonatomic, copy) NSString *<#string#>;
     // <#delegate注释#>
     @property (nonatomic, weak) id<<#protocol#>> <#delegate#>;
     // <#strong注释#>
     @property (nonatomic, strong) <#Class#> *<#object#>;
     // <#weak注释#>
     @property (nonatomic, weak) <#Class#> *<#object#>;
     
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
//nameLabel.text = @"-";
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
#pragma mark - vvUIImageView
//UIImageView *backImageView = [[UIImageView alloc] init];
//backImageView.image = [UIImage imageNamed:@"imageName"];
//[self.view addSubview:backImageView];
//
//[backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//    make.top.left.right.equalTo(self.view);
//    make.height.equalTo(@(200));
//}];

#pragma mark - vvUITextField
//UITextField *textField = [[UITextField alloc] init];
////    textField.tag = 100;
//// textField.backgroundColor = [UIColor greenColor];  // 更改背景颜色
//textField.borderStyle = UITextBorderStyleRoundedRect;  //边框类型
//textField.font = [UIFont boldSystemFontOfSize:14.0];  // 字体
//textField.textColor = [UIColor blueColor];  // 字体颜色
////    textField.textAlignment = NSTextAlignmentLeft;  // 文本对齐方式
////    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter; // 垂直对齐
////    textField.adjustsFontSizeToFitWidth = YES; // 文字缩放
////    textField.minimumFontSize = 40.0; // 缩放后最小字号
////textField.text = @"请输入账号"; // 文本
//textField.placeholder = @"请输入账号"; // 占位文字
//textField.clearButtonMode = UITextFieldViewModeAlways; // 清空按钮
////textField.clearsOnBeginEditing = YES; // 当编辑时清空
////textField.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters; // 自动大写
////    textField.autocorrectionType = UITextAutocorrectionTypeNo; // 单词检测 是否是单词 显示下划线
////textField.background
//textField.delegate = self;
////textField.keyboardAppearance = UIKeyboardAppearanceAlert; // 键盘样式
//textField.keyboardType = UIKeyboardTypeEmailAddress; // 键盘类型
//textField.returnKeyType = UIReturnKeyGo;
////    textField.secureTextEntry = YES; // 密码
////    textField.layer.cornerRadius = 5.0; // 圆角 导入QuartzCore.framework, 引用#import <QuartzCore/QuartzCore.h>
////    textField.borderStyle = UITextBorderStyleRoundedRect; // 光标过于靠前
//
//[textField mas_makeConstraints:^(MASConstraintMaker *make) {
//    make.top.mas_equalTo(self.view.mas_top);
//    make.left.mas_equalTo(self.view.mas_left);
//    make.right.mas_equalTo(self.view.mas_right);
//    make.height.mas_equalTo(@(40));
//}];

#pragma mark - scrollView
// 注意事项
// 当我们在view中添加了一个scrollView并设置其约束后，再向scrollView中添加一个以scrollView为基准的约束的控件时，约束会报错，这是因为scrollView需要根据添加在其内部的子控件的宽高及与四周的距离计算出它的contentSize，也就是说内部子控件约束的添加需要遵循两个原则:
//1、scrollView内部子控件的尺寸不能以scrollView的尺寸为参照
//2、scrollView内部的子控件的约束必须完整
//解决方法：
//1、提供一个具体值的约束
//2、子控件的尺寸可以参照scrollView以外其它的控件的尺寸(如控制器的view的尺寸)
//- (UIScrollView *)scrollView {
//    if (!_scrollView) {
//        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];;
//        _scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)+1000); // 设置UIScrollView的滚动范围
//        _scrollView.pagingEnabled = YES;
//        //        _scrollView.scrollEnabled = YES;
//        _scrollView.delegate = self;
//        // 隐藏水平滚动条
//        _scrollView.showsHorizontalScrollIndicator = NO;
//        //        _scrollView.showsVerticalScrollIndicator = NO;
//        _scrollView.bounces = NO; // 去掉弹簧效果
//        _scrollView.backgroundColor = [UIColor whiteColor];
//    }
//    return _scrollView;
//}




// 单例

//static id *_instance = nil;
//
//+ (instancetype)shareInstance
//{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        _instance = [[self alloc] init];
//    });
//    return _instance;
//}





@end
