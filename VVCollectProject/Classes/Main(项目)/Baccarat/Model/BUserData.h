//
//  BUserData.h
//  VVCollectProject
//
//  Created by Admin on 2021/12/26.
//  Copyright © 2021 Mike. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 用户数据
@interface BUserData : NSObject

/// 用户当前总金额
@property (nonatomic, assign) NSInteger userTotalMoney;
/// 本次下注之前总金额
@property (nonatomic, assign) NSInteger beforeBetTotalMoney;



// ************** 今日 **************

/// 游戏总局数
@property (nonatomic, assign) NSInteger today_gameTotalNum;
/// 闲总局数
@property (nonatomic, assign) NSInteger today_playerTotalNum;
/// 庄总局数
@property (nonatomic, assign) NSInteger today_bankerTotalNum;
/// 和总局数
@property (nonatomic, assign) NSInteger today_tieTotalNum;
/// 获胜总局数
@property (nonatomic, assign) NSInteger today_winTotalNum;
/// 获胜概率
@property (nonatomic, assign) CGFloat today_winTotalProbability;
/// 最高连胜记录
@property (nonatomic, assign) NSInteger today_continuoustoday_winTotalNum;
/// 最高连输记录
@property (nonatomic, assign) NSInteger today_continuousLoseTotalNum;
/// 最高获胜记录
@property (nonatomic, assign) NSInteger today_maxWinTotalMoney;
/// 最高失败记录
@property (nonatomic, assign) NSInteger today_maxLoseTotalMoney;





/// 用户今日初始金额
@property (nonatomic, assign) NSInteger today_InitMoney;
/// 今日盈利
@property (nonatomic, assign) NSInteger today_ProfitMoney;
/// 今日最高余额记录
@property (nonatomic, assign) NSInteger today_maxTotalMoney;
/// 今日最低余额记录
@property (nonatomic, assign) NSInteger today_MinTotalMoney;


// ************** 全部 保存到数据库的 **************
/// 游戏总局数
@property (nonatomic, assign) NSInteger all_gameTotalNum;
/// 闲总局数
@property (nonatomic, assign) NSInteger all_playerTotalNum;
/// 庄总局数
@property (nonatomic, assign) NSInteger all_bankerTotalNum;
/// 和总局数
@property (nonatomic, assign) NSInteger all_tieTotalNum;
/// 获胜总局数
@property (nonatomic, assign) NSInteger all_winTotalNum;
/// 获胜概率
@property (nonatomic, assign) CGFloat all_winTotalProbability;
/// 最高连胜记录
@property (nonatomic, assign) NSInteger all_continuoustoday_winTotalNum;
/// 最高连输记录
@property (nonatomic, assign) NSInteger all_continuousLoseTotalNum;
/// 最高获胜记录
@property (nonatomic, assign) NSInteger all_maxWinTotalMoney;
/// 最高失败记录
@property (nonatomic, assign) NSInteger all_maxLoseTotalMoney;





/// 用户今日初始金额
@property (nonatomic, assign) NSInteger all_InitMoney;
/// 全部总盈利
@property (nonatomic, assign) NSInteger all_ProfitMoney;
/// 全部最高余额记录
@property (nonatomic, assign) NSInteger all_maxTotalMoney;
/// 全部最低余额记录
@property (nonatomic, assign) NSInteger all_MinTotalMoney;

@end

NS_ASSUME_NONNULL_END
