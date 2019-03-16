//
//  BaccaratController.m
//  VVCollectProject
//
//  Created by Mike on 2019/2/20.
//  Copyright © 2019 Mike. All rights reserved.
//

#import "BaccaratController.h"
#import "BaccaratCell.h"
#import "BaccaratCollectionView.h"
#include <stdlib.h>
#import "VVFunctionManager.h"


#define kBtnHeight 35
#define kBuyBtnHeight 50
#define kBtnFontSize 16
#define kMarginHeight 10
// 边距
#define kMarginWidth 20
#define kTrendViewHeight 138
#define kLabelFontSize 12



@interface BaccaratController ()<UITableViewDataSource, UITableViewDelegate>

//
@property (nonatomic,strong) NSMutableArray *dataArray;


// 牌副数
@property (nonatomic,assign) NSInteger pokerNum;
// 下注金额
@property (nonatomic,assign) NSInteger betMoney;
// 下注输赢总金额
@property (nonatomic,assign) NSInteger betTotalMoney;
// 庄闲和 0 和 1 庄 2 闲
@property (nonatomic,assign) NSInteger buyType;
// 间隔局数量
@property (nonatomic,assign) NSInteger intervalNum;

// 牌副数
@property (nonatomic, strong) UITextField *pokerNumTextField;
// 下注金额
@property (nonatomic, strong) UITextField *betMoneyTextField;


// 牌的总张数
@property (nonatomic,assign) NSInteger pokerTotalNum;
// 发牌局数
@property (nonatomic,assign) NSInteger pokerCount;

// 闲局数
@property (nonatomic,assign) NSInteger playerCount;
// 庄局数
@property (nonatomic,assign) NSInteger bankerCount;

// 闲对局数
@property (nonatomic,assign) NSInteger playerPairCount;
// 庄对局数
@property (nonatomic,assign) NSInteger bankerPairCount;
// 每局的 Pair 统计， 一次出2个也算1个
@property (nonatomic,assign) NSInteger bankerPlayerSinglePairCount;

// Super6
@property (nonatomic,assign) NSInteger superSixCount;
// 和局
@property (nonatomic,assign) NSInteger tieCount;



//@property (nonatomic, strong) UIView *trendView;
@property (nonatomic, strong) BaccaratCollectionView *trendView;




// 结果数据
@property (nonatomic, strong) NSMutableArray *resultDataArray;

//
@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic, strong) UILabel *pokerCountLabel;
@property (nonatomic,strong) UILabel *bankerCountLabel;
@property (nonatomic,strong) UILabel *playerCountLabel;
@property (nonatomic,strong) UILabel *tieCountLabel;
@property (nonatomic,strong) UILabel *bankerPairCountLabel;
@property (nonatomic,strong) UILabel *playerPairCountLabel;
@property (nonatomic,strong) UILabel *superSixCountLabel;
@property (nonatomic,strong) UILabel *kkkLabel;
@property (nonatomic,strong) UILabel *buyMoneyLabel;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UILabel *aaaa;
@property (nonatomic,strong) UILabel *bbbb;

// 买庄
@property (nonatomic,strong) UIButton *buyBankerBtn;
// 买闲
@property (nonatomic,strong) UIButton *buyPlayerBtn;


// ************************ 统计字段 ************************
// 跳转的
@property (nonatomic,assign) NSInteger jumpsCount;
@property (nonatomic,assign) NSInteger continuous2;
@property (nonatomic,assign) NSInteger continuous3;
@property (nonatomic,assign) NSInteger continuous4;
@property (nonatomic,assign) NSInteger continuous5;
@property (nonatomic,assign) NSInteger continuous6;
@property (nonatomic,assign) NSInteger continuous7;
@property (nonatomic,assign) NSInteger continuous8;
// 单跳
@property (nonatomic,assign) NSInteger singleJumpCount;

@property (nonatomic,assign) NSInteger bankerPairOrplayerPairContinuousCount;
// 庄闲间隔局数数量
@property (nonatomic,assign) NSInteger bankerPairOrplayerPairIntervalCount;
@property (nonatomic,assign) NSInteger playerPairContinuousCount;
@property (nonatomic,assign) NSInteger superSixContinuousCount;

// 距离前6局的相同的数量
@property (nonatomic,assign) NSInteger front6SameCount;



@end

@implementation BaccaratController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.pokerNum = 8;
    self.betMoney = 2000;
    self.betTotalMoney = 0;
    self.intervalNum = 1;
    [self initData];
    [self initUI];
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[BaccaratCell class] forCellReuseIdentifier:@"BaccaratCell"];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //    [self configureNavigationBar];
    // 要刷新状态栏，让其重新执行该方法需要调用{-setNeedsStatusBarAppearanceUpdate}
    //    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)initUI {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITextField *pokerNumTextField = [[UITextField alloc] initWithFrame:CGRectMake(kMarginWidth, kMarginHeight, 60, kBtnHeight)];
    pokerNumTextField.text = @"8";
    pokerNumTextField.keyboardType = UIKeyboardTypeNumberPad;
    pokerNumTextField.textColor = [UIColor grayColor];
    pokerNumTextField.layer.cornerRadius = 5;
    pokerNumTextField.layer.borderColor = [UIColor grayColor].CGColor;
    pokerNumTextField.layer.borderWidth = 1;
    _pokerNumTextField = pokerNumTextField;
    
    
    [self.view addSubview:pokerNumTextField];
    
    UIButton *startButton = [[UIButton alloc] initWithFrame:CGRectMake(kMarginWidth + 60 + 10, kMarginHeight, 50, kBtnHeight)];
    startButton.titleLabel.font = [UIFont systemFontOfSize:kBtnFontSize];
    [startButton setTitle:@"全盘" forState:UIControlStateNormal];
    [startButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [startButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    startButton.backgroundColor = [UIColor colorWithRed:0.027 green:0.757 blue:0.376 alpha:1.000];
    startButton.layer.cornerRadius = 5;
    [startButton addTarget:self action:@selector(onStartButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startButton];
    
    
    UIButton *startOneButton = [[UIButton alloc] initWithFrame:CGRectMake(kMarginWidth + 60 + 10 +50 +10, kMarginHeight, 80, kBtnHeight)];
    [startOneButton setTitle:@"开始一局" forState:UIControlStateNormal];
    startButton.titleLabel.font = [UIFont systemFontOfSize:kBtnFontSize];
    [startOneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [startOneButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    startOneButton.backgroundColor = [UIColor colorWithRed:0.027 green:0.757 blue:0.376 alpha:1.000];
    startOneButton.layer.cornerRadius = 5;
    [startOneButton addTarget:self action:@selector(onStartOneButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startOneButton];
    
    UIButton *clearButton = [[UIButton alloc] initWithFrame:CGRectMake(kMarginWidth + 60 + 10 +50 +10 +80 +10, kMarginHeight, 50, kBtnHeight)];
    [clearButton setTitle:@"清除" forState:UIControlStateNormal];
    clearButton.titleLabel.font = [UIFont systemFontOfSize:kBtnFontSize];
    [clearButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [clearButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    clearButton.backgroundColor = [UIColor colorWithRed:0.027 green:0.757 blue:0.376 alpha:1.000];
    clearButton.layer.cornerRadius = 5;
    [clearButton addTarget:self action:@selector(onClearButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:clearButton];
    
    
    UIButton *disKeyboardButton = [[UIButton alloc] initWithFrame:CGRectMake(kMarginWidth + 60 + 10 +50 +10 +80 +10 + 50 +10, kMarginHeight, 50, kBtnHeight)];
    [disKeyboardButton setTitle:@"消键盘" forState:UIControlStateNormal];
    disKeyboardButton.titleLabel.font = [UIFont systemFontOfSize:kBtnFontSize];
    [disKeyboardButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [disKeyboardButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    disKeyboardButton.backgroundColor = [UIColor colorWithRed:0.027 green:0.757 blue:0.376 alpha:1.000];
    disKeyboardButton.layer.cornerRadius = 5;
    [disKeyboardButton addTarget:self action:@selector(onDisKeyboardButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:disKeyboardButton];
    
    
    // 下注视图
    [self betView];
    
    BaccaratCollectionView *trendView = [[BaccaratCollectionView alloc] initWithFrame:CGRectMake(20, kMarginHeight + kBtnHeight + kBuyBtnHeight +5*2, [UIScreen mainScreen].bounds.size.width - 20*2, kTrendViewHeight)];
    //    trendView.backgroundColor = [UIColor redColor];
    trendView.layer.borderWidth = 1;
    trendView.layer.borderColor = [UIColor colorWithRed:0.643 green:0.000 blue:0.357 alpha:1.000].CGColor;
    [self.view addSubview:trendView];
    _trendView = trendView;
    
    
    // 统计视图
    [self textStatisticsView];
    
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
    [self.view addSubview:betMoneyTextField];
    
    [betMoneyTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.pokerNumTextField.mas_left);
        make.top.mas_equalTo(self.pokerNumTextField.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(70, kBtnHeight));
    }];
    
    UIButton *buyDoubleBtn = [[UIButton alloc] init];
    [buyDoubleBtn setTitle:@"加倍" forState:UIControlStateNormal];
    buyDoubleBtn.titleLabel.font = [UIFont systemFontOfSize:kBtnFontSize];
    [buyDoubleBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [buyDoubleBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    buyDoubleBtn.backgroundColor = [UIColor colorWithRed:0.027 green:0.757 blue:0.376 alpha:1.000];
    buyDoubleBtn.layer.cornerRadius = 5;
    [buyDoubleBtn addTarget:self action:@selector(onBuyDoubleBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buyDoubleBtn];
    
    [buyDoubleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(betMoneyTextField.mas_right).offset(10);
        make.centerY.mas_equalTo(betMoneyTextField.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(50, kBuyBtnHeight));
    }];
    
    UIButton *buyBankerBtn = [[UIButton alloc] init];
    [buyBankerBtn setTitle:@"买庄" forState:UIControlStateNormal];
    buyBankerBtn.titleLabel.font = [UIFont systemFontOfSize:kBtnFontSize];
    [buyBankerBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [buyBankerBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    buyBankerBtn.backgroundColor = [UIColor colorWithRed:0.027 green:0.757 blue:0.376 alpha:1.000];
    buyBankerBtn.layer.cornerRadius = 5;
    [buyBankerBtn addTarget:self action:@selector(onBuyBankerBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buyBankerBtn];
    _buyBankerBtn = buyBankerBtn;
    
    [buyBankerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(buyDoubleBtn.mas_right).offset(10);
        make.centerY.mas_equalTo(betMoneyTextField.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(65, kBuyBtnHeight));
    }];
    
    UIButton *buyPlayerBtn = [[UIButton alloc] init];
    [buyPlayerBtn setTitle:@"买闲" forState:UIControlStateNormal];
    buyPlayerBtn.titleLabel.font = [UIFont systemFontOfSize:kBtnFontSize];
    [buyPlayerBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [buyPlayerBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    buyPlayerBtn.backgroundColor = [UIColor colorWithRed:0.027 green:0.757 blue:0.376 alpha:1.000];
    buyPlayerBtn.layer.cornerRadius = 5;
    [buyPlayerBtn addTarget:self action:@selector(onBuyPlayerBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buyPlayerBtn];
    _buyPlayerBtn = buyPlayerBtn;
    
    [buyPlayerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(buyBankerBtn.mas_right).offset(10);
        make.centerY.mas_equalTo(betMoneyTextField.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(65, kBuyBtnHeight));
    }];
    
}

#pragma mark - 加倍
- (void)onBuyDoubleBtn {
    
    self.betMoneyTextField.text = [NSString stringWithFormat:@"%ld", self.betMoneyTextField.text.integerValue * 2];
}


#pragma mark - 买庄
- (void)onBuyBankerBtn {
    self.buyType = 1;
    [self onStartOneButton];
}
#pragma mark - 买闲
- (void)onBuyPlayerBtn {
    self.buyType = 2;
    [self onStartOneButton];
}

#pragma mark - 消键盘
- (void)onDisKeyboardButton {
    [self.view endEditing:YES];
}

- (void)textStatisticsView {
    UILabel *bankerCountLabel = [[UILabel alloc] init];
    bankerCountLabel.font = [UIFont systemFontOfSize:kLabelFontSize];
    bankerCountLabel.numberOfLines = 0;
    //    bankerCountLabel.text = @"庄赢";
    bankerCountLabel.textColor = [UIColor darkGrayColor];
    [self.view addSubview:bankerCountLabel];
    _bankerCountLabel = bankerCountLabel;
    
    [bankerCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.trendView.mas_left);
        make.top.mas_equalTo(self.trendView.mas_bottom).offset(5);
    }];
    
    UILabel *playerCountLabel = [[UILabel alloc] init];
    playerCountLabel.font = [UIFont systemFontOfSize:kLabelFontSize];
    playerCountLabel.numberOfLines = 0;
    //    playerCountLabel.text = @"闲赢";
    playerCountLabel.textColor = [UIColor darkGrayColor];
    [self.view addSubview:playerCountLabel];
    _playerCountLabel = playerCountLabel;
    
    [playerCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.trendView.mas_left);
        make.top.mas_equalTo(bankerCountLabel.mas_bottom);
    }];
    
    UILabel *tieCountLabel = [[UILabel alloc] init];
    tieCountLabel.font = [UIFont systemFontOfSize:kLabelFontSize];
    tieCountLabel.numberOfLines = 0;
    //    tieCountLabel.text = @"和";
    tieCountLabel.textColor = [UIColor darkGrayColor];
    [self.view addSubview:tieCountLabel];
    _tieCountLabel = tieCountLabel;
    
    [tieCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.trendView.mas_left);
        make.top.mas_equalTo(playerCountLabel.mas_bottom);
    }];
    
    UILabel *bankerPairCountLabel = [[UILabel alloc] init];
    bankerPairCountLabel.font = [UIFont systemFontOfSize:kLabelFontSize];
    bankerPairCountLabel.numberOfLines = 0;
    //    bankerPairCountLabel.text = @"庄对";
    bankerPairCountLabel.textColor = [UIColor darkGrayColor];
    [self.view addSubview:bankerPairCountLabel];
    _bankerPairCountLabel = bankerPairCountLabel;
    
    [bankerPairCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.trendView.mas_left);
        make.top.mas_equalTo(tieCountLabel.mas_bottom);
    }];
    
    UILabel *playerPairCountLabel = [[UILabel alloc] init];
    playerPairCountLabel.font = [UIFont systemFontOfSize:kLabelFontSize];
    playerPairCountLabel.numberOfLines = 0;
    //    playerPairCountLabel.text = @"闲对";
    playerPairCountLabel.textColor = [UIColor darkGrayColor];
    [self.view addSubview:playerPairCountLabel];
    _playerPairCountLabel = playerPairCountLabel;
    
    [playerPairCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.trendView.mas_left);
        make.top.mas_equalTo(bankerPairCountLabel.mas_bottom);
    }];
    
    UILabel *superSixCountLabel = [[UILabel alloc] init];
    superSixCountLabel.font = [UIFont systemFontOfSize:kLabelFontSize];
    superSixCountLabel.numberOfLines = 0;
    //    superSixCountLabel.text = @"SuperSix";
    superSixCountLabel.textColor = [UIColor darkGrayColor];
    [self.view addSubview:superSixCountLabel];
    _superSixCountLabel = superSixCountLabel;
    
    [superSixCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.trendView.mas_left);
        make.top.mas_equalTo(playerPairCountLabel.mas_bottom);
    }];
    
    UILabel *pokerCountLabel = [[UILabel alloc] init];
    pokerCountLabel.font = [UIFont systemFontOfSize:kLabelFontSize];
    //    pokerCountLabel.layer.borderWidth = 1;
    //    pokerCountLabel.layer.borderColor = [UIColor blueColor].CGColor;
    pokerCountLabel.numberOfLines = 0;
    //    pokerCountLabel.text = @"结果";S
    pokerCountLabel.textColor = [UIColor darkGrayColor];
    [self.view addSubview:pokerCountLabel];
    _pokerCountLabel = pokerCountLabel;
    
    [pokerCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.trendView.mas_left);
        make.top.mas_equalTo(superSixCountLabel.mas_bottom);
    }];
    
    UILabel *kkkLabel = [[UILabel alloc] init];
    kkkLabel.font = [UIFont systemFontOfSize:kLabelFontSize];
    //    pokerCountLabel.layer.borderWidth = 1;
    //    pokerCountLabel.layer.borderColor = [UIColor blueColor].CGColor;
    kkkLabel.numberOfLines = 0;
    //    pokerCountLabel.text = @"结果";S
    kkkLabel.textColor = [UIColor darkGrayColor];
    [self.view addSubview:kkkLabel];
    _kkkLabel = kkkLabel;
    
    [kkkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.trendView.mas_left);
        make.top.mas_equalTo(pokerCountLabel.mas_bottom);
    }];
    
    
    UILabel *aaaa = [[UILabel alloc] init];
    aaaa.font = [UIFont systemFontOfSize:kLabelFontSize];
    //    pokerCountLabel.layer.borderWidth = 1;
    //    pokerCountLabel.layer.borderColor = [UIColor blueColor].CGColor;
    aaaa.numberOfLines = 0;
    //    pokerCountLabel.text = @"结果";S
    aaaa.textColor = [UIColor darkGrayColor];
    [self.view addSubview:aaaa];
    _aaaa = aaaa;
    
    [aaaa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.trendView.mas_left);
        make.top.mas_equalTo(kkkLabel.mas_bottom);
    }];
    
    
    UILabel *bbbb = [[UILabel alloc] init];
    bbbb.font = [UIFont systemFontOfSize:kLabelFontSize];
    //    pokerCountLabel.layer.borderWidth = 1;
    //    pokerCountLabel.layer.borderColor = [UIColor blueColor].CGColor;
    bbbb.numberOfLines = 0;
    //    pokerCountLabel.text = @"结果";S
    bbbb.textColor = [UIColor darkGrayColor];
    [self.view addSubview:bbbb];
    _bbbb = bbbb;
    
    [bbbb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.trendView.mas_left);
        make.top.mas_equalTo(aaaa.mas_bottom);
        make.right.mas_equalTo(self.view.mas_right);
    }];
    
    UILabel *buyMoneyLabel = [[UILabel alloc] init];
    buyMoneyLabel.font = [UIFont systemFontOfSize:kLabelFontSize];
    //    pokerCountLabel.layer.borderWidth = 1;
    //    pokerCountLabel.layer.borderColor = [UIColor blueColor].CGColor;
    buyMoneyLabel.numberOfLines = 0;
    //    pokerCountLabel.text = @"结果";S
    buyMoneyLabel.textColor = [UIColor darkGrayColor];
    [self.view addSubview:buyMoneyLabel];
    _buyMoneyLabel = buyMoneyLabel;
    
    [buyMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.trendView.mas_left);
        make.top.mas_equalTo(bbbb.mas_bottom);
        make.right.mas_equalTo(self.view.mas_right);
    }];
    
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.font = [UIFont systemFontOfSize:kLabelFontSize];
    timeLabel.textColor = [UIColor darkGrayColor];
    [self.view addSubview:timeLabel];
    _timeLabel = timeLabel;
    
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.trendView.mas_left);
        make.top.mas_equalTo(buyMoneyLabel.mas_bottom);
        make.right.mas_equalTo(self.view.mas_right);
    }];
    
    
}

#pragma mark -  清除
- (void)onClearButton {
    
    [self initData];
    self.trendView.model = self.resultDataArray;
    [self resultStatisticsText];
    [self.tableView reloadData];
}

#pragma mark -  开始一局
- (void)onStartOneButton {
    [self.view endEditing:YES];
    
    if (self.pokerTotalNum < 6) {  // 停止发牌
        self.pokerCountLabel.text = [NSString stringWithFormat:@"GAME  %ld  剩余%ld张牌  庄闲相差 %ld  已结束", self.pokerCount, self.pokerTotalNum, self.bankerCount - self.playerCount];
        self.buyBankerBtn.backgroundColor = [UIColor lightGrayColor];
        self.buyPlayerBtn.backgroundColor = [UIColor lightGrayColor];
        return;
    }
    
    self.pokerCount++;
    [self oncePoker];
    
    self.trendView.model = self.resultDataArray;
    [self resultStatisticsContinuous];
    [self resultStatisticsText];
    [self.tableView reloadData];
}

#pragma mark -  全盘
/**
 全盘
 */
- (void)onStartButton {
    // 记录当前时间
    float start = CACurrentMediaTime();
    
    self.pokerNum = self.pokerNumTextField.text.integerValue;
    
    [self opening];
    self.trendView.model = self.resultDataArray;
    //    [self resultStatisticsContinuous];
    
    [self resultStatisticsContinuous];
    [self resultStatisticsText];
    [self.tableView reloadData];
    
    
    
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
    
    NSDictionary *firstDict = (NSDictionary *)self.resultDataArray.firstObject;
    compareChar       = [[firstDict objectForKey:@"WinType"] stringValue];  // 从第一个字符开始比较
    longestContinChar = compareChar;
    
    firstisBankerPair       = [[firstDict objectForKey:@"isBankerPair"] boolValue];
    firstisPlayerPair       = [[firstDict objectForKey:@"isPlayerPair"] boolValue];
    firstisSuperSix       = [[firstDict objectForKey:@"isSuperSix"] boolValue];
    
    if (![compareChar isEqualToString:@"2"]) {  // 记录最后一次的 Banker或者Player
        lastBankerOrPlayer = compareChar;
    }
    
    for (NSInteger indexFlag = 1; indexFlag < self.resultDataArray.count; indexFlag++) {
        
        NSDictionary *dict = (NSDictionary *)self.resultDataArray[indexFlag];
        NSString *tempStrWinType       = [[dict objectForKey:@"WinType"] stringValue]; //
        BOOL tempIsBankerPair       = [[dict objectForKey:@"isBankerPair"] boolValue];
        BOOL tempIsPlayerPair       = [[dict objectForKey:@"isPlayerPair"] boolValue];
        BOOL tempIsSuperSix       = [[dict objectForKey:@"isSuperSix"] boolValue];
        
        // 与前6局关系
        if (indexFlag >= 6) {
            NSDictionary *front6SameCountDict = (NSDictionary *)self.resultDataArray[indexFlag - 6];
            NSString *tempFront6SameCountDict       = [[front6SameCountDict objectForKey:@"WinType"] stringValue];
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
            NSDictionary *dictII = (NSDictionary *)self.resultDataArray[indexFlag - self.intervalNum];
            NSString *tempStrWinTypeII       = [[dictII objectForKey:@"WinType"] stringValue]; //
            BOOL tempIsBankerPairII       = [[dictII objectForKey:@"isBankerPair"] boolValue];
            BOOL tempIsPlayerPairII       = [[dictII objectForKey:@"isPlayerPair"] boolValue];
            BOOL tempIsSuperSixII       = [[dictII objectForKey:@"isSuperSix"] boolValue];
            
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
    
}


#pragma mark -  开始
- (void)opening {
    [self initData];
    // 发牌局数
    for (NSInteger i = 1; i <= (self.pokerNum * 52 / 4); i++) {
        if (self.pokerTotalNum < 6) {
            break;
        }
        self.pokerCount++;
        [self oncePoker];
    }
}




#pragma mark -  数据初始化
- (void)initData {
    
    NSArray *pokerArray = @[ @(1),@(2),@(3),@(4),@(5),@(6),@(7),@(8),@(9),@(10),@(11),@(12),@(13),
                             @(1),@(2),@(3),@(4),@(5),@(6),@(7),@(8),@(9),@(10),@(11),@(12),@(13),
                             @(1),@(2),@(3),@(4),@(5),@(6),@(7),@(8),@(9),@(10),@(11),@(12),@(13),
                             @(1),@(2),@(3),@(4),@(5),@(6),@(7),@(8),@(9),@(10),@(11),@(12),@(13)
                             ];
    
    NSMutableArray *array = [VVFunctionManager shuffleArray:pokerArray pokerPairsNum:self.pokerNum];
    self.dataArray = [NSMutableArray arrayWithArray:array];
    
    self.pokerTotalNum = self.dataArray.count;
    self.pokerCount = 0;
    self.playerCount = 0;
    self.bankerCount = 0;
    self.playerPairCount = 0;
    self.bankerPairCount = 0;
    self.superSixCount = 0;
    self.tieCount = 0;
    self.resultDataArray = [NSMutableArray array];
    self.bankerPlayerSinglePairCount = 0;
    self.betTotalMoney = 0;
    self.buyType = -1;
}

#pragma mark -  Baccarat算法
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
        //        NSNumber *num = (NSNumber *)self.dataArray[pokerPoints];
        //        [self.dataArray removeObjectAtIndex:pokerPoints];
        //        NSLog(@"🔴= %@", num.stringValue);
        
        
        NSNumber *num = (NSNumber *)self.dataArray.firstObject;
        [self.dataArray removeObjectAtIndex:0];
        self.pokerTotalNum--;
        
        if (i == 1) {
            player1 = num.integerValue;
        } else if (i == 2) {
            banker1 = num.integerValue;
        } else if (i == 3) {
            player2 = num.integerValue;
        } else if (i == 4) {
            banker2 = num.integerValue;
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
                player3 = num.stringValue;
            } else {
                if (bankerPointsNum < 6) {
                    banker3 = num.stringValue;
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
                banker3 = num.stringValue;
            }
        }
    }
    
    
    NSInteger tempPlayer3 = player3.integerValue >= 10 ? 0 : player3.integerValue;
    NSInteger tempBanker3 = banker3.integerValue >= 10 ? 0 : banker3.integerValue;
    playerPointsNum = (playerPointsNum + tempPlayer3) >= 10 ? playerPointsNum + tempPlayer3 - 10 : playerPointsNum + tempPlayer3;
    bankerPointsNum = (bankerPointsNum + tempBanker3) >= 10 ? bankerPointsNum + tempBanker3 - 10 : bankerPointsNum + tempBanker3;
    
    NSMutableDictionary *dict =  [NSMutableDictionary dictionary];
    // 判断庄闲 输赢
    NSString *win;
    if (playerPointsNum < bankerPointsNum) {
        if (bankerPointsNum == 6) {  // Super6
            win = @"🔴🔸";
            self.superSixCount++;
            [dict setObject:@(YES) forKey:@"isSuperSix"];
            
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
        [dict setObject:@(1) forKey:@"WinType"];
        self.bankerCount++;
    } else if (playerPointsNum > bankerPointsNum) {
        win = @"🅿️";
        self.playerCount++;
        [dict setObject:@(2) forKey:@"WinType"];
        
        if (self.buyType == 2) {
            self.betTotalMoney = self.betTotalMoney + self.betMoneyTextField.text.integerValue;
        } else {
            self.betTotalMoney = self.betTotalMoney - self.betMoneyTextField.text.integerValue;
        }
        
    } else {
        win = @"✅";
        self.tieCount++;
        [dict setObject:@(0) forKey:@"WinType"];
    }
    
    // Pair
    if (player1 == player2) {
        win = [NSString stringWithFormat:@"%@🔹", win];
        self.playerPairCount++;
        [dict setObject:@(YES) forKey:@"isPlayerPair"];
    }
    if (banker1 == banker2) {
        win = [NSString stringWithFormat:@"%@🔺", win];
        self.bankerPairCount++;
        [dict setObject:@(YES) forKey:@"isBankerPair"];
    }
    
    if (player1 == player2 || banker1 == banker2) {
        self.bankerPlayerSinglePairCount++;
    }
    
    [dict setObject: [NSString stringWithFormat:@"%ld", player1] forKey:@"player1"];
    [dict setObject: [NSString stringWithFormat:@"%ld", player2] forKey:@"player2"];
    
    [dict setObject: player3 == nil ? @"" : player3 forKey:@"player3"];
    [dict setObject: [NSString stringWithFormat:@"%ld", banker1] forKey:@"banker1"];
    [dict setObject: [NSString stringWithFormat:@"%ld", banker2] forKey:@"banker2"];
    [dict setObject: banker3  == nil ? @"" : banker3 forKey:@"banker3"];
    [dict setObject: [NSString stringWithFormat:@"%ld", playerPointsNum] forKey:@"playerPointsNum"];
    [dict setObject: [NSString stringWithFormat:@"%ld", bankerPointsNum] forKey:@"bankerPointsNum"];
    [dict setObject: [NSString stringWithFormat:@"%ld", self.pokerCount] forKey:@"pokerCount"];
    
    
    [self.resultDataArray addObject:dict];
    
    NSLog(@"Player: %ld点 %ld  %ld  %@  - Banker: %ld点 %d  %ld  %@ =%@",playerPointsNum, player1, player2, player3.length > 0 ? player3 : @"",   bankerPointsNum, banker1, banker2, banker3.length > 0 ? banker3 : @"", win);
}


#pragma mark -  UITableView 初始化
- (UITableView *)tableView {
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kMarginHeight + 30 +5 + kTrendViewHeight +2 + 126 +100 +30, [[UIScreen mainScreen] bounds].size.width , [UIScreen mainScreen].bounds.size.height - (kMarginHeight + 30 +5 + kTrendViewHeight +2 + 126 +64 +100 +30)) style:UITableViewStylePlain];
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
    
    BaccaratCell *cell = [BaccaratCell cellWithTableView:tableView reusableId:@"BaccaratCell"];
    // 倒序
    cell.model = self.resultDataArray[self.resultDataArray.count - indexPath.row -1];
    return cell;
    
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 35;
}




@end


