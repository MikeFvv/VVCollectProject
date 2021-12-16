//
//  BJWinOrLoseResultModel.m
//  VVCollectProject
//
//  Created by Admin on 2021/12/17.
//  Copyright © 2021 Mike. All rights reserved.
//

#import "BJWinOrLoseResultModel.h"

@implementation BJWinOrLoseResultModel


/// 计算庄闲结果
/// @param playerArray 玩家牌
/// @param bankerArray 庄家牌
-(void)blackJackResultComputer:(NSMutableArray<PokerCardModel *> *)playerArray bankerArray:(NSMutableArray<PokerCardModel *> *)bankerArray isPlayerDoubleOne:(BOOL)isPlayerDoubleOne {
    
    self.playerArray = playerArray;
    self.bankerArray = bankerArray;
    self.isPlayerDoubleOne = isPlayerDoubleOne;
    
    // *** 玩家计算 ***
    self.playerTotal = 0;
    for (PokerCardModel *model in playerArray) {
        if (model.alterValue == 11) {
            self.isPlayerA = YES;
        }
        self.playerTotal = self.playerTotal + model.cardValue;
    }
    
    if (self.isPlayerA) {
        if (self.playerTotal + 10 <= 21) {
            self.playerTotal = self.playerTotal + 10;
        }
    }
    
    if (self.playerTotal > 21) {
        self.isPlayerBust = YES;
    }
    
    PokerCardModel *first = playerArray[0];
    PokerCardModel *second = playerArray[1];
    if ([first.cardStr isEqualToString:second.cardStr]) {
        self.isPlayerPair = YES;
    }
    
    
    // *** 庄计算 ***
    self.bankerTotal = 0;
    for (PokerCardModel *model in bankerArray) {
        if (model.alterValue == 11) {
            self.isBankerA = YES;
        }
        self.bankerTotal = self.bankerTotal + model.cardValue;
    }
    
    if (self.isBankerA) {
        if (self.bankerTotal + 10 <= 21) {
            self.bankerTotal = self.bankerTotal + 10;
        }
    }
    
    if (self.bankerTotal > 21) {
        self.isBankerBust = YES;
    }
    
    
    // *** 输赢计算 ***
    if (self.isPlayerBust) {
        self.winType = WinType_Banker;
    } else if (self.isBankerBust) {
        self.winType = WinType_Player;
    } else if (self.playerTotal == self.bankerTotal) {
        self.winType = WinType_TIE;
    } else if (self.playerTotal > self.bankerTotal) {
        self.winType = WinType_Player;
    } else if (self.playerTotal < self.bankerTotal) {
        self.winType = WinType_Banker;
    } else {
        NSLog(@"🔴未知🔴");
    }
    
}

@end
