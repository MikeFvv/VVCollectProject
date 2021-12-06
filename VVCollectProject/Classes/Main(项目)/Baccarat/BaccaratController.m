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
#import "BaccaratModel.h"
#import "BaccaratRoadMapView.h"


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

/// 闲局数
@property (nonatomic, assign) NSInteger playerCount;
/// 庄局数
@property (nonatomic, assign) NSInteger bankerCount;

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



//@property (nonatomic, strong) UIView *trendView;
@property (nonatomic, strong) BaccaratCollectionView *trendView;
/// 大路
@property (nonatomic, strong) BaccaratRoadMapView *roadmapView;



/// 结果数据
@property (nonatomic, strong) NSMutableArray *resultDataArray;
/// 大路数据
//@property (nonatomic, strong) NSMutableArray *daluResultDataArray;


///
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UILabel *pokerCountLabel;
@property (nonatomic, strong) UILabel *bankerCountLabel;
@property (nonatomic, strong) UILabel *playerCountLabel;
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

@property (nonatomic, strong) UIView *playerBackView;
@property (nonatomic, strong) UIView *player3BackView;
@property (nonatomic, strong) UIView *bankerBackView;
@property (nonatomic, strong) UIView *banker3BackView;
@property (nonatomic, strong) UIStackView *playerStackView;
@property (nonatomic, strong) UIStackView *bankerStackView;
/// 定时器
@property (nonatomic, strong) NSTimer *dealerTimer;


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

@property (nonatomic, assign) NSInteger jjjjjjj;
/// 是否运行全盘
@property (nonatomic, assign) BOOL isRunOverall;

// ******* grm 指路图 *******

@property (nonatomic, strong) UILabel *grm_bankerLabel;
@property (nonatomic, strong) UILabel *grm_playerLabel;
@property (nonatomic, strong) UIView *grm_dyzl_bankerView;
@property (nonatomic, strong) UIView *grm_dyzl_playerView;
@property (nonatomic, strong) UIView *grm_xl_bankerView;
@property (nonatomic, strong) UIView *grm_xl_playerView;
@property (nonatomic, strong) UILabel *grm_yyl_bankerLabel;
@property (nonatomic, strong) UILabel *grm_yyl_playerLabel;


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
    
    self.jjjjjjj = 0;
    self.isRunOverall = NO;
    
    [self setupNavUI];
    [self initUI];
    [self initData];
    
    self.title = [NSString stringWithFormat:@"%ld", self.betTotalMoney];
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
    
    
    
    NSMutableArray *array = [VVFunctionManager shuffleArray:pokerArray pokerPairsNum:self.pokerNumTextField.text.integerValue];
    self.dataArray = [NSMutableArray arrayWithArray:array];
    
    self.pokerTotalNum = self.dataArray.count;
    self.pokerCount = 0;
    self.playerCount = 0;
    self.bankerCount = 0;
    self.playerPairCount = 0;
    self.bankerPairCount = 0;
    self.superSixCount = 0;
    self.tieCount = 0;
    self.gongCount = 0;
    self.resultDataArray = [NSMutableArray array];
    //    self.daluResultDataArray = [NSMutableArray array];
    self.bankerPlayerSinglePairCount = 0;
    self.buyType = -1;
}

- (void)configAction {
    BaccaratConfigController *vc = [[BaccaratConfigController alloc] init];
    //    vc.resultDataArray = self.resultDataArray;
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
    [self pressStop];
}

- (void)initUI {
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
    /// 扑克牌视图
    [self playingCardsView];
    [self roadMapView];
    // 统计视图
    [self textStatisticsView];
    [self setGuideRoadMap];
    
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

- (void)playingCardsView {
    
    UIView *playerBackView = [[UIView alloc] init];
    playerBackView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:playerBackView];
    _playerBackView = playerBackView;
    
    [playerBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view.mas_centerY).offset(20);
        make.left.equalTo(self.view.mas_left).offset(50);
        make.size.mas_equalTo(CGSizeMake(125, 80));
    }];
    
    UIView *player3BackView = [[UIView alloc] init];
    player3BackView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:player3BackView];
    _player3BackView = player3BackView;
    
    [player3BackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(playerBackView.mas_bottom).offset(5);
        make.centerX.equalTo(playerBackView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(60, 80));
    }];
    
    _playerStackView = [[UIStackView alloc] init];
    //    _playerStackView.backgroundColor = [UIColor orangeColor];
    //子控件的布局方向
    _playerStackView.axis = UILayoutConstraintAxisHorizontal;
    _playerStackView.distribution = UIStackViewDistributionFillEqually;
    _playerStackView.spacing = 5;
    _playerStackView.alignment = UIStackViewAlignmentFill;
    //    _playerStackView.frame = CGRectMake(0, 100, ScreenWidth, 200);
    [playerBackView addSubview:_playerStackView];
    [_playerStackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(playerBackView);
    }];
    
    
    
    UIView *bankerBackView = [[UIView alloc] init];
    bankerBackView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:bankerBackView];
    _bankerBackView = bankerBackView;
    
    [bankerBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(playerBackView.mas_centerY);
        make.right.equalTo(self.view.mas_right).offset(-50);
        make.size.mas_equalTo(CGSizeMake(125, 80));
    }];
    
    UIView *banker3BackView = [[UIView alloc] init];
    banker3BackView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:banker3BackView];
    _banker3BackView = banker3BackView;
    
    [banker3BackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bankerBackView.mas_bottom).offset(5);
        make.centerX.equalTo(bankerBackView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(60, 80));
    }];
    
    _bankerStackView = [[UIStackView alloc] init];
    //    _bankerStackView.backgroundColor = [UIColor orangeColor];
    //子控件的布局方向
    _bankerStackView.axis = UILayoutConstraintAxisHorizontal;
    _bankerStackView.distribution = UIStackViewDistributionFillEqually;
    _bankerStackView.spacing = 5;
    _bankerStackView.alignment = UIStackViewAlignmentFill;
    //    _bankerStackView.frame = CGRectMake(0, 100, ScreenWidth, 200);
    [bankerBackView addSubview:_bankerStackView];
    [_bankerStackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(bankerBackView);
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
    [startButton setTitle:@"全盘" forState:UIControlStateNormal];
    [startButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [startButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    startButton.backgroundColor = [UIColor colorWithRed:0.027 green:0.757 blue:0.376 alpha:1.000];
    startButton.layer.cornerRadius = 5;
    [startButton addTarget:self action:@selector(onStartButton) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:startButton];
    
    
    UIButton *startOneButton = [[UIButton alloc] initWithFrame:CGRectMake(kMarginWidth + 60 + 10 +50 +10, kMarginHeight, 80, kBtnHeight)];
    [startOneButton setTitle:@"开始一局" forState:UIControlStateNormal];
    startButton.titleLabel.font = [UIFont systemFontOfSize:kBtnFontSize];
    [startOneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [startOneButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    startOneButton.backgroundColor = [UIColor colorWithRed:0.027 green:0.757 blue:0.376 alpha:1.000];
    startOneButton.layer.cornerRadius = 5;
    [startOneButton addTarget:self action:@selector(onStartOneButton) forControlEvents:UIControlEventTouchUpInside];
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
    
    
    //    UIButton *disKeyboardButton = [[UIButton alloc] initWithFrame:CGRectMake(kMarginWidth + 60 + 10 +50 +10 +80 +10 + 50 +10, kMarginHeight, 50, kBtnHeight)];
    //    [disKeyboardButton setTitle:@"消键盘" forState:UIControlStateNormal];
    //    disKeyboardButton.titleLabel.font = [UIFont systemFontOfSize:kBtnFontSize];
    //    [disKeyboardButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    [disKeyboardButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    //    disKeyboardButton.backgroundColor = [UIColor colorWithRed:0.027 green:0.757 blue:0.376 alpha:1.000];
    //    disKeyboardButton.layer.cornerRadius = 5;
    //    [disKeyboardButton addTarget:self action:@selector(onDisKeyboardButton) forControlEvents:UIControlEventTouchUpInside];
    //    [bottomView addSubview:disKeyboardButton];
    
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
    [self onStartOneButton];
}
#pragma mark - 买闲
- (void)onBuyPlayerBtn {
    if (self.betMoneyTextField.text.integerValue > self.betTotalMoney) {
        [self showMessage:@"下注超出本金!"];
        return;
    }
    self.buyType = 2;
    [self onStartOneButton];
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
    
    UILabel *bankerCountLabel = [[UILabel alloc] init];
    bankerCountLabel.font = [UIFont systemFontOfSize:kLabelFontSize];
    bankerCountLabel.numberOfLines = 0;
    //    bankerCountLabel.text = @"庄赢";
    bankerCountLabel.textColor = [UIColor darkGrayColor];
    [backView addSubview:bankerCountLabel];
    _bankerCountLabel = bankerCountLabel;
    
    [bankerCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView.mas_left);
        make.top.equalTo(backView.mas_top);
    }];
    
    UILabel *playerCountLabel = [[UILabel alloc] init];
    playerCountLabel.font = [UIFont systemFontOfSize:kLabelFontSize];
    playerCountLabel.numberOfLines = 0;
    //    playerCountLabel.text = @"闲赢";
    playerCountLabel.textColor = [UIColor darkGrayColor];
    [backView addSubview:playerCountLabel];
    _playerCountLabel = playerCountLabel;
    
    [playerCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView.mas_left);
        make.top.equalTo(bankerCountLabel.mas_bottom);
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
        make.top.equalTo(playerCountLabel.mas_bottom);
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
    //    [self.tableView reloadData];
}

#pragma mark -  开始一局
- (void)onStartOneButton {
    [self.view endEditing:YES];
    
    //    self.betMoneyTextField.text = 0;
    
    if (self.pokerTotalNum < 36) {  // 停止发牌
        self.pokerCountLabel.text = [NSString stringWithFormat:@"GAME  %ld  剩余%ld张牌  庄闲相差 %ld  已结束", self.pokerCount, self.pokerTotalNum, self.bankerCount - self.playerCount];
        self.buyBankerBtn.backgroundColor = [UIColor lightGrayColor];
        self.buyPlayerBtn.backgroundColor = [UIColor lightGrayColor];
        return;
    }
    
    self.pokerCount++;
    self.jjjjjjj++;
    [self oncePoker];
    //    [self daluCalculationMethod];
    
    self.trendView.model = self.resultDataArray;
    self.roadmapView.model = self.resultDataArray;
    [self resultStatisticsContinuous];
    [self resultStatisticsText];
    //    [self.tableView reloadData];
}

#pragma mark -  全盘
/**
 全盘
 */
- (void)onStartButton {
    self.isRunOverall = YES;
    // 记录当前时间
    float start = CACurrentMediaTime();
    
    [self opening];
    self.trendView.model = self.resultDataArray;
    self.roadmapView.model = self.resultDataArray;
    //    [self resultStatisticsContinuous];
    
    [self resultStatisticsContinuous];
    [self resultStatisticsText];
    //    [self.tableView reloadData];
    
    
    
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
    
    BaccaratModel *firstModel = (BaccaratModel *)self.resultDataArray.firstObject;
    compareChar       = [NSString stringWithFormat:@"%ld", firstModel.winType];  // 从第一个字符开始比较
    longestContinChar = compareChar;
    
    firstisBankerPair       = firstModel.isBankerPair;
    firstisPlayerPair       = firstModel.isPlayerPair;
    firstisSuperSix       = firstModel.isSuperSix;
    
    if (![compareChar isEqualToString:@"2"]) {  // 记录最后一次的 Banker或者Player
        lastBankerOrPlayer = compareChar;
    }
    
    for (NSInteger indexFlag = 1; indexFlag < self.resultDataArray.count; indexFlag++) {
        
        BaccaratModel *model = (BaccaratModel *)self.resultDataArray[indexFlag];
        NSString *tempStrWinType       = [NSString stringWithFormat:@"%ld", model.winType];; //
        BOOL tempIsBankerPair       = model.isBankerPair;
        BOOL tempIsPlayerPair       = model.isPlayerPair;
        BOOL tempIsSuperSix       = model.isSuperSix;
        
        // 与前6局关系
        if (indexFlag >= 6) {
            BaccaratModel *front6SameCountModel = (BaccaratModel *)self.resultDataArray[indexFlag - 6];
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
            BaccaratModel *modelII = (BaccaratModel *)self.resultDataArray[indexFlag - self.intervalNum];
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
    
    self.bankerCountLabel.text = [NSString stringWithFormat:@"BANKER %ld  Win  %ld", self.bankerCount, (self.bankerCount - self.playerCount) * self.betMoney - self.superSixCount * self.betMoney/2];
    self.playerCountLabel.text = [NSString stringWithFormat:@"PLAYER  %ld  Win  %ld", self.playerCount, (self.playerCount-self.bankerCount) * self.betMoney];
    self.tieCountLabel.text = [NSString stringWithFormat:@"TIE          %ld  平均 %ld", self.tieCount, self.tieCount ? self.pokerCount/self.tieCount : 0];
    
    //连续局数 * betMoney * 11 - （总局数 - 连续的局数 = 跟之前出的局数 * 2 * betMoney） = 盈利
    NSInteger pariWinMoney = (self.bankerPairOrplayerPairContinuousCount * self.betMoney * 11) -((self.bankerPlayerSinglePairCount - self.bankerPairOrplayerPairContinuousCount)  * self.betMoney * 2);
    
    self.bankerPairCountLabel.text = [NSString stringWithFormat:@"BANKER PAIR %ld  平均 %ld  B+P Pari连续%ld Win %ld", self.bankerPairCount, self.bankerPairCount ? self.pokerCount/self.bankerPairCount : 0, self.bankerPairOrplayerPairContinuousCount, pariWinMoney];
    self.playerPairCountLabel.text = [NSString stringWithFormat:@"PLAYER PAIR  %ld  平均 %ld  间隔%ld局统计数 %ld", self.playerPairCount, self.playerPairCount ? self.pokerCount/self.playerPairCount : 0,self.intervalNum, self.bankerPairOrplayerPairIntervalCount];
    
    self.superSixCountLabel.text = [NSString stringWithFormat:@"SUPER6          %ld  平均 %ld  连续%ld", self.superSixCount, self.superSixCount ? self.pokerCount/self.superSixCount : 0, self.superSixContinuousCount];
    self.pokerCountLabel.text = [NSString stringWithFormat:@"GAME  %ld  剩余%ld张牌  庄闲相差 %ld", self.pokerCount, self.pokerTotalNum, self.bankerCount - self.playerCount];
    
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
    // 闲
    NSInteger player1 = 0;
    NSInteger player2 = 0;
    NSString *player3;
    // 庄
    NSInteger banker1 = 0;
    NSInteger banker2 = 0;
    NSString *banker3;
    // 庄闲点数
    NSInteger playerPointsNum = 0;
    NSInteger bankerPointsNum = 0;
    
    for (NSInteger i = 1; i <= 6; i++) {
        
        // 洗牌
        //        int pokerIndex = (arc4random() % self.pokerTotalNum) + 0;
        //        NSString *num = (NSString *)self.dataArray[pokerPoints];
        //        [self.dataArray removeObjectAtIndex:pokerPoints];
        //        NSLog(@"🔴= %@", num.stringValue);
        
        
        NSString *numStr = (NSString *)self.dataArray.firstObject;
        [self.dataArray removeObjectAtIndex:0];
        self.pokerTotalNum--;
        
        
        //        if (self.jjjjjjj > 22) {   // 测试使用  增加长庄长闲
        //            numStr = @"7";
        //        }
        //         numStr = @"7";
        //        if (i == 5) {
        //
        //            if (self.jjjjjjj < 5) {
        //                numStr = @"10";
        //            } else if (self.jjjjjjj > 10) {
        //
        //                if (self.jjjjjjj > 18) {
        //                    if (self.jjjjjjj > 27) {
        //                        if (self.jjjjjjj > 36) {
        //                            if (self.jjjjjjj > 45) {
        //                                if (self.jjjjjjj > 54) {
        //                                    numStr = @"1";
        //                                } else {
        //                                    numStr = @"8";
        //                                }
        //                            } else {
        //                                numStr = @"1";
        //                            }
        //                        } else {
        //                            numStr = @"8";
        //                        }
        //                    } else {
        //                        numStr = @"1";
        //                    }
        //                } else {
        //                    numStr = @"8";
        //                }
        //
        //            } else {
        //                numStr = @"1";
        //            }
        //        }
        
        
        if (i == 1) {
            [self playerDealerDisplayView:numStr];
            player1 = numStr.integerValue;
        } else if (i == 2) {
            [self bankerDealerDisplayView:numStr];
            banker1 = numStr.integerValue;
        } else if (i == 3) {
            [self playerDealerDisplayView:numStr];
            player2 = numStr.integerValue;
        } else if (i == 4) {
            [self bankerDealerDisplayView:numStr];
            banker2 = numStr.integerValue;
        }
        
        
        NSInteger tempPlayer1 = player1 >= 10 ? 0 : player1;
        NSInteger tempPlayer2 = player2 >= 10 ? 0 : player2;
        
        NSInteger tempBanker1 = banker1 >= 10 ? 0 : banker1;
        NSInteger tempBanker2 = banker2 >= 10 ? 0 : banker2;
        
        playerPointsNum = tempPlayer1 + tempPlayer2 >= 10 ? tempPlayer1 + tempPlayer2 - 10 : tempPlayer1 + tempPlayer2;
        bankerPointsNum = tempBanker1 + tempBanker2 >= 10 ? tempBanker1 + tempBanker2 - 10 : tempBanker1 + tempBanker2;
        
        if (i == 4) {
            if (playerPointsNum >= 8 ||  bankerPointsNum >= 8) {
                break;
            }
            if (playerPointsNum >= 6 && bankerPointsNum >= 6) {
                break;
            }
        } else if (i == 5) {
            if (playerPointsNum < 6) {
                player3 = numStr;
                [self player3DealerDisplayView:numStr];
            } else {
                if (bankerPointsNum < 6) {
                    banker3 = numStr;
                    [self banker3DealerDisplayView:numStr];
                    break;
                }
            }
            
            NSInteger tempPlayer3 = player3.integerValue >= 10 ? 0 : player3.integerValue;
            if (bankerPointsNum == 3 && tempPlayer3 == 8) {
                break;
            } else if (bankerPointsNum == 4 && (tempPlayer3 == 8 || tempPlayer3 == 9 || tempPlayer3 == 0 || tempPlayer3 == 1)) {
                break;
            } else if (bankerPointsNum == 5 && (tempPlayer3 == 8 || tempPlayer3 == 9 || tempPlayer3 == 0 || tempPlayer3 == 1 || tempPlayer3 == 2 || tempPlayer3 == 3)) {
                break;
            } else if (bankerPointsNum == 6 && (tempPlayer3 != 6 && tempPlayer3 != 7)) {
                break;
            }
        } else if (i == 6) {
            if (bankerPointsNum <= 6) {
                banker3 = numStr;
                [self banker3DealerDisplayView:numStr];
            }
        }
    }
    
    
    NSInteger tempPlayer3 = player3.integerValue >= 10 ? 0 : player3.integerValue;
    NSInteger tempBanker3 = banker3.integerValue >= 10 ? 0 : banker3.integerValue;
    playerPointsNum = (playerPointsNum + tempPlayer3) >= 10 ? playerPointsNum + tempPlayer3 - 10 : playerPointsNum + tempPlayer3;
    bankerPointsNum = (bankerPointsNum + tempBanker3) >= 10 ? bankerPointsNum + tempBanker3 - 10 : bankerPointsNum + tempBanker3;
    
    BaccaratModel *model =  [[BaccaratModel alloc] init];
    // 判断庄闲 输赢
    NSString *win;
    if (playerPointsNum < bankerPointsNum) {
        if (bankerPointsNum == 6) {  // Super6
            win = @"🔴🔸";
            self.superSixCount++;
            model.isSuperSix = YES;
            
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
        self.bankerCount++;
    } else if (playerPointsNum > bankerPointsNum) {
        win = @"🅿️";
        self.playerCount++;
        self.currentWinType = 2;
        
        if (self.buyType == 2) {
            self.betTotalMoney = self.betTotalMoney + self.betMoneyTextField.text.integerValue;
        } else {
            self.betTotalMoney = self.betTotalMoney - self.betMoneyTextField.text.integerValue;
        }
        
    } else if (playerPointsNum == bankerPointsNum) {
        win = @"✅";
        self.tieCount++;
        self.currentWinType = 0;
    } else {
        [self showMessage:@"本局判断错误， 请查看列表原因"];
        return;
    }
    
    if (self.betTotalMoney > self.maxBetTotalMoney) {
        self.maxBetTotalMoney = self.betTotalMoney;
    } else if (self.betTotalMoney < self.minBetTotalMoney) {
        self.minBetTotalMoney = self.betTotalMoney;
    }
    
    model.betMoney = self.betMoneyTextField.text.integerValue;
    model.winType = self.currentWinType;
    
    // Pair
    if (player1 == player2) {
        win = [NSString stringWithFormat:@"%@🔹", win];
        self.playerPairCount++;
        model.isPlayerPair = YES;
    }
    if (banker1 == banker2) {
        win = [NSString stringWithFormat:@"%@🔺", win];
        self.bankerPairCount++;
        model.isBankerPair = YES;
    }
    
    if (player1 == player2 || banker1 == banker2) {
        self.bankerPlayerSinglePairCount++;
    }
    
    model.player1 = player1;
    model.player2 = player2;
    model.player3 = player3 == nil ? @"" : player3;
    
    model.banker1 = banker1;
    model.banker2 = banker2;
    model.banker3 = banker3  == nil ? @"" : banker3;
    
    model.playerPointsNum = playerPointsNum;
    model.bankerPointsNum = bankerPointsNum;
    model.pokerCount = self.pokerCount;
    
    [self.resultDataArray addObject:model];
    
    // 计算公的张数
    if (player1 >= 10) {
        self.gongCount++;
    }
    if (player2 >= 10) {
        self.gongCount++;
    }
    if (player3 && player3.integerValue >= 10) {
        self.gongCount++;
    }
    if (banker1 >= 10) {
        self.gongCount++;
    }
    if (banker2 >= 10) {
        self.gongCount++;
    }
    if (banker3 && banker3.integerValue >= 10) {
        self.gongCount++;
    }
    
    
    NSLog(@"Player: %ld点 %ld  %ld  %@  - Banker: %ld点 %d  %ld  %@ =%@",playerPointsNum, player1, player2, player3.length > 0 ? player3 : @"",   bankerPointsNum, banker1, banker2, banker3.length > 0 ? banker3 : @"", win);
    
    if (!self.isRunOverall) {
        _dealerTimer=[NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(removeStackView) userInfo:nil repeats:YES];
    }
    
}

-(void)pressStop {
    if (_dealerTimer!=nil) {
        //停止计时器
        [_dealerTimer invalidate];
    }
}

#pragma mark -  发牌显示视图
- (void)playerDealerDisplayView:(NSString *)cardPoints {
    if (self.isRunOverall) {
        return;
    }
    UILabel *view = [[UILabel alloc] init];
    view.textAlignment = NSTextAlignmentCenter;
    view.font = [UIFont boldSystemFontOfSize:26];
    view.textColor = [UIColor blueColor];
    view.text = [self pokerCharacter:cardPoints.integerValue];;
    view.backgroundColor = [UIColor colorWithRed:0.259 green:0.749 blue:0.8 alpha:kColorAlpha];
    [self.playerStackView addArrangedSubview:view];
    [UIView animateWithDuration:0.5 animations:^{
        [self.playerStackView layoutIfNeeded];
    }];
}
- (void)player3DealerDisplayView:(NSString *)cardPoints {
    if (self.isRunOverall) {
        return;
    }
    UILabel *view = [[UILabel alloc] init];
    view.textAlignment = NSTextAlignmentCenter;
    view.font = [UIFont boldSystemFontOfSize:26];
    view.textColor = [UIColor blueColor];
    view.text = [self pokerCharacter:cardPoints.integerValue];;
    view.backgroundColor = [UIColor colorWithRed:0.259 green:0.749 blue:0.8 alpha:kColorAlpha];
    [self.player3BackView addSubview:view];
    [UIView animateWithDuration:1.2 animations:^{
        view.frame = CGRectMake(0, 0, 60, 90);
    }];
}
- (void)bankerDealerDisplayView:(NSString *)cardPoints {
    if (self.isRunOverall) {
        return;
    }
    UILabel *view = [[UILabel alloc] init];
    view.textAlignment = NSTextAlignmentCenter;
    view.font = [UIFont boldSystemFontOfSize:26];
    view.textColor = [UIColor redColor];
    view.text = [self pokerCharacter:cardPoints.integerValue];
    view.backgroundColor = [UIColor colorWithRed:0.965 green:0.412 blue:0.8 alpha:kColorAlpha];
    [self.bankerStackView addArrangedSubview:view];
    [UIView animateWithDuration:0.5 animations:^{
        [self.bankerStackView layoutIfNeeded];
    }];
}
- (void)banker3DealerDisplayView:(NSString *)cardPoints {
    if (self.isRunOverall) {
        return;
    }
    UILabel *view = [[UILabel alloc] init];
    view.textAlignment = NSTextAlignmentCenter;
    view.font = [UIFont boldSystemFontOfSize:26];
    view.textColor = [UIColor redColor];
    view.text = [self pokerCharacter:cardPoints.integerValue];
    view.backgroundColor = [UIColor colorWithRed:0.965 green:0.412 blue:0.8 alpha:kColorAlpha];
    [self.banker3BackView addSubview:view];
    [UIView animateWithDuration:1.2 animations:^{
        view.frame = CGRectMake(0, 0, 60, 90);
    }];
}
- (void)removeStackView {
    
    for (NSInteger i = 0; i < [self.playerStackView subviews].count; i++) {
        UILabel *viewLabel = [self.playerStackView subviews][i];
        viewLabel.text = @"";
        [self.playerStackView removeArrangedSubview:viewLabel];
    }
    while (self.player3BackView.subviews.count) {
        [self.player3BackView.subviews.lastObject removeFromSuperview];
    }
    
    
    for (NSInteger j = 0; j < [self.bankerStackView subviews].count; j++) {
        UILabel *viewLabel = [self.bankerStackView subviews][j];
        viewLabel.text = @"";
        [self.bankerStackView removeArrangedSubview:viewLabel];
    }
    while (self.banker3BackView.subviews.count) {
        [self.banker3BackView.subviews.lastObject removeFromSuperview];
    }
    
    [self pressStop];
}


- (NSString *)pokerCharacter:(NSInteger)num {
    switch (num) {
        case 1:
            return @"A";
            break;
        case 2:
        case 3:
        case 4:
        case 5:
        case 6:
        case 7:
        case 8:
        case 9:
        case 10:
            return [NSString stringWithFormat:@"%ld", num];
        case 11:
            return @"L";
            break;
        case 12:
            return @"Q";
            break;
        case 13:
            return @"K";
            break;
        default:
            break;
    }
    return nil;
}



#pragma mark -  Baccarat大路算法
- (void)daluCalculationMethod {
    //    NSMutableDictionary *dict =  [NSMutableDictionary dictionary];
    //    if (self.currentWinType != 0 || (self.currentWinType == 0 && self.daluResultDataArray.count == 0)) {
    //        [dict setObject:@(self.currentWinType) forKey:@"winType"];
    //    }
    //
    //    [self.daluResultDataArray addObject:dict];
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

- (void)setGuideRoadMap {
    
    UIView *guideRoadMapBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 70, 135)];
    guideRoadMapBackView.backgroundColor = [UIColor whiteColor];
    guideRoadMapBackView.layer.cornerRadius = 5;
    guideRoadMapBackView.layer.masksToBounds = YES;
    guideRoadMapBackView.layer.borderWidth = 1;
    guideRoadMapBackView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.view addSubview:guideRoadMapBackView];
    
    [self.view addSubview:guideRoadMapBackView];
    [self.view bringSubviewToFront:guideRoadMapBackView];
    
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc]
                                                    
                                                    initWithTarget:self
                                                    
                                                    action:@selector(handlePan:)];
    
    [guideRoadMapBackView addGestureRecognizer:panGestureRecognizer];
    
    
    CGFloat lineSpacing = 30;
     CGFloat widht = 18;
    
    UIView *line1View = [[UIView alloc] init];
    line1View.backgroundColor = [UIColor purpleColor];
    [guideRoadMapBackView addSubview:line1View];
    
    [line1View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(guideRoadMapBackView.mas_top).offset(lineSpacing);
        make.left.equalTo(guideRoadMapBackView.mas_left).offset(7);
        make.right.equalTo(guideRoadMapBackView.mas_right).offset(-7);
        make.height.mas_equalTo(2);
    }];
    
    UIView *line2View = [[UIView alloc] init];
    line2View.backgroundColor = [UIColor grayColor];
    [guideRoadMapBackView addSubview:line2View];
    
    [line2View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line1View.mas_bottom).offset(lineSpacing);
        make.left.equalTo(line1View.mas_left);
        make.right.equalTo(line1View.mas_right);
        make.height.mas_equalTo(1);
    }];
    
    UIView *line3View = [[UIView alloc] init];
    line3View.backgroundColor = [UIColor grayColor];
    [guideRoadMapBackView addSubview:line3View];
    
    [line3View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line2View.mas_bottom).offset(lineSpacing);
        make.left.equalTo(line1View.mas_left);
        make.right.equalTo(line1View.mas_right);
        make.height.mas_equalTo(1);
    }];
    
    UIView *line4View = [[UIView alloc] init];
    line4View.backgroundColor = [UIColor grayColor];
    [guideRoadMapBackView addSubview:line4View];
    
    [line4View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line3View.mas_bottom).offset(lineSpacing);
        make.left.equalTo(line1View.mas_left);
        make.right.equalTo(line1View.mas_right);
        make.height.mas_equalTo(1);
    }];
    
    /// *** 1 ***
    UILabel *grm_bankerLabel = [UILabel new];
    grm_bankerLabel.layer.cornerRadius = widht/2;
    grm_bankerLabel.layer.masksToBounds = YES;
    grm_bankerLabel.backgroundColor = [UIColor redColor];
    [guideRoadMapBackView addSubview:grm_bankerLabel];
    grm_bankerLabel.text = @"B";
    grm_bankerLabel.textAlignment = NSTextAlignmentCenter;
    grm_bankerLabel.font = [UIFont boldSystemFontOfSize:16];
    grm_bankerLabel.textColor = [UIColor whiteColor];
    _grm_bankerLabel = grm_bankerLabel;
    
    [grm_bankerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(guideRoadMapBackView.mas_left).offset(10);
        make.bottom.equalTo(line1View.mas_top).offset(-3);
        make.size.mas_equalTo(widht);
    }];
    
    UILabel *grm_playerLabel = [UILabel new];
    grm_playerLabel.layer.cornerRadius = widht/2;
    grm_playerLabel.layer.masksToBounds = YES;
    grm_playerLabel.backgroundColor = [UIColor blueColor];
    [guideRoadMapBackView addSubview:grm_playerLabel];
    grm_playerLabel.text = @"P";
    grm_playerLabel.textAlignment = NSTextAlignmentCenter;
    grm_playerLabel.font = [UIFont boldSystemFontOfSize:16];
    grm_playerLabel.textColor = [UIColor whiteColor];
    _grm_playerLabel = grm_playerLabel;
    
    [grm_playerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(guideRoadMapBackView.mas_right).offset(-10);
        make.centerY.equalTo(grm_bankerLabel.mas_centerY);
        make.size.mas_equalTo(widht);
    }];
    
    /// *** 2 ***
    UIView *grm_dyzl_bankerView = [UIView new];
    grm_dyzl_bankerView.layer.cornerRadius = widht/2;
    grm_dyzl_bankerView.layer.masksToBounds = YES;
    grm_dyzl_bankerView.layer.borderWidth = 3.6;
    grm_dyzl_bankerView.layer.borderColor = [UIColor redColor].CGColor;
    [guideRoadMapBackView addSubview:grm_dyzl_bankerView];
    _grm_dyzl_bankerView = grm_dyzl_bankerView;
    
    [grm_dyzl_bankerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(grm_bankerLabel.mas_left);
        make.bottom.equalTo(line2View.mas_top).offset(-3);
        make.size.mas_equalTo(widht);
    }];
    
    UIView *grm_dyzl_playerView = [UIView new];
    grm_dyzl_playerView.layer.cornerRadius = widht/2;
    grm_dyzl_playerView.layer.masksToBounds = YES;
    grm_dyzl_playerView.layer.borderWidth = 4;
    grm_dyzl_playerView.layer.borderColor = [UIColor blueColor].CGColor;
    [guideRoadMapBackView addSubview:grm_dyzl_playerView];
    _grm_dyzl_playerView = grm_dyzl_playerView;
    
    [grm_dyzl_playerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(grm_playerLabel.mas_right);
        make.centerY.equalTo(grm_dyzl_bankerView.mas_centerY);
        make.size.mas_equalTo(widht);
    }];
    
    /// *** 3 ***
    UIView *grm_xl_bankerView = [UIView new];
    grm_xl_bankerView.layer.cornerRadius = widht/2;
    grm_xl_bankerView.layer.masksToBounds = YES;
    grm_xl_bankerView.backgroundColor = [UIColor redColor];
    [guideRoadMapBackView addSubview:grm_xl_bankerView];
    _grm_xl_bankerView = grm_xl_bankerView;
    
    [grm_xl_bankerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(grm_bankerLabel.mas_left);
        make.bottom.equalTo(line3View.mas_top).offset(-3);
        make.size.mas_equalTo(widht);
    }];
    
    UIView *grm_xl_playerView = [UIView new];
    grm_xl_playerView.layer.cornerRadius = widht/2;
    grm_xl_playerView.layer.masksToBounds = YES;
    grm_xl_playerView.backgroundColor = [UIColor blueColor];
    [guideRoadMapBackView addSubview:grm_xl_playerView];
    _grm_xl_playerView = grm_xl_playerView;
    
    [grm_xl_playerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(grm_playerLabel.mas_right);
        make.centerY.equalTo(grm_xl_bankerView.mas_centerY);
        make.size.mas_equalTo(widht);
    }];
    
    /// *** 4 ***
    UIView *grm_yyl_bankerView = [UIView new];
    grm_yyl_bankerView.backgroundColor = [UIColor clearColor];
    [guideRoadMapBackView addSubview:grm_yyl_bankerView];

    [grm_yyl_bankerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(grm_bankerLabel.mas_left);
        make.bottom.equalTo(line4View.mas_top).offset(-3);
        make.size.mas_equalTo(widht);
    }];

    UIView *grm_yyl_playerView = [UIView new];
    grm_yyl_playerView.backgroundColor = [UIColor clearColor];
    [guideRoadMapBackView addSubview:grm_yyl_playerView];

    [grm_yyl_playerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(grm_playerLabel.mas_right);
        make.centerY.equalTo(grm_yyl_bankerView.mas_centerY);
        make.size.mas_equalTo(widht);
    }];
    
    
    // 线的路径
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    // 起点
    [linePath moveToPoint:CGPointMake(widht, 0)];
    // 其他点
    [linePath addLineToPoint:CGPointMake(0, widht)];
    
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    lineLayer.lineWidth = 3;
    lineLayer.strokeColor = [UIColor redColor].CGColor;
    lineLayer.path = linePath.CGPath;
    lineLayer.fillColor = nil;
    [grm_yyl_bankerView.layer addSublayer:lineLayer];
    
    
    // 线的路径
    UIBezierPath *linePath2 = [UIBezierPath bezierPath];
    // 起点
    [linePath2 moveToPoint:CGPointMake(widht, 0)];
    // 其他点
    [linePath2 addLineToPoint:CGPointMake(0, widht)];
    
    CAShapeLayer *lineLayer2 = [CAShapeLayer layer];
    lineLayer2.lineWidth = 3;
    lineLayer2.strokeColor = [UIColor blueColor].CGColor;
    lineLayer2.path = linePath.CGPath;
    lineLayer2.fillColor = nil;
    [grm_yyl_playerView.layer addSublayer:lineLayer2];
 
}

- (void)handlePan:(UIPanGestureRecognizer *)recognizer{
    
    CGPoint translation = [recognizer translationInView:self.view];
    
    CGFloat centerX=recognizer.view.center.x+ translation.x;
    CGFloat centerY=recognizer.view.center.y+ translation.y;
    CGFloat thecenterX=0;
    CGFloat thecenterY=0;
    recognizer.view.center=CGPointMake(centerX,
                                       
                                       recognizer.view.center.y+ translation.y);
    
    [recognizer setTranslation:CGPointZero inView:self.view];
    
    if(recognizer.state==UIGestureRecognizerStateEnded|| recognizer.state==UIGestureRecognizerStateCancelled) {
        
        if(centerX>kSCREEN_WIDTH/2) {
            thecenterX=kSCREEN_WIDTH-70/2;
        } else {
            thecenterX=70/2;
        }
        
        if (centerY>kSCREEN_HEIGHT-Height_NavBar) {
            thecenterY=kSCREEN_HEIGHT-Height_NavBar;
        } else if (centerY<Height_NavBar) {
            thecenterY=Height_NavBar;
        } else {
            thecenterY = recognizer.view.center.y+ translation.y;
        }
        
        [UIView animateWithDuration:0.3 animations:^{
            recognizer.view.center=CGPointMake(thecenterX,thecenterY);
        }];
        
    }
}

@end


