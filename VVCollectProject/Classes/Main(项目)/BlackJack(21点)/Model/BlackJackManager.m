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
/// @param isPlayer_A 玩家是否有A
/// @param bankerTotal 庄家点数
+ (BOOL)autoRunPlayerStandTakeCards:(NSInteger)playerTotal isPlayer_A:(BOOL)isPlayer_A bankerTotal:(NSInteger)bankerTotal {
    
    BOOL isStand = NO;
    
    if (isPlayer_A) {
        if (playerTotal + 10 >= 19 || (playerTotal + 10 == 18 && (bankerTotal == 7 || bankerTotal == 8))) {
            // 停牌
            isStand = YES;
        }
        return isStand;
    }
    
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


#pragma mark - 加倍算法

/// 玩家是否加倍拿牌
/// @param playerTotal 玩家点数
/// @param isPlayer_A 玩家是否有A
/// @param bankerTotal 庄家点数  autoRunPlayerStandTakeCards
+ (BOOL)autoRunPlayerDoubleOneTakeCards:(NSInteger)playerTotal isPlayer_A:(BOOL)isPlayer_A bankerTotal:(NSInteger)bankerTotal {
    BOOL isDoubleOne = NO;
    
    if (isPlayer_A) {
       NSInteger playerTotal_A = playerTotal + 10;
        if ((playerTotal_A == 13 || playerTotal_A == 14) && (bankerTotal == 5 || bankerTotal == 6)) {
            isDoubleOne = YES;
        } else if ((playerTotal_A == 15 || playerTotal_A == 15) && (bankerTotal == 4 || bankerTotal == 5 || bankerTotal == 6)) {
            isDoubleOne = YES;
        } else if (playerTotal_A == 17 && (bankerTotal == 3 || bankerTotal == 4 || bankerTotal == 5 || bankerTotal == 6)) {
            isDoubleOne = YES;
        } else if (playerTotal_A == 18 && (bankerTotal == 2 ||bankerTotal == 3 || bankerTotal == 4 || bankerTotal == 5 || bankerTotal == 6)) {
            isDoubleOne = YES;
        }
        return isDoubleOne;
    }
    
    
    if (playerTotal == 9 && (bankerTotal == 3 || bankerTotal == 4 || bankerTotal == 5 || bankerTotal == 6)) {
        isDoubleOne = YES;
    } else if (playerTotal == 10 && (bankerTotal == 2 || bankerTotal == 3 || bankerTotal == 4 || bankerTotal == 5 || bankerTotal == 6 || bankerTotal == 7 || bankerTotal == 8 || bankerTotal == 9)) {
        isDoubleOne = YES;
    } else if (playerTotal == 10 && (bankerTotal == 2 || bankerTotal == 3 || bankerTotal == 4 || bankerTotal == 5 || bankerTotal == 6 || bankerTotal == 7 || bankerTotal == 8 || bankerTotal == 9 || bankerTotal == 10)) {
        isDoubleOne = YES;
    }
    return isDoubleOne;
}




/// 庄家是否停止拿牌
/// @param bankerTotal 庄家点数
/// @param isBanker_A 庄家是否有A
/// @param playerTotal 玩家点数
+(BOOL)bankerStandTakeCards:(NSInteger)bankerTotal isBanker_A:(BOOL)isBanker_A playerTotal:(NSInteger)playerTotal {
    BOOL isStand = NO;
    if (isBanker_A && bankerTotal <= 11) {  // 有A的时候
        // 有A大于等于18的时候停牌， 有A等于17的时候并且大于闲家牌停牌
        if (bankerTotal + 10 >= 18 || (bankerTotal + 10 == 17 && bankerTotal + 10 > playerTotal)) {
            isStand = YES;
        }
    } else if (bankerTotal >= 17) {  // 大于等于17停牌
        isStand = YES;
    }
    return isStand;
}


@end
