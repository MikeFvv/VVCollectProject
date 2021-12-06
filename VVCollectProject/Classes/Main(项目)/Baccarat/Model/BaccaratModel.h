//
//  BaccaratModel.h
//  VVCollectProject
//
//  Created by pt c on 2019/9/10.
//  Copyright © 2019 Mike. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, WinType) {
    WinType_TIE = 0,
    WinType_Banker = 1,
    WinType_Player = 2
};

NS_ASSUME_NONNULL_BEGIN

@interface BaccaratModel : NSObject

/// 0 Tie   1 banker   2 player
@property (nonatomic, assign) WinType winType;

/// banker 点数
@property (nonatomic, assign) NSInteger bankerPointsNum;
/// player 点数
@property (nonatomic, assign) NSInteger playerPointsNum;

/// banker1牌 点数
@property (nonatomic, assign) NSInteger banker1;
/// banker2牌 点数
@property (nonatomic, assign) NSInteger banker2;
/// banker3牌 点数
@property (nonatomic, copy) NSString *banker3;

/// player1牌 点数
@property (nonatomic, assign) NSInteger player1;
/// player2牌 点数
@property (nonatomic, assign) NSInteger player2;
/// player3牌 点数
@property (nonatomic, copy) NSString *player3;

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

// ************ 不是Baccarat ************

/// 是否 闲爆牌
@property (nonatomic, assign) BOOL isPlayerBust;
/// 是否 庄爆牌
@property (nonatomic, assign) BOOL isBankerBust;


@end

NS_ASSUME_NONNULL_END
