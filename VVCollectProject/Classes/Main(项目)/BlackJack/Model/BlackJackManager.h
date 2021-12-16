//
//  BlackJackManager.h
//  VVCollectProject
//
//  Created by Admin on 2021/12/12.
//  Copyright © 2021 Mike. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PokerCardModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BlackJackManager : NSObject

/// 玩家是否停止拿牌
/// @param playerTotal 玩家点数
/// @param isPlayer_A 玩家是否有A
/// @param bankerTotal 庄家点数
+ (BOOL)autoRunPlayerStandTakeCards:(NSInteger)playerTotal isPlayer_A:(BOOL)isPlayer_A bankerTotal:(NSInteger)bankerTotal;


#pragma mark - 加倍算法

/// 玩家是否加倍拿牌
/// @param playerTotal 玩家点数
/// @param isPlayer_A 玩家是否有A
/// @param bankerTotal 庄家点数  autoRunPlayerStandTakeCards
+ (BOOL)autoRunPlayerDoubleOneTakeCards:(NSInteger)playerTotal isPlayer_A:(BOOL)isPlayer_A bankerTotal:(NSInteger)bankerTotal;


#pragma mark - 庄家是否停止拿牌
/// 庄家是否停止拿牌
/// @param bankerTotal 庄家点数
/// @param isBanker_A 庄家是否有A
/// @param playerTotal 玩家点数
+(BOOL)bankerStandTakeCards:(NSInteger)bankerTotal isBanker_A:(BOOL)isBanker_A playerTotal:(NSInteger)playerTotal;

@end

NS_ASSUME_NONNULL_END
