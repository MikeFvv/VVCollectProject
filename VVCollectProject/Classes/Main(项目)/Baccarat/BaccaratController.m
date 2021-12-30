//
//  BaccaratController.m
//  VVCollectProject
//
//  Created by Mike on 2019/2/20.
//  Copyright © 2019 Mike. All rights reserved. 1 2 3
//

#import "BaccaratController.h"
#import "BZhuPanLuCollectionView.h"
#include <stdlib.h>
#import "VVFunctionManager.h"
#import "PointListController.h"
#import <MBProgressHUD.h>
#import "BaccaratConfigController.h"
#import "BaccaratResultModel.h"
#import "BBigRoadMapView.h"
#import "CardDataSourceModel.h"
#import "BAnalyzeRoadMapView.h"
#import "BShowPokerView.h"
#import "BaccaratCom.h"
#import "FunctionManager.h"
#import "WMDragView.h"
#import "BaccaratBetView.h"
#import "BaccaratXiaSanLuView.h"
#import "ChipsView.h"
#import "BBBetMaxMinView.h"
#import "BGameStatisticsModel.h"
#import "BUserChipssView.h"
#import "BBetModel.h"
#import "BUserData.h"


#define kBtnHeight 35
#define kBuyBtnHeight 50
#define kBtnFontSize 16
#define kMarginHeight 10
// 边距
#define kMarginWidth 15

#define kLabelFontSize 12

#define kColorAlpha 0.9

#define kAddWidth 60


@interface BaccaratController ()<BBigRoadMapViewDelegate,ChipsViewDelegate,BShowPokerViewDelegate,BaccaratBetViewDelegate>

@property (nonatomic, strong) UIView *contentView;
//
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UIView *bottomView;

/// 牌副数
@property (nonatomic, strong) UITextField *pokerNumTextField;


/// 珠盘路
@property (nonatomic, strong) BZhuPanLuCollectionView *zhuPanLuCollectionView;
/// 大路
@property (nonatomic, strong) BBigRoadMapView *bigRoadMapView;
/// 大眼路
@property (nonatomic, strong) BaccaratXiaSanLuView *dylXiaSanLuView;
/// 小路
@property (nonatomic, strong) BaccaratXiaSanLuView *xlXiaSanLuView;
/// 小强路
@property (nonatomic, strong) BaccaratXiaSanLuView *xqlXiaSanLuView;
/// 筹码视图
@property (nonatomic, strong) ChipsView *chipsView;
/// 下注视图
@property (nonatomic, strong) BaccaratBetView *bBetView;
/// 用户筹码视图
@property (nonatomic, strong) BUserChipssView *userChipssView;

/// 分析路图
@property (nonatomic, strong) BAnalyzeRoadMapView *analyzeRoadMapView;
/// 显示牌型视图
@property (nonatomic, strong) BShowPokerView *showPokerView;


/// 结果数据
@property (nonatomic, strong) NSMutableArray<BaccaratResultModel *> *resultDataArray;
@property (strong, nonatomic) CardDataSourceModel *baccaratDataModel;
/// 选中的筹码
@property (nonatomic, strong) ChipsModel *selectedModel;
/// 下注金额
@property (nonatomic, strong) BBetModel *betModel;


/// 返回按钮
@property(nonatomic,strong) WMDragView *backDragView;

/// *** 测试时使用 ***
@property (nonatomic, assign) NSInteger testIndex;

/// /// 是否自动运行全部
@property (nonatomic, assign) BOOL isAutoRunAll;


@property(nonatomic,strong) BGameStatisticsModel *gameStatisticsModel;
@property(nonatomic,strong) BUserData *bUserData;


@end

@implementation BaccaratController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.testIndex = 0;
    self.isAutoRunAll = NO;
    
    [self initData];
    [self setupNavUI];
    [self createUI];
    
    
    [self setFloatingBackBtnView];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //    [self configureNavigationBar];
    // 要刷新状态栏，让其重新执行该方法需要调用{-setNeedsStatusBarAppearanceUpdate}
    //    [self setNeedsStatusBarAppearanceUpdate];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [FunctionManager interfaceOrientation:UIInterfaceOrientationPortrait];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}


#pragma mark -  数据初始化
- (void)initData {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSInteger amount = [userDefaults integerForKey:@"BaccaratBetAmount"];
    NSArray *tempArray = [userDefaults objectForKey:@"BaccaratPokerArray"];
    
    
    NSArray *pokerArray = nil;
    if (tempArray) {
        pokerArray = tempArray;
    } else {
        pokerArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",
                       @"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",
                       @"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",
                       @"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13"
        ];
    }
    
    BUserData *bUserData = [[BUserData alloc] init];
    _bUserData = bUserData;
    bUserData.betTotalMoney = 30000;
    bUserData.beforeBetTotalMoney = 30000;
    
    bUserData.perTableMaxTotalMoney = 30000;
    bUserData.perTableMinTotalMoney = 30000;
    
    
    
    BBetModel *betModel = [[BBetModel alloc] init];
    _betModel = betModel;
    
    
    BGameStatisticsModel *gameStatisticsModel = [[BGameStatisticsModel alloc] init];
    gameStatisticsModel.pokerTotalNum = self.dataArray.count;
    _gameStatisticsModel = gameStatisticsModel;
    
    self.resultDataArray = [NSMutableArray array];
    
}

- (NSMutableArray*)dataArray
{
    if (!_dataArray) {
        
        NSInteger num = self.pokerNumTextField.text.integerValue ? self.pokerNumTextField.text.integerValue : 8;
        _dataArray = [NSMutableArray arrayWithArray:[VVFunctionManager shuffleArray:self.baccaratDataModel.sortedDeckArray pokerPairsNum:num]];
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


#pragma mark - ChipsViewDelegate 筹码选中
/// 选中筹码后
/// @param selectedModel 选中筹码模型
- (void)chipsSelectedModel:(ChipsModel *)selectedModel {
    self.bBetView.selectedModel = selectedModel;
    self.selectedModel = selectedModel;
    NSLog(@"111");
}

/// 确定下注
- (void)sureBetBtnClick:(UIButton *)sender {

    if (sender.tag == 5000) {
        self.chipsView.hidden = YES;
        [self onStartOneButton];
    } else if (sender.tag == 5001) { // 重复下注
        self.chipsView.isRepeatBetBtn = NO;
        self.betModel = self.gameStatisticsModel.lastBetModel;
        [self benCommonMethod];
    } else if (sender.tag == 5002) {  // 全押
        self.chipsView.isAllInBetBtn = NO;
        /// 判断上次下注庄、闲
        if (self.gameStatisticsModel.lastBetModel.player_money > self.gameStatisticsModel.lastBetModel.banker_money) {
            self.betModel.player_money = self.bUserData.betTotalMoney - self.bUserData.betTotalMoney / kMinBetChipsNum;
        } else {
            self.betModel.banker_money = self.bUserData.betTotalMoney - self.bUserData.betTotalMoney % kMinBetChipsNum;
        }
        [self benCommonMethod];
    }
    
}
/// 取消注码
- (void)cancelBetChipsBtnClick {
    [self.bBetView cancelBetChips];
    
    self.bUserData.betTotalMoney = self.bUserData.beforeBetTotalMoney;
    self.userChipssView.userMoneyLabel.text = [NSString stringWithFormat:@"%ld",self.bUserData.betTotalMoney];
    
    self.betModel = nil;
    self.betModel = [[BBetModel alloc] init];
    self.chipsView.currentBalance = self.bUserData.betTotalMoney;
    
    if (self.chipsView.isShowCancelBtn) {
        self.chipsView.isShowCancelBtn = NO;
    }
}

#pragma mark -  翻牌结束
/// 翻牌结束 结束一局
- (void)endFlop {
    self.chipsView.hidden = NO;
    [self.bBetView cancelBetChips];
    [self calculationResults];
    
    self.betModel = nil;
    self.betModel = [[BBetModel alloc] init];
    
    self.zhuPanLuCollectionView.model = self.resultDataArray;
    self.bigRoadMapView.model = self.resultDataArray;
}

#pragma mark BaccaratBetViewDelegate 选中下注
/// 每次下注回调
- (void)everyBetClick:(UIButton *)sender {
    
    // 正在翻盘中，禁止下注
    if (self.chipsView.hidden) {
        return;
    }
    
    // 用户筹码小于选定筹码，禁止下注
    if (self.bUserData.betTotalMoney < self.selectedModel.money) {
        return;
    }
    
    if (sender.tag == 3001) { // 闲对
        if (self.betModel.playerPair_money + self.selectedModel.money <= kMaxBetChipsNum) {
            
            self.betModel.playerPair_money = self.betModel.playerPair_money + self.selectedModel.money;
        }
    } else if (sender.tag == 3002) { // 和
        if (self.betModel.tie_money + self.selectedModel.money <= kMaxBetChipsNum) {
            self.betModel.tie_money = self.betModel.tie_money + self.selectedModel.money;
        }
    } else if (sender.tag == 3003) { // 超级6
        if (self.betModel.superSix_money + self.selectedModel.money <= kMaxBetChipsNum) {
            
            self.betModel.superSix_money = self.betModel.superSix_money + self.selectedModel.money;
        }
    } else if (sender.tag == 3004) { // 庄对
        if (self.betModel.bankerPair_money + self.selectedModel.money <= kMaxBetChipsNum) {
            
            self.betModel.bankerPair_money = self.betModel.bankerPair_money + self.selectedModel.money;
        }
    } else if (sender.tag == 3005) { // 闲
        if (self.betModel.player_money + self.selectedModel.money <= kMaxBetChipsNum && self.betModel.player_money + self.selectedModel.money >= kMinBetChipsNum) {
            
            self.betModel.player_money = self.betModel.player_money + self.selectedModel.money;
        }
    } else if (sender.tag == 3006) { // 庄
        if (self.betModel.banker_money + self.selectedModel.money <= kMaxBetChipsNum && self.betModel.banker_money + self.selectedModel.money >= kMinBetChipsNum) {
            self.betModel.banker_money = self.betModel.banker_money + self.selectedModel.money;
        }
    }
    
    [self benCommonMethod];
}

- (void)benCommonMethod {
    self.bBetView.betModel = self.betModel;
    self.bUserData.betTotalMoney = self.bUserData.beforeBetTotalMoney - self.betModel.total_ben_money;
    self.userChipssView.userMoneyLabel.text = [NSString stringWithFormat:@"%ld",self.bUserData.betTotalMoney];
    
    self.chipsView.currentBalance = self.bUserData.betTotalMoney;
    
    if (self.chipsView.isRepeatBetBtn) {
        self.chipsView.isRepeatBetBtn = NO;
    }
    
    if (self.betModel.total_ben_money > 0) {
        self.chipsView.isShowCancelBtn = YES;
    }
}





/// 计算结果
- (void)calculationResults {
    
    BaccaratResultModel *resultModel = self.resultDataArray.lastObject;
    
    self.gameStatisticsModel.pokerCount = self.resultDataArray.count;
    self.gameStatisticsModel.gameNum = self.resultDataArray.count;
    
    if (resultModel.winType == WinType_Player) {
        self.gameStatisticsModel.playerNum = self.gameStatisticsModel.playerNum +1;
    } else if (resultModel.winType == WinType_Banker) {
        self.gameStatisticsModel.bankerNum = self.gameStatisticsModel.bankerNum +1;
    } else {
        self.gameStatisticsModel.tieNum = self.gameStatisticsModel.tieNum +1;
    }
    
    
    if (resultModel.isPlayerPair) {
        self.gameStatisticsModel.playerPairNum = self.gameStatisticsModel.playerPairNum +1;
    }
    if (resultModel.isBankerPair) {
        self.gameStatisticsModel.bankerPairNum = self.gameStatisticsModel.bankerPairNum +1;
    }
    if (resultModel.isSuperSix) {
        self.gameStatisticsModel.superNum = self.gameStatisticsModel.superNum +1;
    }
    
    self.analyzeRoadMapView.gameStatisticsModel = self.gameStatisticsModel;
    
    
    [self calculateWinAndLoseChips:resultModel];
    
}

/// 计算输赢筹码
/// @param resultModel 模型
- (void)calculateWinAndLoseChips:(BaccaratResultModel *)resultModel {
    // 上次下注记录
    self.gameStatisticsModel.lastBetModel = [self.betModel modelCopy];
    
    if (resultModel.winType == WinType_Player) {
        self.betModel.player_money = self.betModel.player_money *2;
        self.betModel.banker_money = 0;
        self.betModel.tie_money = 0;
    } else if (resultModel.winType == WinType_Banker) {
        self.betModel.player_money = 0;
        if (resultModel.isSuperSix) {
            self.betModel.banker_money = self.betModel.banker_money *1.5;
        } else {
            self.betModel.banker_money = self.betModel.banker_money *2;
        }
        self.betModel.tie_money = 0;
    } else {
        self.betModel.tie_money = self.betModel.tie_money *9;
    }
    
    
    if (resultModel.isPlayerPair) {
        self.betModel.playerPair_money = self.betModel.playerPair_money *12;
    } else {
        self.betModel.playerPair_money = 0;
    }
    
    if (resultModel.isBankerPair) {
        self.betModel.bankerPair_money = self.betModel.bankerPair_money *12;
    } else {
        self.betModel.bankerPair_money = 0;
    }
    
    if (resultModel.isSuperSix) {
        self.betModel.superSix_money = self.betModel.superSix_money *13;
    } else {
        self.betModel.superSix_money = 0;
    }
    
    
    // 总金额
    self.bUserData.betTotalMoney = self.bUserData.betTotalMoney + self.betModel.total_ben_money;
    // 输赢金额
    self.gameStatisticsModel.lastLoseWinMoney = self.bUserData.betTotalMoney - self.bUserData.beforeBetTotalMoney;
    
    self.bUserData.beforeBetTotalMoney = self.bUserData.betTotalMoney;
    self.userChipssView.userMoneyLabel.text = [NSString stringWithFormat:@"%ld",self.bUserData.betTotalMoney];
    self.chipsView.currentBalance = self.bUserData.betTotalMoney;
    
    
    if (self.chipsView.isShowCancelBtn) {
        self.chipsView.isShowCancelBtn = NO;
    }
    /// 当前总金额大于上次 下注金额  显示 重复下注 按钮
    if (self.bUserData.betTotalMoney > 0 && self.bUserData.betTotalMoney >= self.gameStatisticsModel.lastBetModel.total_ben_money) {
        self.chipsView.isRepeatBetBtn = YES;
    } else if (self.bUserData.betTotalMoney > 0) {
        self.chipsView.isAllInBetBtn = YES;
    }
    
    
    // 最低
    if (self.bUserData.betTotalMoney < self.bUserData.perTableMinTotalMoney) {
        self.bUserData.perTableMinTotalMoney = self.bUserData.betTotalMoney;
    }
    // 最高
    if (self.bUserData.betTotalMoney > self.bUserData.perTableMaxTotalMoney) {
        self.bUserData.perTableMaxTotalMoney = self.bUserData.betTotalMoney;
    }
}




#pragma mark -  BBigRoadMapViewDelegate 下三路数据
- (void)getXSLDataWithCurrentModel:(BaccaratResultModel *)currentModel wenLuDataArray:(NSMutableArray *)wenLuDataArray dylDataArray:(NSMutableArray *)dylDataArray xlDataArray:(NSMutableArray *)xlDataArray xqlDataArray:(NSMutableArray *)xqlDataArray {
    
    self.analyzeRoadMapView.currentModel = currentModel;
    self.analyzeRoadMapView.wenLuDataArray = wenLuDataArray;
    
    self.dylXiaSanLuView.dataArray = dylDataArray;
    self.xlXiaSanLuView.dataArray = xlDataArray;
    self.xqlXiaSanLuView.dataArray = xqlDataArray;
}

- (void)createUI {
    self.view.backgroundColor = [UIColor blackColor];
    
    CGFloat halfWidth = self.view.frame.size.width/2;
    
    UIView *contentView = [[UIView alloc]init];
    contentView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:contentView];
    _contentView = contentView;
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
        make.width.offset(self.view.bounds.size.width);
        make.height.equalTo(@600);
    }];
    
    
    // ********* 左边 *********
    [self createLeftView];
    
    // 底部按钮功能
    [self setBottomView];
    // 右边路子图
    [self rightRoadMapView];
    
}

- (void)createLeftView {
    
    //    CGFloat navst = mxwStatusHeight();
    
    CGFloat leftW =  IS_NOTCHED_SCREEN ? getNotchScreenHeight-16 : 0;
    
    
    
    
    CGFloat halfWidth = self.view.frame.size.width/2;
    CGFloat leftVWidht = halfWidth + kAddWidth-leftW -2;
    
    UIView *leftBgView = [[UIView alloc] init];
    leftBgView.backgroundColor = [UIColor colorWithHex:@"046726"];
    [self.contentView addSubview:leftBgView];
    
    [leftBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(0);
        make.left.equalTo(self.contentView.mas_left).offset(leftW);
        make.width.mas_equalTo(leftVWidht);
        make.height.mas_equalTo(mxwScreenHeight()-kTrendViewHeight);
    }];
    
    // 展示牌型视图
    BShowPokerView *showPokerView = [[BShowPokerView alloc] initWithFrame:CGRectMake(70, 10, 360, 150)];
    showPokerView.delegate = self;
    [leftBgView addSubview:showPokerView];
    _showPokerView = showPokerView;
    
    
    // 下注庄闲视图
    BaccaratBetView *betView = [[BaccaratBetView alloc] initWithFrame:CGRectMake(100, 120, halfWidth-60-20*2, 50*2+10+30)];
    betView.delegate = self;
    [leftBgView addSubview:betView];
    _bBetView = betView;
    
    // 用户筹码视图
    BUserChipssView *userChipssView = [[BUserChipssView alloc] initWithFrame:CGRectMake(35, 180, 60, 80)];
    [leftBgView addSubview:userChipssView];
    _userChipssView = userChipssView;
    
    self.userChipssView.userMoneyLabel.text = [NSString stringWithFormat:@"%ld",self.bUserData.betTotalMoney];
    
    
    //筹码视图
    ChipsView *chipsView = [[ChipsView alloc] initWithFrame:CGRectMake(leftW+100, mxwScreenHeight()-50-10, mxwScreenWidth()-leftW*2-100*2-60, 50)];
    
    [self.view addSubview:chipsView];
    _chipsView = chipsView;
    chipsView.currentBalance = self.bUserData.betTotalMoney;
    chipsView.delegate = self;
    
    // 珠盘路(庄闲路)
    BZhuPanLuCollectionView *zhuPanLuCollectionView = [[BZhuPanLuCollectionView alloc] initWithFrame:CGRectMake(leftW, mxwScreenHeight()-kTrendViewHeight, leftVWidht/3*2-5, kTrendViewHeight)];
    zhuPanLuCollectionView.roadType = 0;
    //    zhuPanLuCollectionView.backgroundColor = [UIColor redColor];
    zhuPanLuCollectionView.layer.borderWidth = 1;
    zhuPanLuCollectionView.layer.borderColor = [UIColor colorWithRed:0.643 green:0.000 blue:0.357 alpha:1.000].CGColor;
    [self.contentView addSubview:zhuPanLuCollectionView];
    _zhuPanLuCollectionView = zhuPanLuCollectionView;
    
    
    // 分析问路图
    BAnalyzeRoadMapView *analyzeRoadMapView = [[BAnalyzeRoadMapView alloc] initWithFrame:CGRectMake(leftVWidht/3*2+leftW, mxwScreenHeight()-kTrendViewHeight, leftVWidht/3*1, kTrendViewHeight)];
    [self.contentView addSubview:analyzeRoadMapView];
    _analyzeRoadMapView = analyzeRoadMapView;
}

/// 路子图
- (void)rightRoadMapView {
    
    CGFloat halfWidth = self.view.frame.size.width/2;
    CGFloat height = self.view.frame.size.height/2;
    
    // ********* 右边 *********
    // 最小下注 最大下注
    CGFloat betViewHeight = 40;
    BBBetMaxMinView *betMaxMinView = [[BBBetMaxMinView alloc] initWithFrame:CGRectMake(halfWidth+kAddWidth, 1*1, halfWidth - kAddWidth-10, betViewHeight)];
    betMaxMinView.layer.borderWidth = 1;
    betMaxMinView.layer.borderColor = [UIColor colorWithRed:0.643 green:0.000 blue:0.357 alpha:1.000].CGColor;
    [self.contentView addSubview:betMaxMinView];
    
    
    // 大路
    CGFloat daluHeight = (kDLItemSizeWidth+1)*6+1;
    BBigRoadMapView *bigRoadMapView = [[BBigRoadMapView alloc] initWithFrame:CGRectMake(halfWidth+kAddWidth, betViewHeight+1*1, halfWidth - kAddWidth-10, daluHeight)];
    bigRoadMapView.layer.borderWidth = 1;
    bigRoadMapView.layer.borderColor = [UIColor colorWithRed:0.643 green:0.000 blue:0.357 alpha:1.000].CGColor;
    bigRoadMapView.delegate = self;
    [self.contentView addSubview:bigRoadMapView];
    _bigRoadMapView = bigRoadMapView;
    
    // *** 下三路 ***
    CGFloat xiasanluHeight = (kItemSizeWidth+1)*6+1;
    BaccaratXiaSanLuView *dylXiaSanLuView = [[BaccaratXiaSanLuView alloc] initWithFrame:CGRectMake(halfWidth+kAddWidth, betViewHeight+daluHeight+1*2, halfWidth - kAddWidth-10, xiasanluHeight)];
    dylXiaSanLuView.roadMapType = RoadMapType_DYL;
    dylXiaSanLuView.layer.borderWidth = 1;
    dylXiaSanLuView.layer.borderColor = [UIColor colorWithRed:0.643 green:0.000 blue:0.357 alpha:1.000].CGColor;
    [self.contentView addSubview:dylXiaSanLuView];
    _dylXiaSanLuView = dylXiaSanLuView;
    
    
    BaccaratXiaSanLuView *xlXiaSanLuView = [[BaccaratXiaSanLuView alloc] initWithFrame:CGRectMake(halfWidth+kAddWidth, betViewHeight+daluHeight+xiasanluHeight*1+1*3, halfWidth - kAddWidth-10, xiasanluHeight)];
    xlXiaSanLuView.roadMapType = RoadMapType_XL;
    xlXiaSanLuView.layer.borderWidth = 1;
    xlXiaSanLuView.layer.borderColor = [UIColor colorWithRed:0.643 green:0.000 blue:0.357 alpha:1.000].CGColor;
    [self.contentView addSubview:xlXiaSanLuView];
    _xlXiaSanLuView = xlXiaSanLuView;
    
    BaccaratXiaSanLuView *xqlXiaSanLuView = [[BaccaratXiaSanLuView alloc] initWithFrame:CGRectMake(halfWidth+kAddWidth, betViewHeight+daluHeight+xiasanluHeight*2+1*4, halfWidth - kAddWidth-10, xiasanluHeight)];
    xqlXiaSanLuView.roadMapType = RoadMapType_XQL;
    xqlXiaSanLuView.layer.borderWidth = 1;
    xqlXiaSanLuView.layer.borderColor = [UIColor colorWithRed:0.643 green:0.000 blue:0.357 alpha:1.000].CGColor;
    [self.contentView addSubview:xqlXiaSanLuView];
    _xqlXiaSanLuView = xqlXiaSanLuView;
    
}


- (void)setBottomView {
    
    UIView *bottomView = [[UIView alloc] init];
    bottomView.layer.borderWidth = 1;
    bottomView.layer.borderColor = [UIColor redColor].CGColor;
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:bottomView];
    _bottomView = bottomView;
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_top).offset(500);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.height.mas_equalTo(50);
    }];
    
    UITextField *pokerNumTextField = [[UITextField alloc] initWithFrame:CGRectMake(kMarginWidth, kMarginHeight, 150, kBtnHeight)];
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
    
    
    UIButton *clearButton = [[UIButton alloc] initWithFrame:CGRectMake(kMarginWidth + 60 + 10 +50 +10 +80 +10, kMarginHeight, 50, kBtnHeight)];
    [clearButton setTitle:@"清除" forState:UIControlStateNormal];
    clearButton.titleLabel.font = [UIFont systemFontOfSize:kBtnFontSize];
    [clearButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [clearButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    clearButton.backgroundColor = [UIColor colorWithRed:0.027 green:0.757 blue:0.376 alpha:1.000];
    clearButton.layer.cornerRadius = 5;
    [clearButton addTarget:self action:@selector(onClearButton) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:clearButton];
    
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

#pragma mark - 消键盘
- (void)onDisKeyboardButton {
    [self.view endEditing:YES];
}


#pragma mark -  清除
- (void)onClearButton {
    
    [self initData];
    self.zhuPanLuCollectionView.model = self.resultDataArray;
    self.bigRoadMapView.model = self.resultDataArray;
    
}

#pragma mark -  开始一局
- (void)onStartOneButton {
    [self.view endEditing:YES];
    
    [self.showPokerView removeStackView];
    
    if (self.gameStatisticsModel.pokerTotalNum < 36) {  // 停止发牌
        [MBProgressHUD showTipMessageInWindow:@"本桌已结束"];
        return;
    }
    
    self.gameStatisticsModel.pokerCount++;
    self.testIndex++;
    [self oncePoker];
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
    self.zhuPanLuCollectionView.model = self.resultDataArray;
    self.bigRoadMapView.model = self.resultDataArray;
    
    
    
    float end = CACurrentMediaTime();
    NSString *time = [NSString stringWithFormat:@"%f", end - start];
    NSLog(time);
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


#pragma mark -  开始
- (void)opening {
    [self initData];
    // 发牌局数   52最齐的张数
    for (NSInteger i = 1; i <= (self.pokerNumTextField.text.integerValue * 52 / 4); i++) {
        if (self.gameStatisticsModel.pokerTotalNum < 6) {
            break;
        }
        self.gameStatisticsModel.pokerCount++;
        
        [self oncePoker];
        //        [self daluCalculationMethod];
    }
}






#pragma mark -  Baccarat庄闲算法
- (void)oncePoker {
    
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
        self.gameStatisticsModel.pokerTotalNum--;
        
        
        //                if (self.testIndex > 22) {   // 测试使用  增加长庄长闲
        //                    numStr = @"7";
        //                }
        //
        //                 numStr = @"7";
        //
        //                if (i == 5) {
        //
        //                    if (self.testIndex < 5) {
        //                        numStr = @"10";
        //                    } else if (self.testIndex > 10) {
        //
        //                        if (self.testIndex > 18) {
        //                            if (self.testIndex > 27) {
        //                                if (self.testIndex > 36) {
        //                                    if (self.testIndex > 45) {
        //                                        if (self.testIndex > 54) {
        //                                            numStr = @"1";
        //                                        } else {
        //                                            numStr = @"8";
        //                                        }
        //                                    } else {
        //                                        numStr = @"1";
        //                                    }
        //                                } else {
        //                                    numStr = @"8";
        //                                }
        //                            } else {
        //                                numStr = @"1";
        //                            }
        //                        } else {
        //                            numStr = @"8";
        //                        }
        //
        //                    } else {
        //                        numStr = @"1";
        //                    }
        //                }
        //
        //        cardModel.bCardValue = [numStr integerValue];
        
        
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
    } else if (bResultModel.winType == WinType_Banker) {
        if (bResultModel.isSuperSix) {
            win = @"🔴🔸";
        } else {
            win = @"🔴";
        }
    } else {
        win = @"🅿️";
    }
    
    bResultModel.pokerCount = self.gameStatisticsModel.pokerCount;
    
    [self.resultDataArray addObject:bResultModel];
    
}


- (void)setupNavUI {
    
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





#pragma mark -  浮动返回按钮
- (void)setFloatingBackBtnView {
    CGFloat widthDr = 45;
    self.backDragView = [[WMDragView alloc] initWithFrame:CGRectMake(0, 0, widthDr, widthDr)];
    [self.backDragView.button setBackgroundImage:[UIImage imageNamed:@"game_back_btn"] forState:UIControlStateNormal];
    self.backDragView.button.backgroundColor = [UIColor clearColor];
    self.backDragView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.backDragView];
    
    CGFloat widthX = self.view.bounds.size.width >= 812.0 ? 44 : 0;
    CGRect rectDr = CGRectMake(widthX, 30, widthDr, widthDr);
    self.backDragView.frame = rectDr;
    
    //    self.backDragView.layer.cornerRadius = width/2;
    //    self.backDragView.layer.masksToBounds = YES;
    //    self.backDragView.layer.borderWidth = 1;
    //    self.backDragView.layer.borderColor = [UIColor colorWithRed:255.0/255 green:255.0/255 blue:255.0/255 alpha:0.5].CGColor;
    
    __weak typeof(self) weakSelf = self;
    self.backDragView.clickDragViewBlock = ^(WMDragView *dragView){
        
        [weakSelf.navigationController popViewControllerAnimated:true];
        //        [weakSelf.navigationController popViewControllerAnimated:true];
    };
    
    self.backDragView.beginDragBlock = ^(WMDragView *dragView) {
        DLog(@"开始拖曳");
    };
    
    self.backDragView.endDragBlock = ^(WMDragView *dragView) {
        DLog(@"结束拖曳");
    };
    
    self.backDragView.duringDragBlock = ^(WMDragView *dragView) {
        DLog(@"拖曳中...");
    };
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

@end


