//
//  MMOtherCodingBlock.h
//  xxCollectProject
//
//  Created by Mike on 2020/2/11.
//  Copyright © 2020 Mike. All rights reserved.
//

#ifndef MMOtherCodingBlock_h
#define MMOtherCodingBlock_h


/// extension代码 xxextension
@interface <#class#> ()

@end



/// ignored代码 xxignore
#pragma clang diagnostic push
#pragma clang diagnostic ignored <#"-Wdeprecated-declarations"#>
<#code#>
#pragma clang diagnostic pop



/// singleTon代码 xxsingle
static id *_instance = nil;

+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}



/// init代码 xxinit
#pragma mark - 👀 Init Method 👀 💤

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        // 设置默认参数
        [self setupDefaults];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
}




/// lazyLoad代码 xxlazy
- (<#Class#> *)<#para#>
{
    if (!<#para#>)
    {
        <#para#> = [<#Class#> <#classMethod#>];
    }
    return <#para#>;
}



/// afterDispath代码 xxafter
dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(<#delayInSeconds#> * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    <#code to be executed after a specified delay#>
});



/// cellRegister代码 xxregister
[self.tableView registerNib:[UINib nibWithNibName:<#(nonnull NSString *)#> bundle:nil] forCellReuseIdentifier:<#(nonnull NSString *)#>];



/// tableViewDataSource代码 xxcell
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return <#section#>;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    <#cellClass#> *<#cell#> = [tableView dequeueReusableCellWithIdentifier:<#(nonnull NSString *)#> forIndexPath:<#(nonnull NSIndexPath *)#>];
    return <#cell#>;
}



/// alertViewController代码 xxalertview

/// 弹出 警告框
UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:<#title#> message:<#message#> preferredStyle:UIAlertControllerStyleAlert];

// 点击取消
UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:<#title#> style:UIAlertActionStyleDefault handler:<#^(UIAlertAction * _Nonnull action)handler#>];

// 点击确定
UIAlertAction *enterAction = [UIAlertAction actionWithTitle:<#title#> style:UIAlertActionStyleDefault handler:<#^(UIAlertAction * _Nonnull action)handler#>];

[alertVc addAction:cancelAction];
[alertVc addAction:enterAction];

[self presentViewController:alertVc animated:YES completion:NULL];

















     

     


#pragma mark - xxUITableView
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        self.tableView.tableHeaderView = self.headView;
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            // Fallback on earlier versions
        }
 
        _tableView.rowHeight = 76;   // 行高
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;  // 去掉分割线
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
    }
    return _tableView;
}

 
#pragma mark - UITableViewDataSource
//返回列表每个分组section拥有cell行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 0;
}

//配置每个cell，随着用户拖拽列表，cell将要出现在屏幕上时此方法会不断调用返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 1.定义一个cell的标识
    static NSString *ID = @"reuseIdentifier";
    // 2.从缓存池中取出cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    // 3.如果缓存池中没有cell
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.textLabel.text = @"aaa";
    cell.detailTextLabel.text = @"bbb";
    // 4.设置cell的属性...
    return cell;
}
 


#pragma mark - xxUILabel
UILabel *nameLabel = [[UILabel alloc] init];
nameLabel.text = @"-";
nameLabel.font = [UIFont systemFontOfSize:14];
nameLabel.textColor = [UIColor darkGrayColor];
nameLabel.textAlignment = NSTextAlignmentCenter;
[self.view addSubview:nameLabel];
_nameLabel = nameLabel;

[nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.view.mas_top).offset(10);
    make.left.equalTo(self.view.mas_left).offset(10);
}];

 
#pragma mark - xxUIButton
UIButton *confirmBtn = [[UIButton alloc] init];
[confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
[confirmBtn addTarget:self action:@selector(confirmBtn:) forControlEvents:UIControlEventTouchUpInside];
confirmBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
[confirmBtn setImage:[UIImage imageNamed:@"dial_mute"] forState:UIControlStateNormal];
confirmBtn.backgroundColor = [UIColor redColor];
confirmBtn.layer.borderWidth = 1.0;
confirmBtn.layer.borderColor = [UIColor whiteColor].CGColor;
confirmBtn.layer.cornerRadius = 5;
confirmBtn.tag = 103;
[self.view addSubview:confirmBtn];

[confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.view.mas_top).offset(100);
    make.left.equalTo(self.view.mas_left).offset(100);
    make.size.mas_equalTo(CGSizeMake(100, 50));
}];



#pragma mark - xxUIView

UIView *backView = [[UIView alloc] init];
backView.backgroundColor = [UIColor greenColor];
[self.view addSubview:backView];

[backView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.view.mas_top).offset(10);
    make.left.equalTo(self.view.mas_left).offset(10);
    make.right.equalTo(self.view.mas_right).offset(-10);
    make.height.mas_equalTo(100);
}];

/// xxLineView
UIView *lineView = [[UIView alloc] init];
lineView.backgroundColor = [UIColor greenColor];
[self.view addSubview:lineView];

[lineView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.left.right.equalTo(self);
    make.height.mas_equalTo(1);
}];


#pragma mark - xxUIImageView
UIImageView *backImageView = [[UIImageView alloc] init];
backImageView.image = [UIImage imageNamed:@"imageName"];
[self.view addSubview:backImageView];

[backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.left.right.equalTo(self.view);
    make.height.equalTo(@(200));
}];



#pragma mark - xxUITextView
UITextView* textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 20, 300, 330)];
textView.backgroundColor = [UIColor grayColor];
//文本
textView.text = @"aaweqtrehgtbwsagas 123456 撒旦法师打发四的发生的 阿斯顿发送到发送到发阿斯顿发生阿斯蒂芬 撒旦法阿斯蒂芬";
//字体
textView.font = [UIFont boldSystemFontOfSize:20.0];
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

//textView.scrollEnabled = YES;//滑动
//textView.returnKeyType = UIReturnKeyDone;//返回键类型
//textView.keyboardType = UIKeyboardTypeDefault;//键盘类型
//textView.autoresizingMask = UIViewAutoresizingFlexibleHeight;//自适应
//textView.dataDetectorTypes = UIDataDetectorTypeAll;//数据类型连接模式
//textView.autocorrectionType = UITextAutocorrectionTypeNo;//自动纠错方式
//textView.autocapitalizationType = UITextAutocapitalizationTypeNone;//自动大写方式
//
////禁止文字居中或下移64，因为avigationController下scrollView自动适应屏幕，而UITextView继承自UIScrollView
//if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
//    self.automaticallyAdjustsScrollViewInsets = NO;
//}
[self.view addSubview:textView];


#pragma mark - xxUITextField
UITextField *textField = [[UITextField alloc] init];
//    textField.tag = 100;
// textField.backgroundColor = [UIColor greenColor];  // 更改背景颜色
textField.borderStyle = UITextBorderStyleRoundedRect;  //边框类型
textField.font = [UIFont boldSystemFontOfSize:14.0];  // 字体
textField.textColor = [UIColor blueColor];  // 字体颜色
//    textField.textAlignment = NSTextAlignmentLeft;  // 文本对齐方式
//    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter; // 垂直对齐
//    textField.adjustsFontSizeToFitWidth = YES; // 文字缩放
//    textField.minimumFontSize = 40.0; // 缩放后最小字号
//textField.text = @"请输入账号"; // 文本
textField.placeholder = @"请输入账号"; // 占位文字
textField.clearButtonMode = UITextFieldViewModeAlways; // 清空按钮
//textField.clearsOnBeginEditing = YES; // 当编辑时清空
//textField.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters; // 自动大写
//    textField.autocorrectionType = UITextAutocorrectionTypeNo; // 单词检测 是否是单词 显示下划线
//textField.background
textField.delegate = self;
//textField.keyboardAppearance = UIKeyboardAppearanceAlert; // 键盘样式
textField.keyboardType = UIKeyboardTypeEmailAddress; // 键盘类型
textField.returnKeyType = UIReturnKeyGo;
//    textField.secureTextEntry = YES; // 密码
//    textField.layer.cornerRadius = 5.0; // 圆角 导入QuartzCore.framework, 引用#import <QuartzCore/QuartzCore.h>
//    textField.borderStyle = UITextBorderStyleRoundedRect; // 光标过于靠前

[textField mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.view.mas_top);
    make.left.equalTo(self.view.mas_left);
    make.right.equalTo(self.view.mas_right);
    make.height.mas_equalTo(40);
}];
 
 



#pragma mark - xxUIScrollView
// 注意事项
// 当我们在view中添加了一个scrollView并设置其约束后，再向scrollView中添加一个以scrollView为基准的约束的控件时，约束会报错，这是因为scrollView需要根据添加在其内部的子控件的宽高及与四周的距离计算出它的contentSize，也就是说内部子控件约束的添加需要遵循两个原则:
//1、scrollView内部子控件的尺寸不能以scrollView的尺寸为参照
//2、scrollView内部的子控件的约束必须完整
//解决方法：
//1、提供一个具体值的约束
//2、子控件的尺寸可以参照scrollView以外其它的控件的尺寸(如控制器的view的尺寸)
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];;
        _scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)+1000); // 设置UIScrollView的滚动范围
        _scrollView.pagingEnabled = YES;
        //        _scrollView.scrollEnabled = YES;
        _scrollView.delegate = self;
        // 隐藏水平滚动条
        _scrollView.showsHorizontalScrollIndicator = NO;
        //        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.bounces = NO; // 去掉弹簧效果
        _scrollView.backgroundColor = [UIColor whiteColor];
    }
    return _scrollView;
}


#endif /* MMOtherCodingBlock_h */
