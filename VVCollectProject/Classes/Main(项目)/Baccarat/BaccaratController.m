//
//  BaccaratController.m
//  VVCollectProject
//
//  Created by blom on 2019/2/20.
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
#import "DZMTimer.h"
#import "BAutoRunView.h"
#import "BAutoRunModel.h"
#import "BManualManageRoadView.h"
#import "BaccaratComputer.h"


#define kBtnHeight 35
#define kBtnFontSize 16
#define kMarginHeight 10
// 边距
#define kMarginWidth 15

#define kLabelFontSize 12

#define kColorAlpha 0.9




@interface BaccaratController ()<BBigRoadMapViewDelegate,ChipsViewDelegate,BShowPokerViewDelegate,BaccaratBetViewDelegate,JMDropMenuDelegate,BTopupAlertViewDelegate,BAutoRunViewDelegate,BManualManageRoadViewDelegate>

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
/// 自动运行View
@property(nonatomic,strong) BAutoRunView *autoRunView;
/// 手动管理路子View
@property(nonatomic,strong) BManualManageRoadView *manualManageRoadView;
/// 0 Tie   1 banker   2 player   路单选择路类型
@property (nonatomic, assign) WinType roadListSelectedWinType;
/// 路单选择路类型
@property (nonatomic, assign) PXSType roadListSelectedPXSType;

/// 结果数据
@property (nonatomic, strong) NSMutableArray<BaccaratResultModel *> *zhuPanLuResultDataArray;
@property (strong, nonatomic) CardDataSourceModel *baccaratDataModel;

@property (strong, nonatomic) BaccaratResultModel *bResultModel;

/// 选中的筹码
@property (nonatomic, strong) ChipsModel *selectedModel;
/// 下注金额
@property (nonatomic, strong) BBetModel *betModel;


/// 返回按钮
@property(nonatomic,strong) WMDragView *backDragView;

/// 是否自动运行全部
@property (nonatomic, assign) BOOL isAutoRunAll;
/// 桌子是否已结束
@property (nonatomic, assign) BOOL isTableEnd;
@property(nonatomic,strong) NSArray *titleArr;

@property(nonatomic,strong) BGameStatisticsModel *gameStatisticsModel;
@property(nonatomic,strong) BUserData *bUserData;

/// 连胜记录
@property (nonatomic, assign) NSInteger continuousWinNum;
/// 连输记录
@property (nonatomic, assign) NSInteger continuousLoseNum;
/// 游戏桌子ID 每天日期+001 自增
@property (nonatomic, copy) NSString *tableID;

/// 测试随机生成路单功能
@property (nonatomic, assign) NSInteger testIndex;

@end

@implementation BaccaratController


- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    
    self.isAutoRunAll = NO;
    self.titleArr = @[@"返回",@"充值",@"游戏记录",@"余额记录",@"设置",@"更换赌桌"];
    self.testIndex = 0;
    self.isTableEnd = NO;
    self.dataArray = nil;
    self.roadListSelectedWinType = WinType_None;
    self.roadListSelectedPXSType = PXSType_None;
    
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
    
    NSString *date = [MFHTimeManager getNowTimeWithDateFormat:@"YYYY年MM月dd日"];
    
    NSString *queryWhere = [NSString stringWithFormat:@"userId='%@' and update_time = '%@'",kUserId_String,date];
    NSArray *userDataArray = [WHC_ModelSqlite query:[BUserData class] where:queryWhere];
    
    BUserData *oldUserData = userDataArray.firstObject;
    
    // 初始化数据
    BUserData *bUserData = [[BUserData alloc] init];
    if (oldUserData) {
        bUserData = oldUserData;
    }
    _bUserData = bUserData;
    
    bUserData.autoIncrementID = bUserData.autoIncrementID +1;
    self.tableID = [NSString stringWithFormat:@"%@_%ld",date,bUserData.autoIncrementID];
    bUserData.tableID = self.tableID;
    
    BBetModel *betModel = [[BBetModel alloc] init];
    _betModel = betModel;
    
    
    BGameStatisticsModel *gameStatisticsModel = [[BGameStatisticsModel alloc] init];
    gameStatisticsModel.tableID = self.tableID;
    gameStatisticsModel.pokerTotalNum = self.dataArray.count;
    _gameStatisticsModel = gameStatisticsModel;
    
    
    self.zhuPanLuResultDataArray = [NSMutableArray array];
    
    NSLog(@"1");
}

/// 复位数据
- (void)resetData {
    
}


- (NSMutableArray*)dataArray
{
    if (!_dataArray) { // 8
        NSInteger num = self.pokerNumTextField.text.integerValue ? self.pokerNumTextField.text.integerValue : 16;
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
- (BAutoRunView* )autoRunView {
    if (!_autoRunView) {
        _autoRunView = [[BAutoRunView alloc] initWithFrame:CGRectMake(100, -50, 500, 50)];
        _autoRunView.delegate = self;
    }
    return _autoRunView;
}

- (BManualManageRoadView* )manualManageRoadView {
    if (!_manualManageRoadView) {
        _manualManageRoadView = [[BManualManageRoadView alloc] initWithFrame:CGRectMake(100, mxwScreenHeight(), 360, 100)];
        _manualManageRoadView.delegate = self;
    }
    return _manualManageRoadView;
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
    self.isAutoRunAll = NO;
    self.roadListSelectedWinType = WinType_None;
    self.roadListSelectedPXSType = PXSType_None;
    
    
    if (sender.tag == 5000) {  // 确定下注
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

/// 取消注码  越过本局
- (void)cancelBetChipsBtnClick:(UIButton *)sender {
    
    if (sender.tag == 6000) { // 取消注码
        [self.bBetView cancelBetChips];
        
        self.bUserData.userTotalMoney = self.bUserData.beforeBetTotalMoney;
        self.userChipssView.userMoneyLabel.text = [NSString stringWithFormat:@"%ld",self.bUserData.userTotalMoney];
        
        self.betModel = nil;
        self.betModel = [[BBetModel alloc] init];
        self.chipsView.currentBalance = self.bUserData.userTotalMoney;
        
        if (self.chipsView.isShowCancelBtn) {
            self.chipsView.isShowCancelBtn = NO;
        }
    } else {  // 越过本局
        self.isAutoRunAll = NO;
        self.chipsView.hidden = YES;
        self.roadListSelectedWinType = WinType_None;
        self.roadListSelectedPXSType = PXSType_None;
        
        [self onStartOneButton];
    }
}

#pragma mark -  翻牌结束
/// 翻牌结束 结束一局
- (void)showPokerEndFlop {
    self.chipsView.hidden = NO;
    // 取消下注筹码
    [self.bBetView cancelBetChips];
    
    [self calculationResults];
    
    self.betModel = nil;
    self.betModel = [[BBetModel alloc] init];
    
    self.zhuPanLuCollectionView.model = self.zhuPanLuResultDataArray;
    self.bigRoadMapView.zhuPanLuResultDataArray = self.zhuPanLuResultDataArray;
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
    } else {
        [self everyGameRecord];
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
    
    
    [self saveDataToSql];
    
}

#pragma mark -  保存数据Sql
- (void)saveDataToSql {
    // *** 更新用户下注数据 ***
    //    dispatch_async(dispatch_get_global_queue(0, 0), ^{
    //        BOOL isSuccess =  [WHC_ModelSqlite update:ypMessage where:whereStr];
    //        if (isSuccess) {
    //            NSLog(@"成功");
    //        }
    //        NSLog(@"1111");
    //    });
    
    [self everyGameRecord];
    
    [self updateUserData];
    
}

- (void)everyGameRecord {
    // *** 保存每盘游戏数据 ***
    self.bResultModel.userId = kUserId_String;
    self.bResultModel.tableID = self.tableID;
    self.bResultModel.create_time = [MFHTimeManager getNowTimeWithDateFormat:@"YYYY年MM月dd日 HH:mm:ss"];
    self.bResultModel.update_time = [MFHTimeManager getNowTimeWithDateFormat:@"YYYY年MM月dd日 HH:mm:ss"];
    
    self.bResultModel.betMoney = self.betModel.total_bet_money;
    self.bResultModel.winLose_money = self.betModel.winLose_money;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        BOOL isSuccess = [WHCSqlite insert:self.bResultModel];
        if (isSuccess) {
            NSLog(@"成功");
        }
    });
    NSLog(@"11111");
}

- (void)updateUserData {
    self.bUserData.userId = kUserId_String;
    self.bUserData.create_time = [MFHTimeManager getNowTimeWithDateFormat:@"YYYY年MM月dd日"];
    self.bUserData.update_time = [MFHTimeManager getNowTimeWithDateFormat:@"YYYY年MM月dd日"];
    
    NSString *date = [MFHTimeManager getNowTimeWithDateFormat:@"YYYY年MM月dd日"];
    NSString *whereStr = [NSString stringWithFormat:@"userId='%@' and update_time = '%@'",kUserId_String,date];
    
    // *** 保存用户下注数据 ***
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        // 当天的数据
        NSArray *userDataArray = [WHC_ModelSqlite query:[BUserData class] where:whereStr];
        if (userDataArray.count > 0) {
            BOOL isSuccess =  [WHC_ModelSqlite update:self.bUserData where:whereStr];
            if (isSuccess) {
                NSLog(@"成功");
            }
        } else {
            BOOL isSuccess = [WHCSqlite insert:self.bUserData];
            if (isSuccess) {
                NSLog(@"成功");
            }
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
    
    NSString *all_queryWhere = [NSString stringWithFormat:@"userId='%@' ORDER BY create_time DESC",kUserId_String];
    // 全部的数据
    NSArray *allUserDataArray = [WHC_ModelSqlite query:[BUserData class] where:all_queryWhere];
    
    
    BUserData *allUserData = [[BUserData alloc] init];
    for (BUserData *userData in allUserDataArray) {
        allUserData.userId = userData.userId;
        allUserData.tableID = userData.tableID;
        allUserData.create_time = userData.create_time;
        allUserData.update_time = userData.update_time;
        
        allUserData.userTotalMoney = allUserData.userTotalMoney + userData.userTotalMoney;
        allUserData.today_gameTotalNum = allUserData.today_gameTotalNum + userData.today_gameTotalNum;
        allUserData.today_playerTotalNum = allUserData.today_playerTotalNum + userData.today_playerTotalNum;
        allUserData.today_bankerTotalNum = allUserData.today_bankerTotalNum + userData.today_bankerTotalNum;
        allUserData.today_tieTotalNum = allUserData.today_tieTotalNum + userData.today_tieTotalNum;
        allUserData.today_winTotalNum = allUserData.today_winTotalNum + userData.today_winTotalNum;
        
        // 总盈利
        allUserData.today_ProfitMoney = allUserData.today_ProfitMoney + userData.today_ProfitMoney;
        
        
        // 最高连胜记录
        if (allUserData.today_continuoustoday_winTotalNum < userData.today_continuoustoday_winTotalNum) {
            allUserData.today_continuoustoday_winTotalNum = userData.today_continuoustoday_winTotalNum;
        }
        // 最高连输记录
        if (allUserData.today_continuousLoseTotalNum < userData.today_continuousLoseTotalNum) {
            allUserData.today_continuousLoseTotalNum = userData.today_continuousLoseTotalNum;
        }
        
        // 最高获胜记录
        if (allUserData.today_maxWinTotalMoney < userData.today_maxWinTotalMoney) {
            allUserData.today_maxWinTotalMoney = userData.today_maxWinTotalMoney;
        }
        // 最高失败记录
        if (allUserData.today_maxLoseTotalMoney > userData.today_maxLoseTotalMoney) {
            allUserData.today_maxLoseTotalMoney = userData.today_maxLoseTotalMoney;
        }
        
        
        // 最高余额记录
        if (allUserData.today_maxTotalMoney < userData.today_maxTotalMoney) {
            allUserData.today_maxTotalMoney = userData.today_maxTotalMoney;
        }
        // 最低余额记录
        if (allUserData.today_MinTotalMoney < userData.today_MinTotalMoney) {
            allUserData.today_MinTotalMoney = userData.today_MinTotalMoney;
        }
    }
    
    NSMutableArray *tempMArray = [NSMutableArray array];
    [tempMArray addObject:allUserData];
    // 全部数据
    [tempMArray addObjectsFromArray:allUserDataArray];
    
    self.statisticsView.dataArray = tempMArray;
    [self.statisticsView showAlertAnimation];
}


#pragma mark -  BTopupAlertViewDelegate 充值
/// 充值
- (void)didTopup:(BalanceRecordModel *)model {
    NSLog(@"11111");
    
    model.create_time = [MFHTimeManager getNowTimeWithDateFormat:@"YYYY年MM月dd日 HH:mm:ss"];
    model.update_time = [MFHTimeManager getNowTimeWithDateFormat:@"YYYY年MM月dd日 HH:mm:ss"];
    model.create_date = [MFHTimeManager getNowTimeWithDateFormat:@"YYYY年MM月dd日"];
    BOOL isSuccess = [WHCSqlite insert:model];
    if (isSuccess) {
        NSString *titleMsg = [NSString stringWithFormat:@"%@ 成功",model.title];
        [MBProgressHUD showTipMessageInWindow:titleMsg];
    }
    NSLog(@"11111");
    
    
    // 总金额 当前用户金额+本次总输赢金额
    self.bUserData.userTotalMoney = self.bUserData.userTotalMoney + model.money;
    self.bUserData.today_InitMoney = self.bUserData.today_InitMoney + model.money;
    self.bUserData.beforeBetTotalMoney = self.bUserData.userTotalMoney;
    
    if (self.bUserData.userTotalMoney > self.bUserData.today_maxTotalMoney) {
        self.bUserData.today_maxTotalMoney = self.bUserData.userTotalMoney;
    }
    self.bUserData.today_MinTotalMoney = self.bUserData.today_MinTotalMoney + model.money;
    
    
    self.userChipssView.userMoneyLabel.text = [NSString stringWithFormat:@"%ld",self.bUserData.userTotalMoney];
    
    
    [self updateUserData];
}

#pragma mark -  开始一局
- (void)onStartOneButton {
    [self.view endEditing:YES];
    
    [self.showPokerView removeStackView];
    
    if (self.gameStatisticsModel.pokerTotalNum < 36) {  // 停止发牌
        [MBProgressHUD showTipMessageInWindow:@"本桌已结束"];
        self.isTableEnd = YES;
        return;
    }
    
    
    self.gameStatisticsModel.pokerCount++;
    [self oncePoker];
    
    NSLog(@"11");
    
}

#pragma mark -  自动运行
- (void)onAutoStartRunsNum:(NSInteger)runsNum {
    self.isAutoRunAll = YES;
    // 记录当前时间
    float start = CACurrentMediaTime();
    
    for (NSInteger index = 0; index < runsNum; index++) {
        if (self.isTableEnd) {
            break;
        }
        [self onStartOneButton];
        [self showPokerEndFlop];
    }
    
    float end = CACurrentMediaTime();
    NSString *time = [NSString stringWithFormat:@"自动运行:%ld局 ====== 时间:%f 秒",runsNum, end - start];
    NSLog(time);
}


#pragma mark -  Baccarat庄闲算法
- (void)oncePoker {
    
    self.testIndex++;
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
    
    for (NSInteger index = 1; index <= 6; index++) {
        
        // 洗牌
        //        int pokerIndex = (arc4random() % self.pokerTotalNum) + 0;
        //        NSString *num = (NSString *)self.dataArray[pokerPoints];
        //        [self.dataArray removeObjectAtIndex:pokerPoints];
        //        NSLog(@"🔴= %@", num.stringValue);
        
        
        PokerCardModel *cardModel = [[PokerCardModel alloc] init];
        PokerCardModel *tempCardModel = (PokerCardModel *)self.dataArray.firstObject;
        cardModel = [tempCardModel modelCopy];
        [self.dataArray removeObjectAtIndex:0];
        self.gameStatisticsModel.pokerTotalNum--;
        
        // 路单功能
        if (self.isAutoRunAll && self.roadListSelectedWinType != WinType_None) {
            NSString *textNumStr = [BaccaratComputer roadListSendCardIndex:index winType:self.roadListSelectedWinType pxsType:self.roadListSelectedPXSType];
            cardModel.bCardValue = [textNumStr integerValue] % 10;
            cardModel.cardStr = textNumStr;
        }
        
        // 随机路单功能，只在测试时手动使用
//        if (self.isAutoRunAll) {
//            NSString *testNumStr = [BaccaratComputer testRandomRoadListIndex:index testIndex:self.testIndex];
//            cardModel.bCardValue = [testNumStr integerValue];
////            cardModel.cardStr = testNumStr;
//        }
        
        
        
        if (index == 1) {
            player1 = cardModel.bCardValue;
            [playerArray addObject:cardModel];
        } else if (index == 2) {
            banker1 = cardModel.bCardValue;
            [bankerArray addObject:cardModel];
        } else if (index == 3) {
            player2 = cardModel.bCardValue;
            [playerArray addObject:cardModel];
        } else if (index == 4) {
            banker2 = cardModel.bCardValue;
            [bankerArray addObject:cardModel];

            playerTotalPoints = (player1 + player2) % 10;
            bankerTotalPoints = (banker1 + banker2) % 10;
            
        } else if (index == 5) {
            
            if (playerTotalPoints < 6) {
                player3 = cardModel.bCardValue;
                [playerArray addObject:cardModel];
            } else {
                if (playerTotalPoints >= 6 || bankerTotalPoints < 6) {
                    banker3 = cardModel.bCardValue;
                    [bankerArray addObject:cardModel];
                } else {
                    NSLog(@"🔴🔴🔴发牌有问题🔴🔴🔴");
                }
            }
        } else if (index == 6) {
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
        
        
        BOOL isStopSendCard = [BaccaratComputer baccaratStopCardIndex:index player3:player3 playerTotalPoints:playerTotalPoints bankerTotalPoints:bankerTotalPoints];
        if (isStopSendCard) {
            break;  // 停止发牌
        }
        cardModel = nil;
    }
    
    BaccaratResultModel *bResultModel =  [[BaccaratResultModel alloc] init];
    [bResultModel baccaratResultComputer:playerArray bankerArray:bankerArray];
    
    if (!self.isAutoRunAll) {
        /// 显示所有牌例
        self.showPokerView.resultModel = bResultModel;
    }
    
    bResultModel.pokerCount = self.gameStatisticsModel.pokerCount;
    _bResultModel = bResultModel;
    [self.zhuPanLuResultDataArray addObject:bResultModel];
    
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

- (void)onAtuoShowView {
    
    [UIView animateWithDuration:0.5 animations:^{
        if (self.autoRunView.frame.origin.y >= 0) {
            self.autoRunView.frame = CGRectMake(100, -50, 500, 50);
        } else {
            self.autoRunView.frame = CGRectMake(100, 0, 500, 50);
        }
    } completion:^(BOOL finished) {
        
    }];
}
- (void)onRoadListBtn {
    
    [UIView animateWithDuration:0.5 animations:^{
        if (self.manualManageRoadView.frame.origin.y < mxwScreenHeight()) {
            self.chipsView.hidden = NO;
            self.manualManageRoadView.frame = CGRectMake(100, mxwScreenHeight(), 360, 100);
        } else {
            self.chipsView.hidden = YES;
            self.manualManageRoadView.frame = CGRectMake(100, mxwScreenHeight()-100, 360, 100);
        }
    } completion:^(BOOL finished) {
        
    }];
    
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
    } else if ([title isEqualToString:@"充值"]) {
        //        self.statisticsView.bUserData = self.bUserData;
        [self.topupAlertView showAlertAnimation];
    } else if ([title isEqualToString:@"游戏记录"]) {
        
        NSString *queryWhere = [NSString stringWithFormat:@"userId='%@'",kUserId_String];
        NSArray *dataArray = [WHC_ModelSqlite query:[BaccaratResultModel class] where:queryWhere];
        
        self.gameRecordAlertView.zhuPanLuResultDataArray = dataArray;
        [self.gameRecordAlertView showAlertAnimation];
        
    } else if ([title isEqualToString:@"余额记录"]) {
        
        NSString *queryWhere = [NSString stringWithFormat:@"userId='%@'",kUserId_String];
        NSArray *balanceArray = [WHC_ModelSqlite query:[BalanceRecordModel class] where:queryWhere];
        
        self.topupRecordAlertView.dataArray = balanceArray;
        [self.topupRecordAlertView showAlertAnimation];
        
    } else if ([title isEqualToString:@"设置"]) {
        //        BaccaratConfigController *vc = [[BaccaratConfigController alloc] init];
        //        [self.navigationController pushViewController:vc animated:YES];
        
    } else if ([title isEqualToString:@"更换赌桌"]) {
        [self initData];
        [self createUI];
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
    
    // 右边路子图
    [self createRightRoadMapView];
    
    
    UIButton *moreBtn = [[UIButton alloc] init];
    [moreBtn setBackgroundImage:[UIImage imageNamed:@"com_more_white"] forState:UIControlStateNormal];
    [moreBtn addTarget:self action:@selector(onMoreBtnMethod) forControlEvents:UIControlEventTouchUpInside];
    //    moreBtn.backgroundColor = [UIColor greenColor];
    [self.view addSubview:moreBtn];
    
    [moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(10);
        make.left.equalTo(self.view.mas_left).offset(25);
        make.size.mas_equalTo(CGSizeMake(25, 20));
    }];
    
    UIButton *autoBtn = [[UIButton alloc] init];
    //    [autoBtn setBackgroundImage:[UIImage imageNamed:@"com_more_white"] forState:UIControlStateNormal];
    [autoBtn addTarget:self action:@selector(onAtuoShowView) forControlEvents:UIControlEventTouchUpInside];
    autoBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [autoBtn setTitle:@"自动" forState:UIControlStateNormal];
    [autoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [autoBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    autoBtn.backgroundColor = [UIColor colorWithRed:0.027 green:0.757 blue:0.376 alpha:1.000];
    autoBtn.layer.borderWidth = 1;
    autoBtn.layer.borderColor = [UIColor greenColor].CGColor;
    autoBtn.layer.cornerRadius = 3;
    [self.view addSubview:autoBtn];
    
    [autoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(moreBtn.mas_bottom).offset(10);
        make.left.equalTo(moreBtn.mas_left).offset(0);
        make.size.mas_equalTo(CGSizeMake(35, 28));
    }];
    
    [self.view addSubview:self.autoRunView];
    
    
    UIButton *roadListBtn = [[UIButton alloc] init];
    //    [autoBtn setBackgroundImage:[UIImage imageNamed:@"com_more_white"] forState:UIControlStateNormal];
    [roadListBtn addTarget:self action:@selector(onRoadListBtn) forControlEvents:UIControlEventTouchUpInside];
    roadListBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [roadListBtn setTitle:@"路单" forState:UIControlStateNormal];
    [roadListBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [roadListBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    roadListBtn.backgroundColor = [UIColor colorWithRed:0.027 green:0.757 blue:0.376 alpha:1.000];
    roadListBtn.layer.borderWidth = 1;
    roadListBtn.layer.borderColor = [UIColor greenColor].CGColor;
    roadListBtn.layer.cornerRadius = 3;
    [self.view addSubview:roadListBtn];
    
    [roadListBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-30);
        make.left.equalTo(moreBtn.mas_left).offset(0);
        make.size.mas_equalTo(CGSizeMake(40, 30));
    }];
    
    [self.view addSubview:self.manualManageRoadView];
    
    
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
    CGFloat xiasanluHeight = (kBXSLItemSizeWidth+1)*6+1;
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

#pragma mark -  BAutoRunViewDelegate 自动运行
/// 自动运行
- (void)didAutoRunModel:(BAutoRunModel *)model {
    
    [self onAutoStartRunsNum:model.runsNum];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.autoRunView.frame = CGRectMake(100, -50, 500, 50);
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark -  BManualManageRoadViewDelegate 路单
/// 手动选择路子
/// @param buttonTag 选择 buttonTag  闲 1  庄 2 和 3 后退 4  闲对 5 庄对 6 超级6 7   赢 8
- (void)didManualManageRoadSelectedClickButtonTag:(NSInteger)buttonTag {
    
    if (buttonTag == 1) {
        self.roadListSelectedWinType = WinType_Player;
    } else if (buttonTag == 2) {
        self.roadListSelectedWinType = WinType_Banker;
    } else if (buttonTag == 3) {
        self.roadListSelectedWinType = WinType_TIE;
    } else if (buttonTag == 4) {  // 退一个
        
        // 大路
        [self.bigRoadMapView removeLastSubview];
        
        BaccaratResultModel *lastModel = self.zhuPanLuResultDataArray.lastObject;
        // 无和
        if (lastModel.winType != WinType_TIE) {
            [self.dylXiaSanLuView removeLastSubview];
            [self.xlXiaSanLuView removeLastSubview];
            [self.xqlXiaSanLuView removeLastSubview];
        }
        
        // 珠盘路
        [self.zhuPanLuResultDataArray removeLastObject];
        self.zhuPanLuCollectionView.model = self.zhuPanLuResultDataArray;
        
        NSLog(@"1");
        return;
    }
    
    [self onAutoStartRunsNum:1];
    NSLog(@"1");
}
/// 特殊选择
/// @param buttonTag 选择 buttonTag   闲对 5 庄对 6 超级6 7   赢 8
/// @param isSelected 是否选中
- (void)specialSelectedClickButtonTag:(NSInteger)buttonTag isSelected:(BOOL)isSelected {
    
    if (isSelected) {
        if (buttonTag == 5) {
            self.roadListSelectedPXSType = self.roadListSelectedPXSType + PXSType_PlayerPair;
        } else if (buttonTag == 6) {
            self.roadListSelectedPXSType = self.roadListSelectedPXSType + PXSType_BankerPair;
        } else if (buttonTag == 7) {
            self.roadListSelectedPXSType = self.roadListSelectedPXSType + PXSType_SuperSix;
        } else if (buttonTag == 8) {
            self.roadListSelectedPXSType = self.roadListSelectedPXSType + PXSType_SkyCard;
        } else if (buttonTag == 9) {
            self.bigRoadMapView.isShowTie = YES;
        }
    } else {
        if (buttonTag == 5) {
            self.roadListSelectedPXSType = self.roadListSelectedPXSType - PXSType_PlayerPair;
        } else if (buttonTag == 6) {
            self.roadListSelectedPXSType = self.roadListSelectedPXSType - PXSType_BankerPair;
        } else if (buttonTag == 7) {
            self.roadListSelectedPXSType = self.roadListSelectedPXSType - PXSType_SuperSix;
        } else if (buttonTag == 8) {
            self.roadListSelectedPXSType = self.roadListSelectedPXSType - PXSType_SkyCard;
        } else if (buttonTag == 9) {
            self.bigRoadMapView.isShowTie = NO;
        }
    }
    
    NSLog(@"1");
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


