//
//  BJWinOrLoseResultModel.h
//  VVCollectProject
//
//  Created by Admin on 2021/12/17.
//  Copyright © 2021 Mike. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PokerCardModel.h"

// 输赢类型
typedef NS_ENUM(NSInteger, WinType) {
    WinType_TIE = 0,   // 和
    WinType_Banker = 1,   // 庄赢
    WinType_Player = 2,    // 闲赢(玩家)
};

NS_ASSUME_NONNULL_BEGIN

/// 每局牌结果
@interface BJWinOrLoseResultModel : NSObject

/// 玩家牌型数组
@property (nonatomic, strong) NSArray<PokerCardModel *> *playerArray;
/// 玩家是否有A
@property (nonatomic, assign) BOOL isPlayerA;
/// 玩家是否爆牌
@property (nonatomic, assign) BOOL isPlayerBust;
/// 玩家总点数
@property (nonatomic, assign) NSInteger playerTotal;

/// 玩家是否加倍
@property (nonatomic, assign) BOOL isPlayerDoubleOne;
/// 玩家是否对子
@property (nonatomic, assign) BOOL isPlayerPair;


/// 庄家牌型数组
@property (nonatomic, strong) NSArray<PokerCardModel *> *bankerArray;
/// 庄家是否有A
@property (nonatomic, assign) BOOL isBankerA;
/// 庄家是否爆牌
@property (nonatomic, assign) BOOL isBankerBust;
/// 庄家总点数
@property (nonatomic, assign) NSInteger bankerTotal;


@property (nonatomic, assign) WinType winType;



/// 计算庄闲结果
/// @param playerArray 玩家牌
/// @param bankerArray 庄家牌
-(void)blackJackResultComputer:(NSMutableArray<PokerCardModel *> *)playerArray bankerArray:(NSMutableArray<PokerCardModel *> *)bankerArray isPlayerDoubleOne:(BOOL)isPlayerDoubleOne;

@end

NS_ASSUME_NONNULL_END
