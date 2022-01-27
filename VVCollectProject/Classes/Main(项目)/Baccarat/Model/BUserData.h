//
//  BUserData.h
//  VVCollectProject
//
//  Created by Admin on 2021/12/26.
//  Copyright © 2021 Mike. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WHC_ModelSqlite.h"



NS_ASSUME_NONNULL_BEGIN

/// 用户数据
@interface BUserData : NSObject<NSCoding,WHC_SqliteInfo>

/// 用户ID
@property (nonatomic, copy) NSString *userId;
/// 游戏桌子ID 每天日期+001 自增
@property (nonatomic, copy) NSString *tableID;

/// 每天自动增加ID
@property (nonatomic, assign) NSInteger autoIncrementID;

/// 创建时间
@property (nonatomic, copy) NSString *create_time;
/// 更新时间
@property (nonatomic, copy) NSString *update_time;
/// 更新日期
@property (nonatomic, copy) NSString *update_date;

// ************** 今日 **************
/// 用户当前总金额
@property (nonatomic, assign) NSInteger userTotalMoney;
/// 本次下注之前总金额
@property (nonatomic, assign) NSInteger beforeBetTotalMoney;

/// 用户今日初始金额
@property (nonatomic, assign) NSInteger today_InitMoney;
/// 今日盈利
@property (nonatomic, assign) NSInteger today_ProfitMoney;

/// 今日最高余额记录
@property (nonatomic, assign) NSInteger today_maxTotalMoney;
/// 今日最低余额记录
@property (nonatomic, assign) NSInteger today_MinTotalMoney;

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
/// 最高连胜记录
@property (nonatomic, assign) NSInteger today_continuoustoday_winTotalNum;
/// 最高连输记录
@property (nonatomic, assign) NSInteger today_continuousLoseTotalNum;
/// 最高获胜记录
@property (nonatomic, assign) NSInteger today_maxWinTotalMoney;
/// 最高失败记录
@property (nonatomic, assign) NSInteger today_maxLoseTotalMoney;


@end

NS_ASSUME_NONNULL_END
