//
//  BaccaratModel.m
//  VVCollectProject
//
//  Created by pt c on 2019/9/10.
//  Copyright © 2019 Mike. All rights reserved.
//

#import "BaccaratResultModel.h"
#import "MFHTimeManager.h"

@implementation BaccaratResultModel

/// 计算庄闲结果
/// @param playerArray 玩家牌
/// @param bankerArray 庄家牌
-(void)baccaratResultComputer:(NSMutableArray<PokerCardModel *> *)playerArray bankerArray:(NSMutableArray<PokerCardModel *> *)bankerArray {
    
    self.playerArray = playerArray;
    self.bankerArray = bankerArray;
    
    // *** 创建时间 ***
   self.createTime = [MFHTimeManager getNowTimeWithDateFormat:@"YYYY年MM月dd日 HH:mm:ss"];
    
    // *** 玩家计算 ***
    self.playerTotalPoints = 0;
    for (PokerCardModel *model in playerArray) {
        self.playerTotalPoints = (self.playerTotalPoints + model.bCardValue) % 10;
    }
    
    // 闲对子
    PokerCardModel *firstP = playerArray[0];
    PokerCardModel *secondP = playerArray[1];
    if ([firstP.cardStr isEqualToString:secondP.cardStr]) {
        self.isPlayerPair = YES;
    }
    
    
    
    // *** 庄计算 ***
    self.bankerTotalPoints = 0;
    for (PokerCardModel *model in bankerArray) {
        self.bankerTotalPoints = (self.bankerTotalPoints + model.bCardValue) % 10;
    }
    // 庄对子
    PokerCardModel *firstB = bankerArray[0];
    PokerCardModel *secondB = bankerArray[1];
    if ([firstB.cardStr isEqualToString:secondB.cardStr]) {
        self.isBankerPair = YES;
    }
    
    // *** 输赢计算 ***
    if (self.playerTotalPoints == self.bankerTotalPoints) {
        self.winType = WinType_TIE;
    } else if (self.playerTotalPoints > self.bankerTotalPoints) {
        self.winType = WinType_Player;
    } else if (self.playerTotalPoints < self.bankerTotalPoints) {
        self.winType = WinType_Banker;
        
        if (self.bankerTotalPoints == 6) {
            self.isSuperSix = YES;  // 超级6
        }
    } else {
        NSLog(@"🔴未知🔴");
    }
    
    
    self.pokerTotalNum = playerArray.count + bankerArray.count;
    
}

@end
