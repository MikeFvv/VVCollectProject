//
//  BlackJackManager.h
//  VVCollectProject
//
//  Created by Admin on 2021/12/12.
//  Copyright © 2021 Mike. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BlackJackManager : NSObject
/// 玩家是否停止拿牌
/// @param playerTotal 玩家点数
/// @param bankerTotal 庄家点数
+ (BOOL)automaticRun:(NSInteger)playerTotal bankerTotal:(NSInteger)bankerTotal;
/// 带A 牌 玩家是否停止拿牌
/// @param p_ATotal 玩家点数
/// @param bankerTotal 庄家点数
+ (BOOL)automaticRunPoints_A:(NSInteger)p_ATotal bankerTotal:(NSInteger)bankerTotal;


#pragma mark - 正常加倍算法

/// 正常 玩家是否加倍
/// @param playerTotal 玩家点数
/// @param bankerTotal 庄家点数
+ (BOOL)autoDoubleOneAction:(NSInteger)playerTotal bankerTotal:(NSInteger)bankerTotal;

/// 2张牌带A的加倍算法  玩家是否加倍
/// @param p_ATotal 玩家点数
/// @param bankerTotal 庄家点数
+ (BOOL)autoDoubleOnePoints_A:(NSInteger)p_ATotal bankerTotal:(NSInteger)bankerTotal;
@end

NS_ASSUME_NONNULL_END
