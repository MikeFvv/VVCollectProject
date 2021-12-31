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

/// 用户今日初始金额
@property (nonatomic, assign) NSInteger initTodayMoney;
/// 今日盈利
@property (nonatomic, assign) NSInteger profitTodayMoney;



/// 每桌最高余额记录
@property (nonatomic, assign) NSInteger perTableMaxTotalMoney;
/// 每桌最低余额记录
@property (nonatomic, assign) NSInteger perTableMinTotalMoney;
/// 最高余额记录
@property (nonatomic, assign) NSInteger maxTotalMoney;
/// 最高获胜记录
@property (nonatomic, assign) NSInteger maxWinTotalMoney;
/// 最高失败记录
@property (nonatomic, assign) NSInteger maxLoseTotalMoney;




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

/// 当前连赢状态
@property (nonatomic, assign) BOOL isContinuousWin;


@end

NS_ASSUME_NONNULL_END
