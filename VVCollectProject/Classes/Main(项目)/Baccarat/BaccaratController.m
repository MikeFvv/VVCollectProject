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
#import "BStatisticsAlertView.h"
#import "UIDevice+ASMandatoryLandscapeDevice.h"
#import "AppDelegate.h"
#import "JMDropMenu.h"
#import "BGameRecordAlertView.h"
#import "MFHTimeManager.h"
#import "WHGradientHelper.h"
#import "SqliteManage.h"
#import "WHC_ModelSqlite.h"
#import "BTopupRecordAlertView.h"
#import "BalanceRecordModel.h"
#import "BTopupAlertView.h"
#import "BalanceRecordModel.h"


#define kBtnHeight 35
#define kBtnFontSize 16
#define kMarginHeight 10
// 边距
#define kMarginWidth 15

#define kLabelFontSize 12

#define kColorAlpha 0.9




@interface BaccaratController ()<BBigRoadMapViewDelegate,ChipsViewDelegate,BShowPokerViewDelegate,BaccaratBetViewDelegate,JMDropMenuDelegate,BTopupAlertViewDelegate>

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
/// 统计视图
@property(nonatomic,strong) BStatisticsAlertView *statisticsView;

/// 充值视图
@property(nonatomic,strong) BTopupAlertView *topupAlertView;
/// 游戏记录
@property(nonatomic,strong) BGameRecordAlertView *gameRecordAlertView;
/// 充值记录
@property(nonatomic,strong) BTopupRecordAlertView *topupRecordAlertView;

/// 结果数据
@property (nonatomic, strong) NSMutableArray<BaccaratResultModel *> *zhuPanLuResultDataArray;
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
@property(nonatomic,strong) NSArray *titleArr;

@property(nonatomic,strong) BGameStatisticsModel *gameStatisticsModel;
@property(nonatomic,strong) BUserData *bUserData;

/// 连胜记录
@property (nonatomic, assign) NSInteger continuousWinNum;
/// 连输记录
@property (nonatomic, assign) NSInteger continuousLoseNum;



@end

@implementation BaccaratController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.testIndex = 0;
    self.isAutoRunAll = NO;
    
    [self initData];
    [self createUI];
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
    //    [FunctionManager interfaceOrientation:UIInterfaceOrientationPortrait];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}


#pragma mark -  数据初始化
- (void)initData {
    self.titleArr = @[@"返回",@"游戏记录",@"余额记录",@"设置",@"更换赌桌",@"充值"];
    
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
    
    
    NSString *queryWhere = [NSString stringWithFormat:@"userId='%@' and to_days(update_time) = to_days(now())",kUserIdStr];
    NSArray *userArray = [WHC_ModelSqlite query:[BUserData class] where:queryWhere];
    
    
    // 初始化数据
    BUserData *bUserData = [[BUserData alloc] init];
    _bUserData = bUserData;
    
    NSInteger tMoney = 30000;
    bUserData.userTotalMoney = tMoney;
    
    bUserData.today_InitMoney = tMoney;
    bUserData.beforeBetTotalMoney = tMoney;
    bUserData.today_maxTotalMoney = tMoney;
    bUserData.today_MinTotalMoney = tMoney;
    
    
    BBetModel *betModel = [[BBetModel alloc] init];
    _betModel = betModel;
    
    
    BGameStatisticsModel *gameStatisticsModel = [[BGameStatisticsModel alloc] init];
    gameStatisticsModel.pokerTotalNum = self.dataArray.count;
    _gameStatisticsModel = gameStatisticsModel;
    
    self.zhuPanLuResultDataArray = [NSMutableArray array];
    
}

- (NSMutableArray*)dataArray
{
    if (!_dataArray) {
        NSInteger num = self.pokerNumTextField.text.integerValue ? self.pokerNumTextField.text.integerValue : 8;
        _dataArray = [NSMutableArray arrayWithArray:[VVFunctionManager shuffleArray:self.baccaratDataModel.sortedDeckArray pokerPairsNum:num]];
    }
    return _dataArray;
}

- (CardDataSourceModel* )baccaratDataModel {
    if (!_baccaratDataModel) {
        _baccaratDataModel = [[CardDataSourceModel alloc] init];
    }
    return _baccaratDataModel;
}

- (BStatisticsAlertView* )statisticsView {
    if (!_statisticsView) {
        UIView  *winView =(UIView*)[UIApplication sharedApplication].delegate.window;
        _statisticsView = [[BStatisticsAlertView alloc] initWithFrame:winView.frame];
    }
    return _statisticsView;
}
- (BTopupAlertView* )topupAlertView {
    if (!_topupAlertView) {
        UIView  *winView =(UIView*)[UIApplication sharedApplication].delegate.window;
        _topupAlertView = [[BTopupAlertView alloc] initWithFrame:winView.frame];
        _topupAlertView.delegate = self;
    }
    return _topupAlertView;
}
- (BGameRecordAlertView* )gameRecordAlertView {
    if (!_gameRecordAlertView) {
        UIView  *winView =(UIView*)[UIApplication sharedApplication].delegate.window;
        _gameRecordAlertView = [[BGameRecordAlertView alloc] initWithFrame:winView.frame];
    }
    return _gameRecordAlertView;
}
- (BTopupRecordAlertView* )topupRecordAlertView {
    if (!_topupRecordAlertView) {
        UIView  *winView =(UIView*)[UIApplication sharedApplication].delegate.window;
        _topupRecordAlertView = [[BTopupRecordAlertView alloc] initWithFrame:winView.frame];
    }
    return _topupRecordAlertView;
}


#pragma mark - ChipsViewDelegate 筹码选中 | 确定下注 | 重复下注
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
        [self betCommonMethod];
    } else if (sender.tag == 5002) {  // 全押
        self.chipsView.isAllInBetBtn = NO;
        // 全部钱 减去 不能下注额度整除的，额度
        NSInteger lastBetMoney = self.bUserData.userTotalMoney - self.bUserData.userTotalMoney % kMinBetChipsNum;
        /// 判断上次下注庄、闲
        if (self.gameStatisticsModel.lastBetModel.player_money > self.gameStatisticsModel.lastBetModel.banker_money) {
            self.betModel.player_money = lastBetMoney;
        } else {
            self.betModel.banker_money = lastBetMoney;
        }
        [self betCommonMethod];
    }
}

/// 取消注码
- (void)cancelBetChipsBtnClick:(UIButton *)sender {
    
    if (sender.tag == 6000) {
        [self.bBetView cancelBetChips];
        
        self.bUserData.userTotalMoney = self.bUserData.beforeBetTotalMoney;
        self.userChipssView.userMoneyLabel.text = [NSString stringWithFormat:@"%ld",self.bUserData.userTotalMoney];
        
        self.betModel = nil;
        self.betModel = [[BBetModel alloc] init];
        self.chipsView.currentBalance = self.bUserData.userTotalMoney;
        
        if (self.chipsView.isShowCancelBtn) {
            self.chipsView.isShowCancelBtn = NO;
        }
    } else {
        self.chipsView.hidden = YES;
        [self onStartOneButton];
    }
}

#pragma mark -  翻牌结束
/// 翻牌结束 结束一局
- (void)endFlop {
    self.chipsView.hidden = NO;
    // 取消下注筹码
    [self.bBetView cancelBetChips];
    
    [self calculationResults];
    
    self.betModel = nil;
    self.betModel = [[BBetModel alloc] init];
    
    self.zhuPanLuCollectionView.model = self.zhuPanLuResultDataArray;
    self.bigRoadMapView.model = self.zhuPanLuResultDataArray;
}

#pragma mark BaccaratBetViewDelegate 选中 下注
/// 每次下注回调
- (void)everyBetClick:(UIButton *)sender {
    
    // 正在翻盘中，禁止下注
    if (self.chipsView.hidden) {
        return;
    }
    
    // 用户筹码小于选定筹码，禁止下注
    if (self.bUserData.userTotalMoney < self.selectedModel.money) {
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
        
        // 如果已经下了庄 禁止下注闲
        if (self.betModel.banker_money > 0) {
            return;
        }
        
        if (self.betModel.player_money + self.selectedModel.money <= kMaxBetChipsNum && self.betModel.player_money + self.selectedModel.money >= kMinBetChipsNum) {
            
            self.betModel.player_money = self.betModel.player_money + self.selectedModel.money;
        }
    } else if (sender.tag == 3006) { // 庄
        // 如果已经下了闲 禁止下注庄
        if (self.betModel.player_money > 0) {
            return;
        }
        
        if (self.betModel.banker_money + self.selectedModel.money <= kMaxBetChipsNum && self.betModel.banker_money + self.selectedModel.money >= kMinBetChipsNum) {
            self.betModel.banker_money = self.betModel.banker_money + self.selectedModel.money;
        }
    }
    
    [self betCommonMethod];
}

- (void)betCommonMethod {
    self.bBetView.betModel = self.betModel;
    self.bUserData.userTotalMoney = self.bUserData.beforeBetTotalMoney - self.betModel.total_bet_money;
    self.userChipssView.userMoneyLabel.text = [NSString stringWithFormat:@"%ld",self.bUserData.userTotalMoney];
    
    self.chipsView.currentBalance = self.bUserData.userTotalMoney;
    
    // 隐藏 重复下注 按钮
    if (self.chipsView.isRepeatBetBtn) {
        self.chipsView.isRepeatBetBtn = NO;
    }
    // 隐藏 全押 按钮
    if (self.chipsView.isAllInBetBtn) {
        self.chipsView.isAllInBetBtn = NO;
    }
    // 显示取消注码按钮
    if (self.betModel.total_bet_money > 0) {
        self.chipsView.isShowCancelBtn = YES;
    }
    
}




#pragma mark -  计算结果
///这是当前桌子数据记录
- (void)calculationResults {
    
    BaccaratResultModel *resultModel = self.zhuPanLuResultDataArray.lastObject;
    
    self.gameStatisticsModel.pokerCount =self.gameStatisticsModel.pokerCount + (resultModel.playerArray.count + resultModel.bankerArray.count);
    self.gameStatisticsModel.gameNum = self.gameStatisticsModel.gameNum +1;
    
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
    // 赋值总记录
    self.analyzeRoadMapView.gameStatisticsModel = self.gameStatisticsModel;
    
    
    // 没下注不记录
    if (self.betModel.total_bet_money > 0) {
        [self calculateWinAndLoseChips:resultModel];
    }
    
    // 筹码视图按钮状态
    [self setBetViewButtonStatus];
}

/// 计算输赢筹码 | 用户相关数据记录
/// @param resultModel 模型
- (void)calculateWinAndLoseChips:(BaccaratResultModel *)resultModel {
    // 上次下注记录
    self.gameStatisticsModel.lastBetModel = [self.betModel modelCopy];
    
    NSInteger tempWinMoney = 0;
    BOOL isWin = NO;
    if (resultModel.winType == WinType_Player) {
        tempWinMoney = self.betModel.player_money *2;
        isWin = tempWinMoney > 0 ? YES : NO;
        self.bUserData.today_playerTotalNum = self.bUserData.today_playerTotalNum +1;
    } else if (resultModel.winType == WinType_Banker) {
        if (resultModel.isSuperSix) {
            tempWinMoney = self.betModel.banker_money *1.5;
        } else {
            tempWinMoney = self.betModel.banker_money *2;
        }
        isWin = tempWinMoney > 0 ? YES : NO;
        self.bUserData.today_bankerTotalNum = self.bUserData.today_bankerTotalNum +1;
    } else {
        tempWinMoney = self.betModel.player_money + self.betModel.banker_money;
        tempWinMoney = tempWinMoney + self.betModel.tie_money *9;
        self.bUserData.today_tieTotalNum = self.bUserData.today_tieTotalNum +1;
    }
    
    
    if (resultModel.isPlayerPair) {
        tempWinMoney = tempWinMoney + self.betModel.playerPair_money *12;
    } else {
        
    }
    
    if (resultModel.isBankerPair) {
        tempWinMoney = tempWinMoney + self.betModel.bankerPair_money *12;
    } else {
        
    }
    
    if (resultModel.isSuperSix) {
        tempWinMoney = tempWinMoney + self.betModel.superSix_money *13;
    } else {
        
    }
    
    self.betModel.total_winLose_money = tempWinMoney;
    
    // 总金额 当前用户金额+本次总输赢金额
    self.bUserData.userTotalMoney = self.bUserData.userTotalMoney + self.betModel.total_winLose_money;
    self.bUserData.beforeBetTotalMoney = self.bUserData.userTotalMoney;
    self.userChipssView.userMoneyLabel.text = [NSString stringWithFormat:@"%ld",self.bUserData.userTotalMoney];
    
    
    
    // ********* 统计🔢🔢🔠🟥🟥🟥🟥🟥 *********
    // 游戏总局数
    self.bUserData.today_gameTotalNum = self.bUserData.today_gameTotalNum + 1;
    
    // 获胜总局数  连输 连赢
    if (isWin) {
        self.bUserData.today_winTotalNum = self.bUserData.today_winTotalNum + 1;
        
        self.continuousWinNum = self.continuousWinNum + 1;
        self.continuousLoseNum = 0;
    } else if (resultModel.winType == WinType_TIE) {
        // 和 这里不计算
    } else {
        // 这里需要判断是否下注了
        if (self.betModel.player_money > 0 || self.betModel.banker_money) {
            self.continuousWinNum = 0;
            self.continuousLoseNum = self.continuousLoseNum + 1;
        }
    }
    
    // 最高连胜记录
    if (self.bUserData.today_continuoustoday_winTotalNum < self.continuousWinNum) {
        self.bUserData.today_continuoustoday_winTotalNum = self.continuousWinNum;
    }
    // 最高连输记录
    if (self.bUserData.today_continuousLoseTotalNum < self.continuousLoseNum) {
        self.bUserData.today_continuousLoseTotalNum = self.continuousLoseNum;
    }
    
    // 获胜概率 需要减去和
    self.bUserData.today_winTotalProbability = (self.bUserData.today_winTotalNum *0.01) / ((self.bUserData.today_gameTotalNum -self.bUserData.today_tieTotalNum) *0.01) * 100;
    
    
    // 最高余额记录
    if (self.bUserData.userTotalMoney > self.bUserData.today_maxTotalMoney) {
        self.bUserData.today_maxTotalMoney = self.bUserData.userTotalMoney;
    }
    // 最低余额记录
    if (self.bUserData.userTotalMoney < self.bUserData.today_MinTotalMoney) {
        self.bUserData.today_MinTotalMoney = self.bUserData.userTotalMoney;
    }
    
    // 最高获胜记录
    if (self.bUserData.today_maxWinTotalMoney < self.betModel.winLose_money) {
        self.bUserData.today_maxWinTotalMoney =  self.betModel.winLose_money;
    }
    // 最高失败记录
    if (self.bUserData.today_maxLoseTotalMoney > self.betModel.winLose_money) {
        self.bUserData.today_maxLoseTotalMoney = self.betModel.winLose_money;
    }
    
    // 今日盈利
    self.bUserData.today_ProfitMoney = self.bUserData.userTotalMoney - self.bUserData.today_InitMoney;
    
    
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        BOOL isSuccess = [WHCSqlite insert:self.bUserData];
        if (isSuccess) {
            NSLog(@"成功");
        }
        NSLog(@"1111");
    });
}

- (void)setBetViewButtonStatus {
    // ********* ✏️✏️✏️✏️✏️✏️✏️✏️✏️✏️ *********
    // 给下注视图 赋值用户当前余额
    self.chipsView.currentBalance = self.bUserData.userTotalMoney;
    // 显示越过本局
    if (self.chipsView.isShowCancelBtn) {
        self.chipsView.isShowCancelBtn = NO;
    }
    /// 当前总金额大于上次 下注金额  显示 重复下注 按钮
    if (self.bUserData.userTotalMoney > 0 && self.bUserData.userTotalMoney >= self.betModel.total_bet_money) {
        self.chipsView.isRepeatBetBtn = YES;
    } else if (self.bUserData.userTotalMoney > 0) {
        self.chipsView.isAllInBetBtn = YES;
    }
    
    // 是否显示 确定下注 按钮和重复按钮
    if (self.bUserData.userTotalMoney > 0) {
        self.chipsView.isShowSureButton = NO;
    } else {
        self.chipsView.isShowSureButton = YES;
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

#pragma mark -  下注记录统计 弹窗
/// 用户筹码下注记录
- (void)onBUserChipssViewShowAction {
    
    self.statisticsView.bUserData = self.bUserData;
    [self.statisticsView showAlertAnimation];
}


#pragma mark -  BTopupAlertViewDelegate 充值
/// 充值
- (void)didTopup:(BalanceRecordModel *)model {
    NSLog(@"11111");
    
    model.create_time = [MFHTimeManager getNowTimeWithDateFormat:@"YYYY年MM月dd日 HH:mm:ss"];
    model.update_time = [MFHTimeManager getNowTimeWithDateFormat:@"YYYY年MM月dd日 HH:mm:ss"];
    BOOL isSuccess = [WHCSqlite insert:model];
    if (isSuccess) {
        NSString *titleMsg = [NSString stringWithFormat:@"%@ 成功",model.title];
        [MBProgressHUD showTipMessageInWindow:titleMsg];
    }
    NSLog(@"11111");
    
}

#pragma mark -  清除
- (void)onClearButton {
    
    [self initData];
    self.zhuPanLuCollectionView.model = self.zhuPanLuResultDataArray;
    self.bigRoadMapView.model = self.zhuPanLuResultDataArray;
    
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
    self.zhuPanLuCollectionView.model = self.zhuPanLuResultDataArray;
    self.bigRoadMapView.model = self.zhuPanLuResultDataArray;
    
    
    
    float end = CACurrentMediaTime();
    NSString *time = [NSString stringWithFormat:@"%f", end - start];
    NSLog(time);
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
    
    bResultModel.pokerCount = self.gameStatisticsModel.pokerCount;
    
    [self.zhuPanLuResultDataArray addObject:bResultModel];
    
    
    bResultModel.userId = kUserIdStr;
    bResultModel.create_time = [MFHTimeManager getNowTimeWithDateFormat:@"YYYY年MM月dd日 HH:mm:ss"];
    bResultModel.update_time = [MFHTimeManager getNowTimeWithDateFormat:@"YYYY年MM月dd日 HH:mm:ss"];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        BOOL isSuccess = [WHCSqlite insert:bResultModel];
        if (isSuccess) {
            NSLog(@"成功");
        }
    });
    NSLog(@"11111");
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



#pragma mark -  跳转界面
- (void)configAction {
    BaccaratConfigController *vc = [[BaccaratConfigController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)rightBtnAction {
    PointListController *vc = [[PointListController alloc] init];
    vc.zhuPanLuResultDataArray = self.zhuPanLuResultDataArray;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)onMoreBtnMethod {
    [JMDropMenu showDropMenuFrame:CGRectMake(kBUNotchSpacing + 5, 36, 120, kBMoreColHeight*6+10) ArrowOffset:16.f TitleArr:self.titleArr ImageArr:@[@"icon_appstore",@"icon_appstore",@"icon_appstore",@"icon_appstore",@"icon_appstore",@"icon_appstore"] Type:JMDropMenuTypeWeChat LayoutType:JMDropMenuLayoutTypeNormal RowHeight:kBMoreColHeight Delegate:self];
}

#pragma mark -  下拉列表
- (void)didSelectRowAtIndex:(NSInteger)index Title:(NSString *)title Image:(NSString *)image {
    NSLog(@"index----%zd,  title---%@, image---%@", index, title, image);
    
    if ([title isEqualToString:@"返回"]) {
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        // 关闭横屏仅允许竖屏
        appDelegate.allowRotation = NO;
        // 切换到竖屏
        [UIDevice deviceMandatoryLandscapeWithNewOrientation:UIInterfaceOrientationPortrait];
        
        [self.navigationController popViewControllerAnimated:true];
    } else if ([title isEqualToString:@"游戏记录"]) {
        
        NSString *queryWhere = [NSString stringWithFormat:@"userId='%@'",kUserIdStr];
        NSArray *dataArray = [WHC_ModelSqlite query:[BaccaratResultModel class] where:queryWhere];
        
        self.gameRecordAlertView.zhuPanLuResultDataArray = dataArray;
        [self.gameRecordAlertView showAlertAnimation];
        
    } else if ([title isEqualToString:@"余额记录"]) {
        
        NSString *queryWhere = [NSString stringWithFormat:@"userId='%@'",kUserIdStr];
        NSArray *balanceArray = [WHC_ModelSqlite query:[BalanceRecordModel class] where:queryWhere];
        
        self.topupRecordAlertView.dataArray = balanceArray;
        [self.topupRecordAlertView showAlertAnimation];
        
    } else if ([title isEqualToString:@"设置"]) {
        BaccaratConfigController *vc = [[BaccaratConfigController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([title isEqualToString:@"充值"]) {
        //        self.statisticsView.bUserData = self.bUserData;
        [self.topupAlertView showAlertAnimation];
    }
    
    
    
}

#pragma mark -  创建UI
- (void)createUI {
    self.view.backgroundColor = [UIColor blackColor];
    
    CGFloat kBHalfWidth = self.view.frame.size.width/2;
    
    UIView *contentView = [[UIView alloc]init];
    contentView.backgroundColor = [UIColor colorWithHex:@"6A0222"];
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
    [self createRightRoadMapView];
    
    
    UIButton *moreBtn = [[UIButton alloc] init];
    [moreBtn setBackgroundImage:[UIImage imageNamed:@"com_more_white"] forState:UIControlStateNormal];
    [moreBtn addTarget:self action:@selector(onMoreBtnMethod) forControlEvents:UIControlEventTouchUpInside];
    //    moreBtn.backgroundColor = [UIColor greenColor];
    [self.view addSubview:moreBtn];
    
    [moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(10);
        make.left.equalTo(self.view.mas_left).offset(kBUNotchSpacing+5);
        make.size.mas_equalTo(CGSizeMake(25, 20));
    }];
}

- (void)createLeftView {
    
    CGFloat kBHalfWidth = self.view.frame.size.width/2;
    CGFloat leftVWidht = kBHalfWidth + kBAddWidth -2;
    
    UIView *leftBgView = [[UIView alloc] init];
    leftBgView.backgroundColor = [UIColor colorWithHex:@"046726"];
    [self.contentView addSubview:leftBgView];
    
    [leftBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(0);
        make.left.equalTo(self.contentView.mas_left).offset(0);
        make.width.mas_equalTo(leftVWidht);
        make.height.mas_equalTo(mxwScreenHeight());
    }];
    
    // 展示牌型视图
    BShowPokerView *showPokerView = [[BShowPokerView alloc] initWithFrame:CGRectMake(70, 10, 360, 150)];
    showPokerView.delegate = self;
    [leftBgView addSubview:showPokerView];
    _showPokerView = showPokerView;
    
    
    // 下注庄闲视图
    BaccaratBetView *betView = [[BaccaratBetView alloc] initWithFrame:CGRectMake(120, 150, kBHalfWidth-60-20*2, kBBetViewBtnHeight*2+20)];
    betView.delegate = self;
    [leftBgView addSubview:betView];
    _bBetView = betView;
    
    // 用户筹码量视图
    BUserChipssView *userChipssView = [[BUserChipssView alloc] initWithFrame:CGRectMake(50, 180, 60, 90)];
    [leftBgView addSubview:userChipssView];
    
    //添加手势事件
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onBUserChipssViewShowAction)];
    //将手势添加到需要相应的view中去
    [userChipssView addGestureRecognizer:tapGesture];
    //选择触发事件的方式（默认单机触发）
    [tapGesture setNumberOfTapsRequired:1];
    
    _userChipssView = userChipssView;
    
    self.userChipssView.userMoneyLabel.text = [NSString stringWithFormat:@"%ld",self.bUserData.userTotalMoney];
    
    
    //筹码视图
    ChipsView *chipsView = [[ChipsView alloc] initWithFrame:CGRectMake(kBUNotchSpacing+100, mxwScreenHeight()-50-10, mxwScreenWidth()-kBUNotchSpacing*2-100*2-60, 50)];
    
    [self.view addSubview:chipsView];
    _chipsView = chipsView;
    chipsView.currentBalance = self.bUserData.userTotalMoney;
    chipsView.delegate = self;
    
    
}

/// 路子图
- (void)createRightRoadMapView {
    
    CGFloat kBHalfWidth = self.view.frame.size.width/2;
    
    // ********* 右边 *********
    // 最小下注 最大下注
    CGFloat betMaxMinViewHeight = 30;
    BBBetMaxMinView *betMaxMinView = [[BBBetMaxMinView alloc] initWithFrame:CGRectMake(kBHalfWidth+kBAddWidth, 1*1, kBHalfWidth - kBAddWidth-10, betMaxMinViewHeight)];
    betMaxMinView.layer.borderWidth = 1;
    betMaxMinView.layer.borderColor = [UIColor colorWithRed:0.643 green:0.000 blue:0.357 alpha:1.000].CGColor;
    [self.contentView addSubview:betMaxMinView];
    
    
    // 大路
    CGFloat daluHeight = (kBDLItemSizeWidth+1)*6+1;
    BBigRoadMapView *bigRoadMapView = [[BBigRoadMapView alloc] initWithFrame:CGRectMake(kBHalfWidth+kBAddWidth, betMaxMinViewHeight+1*1, kBHalfWidth - kBAddWidth-10, daluHeight)];
    bigRoadMapView.layer.borderWidth = 1;
    bigRoadMapView.layer.borderColor = [UIColor colorWithRed:0.643 green:0.000 blue:0.357 alpha:1.000].CGColor;
    bigRoadMapView.delegate = self;
    [self.contentView addSubview:bigRoadMapView];
    _bigRoadMapView = bigRoadMapView;
    
    // *** 下三路 ***
    CGFloat xiasanluHeight = (kBItemSizeWidth+1)*6+1;
    BaccaratXiaSanLuView *dylXiaSanLuView = [[BaccaratXiaSanLuView alloc] initWithFrame:CGRectMake(kBHalfWidth+kBAddWidth, betMaxMinViewHeight+daluHeight+1*2, kBHalfWidth - kBAddWidth-10, xiasanluHeight)];
    dylXiaSanLuView.roadMapType = RoadMapType_DYL;
    dylXiaSanLuView.layer.borderWidth = 1;
    dylXiaSanLuView.layer.borderColor = [UIColor colorWithRed:0.643 green:0.000 blue:0.357 alpha:1.000].CGColor;
    [self.contentView addSubview:dylXiaSanLuView];
    _dylXiaSanLuView = dylXiaSanLuView;
    
    
    BaccaratXiaSanLuView *xlXiaSanLuView = [[BaccaratXiaSanLuView alloc] initWithFrame:CGRectMake(kBHalfWidth+kBAddWidth, betMaxMinViewHeight+daluHeight+xiasanluHeight*1+1*3, kBHalfWidth - kBAddWidth-10, xiasanluHeight)];
    xlXiaSanLuView.roadMapType = RoadMapType_XL;
    xlXiaSanLuView.layer.borderWidth = 1;
    xlXiaSanLuView.layer.borderColor = [UIColor colorWithRed:0.643 green:0.000 blue:0.357 alpha:1.000].CGColor;
    [self.contentView addSubview:xlXiaSanLuView];
    _xlXiaSanLuView = xlXiaSanLuView;
    
    BaccaratXiaSanLuView *xqlXiaSanLuView = [[BaccaratXiaSanLuView alloc] initWithFrame:CGRectMake(kBHalfWidth+kBAddWidth, betMaxMinViewHeight+daluHeight+xiasanluHeight*2+1*4, kBHalfWidth - kBAddWidth-10, xiasanluHeight)];
    xqlXiaSanLuView.roadMapType = RoadMapType_XQL;
    xqlXiaSanLuView.layer.borderWidth = 1;
    xqlXiaSanLuView.layer.borderColor = [UIColor colorWithRed:0.643 green:0.000 blue:0.357 alpha:1.000].CGColor;
    [self.contentView addSubview:xqlXiaSanLuView];
    _xqlXiaSanLuView = xqlXiaSanLuView;
    
    
    CGFloat analyzeRoadMapView_Width = 135;
    CGFloat zhuPanLu_Width = kBHalfWidth - kBAddWidth-10-analyzeRoadMapView_Width;
    // 珠盘路(庄闲路)
    BZhuPanLuCollectionView *zhuPanLuCollectionView = [[BZhuPanLuCollectionView alloc] initWithFrame:CGRectMake(kBHalfWidth+kBAddWidth, betMaxMinViewHeight+daluHeight+xiasanluHeight*3+1*5, zhuPanLu_Width, kBTrendViewHeight)];
    zhuPanLuCollectionView.roadType = 0;
    //    zhuPanLuCollectionView.backgroundColor = [UIColor redColor];
    zhuPanLuCollectionView.layer.borderWidth = 1;
    zhuPanLuCollectionView.layer.borderColor = [UIColor colorWithRed:0.643 green:0.000 blue:0.357 alpha:1.000].CGColor;
    [self.contentView addSubview:zhuPanLuCollectionView];
    _zhuPanLuCollectionView = zhuPanLuCollectionView;
    
    // 分析问路图
    BAnalyzeRoadMapView *analyzeRoadMapView = [[BAnalyzeRoadMapView alloc] initWithFrame:CGRectMake(kBHalfWidth + kBAddWidth + zhuPanLu_Width, betMaxMinViewHeight+daluHeight+xiasanluHeight*3+1*5, analyzeRoadMapView_Width, kBTrendViewHeight)];
    [self.contentView addSubview:analyzeRoadMapView];
    _analyzeRoadMapView = analyzeRoadMapView;
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


//#pragma mark -  浮动返回按钮
//- (void)setFloatingBackBtnView {
//    CGFloat widthDr = 45;
//    self.backDragView = [[WMDragView alloc] initWithFrame:CGRectMake(0, 0, widthDr, widthDr)];
//    [self.backDragView.button setBackgroundImage:[UIImage imageNamed:@"game_back_btn"] forState:UIControlStateNormal];
//    self.backDragView.button.backgroundColor = [UIColor clearColor];
//    self.backDragView.backgroundColor = [UIColor clearColor];
//    [self.view addSubview:self.backDragView];
//
//    CGFloat widthX = self.view.bounds.size.width >= 812.0 ? 44 : 0;
//    CGRect rectDr = CGRectMake(widthX, 30, widthDr, widthDr);
//    self.backDragView.frame = rectDr;
//
//    //    self.backDragView.layer.cornerRadius = width/2;
//    //    self.backDragView.layer.masksToBounds = YES;
//    //    self.backDragView.layer.borderWidth = 1;
//    //    self.backDragView.layer.borderColor = [UIColor colorWithRed:255.0/255 green:255.0/255 blue:255.0/255 alpha:0.5].CGColor;
//
//    __weak typeof(self) weakSelf = self;
//    self.backDragView.clickDragViewBlock = ^(WMDragView *dragView){
//
//        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//        // 关闭横屏仅允许竖屏
//        appDelegate.allowRotation = NO;
//        // 切换到竖屏
//        [UIDevice deviceMandatoryLandscapeWithNewOrientation:UIInterfaceOrientationPortrait];
//
//        [weakSelf.navigationController popViewControllerAnimated:true];
//        //        [weakSelf.navigationController popViewControllerAnimated:true];
//    };
//
//    self.backDragView.beginDragBlock = ^(WMDragView *dragView) {
//        DLog(@"开始拖曳");
//    };
//
//    self.backDragView.endDragBlock = ^(WMDragView *dragView) {
//        DLog(@"结束拖曳");
//    };
//
//    self.backDragView.duringDragBlock = ^(WMDragView *dragView) {
//        DLog(@"拖曳中...");
//    };
//}

@end


