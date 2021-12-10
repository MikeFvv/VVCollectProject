//
//  SuperAI.h
//  VVCollectProject
//
//  Created by Admin on 2021/12/10.
//  Copyright © 2021 Mike. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InitState.h"
#import "BetState.h"



NS_ASSUME_NONNULL_BEGIN
/**
 * 抽象类SuperAI实现了一个AI算法
 * 包含了一个AI算法应该包含的属性及方法，用于客户端主程序与算法程序的交互
 * @author wangtao
 *
 */
@interface SuperAI : NSObject

/// 底牌
@property (nonatomic, strong) NSMutableArray<Poker *> *holdPokers;
/// 公共牌
@property (nonatomic, strong) NSMutableArray<Poker *> *publicPokers;
/// 自己的注册ID
@property (nonatomic, copy) NSString *playerID;
/// 盲注金额或最小押注金额
@property (nonatomic, assign) NSInteger blind;
/// 初始总筹码
@property (nonatomic, assign) NSInteger initJetton;
/// 剩余筹码
@property (nonatomic, assign) NSInteger totalJetton;
/// 剩余金币
@property (nonatomic, assign) NSInteger totalMoney;
/// 玩家人数
@property (nonatomic, assign) NSInteger playerNum;
/// 战胜一个对手的概率
@property (nonatomic, assign) CGFloat winProb;

/// 当前没有弃牌的玩家
@property (nonatomic, strong) NSMutableArray<NSString *> *activePlayers;
/// 庄家ID
@property (nonatomic, copy) NSString *buttonID;
/// 是否是最后一个玩家
@property (nonatomic, assign) BOOL isTheLastOne;
/// 是否是位置偏后的一半玩家
@property (nonatomic, assign) BOOL isLastHalf;
/// 是否有all_in娃
@property (nonatomic, assign) BOOL hasAllIn;
/// 自己的位置，即押注的顺序
//@property (nonatomic, assign) NSInteger position;

/// 当前局数
@property (nonatomic, assign) NSInteger handNum;
/// 是否已弃牌
@property (nonatomic, assign) BOOL folded;
/// 标记本环节是否已加过注
@property (nonatomic, assign) BOOL hasRaised;

/// 用于记录所有玩家的初始状态
@property (nonatomic, strong) NSMutableArray<InitState *> *ainitStates;
/// 用于记录所有未弃牌玩家的押注状态
@property (nonatomic, strong) NSMutableArray<BetState *> *betStates;


-(int)getTotalMoneyAndJetton;



/**
 * 跟注
 *
 * @param diff
 * @param maxMultiple 最大可容忍跟注倍数
 * @return
 */
-(NSString *)callByDiff:(int)diff maxMultiple:(int)maxMultiple;
/**
 * 加注：加注金额为mutiple * blind
 *
 * @param diff
 *            根据前面玩家下注，需要跟注的最小数量
 * @param multiple
 * @param maxMultiple 最大可接受倍数
 * @return
 */
-(NSString *)raiseByDiff:(int)diff multiple:(int)multiple maxMultiple:(int)maxMultiple;

/**
 * 在发送下注策略之前必须通过该方法获得策略
 * @param diff
 * @param jetton
 * @return
 */
-(NSString *)getResponse:(int)diff jetton:(int)jetton;

@end

NS_ASSUME_NONNULL_END
