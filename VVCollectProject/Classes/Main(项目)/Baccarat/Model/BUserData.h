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

// ************** 全部 保存到数据库的 **************
/// 游戏总局数
@property (nonatomic, assign) NSInteger gameTotalNum;
/// 获胜总局数
@property (nonatomic, assign) NSInteger winTotalNum;
/// 获胜概率
@property (nonatomic, assign) CGFloat winTotalProbability;
/// 最高连胜记录
@property (nonatomic, assign) NSInteger continuousWinTotalNum;
/// 最高连输记录
@property (nonatomic, assign) NSInteger continuousLoseTotalNum;
/// 最高余额记录
@property (nonatomic, assign) NSInteger maxTotalMoney;
/// 最高获胜记录
@property (nonatomic, assign) NSInteger maxWinTotalMoney;
/// 最高失败记录
@property (nonatomic, assign) NSInteger maxLoseTotalMoney;



/// 闲总局数
@property (nonatomic, assign) NSInteger playerTotalNum;
/// 庄总局数
@property (nonatomic, assign) NSInteger bankerTotalNum;
/// 和总局数
@property (nonatomic, assign) NSInteger tieTotalNum;


// ************** 今日 **************
/// 用户今日初始金额
@property (nonatomic, assign) NSInteger todayInitMoney;
/// 今日盈利
@property (nonatomic, assign) NSInteger todayProfitMoney;
/// 今日最高余额记录
@property (nonatomic, assign) NSInteger todayMaxTotalMoney;
/// 今日最低余额记录
@property (nonatomic, assign) NSInteger todayMinTotalMoney;


// ************** 只是当前桌 **************
/// 当前桌最高余额记录
@property (nonatomic, assign) NSInteger perTableMaxTotalMoney;
/// 当前桌最低余额记录
@property (nonatomic, assign) NSInteger perTableMinTotalMoney;


@end

NS_ASSUME_NONNULL_END
