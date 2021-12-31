//
//  BGameStatisticsModel.h
//  VVCollectProject
//
//  Created by Admin on 2021/12/26.
//  Copyright © 2021 Mike. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaccaratResultModel.h"
#import "BBetModel.h"


NS_ASSUME_NONNULL_BEGIN

/// 游戏统计模型
@interface BGameStatisticsModel : NSObject

/// 牌的总张数
@property (nonatomic, assign) NSInteger pokerTotalNum;
/// 已发牌局数
@property (nonatomic, assign) NSInteger pokerCount;
/// 当前桌游戏总局数
@property (nonatomic, assign) NSInteger gameNum;

/// 庄家局数
@property (nonatomic, assign) NSInteger bankerNum;
/// 闲家局数
@property (nonatomic, assign) NSInteger playerNum;
/// 和局数
@property (nonatomic, assign) NSInteger tieNum;
/// 庄家对子次数
@property (nonatomic, assign) NSInteger bankerPairNum;
/// 闲家对子次数
@property (nonatomic, assign) NSInteger playerPairNum;
/// 超级6 次数
@property (nonatomic, assign) NSInteger superNum;



/// 上次下注记录
@property (nonatomic, strong) BBetModel *lastBetModel;
///上次牌局
@property (nonatomic, strong) BaccaratResultModel *lastResultModel;

@end

NS_ASSUME_NONNULL_END
