//
//  BaccaratModel.h
//  VVCollectProject
//
//  Created by pt c on 2019/9/10.
//  Copyright © 2019 Mike. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PokerCardModel.h"
#import "BaccaratCom.h"


NS_ASSUME_NONNULL_BEGIN

@interface BaccaratResultModel : NSObject

/// 0 Tie   1 banker   2 player
@property (nonatomic, assign) WinType winType;

/// player 点数
@property (nonatomic, assign) NSInteger playerTotalPoints;
/// banker 点数
@property (nonatomic, assign) NSInteger bankerTotalPoints;



/// 玩家牌型数组
@property (nonatomic, strong) NSArray<PokerCardModel *> *playerArray;
/// 庄家牌型数组
@property (nonatomic, strong) NSArray<PokerCardModel *> *bankerArray;


/// 是否庄对
@property (nonatomic, assign) BOOL isBankerPair;
/// 是否闲对
@property (nonatomic, assign) BOOL isPlayerPair;
/// 是否超级6
@property (nonatomic, assign) BOOL isSuperSix;


/// 发牌局数
@property (nonatomic, assign) NSInteger pokerCount;
/// 每局下注金额
@property (nonatomic, assign) NSInteger betMoney;


/// 一局牌的总张数
@property (nonatomic, assign) NSInteger pokerTotalNum;

/// 创建时间
@property (nonatomic, copy) NSString *createTime;

/// 计算庄闲结果
/// @param playerArray 玩家牌
/// @param bankerArray 庄家牌
-(void)baccaratResultComputer:(NSMutableArray<PokerCardModel *> *)playerArray bankerArray:(NSMutableArray<PokerCardModel *> *)bankerArray;

@end

NS_ASSUME_NONNULL_END
