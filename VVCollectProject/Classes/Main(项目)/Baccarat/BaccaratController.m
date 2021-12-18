//
//  BaccaratController.m
//  VVCollectProject
//
//  Created by Mike on 2019/2/20.
//  Copyright © 2019 Mike. All rights reserved. 1 2 3
//

#import "BaccaratController.h"
#import "BaccaratCollectionView.h"
#include <stdlib.h>
#import "VVFunctionManager.h"
#import "PointListController.h"
#import <MBProgressHUD.h>
#import "BaccaratConfigController.h"
#import "BaccaratResultModel.h"
#import "BaccaratRoadMapView.h"
#import "CardDataSourceModel.h"
#import "BAnalyzeRoadMapView.h"
#import "BShowPokerView.h"
#import "BaccaratCom.h"
#import "FunctionManager.h"
#import "WMDragView.h"


#define kBtnHeight 35
#define kBuyBtnHeight 50
#define kBtnFontSize 16
#define kMarginHeight 10
// 边距
#define kMarginWidth 15
#define kTrendViewHeight 138
#define kLabelFontSize 12

#define kColorAlpha 0.9

@interface BaccaratController ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *contentView;
//
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UIView *bottomView;

/// 下注金额
@property (nonatomic, assign) NSInteger betMoney;
/// 下注输赢总金额
@property (nonatomic, assign) NSInteger betTotalMoney;
/// 最高总金额
@property (nonatomic, assign) NSInteger maxBetTotalMoney;
/// 最低总金额
@property (nonatomic, assign) NSInteger minBetTotalMoney;

@property (nonatomic, strong) UILabel *maxLabel;
@property (nonatomic, strong) UILabel *minLabel;


/// 庄闲和 0 和 1 庄 2 闲
@property (nonatomic, assign) NSInteger buyType;
/// 间隔局数量
@property (nonatomic, assign) NSInteger intervalNum;

/// 牌副数
@property (nonatomic, strong) UITextField *pokerNumTextField;
/// 下注金额
@property (nonatomic, strong) UITextField *betMoneyTextField;


/// 牌的总张数
@property (nonatomic, assign) NSInteger pokerTotalNum;
/// 发牌局数
@property (nonatomic, assign) NSInteger pokerCount;

/// 闲总局数
@property (nonatomic, assign) NSInteger playerTotalCount;
/// 庄总局数
@property (nonatomic, assign) NSInteger bankerTotalCount;

/// 闲对局数
@property (nonatomic, assign) NSInteger playerPairCount;
/// 庄对局数
@property (nonatomic, assign) NSInteger bankerPairCount;
/// 每局的 Pair 统计， 一次出2个也算1个
@property (nonatomic, assign) NSInteger bankerPlayerSinglePairCount;

/// Super6
@property (nonatomic, assign) NSInteger superSixCount;
/// 和局
@property (nonatomic, assign) NSInteger tieCount;

@property (nonatomic, strong) BaccaratCollectionView *trendView;
/// 大路
@property (nonatomic, strong) BaccaratRoadMapView *roadmapView;



/// 结果数据
@property (nonatomic, strong) NSMutableArray *resultDataArray;


@property (nonatomic, strong) UILabel *pokerCountLabel;
@property (nonatomic, strong) UILabel *bankerTotalCountLabel;
@property (nonatomic, strong) UILabel *playerTotalCountLabel;
@property (nonatomic, strong) UILabel *tieCountLabel;
@property (nonatomic, strong) UILabel *bankerPairCountLabel;
@property (nonatomic, strong) UILabel *playerPairCountLabel;
@property (nonatomic, strong) UILabel *superSixCountLabel;
@property (nonatomic, strong) UILabel *kkkLabel;
@property (nonatomic, strong) UILabel *buyMoneyLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *aaaa;
@property (nonatomic, strong) UILabel *bbbb;
@property (nonatomic, strong) UILabel *gongLabel;





/// 买庄
@property (nonatomic, strong) UIButton *buyBankerBtn;
/// 买闲
@property (nonatomic, strong) UIButton *buyPlayerBtn;
/// 本局赢的类型  0 和  1 庄  2 闲
@property (nonatomic, assign) NSInteger currentWinType;





// ************************ 统计字段 ************************
/// 跳转的
@property (nonatomic, assign) NSInteger jumpsCount;
@property (nonatomic, assign) NSInteger continuous2;
@property (nonatomic, assign) NSInteger continuous3;
@property (nonatomic, assign) NSInteger continuous4;
@property (nonatomic, assign) NSInteger continuous5;
@property (nonatomic, assign) NSInteger continuous6;
@property (nonatomic, assign) NSInteger continuous7;
@property (nonatomic, assign) NSInteger continuous8;
/// 单跳
@property (nonatomic, assign) NSInteger singleJumpCount;

@property (nonatomic, assign) NSInteger bankerPairOrplayerPairContinuousCount;
/// 庄闲间隔局数数量
@property (nonatomic, assign) NSInteger bankerPairOrplayerPairIntervalCount;
@property (nonatomic, assign) NSInteger playerPairContinuousCount;
@property (nonatomic, assign) NSInteger superSixContinuousCount;

/// 距离前6局的相同的数量
@property (nonatomic, assign) NSInteger front6SameCount;

/// 计算出公的张数
@property (nonatomic, assign) NSInteger gongCount;

/// 是否自动运行全部
@property (nonatomic, assign) BOOL isAutoRunAll;
@property (strong, nonatomic) CardDataSourceModel *baccaratDataModel;

/// 分析路图
@property (nonatomic, strong) BAnalyzeRoadMapView *analyzeRoadMapView;
/// 显示牌型视图
@property (nonatomic, strong) BShowPokerView *showPokerView;


/// *** 测试时使用 ***
@property (nonatomic, assign) NSInteger testIndex;


@property(nonatomic,strong) WMDragView *dragView;

@end

@implementation BaccaratController

//    Poker
//    spade  黑桃
//    heart  红桃（红心）
//    club  梅花
//    diamond 方块
//    joker  大王 小王（小丑意思）
//    PokerColor  花色

//    ♡♢♤♧♣♦♥♠

//    🔵 💚
//    4种
//    1 2 3 4 5 6 7 8 9 10 11 12 13
//    A 2 3 4 5 6 7 8 9 10 L Q K

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 允许屏幕旋转
//    AppDelegate *appdelegete = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    appdelegete.allowRotation = YES;
    [FunctionManager interfaceOrientation:UIInterfaceOrientationLandscapeRight];
    
    self.testIndex = 0;
    self.isAutoRunAll = NO;
    
    [self setupNavUI];
    [self createUI];
    [self initData];
    
    self.title = [NSString stringWithFormat:@"%ld", self.betTotalMoney];
    
    
    [self setFloatingBackBtnView];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewWillAppear:YES];
    [FunctionManager interfaceOrientation:UIInterfaceOrientationPortrait];
}




#pragma mark -  数据初始化
- (void)initData {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSInteger amount = [userDefaults integerForKey:@"BaccaratBetAmount"];
    NSArray *tempArray = [userDefaults objectForKey:@"BaccaratPokerArray"];
    
    
    NSArray *pokerArray = nil;
    if (tempArray) {
        self.betTotalMoney = amount;
        self.maxBetTotalMoney = amount;
        self.minBetTotalMoney = amount;
        pokerArray = tempArray;
    } else {
        self.betTotalMoney = 40000;
        self.maxBetTotalMoney = 40000;
        self.minBetTotalMoney = 40000;
        
        pokerArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",
                       @"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",
                       @"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",
                       @"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13"
                       ];
    }
    
    self.betMoney = 2000;
    self.intervalNum = 1;
    
    
    self.pokerTotalNum = self.dataArray.count;
    self.pokerCount = 0;
    self.playerTotalCount = 0;
    self.bankerTotalCount = 0;
    self.playerPairCount = 0;
    self.bankerPairCount = 0;
    self.superSixCount = 0;
    self.tieCount = 0;
    self.gongCount = 0;
    self.resultDataArray = [NSMutableArray array];
    self.bankerPlayerSinglePairCount = 0;
    self.buyType = -1;
}

- (NSMutableArray*)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithArray:[VVFunctionManager shuffleArray:self.baccaratDataModel.sortedDeckArray pokerPairsNum:self.pokerNumTextField.text.integerValue]];
    }
    return _dataArray;
}

- (CardDataSourceModel*)baccaratDataModel
{
    if (!_baccaratDataModel)
    {
        _baccaratDataModel = [[CardDataSourceModel alloc] init];
    }
    return _baccaratDataModel;
}


- (void)configAction {
    BaccaratConfigController *vc = [[BaccaratConfigController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)rightBtnAction {
    PointListController *vc = [[PointListController alloc] init];
    vc.resultDataArray = self.resultDataArray;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //    [self configureNavigationBar];
    // 要刷新状态栏，让其重新执行该方法需要调用{-setNeedsStatusBarAppearanceUpdate}
    //    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

}

- (void)createUI {
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT -Height_NavBar - kiPhoneX_Bottom_Height)];
    scrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:scrollView];
    _scrollView = scrollView;
    
    UIView *contentView = [[UIView alloc]init];
    [scrollView addSubview:contentView];
    contentView.backgroundColor = [UIColor clearColor];
    _contentView = contentView;
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scrollView);
        make.width.offset(self.view.bounds.size.width);
        make.height.equalTo(@1000);
    }];
    
    [self setTopView];
    [self setBottomView];
    
    [self roadMapView];
    // 统计视图
    [self textStatisticsView];
    
    BShowPokerView *showPokerView = [[BShowPokerView alloc] initWithFrame:CGRectMake(30, 350, mxwScreenWidth()-30*2, 150)];
    [self.view addSubview:showPokerView];
    _showPokerView = showPokerView;
    
    BAnalyzeRoadMapView *analyzeRoadMapView = [[BAnalyzeRoadMapView alloc] initWithFrame:CGRectMake(300, 550, 70, 135)];
    [self.view addSubview:analyzeRoadMapView];
    _analyzeRoadMapView = analyzeRoadMapView;
}


// 路子图
- (void)roadMapView {
    // 大路
    BaccaratRoadMapView *roadmapView = [[BaccaratRoadMapView alloc] initWithFrame:CGRectMake(kMarginWidth, kMarginWidth +5, [UIScreen mainScreen].bounds.size.width - kMarginWidth*2, 380)];
    roadmapView.roadType = 1;
    //    trendView.backgroundColor = [UIColor redColor];
    roadmapView.layer.borderWidth = 1;
    roadmapView.layer.borderColor = [UIColor colorWithRed:0.643 green:0.000 blue:0.357 alpha:1.000].CGColor;
    [self.contentView addSubview:roadmapView];
    _roadmapView = roadmapView;
    
    // 庄闲路
    BaccaratCollectionView *trendView = [[BaccaratCollectionView alloc] initWithFrame:CGRectMake(kMarginWidth, 380+kMarginWidth + kTrendViewHeight + kMarginWidth, [UIScreen mainScreen].bounds.size.width - kMarginWidth*2, kTrendViewHeight)];
    trendView.roadType = 0;
    //    trendView.backgroundColor = [UIColor redColor];
    trendView.layer.borderWidth = 1;
    trendView.layer.borderColor = [UIColor colorWithRed:0.643 green:0.000 blue:0.357 alpha:1.000].CGColor;
    [self.contentView addSubview:trendView];
    _trendView = trendView;
}

- (void)setTopView {
    
    UILabel *minLabel = [[UILabel alloc] init];
    minLabel.font = [UIFont systemFontOfSize:kLabelFontSize];
    minLabel.numberOfLines = 0;
    minLabel.textColor = [UIColor darkGrayColor];
    [self.contentView addSubview:minLabel];
    _minLabel = minLabel;
    
    [minLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.top.equalTo(self.contentView.mas_top).offset(2);
    }];
    
    UILabel *maxLabel = [[UILabel alloc] init];
    maxLabel.font = [UIFont systemFontOfSize:kLabelFontSize];
    maxLabel.numberOfLines = 0;
    maxLabel.textColor = [UIColor darkGrayColor];
    [self.contentView addSubview:maxLabel];
    _maxLabel = maxLabel;
    
    [maxLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(minLabel.mas_left).offset(-10);
        make.centerY.equalTo(minLabel.mas_centerY);
    }];
    
}



- (void)setBottomView {
    
    
    UIView *bottomView = [[UIView alloc] init];
    bottomView.layer.borderWidth = 1;
    bottomView.layer.borderColor = [UIColor redColor].CGColor;
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    _bottomView = bottomView;
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-kiPhoneX_Bottom_Height);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.mas_equalTo(100);
    }];
    
    UITextField *pokerNumTextField = [[UITextField alloc] initWithFrame:CGRectMake(kMarginWidth, kMarginHeight, 60, kBtnHeight)];
    pokerNumTextField.text = @"8";
    pokerNumTextField.keyboardType = UIKeyboardTypeNumberPad;
    pokerNumTextField.textColor = [UIColor grayColor];
    pokerNumTextField.layer.cornerRadius = 5;
    pokerNumTextField.layer.borderColor = [UIColor grayColor].CGColor;
    pokerNumTextField.layer.borderWidth = 1;
    _pokerNumTextField  = pokerNumTextField;
    
    
    [bottomView addSubview:pokerNumTextField];
    
    UIButton *startButton = [[UIButton alloc] initWithFrame:CGRectMake(kMarginWidth + 60 + 10, kMarginHeight, 50, kBtnHeight)];
    startButton.titleLabel.font = [UIFont systemFontOfSize:kBtnFontSize];
    [startButton setTitle:@"自动全盘" forState:UIControlStateNormal];
    [startButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [startButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    startButton.backgroundColor = [UIColor colorWithRed:0.027 green:0.757 blue:0.376 alpha:1.000];
    startButton.layer.cornerRadius = 5;
    [startButton addTarget:self action:@selector(onStartAllButton:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:startButton];
    
    
    UIButton *startOneButton = [[UIButton alloc] initWithFrame:CGRectMake(kMarginWidth + 60 + 10 +50 +10, kMarginHeight, 80, kBtnHeight)];
    [startOneButton setTitle:@"发牌" forState:UIControlStateNormal];
    startButton.titleLabel.font = [UIFont systemFontOfSize:kBtnFontSize];
    [startOneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [startOneButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    startOneButton.backgroundColor = [UIColor colorWithRed:0.027 green:0.757 blue:0.376 alpha:1.000];
    startOneButton.layer.cornerRadius = 5;
    [startOneButton addTarget:self action:@selector(onStartOneButton:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:startOneButton];
    
    UIButton *clearButton = [[UIButton alloc] initWithFrame:CGRectMake(kMarginWidth + 60 + 10 +50 +10 +80 +10, kMarginHeight, 50, kBtnHeight)];
    [clearButton setTitle:@"清除" forState:UIControlStateNormal];
    clearButton.titleLabel.font = [UIFont systemFontOfSize:kBtnFontSize];
    [clearButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [clearButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    clearButton.backgroundColor = [UIColor colorWithRed:0.027 green:0.757 blue:0.376 alpha:1.000];
    clearButton.layer.cornerRadius = 5;
    [clearButton addTarget:self action:@selector(onClearButton) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:clearButton];
    
    
    // 下注视图
    [self betView];
}

- (void)betView {
    
    UITextField *betMoneyTextField = [[UITextField alloc] init];
    betMoneyTextField.text = @"2000";
    betMoneyTextField.keyboardType = UIKeyboardTypeNumberPad;
    betMoneyTextField.textColor = [UIColor grayColor];
    betMoneyTextField.layer.cornerRadius = 5;
    betMoneyTextField.layer.borderColor = [UIColor grayColor].CGColor;
    betMoneyTextField.layer.borderWidth = 1;
    _betMoneyTextField = betMoneyTextField;
    [self.bottomView addSubview:betMoneyTextField];
    
    [betMoneyTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.pokerNumTextField.mas_left);
        make.top.equalTo(self.pokerNumTextField.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(70, kBtnHeight));
    }];
    
    UIButton *buyLessDoubleBtn = [[UIButton alloc] init];
    [buyLessDoubleBtn setTitle:@"减倍" forState:UIControlStateNormal];
    buyLessDoubleBtn.titleLabel.font = [UIFont systemFontOfSize:kBtnFontSize];
    [buyLessDoubleBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [buyLessDoubleBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    buyLessDoubleBtn.backgroundColor = [UIColor colorWithRed:0.027 green:0.757 blue:0.376 alpha:1.000];
    buyLessDoubleBtn.layer.cornerRadius = 5;
    [buyLessDoubleBtn addTarget:self action:@selector(onBuyLessDoubleBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:buyLessDoubleBtn];
    
    [buyLessDoubleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(betMoneyTextField.mas_right).offset(10);
        make.centerY.equalTo(betMoneyTextField.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(50, kBuyBtnHeight));
    }];
    
    UIButton *buyDoubleBtn = [[UIButton alloc] init];
    [buyDoubleBtn setTitle:@"加倍" forState:UIControlStateNormal];
    buyDoubleBtn.titleLabel.font = [UIFont systemFontOfSize:kBtnFontSize];
    [buyDoubleBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [buyDoubleBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    buyDoubleBtn.backgroundColor = [UIColor colorWithRed:0.027 green:0.757 blue:0.376 alpha:1.000];
    buyDoubleBtn.layer.cornerRadius = 5;
    [buyDoubleBtn addTarget:self action:@selector(onBuyDoubleBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:buyDoubleBtn];
    
    [buyDoubleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(buyLessDoubleBtn.mas_right).offset(10);
        make.centerY.equalTo(betMoneyTextField.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(50, kBuyBtnHeight));
    }];
    
    UIButton *buyPlayerBtn = [[UIButton alloc] init];
    [buyPlayerBtn setTitle:@"买闲" forState:UIControlStateNormal];
    buyPlayerBtn.titleLabel.font = [UIFont systemFontOfSize:kBtnFontSize];
    [buyPlayerBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [buyPlayerBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    buyPlayerBtn.backgroundColor = [UIColor colorWithRed:0.027 green:0.757 blue:0.376 alpha:1.000];
    buyPlayerBtn.layer.cornerRadius = 5;
    [buyPlayerBtn addTarget:self action:@selector(onBuyPlayerBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:buyPlayerBtn];
    _buyPlayerBtn = buyPlayerBtn;
    
    [buyPlayerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(buyDoubleBtn.mas_right).offset(10);
        make.centerY.equalTo(betMoneyTextField.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(65, kBuyBtnHeight));
    }];
    
    UIButton *buyBankerBtn = [[UIButton alloc] init];
    [buyBankerBtn setTitle:@"买庄" forState:UIControlStateNormal];
    buyBankerBtn.titleLabel.font = [UIFont systemFontOfSize:kBtnFontSize];
    [buyBankerBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [buyBankerBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    buyBankerBtn.backgroundColor = [UIColor colorWithRed:0.027 green:0.757 blue:0.376 alpha:1.000];
    buyBankerBtn.layer.cornerRadius = 5;
    [buyBankerBtn addTarget:self action:@selector(onBuyBankerBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:buyBankerBtn];
    _buyBankerBtn = buyBankerBtn;
    
    [buyBankerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(buyPlayerBtn.mas_right).offset(10);
        make.centerY.equalTo(betMoneyTextField.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(65, kBuyBtnHeight));
    }];
    
    
    
}

#pragma mark - 减倍
- (void)onBuyLessDoubleBtn {
    self.betMoneyTextField.text = [NSString stringWithFormat:@"%ld", (self.betMoneyTextField.text.integerValue / 2) <= 0 ? 0 : (self.betMoneyTextField.text.integerValue / 2)];
}


#pragma mark - 加倍
- (void)onBuyDoubleBtn {
    
    self.betMoneyTextField.text = [NSString stringWithFormat:@"%ld", self.betMoneyTextField.text.integerValue * 2];
}

- (void)showMessage:(NSString *)message {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    
    // Set the text mode to show only text.
    hud.mode = MBProgressHUDModeText;
    hud.label.text = NSLocalizedString(message, @"HUD message title");
    // Move to bottm center.
    hud.offset = CGPointMake(0.f, MBProgressMaxOffset);
    
    [hud hideAnimated:YES afterDelay:3.f];
}


#pragma mark - 买庄
- (void)onBuyBankerBtn {
    if (self.betMoneyTextField.text.integerValue > self.betTotalMoney) {
        [self showMessage:@"下注超出本金!"];
        return;
    }
    self.buyType = 1;
    [self onStartOneButton:nil];
}
#pragma mark - 买闲
- (void)onBuyPlayerBtn {
    if (self.betMoneyTextField.text.integerValue > self.betTotalMoney) {
        [self showMessage:@"下注超出本金!"];
        return;
    }
    self.buyType = 2;
    [self onStartOneButton:nil];
}

#pragma mark - 消键盘
- (void)onDisKeyboardButton {
    [self.view endEditing:YES];
}

- (void)textStatisticsView {
    
    UIView *backView = [[UIView alloc] init];
    backView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:backView];
    
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.trendView.mas_bottom).offset(5);
        make.left.equalTo(self.contentView.mas_left).offset(10);
        //        make.right.equalTo(self.contentView.mas_right);
        make.size.mas_equalTo(CGSizeMake(kSCREEN_WIDTH - 10*2, 350));
    }];
    
    UILabel *bankerTotalCountLabel = [[UILabel alloc] init];
    bankerTotalCountLabel.font = [UIFont systemFontOfSize:kLabelFontSize];
    bankerTotalCountLabel.numberOfLines = 0;
    //    bankerTotalCountLabel.text = @"庄赢";
    bankerTotalCountLabel.textColor = [UIColor darkGrayColor];
    [backView addSubview:bankerTotalCountLabel];
    _bankerTotalCountLabel = bankerTotalCountLabel;
    
    [bankerTotalCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView.mas_left);
        make.top.equalTo(backView.mas_top);
    }];
    
    UILabel *playerTotalCountLabel = [[UILabel alloc] init];
    playerTotalCountLabel.font = [UIFont systemFontOfSize:kLabelFontSize];
    playerTotalCountLabel.numberOfLines = 0;
    //    playerTotalCountLabel.text = @"闲赢";
    playerTotalCountLabel.textColor = [UIColor darkGrayColor];
    [backView addSubview:playerTotalCountLabel];
    _playerTotalCountLabel = playerTotalCountLabel;
    
    [playerTotalCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView.mas_left);
        make.top.equalTo(bankerTotalCountLabel.mas_bottom);
    }];
    
    UILabel *tieCountLabel = [[UILabel alloc] init];
    tieCountLabel.font = [UIFont systemFontOfSize:kLabelFontSize];
    tieCountLabel.numberOfLines = 0;
    //    tieCountLabel.text = @"和";
    tieCountLabel.textColor = [UIColor darkGrayColor];
    [backView addSubview:tieCountLabel];
    _tieCountLabel = tieCountLabel;
    
    [tieCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView.mas_left);
        make.top.equalTo(playerTotalCountLabel.mas_bottom);
    }];
    
    UILabel *bankerPairCountLabel = [[UILabel alloc] init];
    bankerPairCountLabel.font = [UIFont systemFontOfSize:kLabelFontSize];
    bankerPairCountLabel.numberOfLines = 0;
    //    bankerPairCountLabel.text = @"庄对";
    bankerPairCountLabel.textColor = [UIColor darkGrayColor];
    [backView addSubview:bankerPairCountLabel];
    _bankerPairCountLabel = bankerPairCountLabel;
    
    [bankerPairCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView.mas_left);
        make.top.equalTo(tieCountLabel.mas_bottom);
    }];
    
    UILabel *playerPairCountLabel = [[UILabel alloc] init];
    playerPairCountLabel.font = [UIFont systemFontOfSize:kLabelFontSize];
    playerPairCountLabel.numberOfLines = 0;
    //    playerPairCountLabel.text = @"闲对";
    playerPairCountLabel.textColor = [UIColor darkGrayColor];
    [backView addSubview:playerPairCountLabel];
    _playerPairCountLabel = playerPairCountLabel;
    
    [playerPairCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView.mas_left);
        make.top.equalTo(bankerPairCountLabel.mas_bottom);
    }];
    
    UILabel *superSixCountLabel = [[UILabel alloc] init];
    superSixCountLabel.font = [UIFont systemFontOfSize:kLabelFontSize];
    superSixCountLabel.numberOfLines = 0;
    //    superSixCountLabel.text = @"SuperSix";
    superSixCountLabel.textColor = [UIColor darkGrayColor];
    [backView addSubview:superSixCountLabel];
    _superSixCountLabel = superSixCountLabel;
    
    [superSixCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView.mas_left);
        make.top.equalTo(playerPairCountLabel.mas_bottom);
    }];
    
    UILabel *pokerCountLabel = [[UILabel alloc] init];
    pokerCountLabel.font = [UIFont systemFontOfSize:kLabelFontSize];
    //    pokerCountLabel.layer.borderWidth = 1;
    //    pokerCountLabel.layer.borderColor = [UIColor blueColor].CGColor;
    pokerCountLabel.numberOfLines = 0;
    //    pokerCountLabel.text = @"结果";S
    pokerCountLabel.textColor = [UIColor darkGrayColor];
    [backView addSubview:pokerCountLabel];
    _pokerCountLabel = pokerCountLabel;
    
    [pokerCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView.mas_left);
        make.top.equalTo(superSixCountLabel.mas_bottom);
    }];
    
    UILabel *kkkLabel = [[UILabel alloc] init];
    kkkLabel.font = [UIFont systemFontOfSize:kLabelFontSize];
    //    pokerCountLabel.layer.borderWidth = 1;
    //    pokerCountLabel.layer.borderColor = [UIColor blueColor].CGColor;
    kkkLabel.numberOfLines = 0;
    //    pokerCountLabel.text = @"结果";S
    kkkLabel.textColor = [UIColor darkGrayColor];
    [backView addSubview:kkkLabel];
    _kkkLabel = kkkLabel;
    
    [kkkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView.mas_left);
        make.top.equalTo(pokerCountLabel.mas_bottom);
    }];
    
    
    UILabel *aaaa = [[UILabel alloc] init];
    aaaa.font = [UIFont systemFontOfSize:kLabelFontSize];
    //    pokerCountLabel.layer.borderWidth = 1;
    //    pokerCountLabel.layer.borderColor = [UIColor blueColor].CGColor;
    aaaa.numberOfLines = 0;
    //    pokerCountLabel.text = @"结果";S
    aaaa.textColor = [UIColor darkGrayColor];
    [backView addSubview:aaaa];
    _aaaa = aaaa;
    
    [aaaa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView.mas_left);
        make.top.equalTo(kkkLabel.mas_bottom);
    }];
    
    
    UILabel *bbbb = [[UILabel alloc] init];
    bbbb.font = [UIFont systemFontOfSize:kLabelFontSize];
    //    pokerCountLabel.layer.borderWidth = 1;
    //    pokerCountLabel.layer.borderColor = [UIColor blueColor].CGColor;
    bbbb.numberOfLines = 0;
    //    pokerCountLabel.text = @"结果";S
    bbbb.textColor = [UIColor darkGrayColor];
    [backView addSubview:bbbb];
    _bbbb = bbbb;
    
    [bbbb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView.mas_left);
        make.top.equalTo(aaaa.mas_bottom);
        make.right.equalTo(backView.mas_right);
    }];
    
    UILabel *buyMoneyLabel = [[UILabel alloc] init];
    buyMoneyLabel.font = [UIFont systemFontOfSize:kLabelFontSize];
    //    pokerCountLabel.layer.borderWidth = 1;
    //    pokerCountLabel.layer.borderColor = [UIColor blueColor].CGColor;
    buyMoneyLabel.numberOfLines = 0;
    //    pokerCountLabel.text = @"结果";S
    buyMoneyLabel.textColor = [UIColor darkGrayColor];
    [backView addSubview:buyMoneyLabel];
    _buyMoneyLabel = buyMoneyLabel;
    
    [buyMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView.mas_left);
        make.top.equalTo(bbbb.mas_bottom);
        make.right.equalTo(backView.mas_right);
    }];
    
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.font = [UIFont systemFontOfSize:kLabelFontSize];
    timeLabel.textColor = [UIColor darkGrayColor];
    [backView addSubview:timeLabel];
    _timeLabel = timeLabel;
    
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView.mas_left);
        make.top.equalTo(buyMoneyLabel.mas_bottom);
        make.right.equalTo(backView.mas_right);
    }];
    
    UILabel *gongLabel = [[UILabel alloc] init];
    gongLabel.font = [UIFont systemFontOfSize:kLabelFontSize];
    gongLabel.textColor = [UIColor darkGrayColor];
    [backView addSubview:gongLabel];
    _gongLabel = gongLabel;
    
    [gongLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView.mas_left);
        make.top.equalTo(timeLabel.mas_bottom);
    }];
    
    
}

#pragma mark -  清除
- (void)onClearButton {
    
    [self initData];
    self.trendView.model = self.resultDataArray;
    self.roadmapView.model = self.resultDataArray;
    [self resultStatisticsText];
}

#pragma mark -  开始一局
- (void)onStartOneButton:(UIButton *)sender {
    [self.view endEditing:YES];
    
    [self.showPokerView removeStackView];
    //    self.betMoneyTextField.text = 0;
    
    if (self.pokerTotalNum < 36) {  // 停止发牌
        [MBProgressHUD showTipMessageInWindow:@"本桌已结束"];
        self.pokerCountLabel.text = [NSString stringWithFormat:@"GAME  %ld  剩余%ld张牌  庄闲相差 %ld  已结束", self.pokerCount, self.pokerTotalNum, self.bankerTotalCount - self.playerTotalCount];
        self.buyBankerBtn.backgroundColor = [UIColor lightGrayColor];
        self.buyPlayerBtn.backgroundColor = [UIColor lightGrayColor];
        return;
    }
    
    self.pokerCount++;
    self.testIndex++;
    [self oncePoker];
    //    [self daluCalculationMethod];
    
    self.trendView.model = self.resultDataArray;
    self.roadmapView.model = self.resultDataArray;
    [self resultStatisticsContinuous];
    [self resultStatisticsText];
}

#pragma mark -  全盘
/**
 全盘
 */
- (void)onStartAllButton:(UIButton *)sender {
    self.isAutoRunAll = YES;
    // 记录当前时间
    float start = CACurrentMediaTime();
    
    [self opening];
    self.trendView.model = self.resultDataArray;
    self.roadmapView.model = self.resultDataArray;
    //    [self resultStatisticsContinuous];
    
    [self resultStatisticsContinuous];
    [self resultStatisticsText];
    
    
    
    float end = CACurrentMediaTime();
    NSString *time = [NSString stringWithFormat:@"%f", end - start];
    NSLog(time);
    self.timeLabel.text = time;
}

- (NSString *)bankerOrPlayerOrTie:(NSString *)string {
    
    switch ([string integerValue]) {
        case 0:
            return @"T";
            break;
        case 1:
            return @"B";
            break;
        case 2:
            return @"P";
            break;
        default:
            break;
    }
    return nil;
}

#pragma mark -  统计数据分析
- (void)resultStatisticsContinuous {
    NSString   *compareChar;          // 前一个字符
    BOOL   firstisBankerPair;          // 前一个字符
    BOOL   firstisPlayerPair;          // 前一个字符
    BOOL   firstisSuperSix;          // 前一个字符
    
    NSString   *longestContinChar;    // 连续最长字符
    NSInteger iMaxLen            = 1;  // 最大次数
    NSInteger iCharCount         = 1;  // 当前次数
    NSString *lastBankerOrPlayer = nil;  // 最后一个BankerOrPlayer
    NSInteger lastiCharCount = iCharCount;  // 最后的连续次数
    
    self.continuous2 = 0;
    self.continuous3 = 0;
    self.continuous4 = 0;
    self.continuous5 = 0;
    self.continuous6 = 0;
    self.continuous7 = 0;
    self.continuous8 = 0;
    
    self.jumpsCount = 0;   // 跳转
    self.singleJumpCount = 0;  // 单跳
    self.front6SameCount = 0;
    
    // 连续出现的次数
    self.bankerPairOrplayerPairContinuousCount = 0;
    // 间隔局数
    self.bankerPairOrplayerPairIntervalCount = 0;
    self.playerPairContinuousCount = 0;
    self.superSixContinuousCount = 0;
    
    if (self.resultDataArray.count <= 0) {
        return;
    }
    
    BaccaratResultModel *firstModel = (BaccaratResultModel *)self.resultDataArray.firstObject;
    compareChar       = [NSString stringWithFormat:@"%ld", firstModel.winType];  // 从第一个字符开始比较
    longestContinChar = compareChar;
    
    firstisBankerPair       = firstModel.isBankerPair;
    firstisPlayerPair       = firstModel.isPlayerPair;
    firstisSuperSix       = firstModel.isSuperSix;
    
    if (![compareChar isEqualToString:@"2"]) {  // 记录最后一次的 Banker或者Player
        lastBankerOrPlayer = compareChar;
    }
    
    for (NSInteger indexFlag = 1; indexFlag < self.resultDataArray.count; indexFlag++) {
        
        BaccaratResultModel *model = (BaccaratResultModel *)self.resultDataArray[indexFlag];
        NSString *tempStrWinType       = [NSString stringWithFormat:@"%ld", model.winType];; //
        BOOL tempIsBankerPair       = model.isBankerPair;
        BOOL tempIsPlayerPair       = model.isPlayerPair;
        BOOL tempIsSuperSix       = model.isSuperSix;
        
        // 与前6局关系
        if (indexFlag >= 6) {
            BaccaratResultModel *front6SameCountModel = (BaccaratResultModel *)self.resultDataArray[indexFlag - 6];
            NSString *tempFront6SameCountDict       = [NSString stringWithFormat:@"%ld", front6SameCountModel.winType];
            if ([tempStrWinType isEqualToString:tempFront6SameCountDict]) {
                self.front6SameCount++;
            }
        }
        
        if ([tempStrWinType isEqualToString:compareChar]) {
            iCharCount++;     // 对相同字符计数加1
            
            if (![tempStrWinType isEqualToString:@"0"]) {  // 记录最后一次的 Banker或者Player
                lastBankerOrPlayer = tempStrWinType;
                lastiCharCount = iCharCount;
            }
            
            switch (iCharCount) {   // 没有排除TIE
                case 2:
                    // 连续2次的统计
                    self.continuous2++;
                    break;
                case 3:
                    // 连续3次的统计
                    self.continuous3++;
                    break;
                case 4:
                    // 连续4次的统计
                    self.continuous4++;
                    break;
                case 5:
                    // 连续5次的统计
                    self.continuous5++;
                    break;
                case 6:
                    // 连续6次的统计
                    self.continuous6++;
                    break;
                case 7:
                    // 连续7次的统计
                    self.continuous7++;
                    break;
                case 8:
                    // 连续8次的统计
                    self.continuous8++;
                    break;
                default:
                    break;
            }
            
        } else {
            
            NSLog(@"下标 %ld",  indexFlag);
            // 单跳的统计
            if (iCharCount == 1 && ![tempStrWinType isEqualToString:@"0"] && ![tempStrWinType isEqualToString:lastBankerOrPlayer] && lastBankerOrPlayer != nil && lastiCharCount == 1) {
                self.singleJumpCount++;
            }
            
            iCharCount   = 1;        // 字符不同时计数变为1
            compareChar = tempStrWinType;   // 重新比较新字符
            
            // 跳转的统计 TIE不计入统计    与之前TIE出现之前的一样 也不记录跳转统计
            if (![tempStrWinType isEqualToString:@"0"] && ![tempStrWinType isEqualToString:lastBankerOrPlayer] && lastBankerOrPlayer != nil) {
                self.jumpsCount++;
            }
            
            if (![tempStrWinType isEqualToString:@"0"]) {  // 记录最后一次的 Banker或者Player
                lastBankerOrPlayer = tempStrWinType;
                lastiCharCount = iCharCount;
            }
            
        }
        
        if (iCharCount > iMaxLen) { // 获取连续出现次数最多的字符及其出现次数
            iMaxLen            = iCharCount;
            longestContinChar = tempStrWinType;
        }
        
        
        // 连续出的 Pair 数量统计
        // isBankerPair
        if ((tempIsBankerPair && firstisBankerPair) || (tempIsPlayerPair && firstisPlayerPair) || (tempIsBankerPair && firstisPlayerPair) || (tempIsPlayerPair && firstisBankerPair)) {
            self.bankerPairOrplayerPairContinuousCount++;
        } else {
            firstisBankerPair = tempIsBankerPair;   // 重新比较新的记录
            firstisPlayerPair = tempIsPlayerPair;   // 重新比较新的记录
        }
        
        
        if (indexFlag > self.intervalNum) {
            BaccaratResultModel *modelII = (BaccaratResultModel *)self.resultDataArray[indexFlag - self.intervalNum];
            NSString *tempStrWinTypeII       =  [NSString stringWithFormat:@"%ld", modelII.winType]; //
            BOOL tempIsBankerPairII       = modelII.isBankerPair;
            BOOL tempIsPlayerPairII       = modelII.isPlayerPair;
            BOOL tempIsSuperSixII       =  modelII.isSuperSix;
            
            // 隔一局出的 Pair 统计
            if ((tempIsBankerPair && tempIsBankerPairII) || (tempIsPlayerPair && tempIsPlayerPairII) || (tempIsBankerPair && tempIsPlayerPairII) || (tempIsPlayerPair && tempIsBankerPairII)) {
                self.bankerPairOrplayerPairIntervalCount++;
            }
        }
        
        
        if (tempIsSuperSix && firstisSuperSix) {
            self.superSixContinuousCount++;
        } else {
            firstisSuperSix = tempIsSuperSix;   // 重新比较新的记录
        }
    }
    
    NSString *aaa = [NSString stringWithFormat:@"连续最多 %@  次数 %ld  与前6相同 %ld   %ld  %0.2f%", [self bankerOrPlayerOrTie:longestContinChar], iMaxLen, self.front6SameCount, self.pokerCount -6- self.front6SameCount, self.front6SameCount*1.00/(self.pokerCount*1.00 -6)*100.0];
    
    NSLog(aaa);
    
    NSString *bbb = [NSString stringWithFormat:@"连续2个%ld  连续3个%ld  连续4个%ld  连续5个%ld  连续6个%ld  连续7个%ld  连续8个%ld", self.continuous2,self.continuous3,self.continuous4,self.continuous5,self.continuous6,self.continuous7,self.continuous8];
    
    NSLog(bbb);
    
    
    //    self.aaaa.backgroundColor = [UIColor yellowColor];
    self.aaaa.text = aaa;
    self.bbbb.text = bbb;
    //    self.bbbb.backgroundColor = [UIColor greenColor];
}



#pragma mark - 百家乐31投注法
- (void)algorithm31Bet {
    
}


//1    A-1    1    输    -1
//2    A-2    1    输    -2
//3    A-3    1    输    -3
//4    B-1    2    输    -5
//5    B-2    2    输    -7
//6    C-1    4    赢    -3
//7    D-1    8    赢    +5


#pragma mark - 结果统计计算
// 结果统计
- (void)resultStatisticsText {
    
    self.maxLabel.text = [NSString stringWithFormat:@"最高:%ld", self.maxBetTotalMoney];
    self.minLabel.text = [NSString stringWithFormat:@"最低:%ld", self.minBetTotalMoney];
    
    self.bankerTotalCountLabel.text = [NSString stringWithFormat:@"BANKER %ld  Win  %ld", self.bankerTotalCount, (self.bankerTotalCount - self.playerTotalCount) * self.betMoney - self.superSixCount * self.betMoney/2];
    self.playerTotalCountLabel.text = [NSString stringWithFormat:@"PLAYER  %ld  Win  %ld", self.playerTotalCount, (self.playerTotalCount-self.bankerTotalCount) * self.betMoney];
    self.tieCountLabel.text = [NSString stringWithFormat:@"TIE          %ld  平均 %ld", self.tieCount, self.tieCount ? self.pokerCount/self.tieCount : 0];
    
    //连续局数 * betMoney * 11 - （总局数 - 连续的局数 = 跟之前出的局数 * 2 * betMoney） = 盈利
    NSInteger pariWinMoney = (self.bankerPairOrplayerPairContinuousCount * self.betMoney * 11) -((self.bankerPlayerSinglePairCount - self.bankerPairOrplayerPairContinuousCount)  * self.betMoney * 2);
    
    self.bankerPairCountLabel.text = [NSString stringWithFormat:@"BANKER PAIR %ld  平均 %ld  B+P Pari连续%ld Win %ld", self.bankerPairCount, self.bankerPairCount ? self.pokerCount/self.bankerPairCount : 0, self.bankerPairOrplayerPairContinuousCount, pariWinMoney];
    self.playerPairCountLabel.text = [NSString stringWithFormat:@"PLAYER PAIR  %ld  平均 %ld  间隔%ld局统计数 %ld", self.playerPairCount, self.playerPairCount ? self.pokerCount/self.playerPairCount : 0,self.intervalNum, self.bankerPairOrplayerPairIntervalCount];
    
    self.superSixCountLabel.text = [NSString stringWithFormat:@"SUPER6          %ld  平均 %ld  连续%ld", self.superSixCount, self.superSixCount ? self.pokerCount/self.superSixCount : 0, self.superSixContinuousCount];
    self.pokerCountLabel.text = [NSString stringWithFormat:@"GAME  %ld  剩余%ld张牌  庄闲相差 %ld", self.pokerCount, self.pokerTotalNum, self.bankerTotalCount - self.playerTotalCount];
    
    // 计算跟买的盈亏金额
    // 总局数 - 跳转的局数 - Tie - 第一局 = 连续局数 * 2000 - 跳转输的钱 *2000 = 盈利
    NSInteger cNumMoney = (self.pokerCount - self.jumpsCount -self.tieCount -1) * self.betMoney - self.jumpsCount * self.betMoney;
    
    self.kkkLabel.text = [NSString stringWithFormat:@"单跳的统计 %ld 跳转 %ld 连续 %ld  跟买Win %ld",self.singleJumpCount,self.jumpsCount, (self.pokerCount - self.jumpsCount), cNumMoney];
    
    self.buyMoneyLabel.text = [NSString stringWithFormat:@"下注Win %ld",self.betTotalMoney];
    
    self.title = [NSString stringWithFormat:@"%ld",self.betTotalMoney];
    self.gongLabel.text = [NSString stringWithFormat:@"%ld - 剩%ld",self.gongCount, 128 - self.gongCount];
}


#pragma mark -  开始
- (void)opening {
    [self initData];
    // 发牌局数   52最齐的张数
    for (NSInteger i = 1; i <= (self.pokerNumTextField.text.integerValue * 52 / 4); i++) {
        if (self.pokerTotalNum < 6) {
            break;
        }
        self.pokerCount++;
        
        [self oncePoker];
        //        [self daluCalculationMethod];
    }
}






#pragma mark -  Baccarat庄闲算法
- (void)oncePoker {
    
    NSString  *numStr = nil;
    // 闲
    NSInteger player1 = 0;
    NSInteger player2 = 0;
    NSInteger player3 = 0;
    // 庄
    NSInteger banker1 = 0;
    NSInteger banker2 = 0;
    NSInteger banker3 = 0;
    
    // 庄闲点数
    NSInteger playerTotalPoints = 0;
    NSInteger bankerTotalPoints = 0;
    
    NSMutableArray<PokerCardModel *> *playerArray = [NSMutableArray array];
    NSMutableArray<PokerCardModel *> *bankerArray = [NSMutableArray array];
    
    for (NSInteger i = 1; i <= 6; i++) {
        
        // 洗牌
        //        int pokerIndex = (arc4random() % self.pokerTotalNum) + 0;
        //        NSString *num = (NSString *)self.dataArray[pokerPoints];
        //        [self.dataArray removeObjectAtIndex:pokerPoints];
        //        NSLog(@"🔴= %@", num.stringValue);
        
        
        
        PokerCardModel *cardModel = (PokerCardModel *)self.dataArray.firstObject;
        [self.dataArray removeObjectAtIndex:0];
        self.pokerTotalNum--;
        
        
                if (self.testIndex > 22) {   // 测试使用  增加长庄长闲
                    numStr = @"7";
                }
        
                 numStr = @"7";
        
                if (i == 5) {
        
                    if (self.testIndex < 5) {
                        numStr = @"10";
                    } else if (self.testIndex > 10) {
        
                        if (self.testIndex > 18) {
                            if (self.testIndex > 27) {
                                if (self.testIndex > 36) {
                                    if (self.testIndex > 45) {
                                        if (self.testIndex > 54) {
                                            numStr = @"1";
                                        } else {
                                            numStr = @"8";
                                        }
                                    } else {
                                        numStr = @"1";
                                    }
                                } else {
                                    numStr = @"8";
                                }
                            } else {
                                numStr = @"1";
                            }
                        } else {
                            numStr = @"8";
                        }
        
                    } else {
                        numStr = @"1";
                    }
                }
        
        cardModel.bCardValue = [numStr integerValue];
        
        
        if (i == 1) {
            player1 = cardModel.bCardValue;
            
            [playerArray addObject:cardModel];
        } else if (i == 2) {
            banker1 = cardModel.bCardValue;
            [bankerArray addObject:cardModel];
        } else if (i == 3) {
            player2 = cardModel.bCardValue;
            [playerArray addObject:cardModel];
        } else if (i == 4) {
            banker2 = cardModel.bCardValue;
            [bankerArray addObject:cardModel];
            
            playerTotalPoints = (player1 + player2) % 10;
            bankerTotalPoints = (banker1 + banker2) % 10;
        }
        
        
        
        if (playerTotalPoints< 6 && bankerTotalPoints ==  7) {
            NSLog(@"🔴🔴🔴发牌有问题🔴🔴🔴");
        }
        
        if (i == 4) {
            if (playerTotalPoints >= 8 ||  bankerTotalPoints >= 8) {
                break;
            }
            if (playerTotalPoints >= 6 && bankerTotalPoints >= 6) {
                break;
            }
        } else if (i == 5) {
            if (playerTotalPoints < 6) {
                player3 = cardModel.bCardValue;
                [playerArray addObject:cardModel];
            } else {
                if (bankerTotalPoints < 6) {
                    banker3 = cardModel.bCardValue;
                    [bankerArray addObject:cardModel];
                    break;
                }
            }
            
            if (bankerTotalPoints == 3 && player3 == 8) {
                break;
            } else if (bankerTotalPoints == 4 && (player3 == 8 || player3 == 9 || player3 == 0 || player3 == 1)) {
                break;
            } else if (bankerTotalPoints == 5 && (player3 == 8 || player3 == 9 || player3 == 0 || player3 == 1 || player3 == 2 || player3 == 3)) {
                break;
            } else if (bankerTotalPoints == 6 && (player3 != 6 && player3 != 7)) {
                break;
            } else if (bankerTotalPoints == 7) {
                break;
            } else {
                NSLog(@"继续发牌");
            }
        } else if (i == 6) {
            if (bankerTotalPoints < 6) {
                banker3 = cardModel.bCardValue;
                [bankerArray addObject:cardModel];
            } else if (bankerTotalPoints == 6 && (player3 == 6 || player3 == 7)) {
                banker3 = cardModel.bCardValue;
                [bankerArray addObject:cardModel];
            } else {
                NSLog(@"🔴🔴🔴发牌有问题🔴🔴🔴");
            }
            
        }
    }
    
    
    
    
    playerTotalPoints = (playerTotalPoints + player3) % 10;
    bankerTotalPoints = (bankerTotalPoints + banker3) % 10;
    
    BaccaratResultModel *bResultModel =  [[BaccaratResultModel alloc] init];
    [bResultModel baccaratResultComputer:playerArray bankerArray:bankerArray];
    /// 显示所有牌例
    self.showPokerView.resultModel = bResultModel;
    
    // 判断庄闲 输赢
    NSString *win;
    if (bResultModel.winType == WinType_TIE) {
        win = @"✅";
        self.tieCount++;
        self.currentWinType = 0;
    } else if (bResultModel.winType == WinType_Banker) {
        if (bResultModel.isSuperSix) {
            win = @"🔴🔸";
            self.superSixCount++;
            // 下注
            if (self.buyType == 1) {
                self.betTotalMoney = self.betTotalMoney + self.betMoneyTextField.text.integerValue/2;
            } else {
                self.betTotalMoney = self.betTotalMoney - self.betMoneyTextField.text.integerValue;
            }
        } else {
            win = @"🔴";
            if (self.buyType == 1) {
                self.betTotalMoney = self.betTotalMoney + self.betMoneyTextField.text.integerValue;
            } else {
                self.betTotalMoney = self.betTotalMoney - self.betMoneyTextField.text.integerValue;
            }
        }
        
        self.currentWinType = 1;
        self.bankerTotalCount++;
    } else {
        win = @"🅿️";
        self.playerTotalCount++;
        self.currentWinType = 2;
        
        if (self.buyType == 2) {
            self.betTotalMoney = self.betTotalMoney + self.betMoneyTextField.text.integerValue;
        } else {
            self.betTotalMoney = self.betTotalMoney - self.betMoneyTextField.text.integerValue;
        }
    }
    
    if (self.betTotalMoney > self.maxBetTotalMoney) {
        self.maxBetTotalMoney = self.betTotalMoney;
    } else if (self.betTotalMoney < self.minBetTotalMoney) {
        self.minBetTotalMoney = self.betTotalMoney;
    }
    
    bResultModel.betMoney = self.betMoneyTextField.text.integerValue;
    bResultModel.pokerCount = self.pokerCount;
    
    if (bResultModel.isPlayerPair) {
        self.bankerPlayerSinglePairCount++;
    }
    
    if (bResultModel.isBankerPair) {
        self.bankerPlayerSinglePairCount++;
    }
    
    [self.resultDataArray addObject:bResultModel];
    
    // 计算公的张数
    if (player1 == 0) {
        self.gongCount++;
    }
    if (player2 == 0) {
        self.gongCount++;
    }
    if (player3 == 0) {
        self.gongCount++;
    }
    
    if (banker1 == 0) {
        self.gongCount++;
    }
    if (banker2 == 0) {
        self.gongCount++;
    }
    if (banker3 == 10) {
        self.gongCount++;
    }
    
    
    NSLog(@"Player: %ld点 %ld  %ld  %ld  - Banker: %ld点 %d  %ld  %ld =%@",playerTotalPoints, player1, player2, player3,  bankerTotalPoints, banker1, banker2, banker3, win);
    
    
}






//#pragma mark -  Baccarat大路算法
- (void)sd11 {
    
}

//#pragma mark -  Baccarat大路算法
- (void)sd22 {
    
}

//#pragma mark -  Baccarat大路算法
- (void)sd33 {
    
}

- (void)setupNavUI {
    //    // nav按钮  nav文字
    //    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithTitle:@"点数列表" style:(UIBarButtonItemStylePlain) target:self action:@selector(rightBtnAction)];
    //    // 字体颜色
    //    [rightBtn setTintColor:[UIColor blackColor]
    //     ];
    //    // 字体大小
    //    [rightBtn setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:12], NSFontAttributeName,nil] forState:(UIControlStateNormal)];
    //    self.navigationItem.rightBarButtonItem = rightBtn;
    //
    //    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    
    
    //添加两个button
    NSMutableArray*buttons=[[NSMutableArray alloc]initWithCapacity:2];
    //    UIBarButtonItem*button3=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"你的图片"] style: UIBarButtonItemStyleDone target:self action:@selector(press2)];
    //    UIBarButtonItem*button2=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"你的图片"] style: UIBarButtonItemStyleDone target:self action:@selector(press)];
    
    UIBarButtonItem *rightBtn1 = [[UIBarButtonItem alloc]initWithTitle:@"配置" style:(UIBarButtonItemStylePlain) target:self action:@selector(configAction)];
    UIBarButtonItem *rightBtn2 = [[UIBarButtonItem alloc]initWithTitle:@"点数列表" style:(UIBarButtonItemStylePlain) target:self action:@selector(rightBtnAction)];
    UIBarButtonItem *rightBtn3 = [[UIBarButtonItem alloc]initWithTitle:@"消键盘" style:(UIBarButtonItemStylePlain) target:self action:@selector(onDisKeyboardButton)];
    
    rightBtn1.tintColor=[UIColor blackColor];
    rightBtn2.tintColor=[UIColor blackColor];
    rightBtn3.tintColor=[UIColor blackColor];
    [rightBtn1 setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:12], NSFontAttributeName,nil] forState:(UIControlStateNormal)];
    [rightBtn2 setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:12], NSFontAttributeName,nil] forState:(UIControlStateNormal)];
    [rightBtn3 setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:12], NSFontAttributeName,nil] forState:(UIControlStateNormal)];
    [buttons addObject:rightBtn1];
    [buttons addObject:rightBtn2];
    [buttons addObject:rightBtn3];
    //    [tools setItems:buttons animated:NO];
    //    UIBarButtonItem*btn=[[UIBarButtonItem alloc]initWithCustomView:tools];
    self.navigationItem.rightBarButtonItems=buttons;
}

#pragma mark -创建UIButton方法
- (UIButton *)createButtonWithFrame:(CGRect)frame
                           andTitle:(NSString *)title
                      andTitleColor:(UIColor *)titleColor
                 andBackgroundImage:(UIImage *)backgroundImage
                           andImage:(UIImage *)Image
                          andTarget:(id)target
                          andAction:(SEL)sel
                            andType:(UIButtonType)type
{
    //创建UIButton并设置类型
    UIButton * btn = [UIButton buttonWithType:type];
    //设置按键位置和大小
    btn.frame = frame;
    //设置按键名
    [btn setTitle:title forState:UIControlStateNormal];
    //设置按键名字体颜色
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    //背景图片
    [btn setBackgroundImage:backgroundImage forState:UIControlStateNormal];
    //图片
    [btn setImage:Image forState:UIControlStateNormal];
    //设置按键响应方法
    [btn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    
    btn.titleLabel.font = [UIFont fontWithName:@"Verdana" size:15];
    
    return btn;
}



#pragma mark -  浮动按钮
- (void)setFloatingBackBtnView {
    CGFloat widthDr = 45;
    self.dragView = [[WMDragView alloc] initWithFrame:CGRectMake(0, 0, widthDr, widthDr)];
    [self.dragView.button setBackgroundImage:[UIImage imageNamed:@"game_back_btn"] forState:UIControlStateNormal];
    self.dragView.button.backgroundColor = [UIColor clearColor];
    self.dragView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.dragView];
    
    CGFloat widthX = self.view.bounds.size.width >= 812.0 ? 44 : 0;
    CGRect rectDr = CGRectMake(widthX, 30, widthDr, widthDr);
    self.dragView.frame = rectDr;
    
    //    self.dragView.layer.cornerRadius = width/2;
    //    self.dragView.layer.masksToBounds = YES;
    //    self.dragView.layer.borderWidth = 1;
    //    self.dragView.layer.borderColor = [UIColor colorWithRed:255.0/255 green:255.0/255 blue:255.0/255 alpha:0.5].CGColor;
    
    __weak typeof(self) weakSelf = self;
    self.dragView.clickDragViewBlock = ^(WMDragView *dragView){
        
        [weakSelf.navigationController popViewControllerAnimated:true];
        //        [weakSelf.navigationController popViewControllerAnimated:true];
    };
    
    self.dragView.beginDragBlock = ^(WMDragView *dragView) {
        DLog(@"开始拖曳");
    };
    
    self.dragView.endDragBlock = ^(WMDragView *dragView) {
        DLog(@"结束拖曳");
    };
    
    self.dragView.duringDragBlock = ^(WMDragView *dragView) {
        DLog(@"拖曳中...");
    };
}


@end


