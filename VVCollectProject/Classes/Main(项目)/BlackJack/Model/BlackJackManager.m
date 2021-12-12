//
//  BlackJackManager.m
//  VVCollectProject
//
//  Created by Admin on 2021/12/12.
//  Copyright © 2021 Mike. All rights reserved.
//

#import "BlackJackManager.h"

@implementation BlackJackManager

#pragma mark - 正常停牌算法


/// 玩家是否停止拿牌
/// @param playerTotal 玩家点数
/// @param bankerTotal 庄家点数
+ (BOOL)automaticRun:(NSInteger)playerTotal bankerTotal:(NSInteger)bankerTotal {
    
    BOOL isStand = NO;
    // 玩家12点的并且庄家牌是 4、5、6时停牌
    if (playerTotal == 12 && (bankerTotal == 4 || bankerTotal == 5 || bankerTotal == 6)) {
        isStand = YES;
    } else if ((playerTotal == 13 || playerTotal == 14 || playerTotal == 15 || playerTotal == 16) && (bankerTotal == 2 || bankerTotal == 3 || bankerTotal == 4 || bankerTotal == 5 || bankerTotal == 6)) {
        // 玩家 13、14、15、16点并且庄家 2、3、4、5、6 停牌
        isStand = YES;
    } else if (playerTotal >= 17) {  // 玩家大于等于17点停牌
        isStand = YES;
    } else {
        isStand = NO;
    }
    
    return isStand;
}

/// 带A 牌 玩家是否停止拿牌
/// @param p_ATotal 玩家点数
/// @param bankerTotal 庄家点数
+ (BOOL)automaticRunPoints_A:(NSInteger)p_ATotal bankerTotal:(NSInteger)bankerTotal {
    BOOL isStand = NO;
    if (p_ATotal >= 19 || (p_ATotal == 18 && (bankerTotal == 7 || bankerTotal == 8))) {
        // 停牌
        isStand = YES;
    } else {
        isStand = NO;
    }
    return isStand;
}


#pragma mark - 加倍算法

/// 正常 玩家是否加倍
/// @param playerTotal 玩家点数
/// @param bankerTotal 庄家点数
+ (BOOL)autoDoubleOneAction:(NSInteger)playerTotal bankerTotal:(NSInteger)bankerTotal {
    BOOL isDoubleOne = NO;
    if (playerTotal == 9 && (bankerTotal == 3 || bankerTotal == 4 || bankerTotal == 5 || bankerTotal == 6)) {
        isDoubleOne = YES;
    } else if (playerTotal == 10 && (bankerTotal == 2 || bankerTotal == 3 || bankerTotal == 4 || bankerTotal == 5 || bankerTotal == 6 || bankerTotal == 7 || bankerTotal == 8 || bankerTotal == 9)) {
        isDoubleOne = YES;
    } else if (playerTotal == 10 && (bankerTotal == 2 || bankerTotal == 3 || bankerTotal == 4 || bankerTotal == 5 || bankerTotal == 6 || bankerTotal == 7 || bankerTotal == 8 || bankerTotal == 9 || bankerTotal == 10)) {
        isDoubleOne = YES;
    }
    return isDoubleOne;
}

/// 2张牌带A的加倍算法  玩家是否加倍
/// @param p_ATotal 玩家点数
/// @param bankerTotal 庄家点数
+ (BOOL)autoDoubleOnePoints_A:(NSInteger)p_ATotal bankerTotal:(NSInteger)bankerTotal {
    BOOL isDoubleOne = NO;
    if ((p_ATotal == 13 || p_ATotal == 14) && (bankerTotal == 5 || bankerTotal == 6)) {
        isDoubleOne = YES;
    } else if ((p_ATotal == 15 || p_ATotal == 15) && (bankerTotal == 4 || bankerTotal == 5 || bankerTotal == 6)) {
        isDoubleOne = YES;
    } else if (p_ATotal == 17 && (bankerTotal == 3 || bankerTotal == 4 || bankerTotal == 5 || bankerTotal == 6)) {
        isDoubleOne = YES;
    } else if (p_ATotal == 18 && (bankerTotal == 2 ||bankerTotal == 3 || bankerTotal == 4 || bankerTotal == 5 || bankerTotal == 6)) {
        isDoubleOne = YES;
    }
    
    return isDoubleOne;
}

@end
