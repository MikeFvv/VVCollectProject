//
//  TwoAI.m
//  VVCollectProject
//
//  Created by Admin on 2021/12/11.
//  Copyright © 2021 Mike. All rights reserved.
//

#import "TwoAI.h"
#import "BetState.h"
#import "CardGroup.h"
#import "MaxCardComputer.h"

static const int PROB_NUM = 80;


/**
 * 人数只有2人的时候使用该AI
 *
 */
@implementation TwoAI




/**
     * 判断手牌是否相差小于等于4(有可能组成顺子)
     *
     * @param hp
     * @return
     */
    - (BOOL)isHoldLessThanFour:(NSArray<Poker *> *)hp {
        // 其中有一张为A
        if (hp[0].value == 14 || hp[1].value == 14)
            return abs(hp[0].value - hp[1].value) % 13 <= 4 ? true
                    : false;
        else if (abs(hp[0].value - hp[1].value) <= 4)
            return true;
        return false;
    }

    /**
     * 手牌都大于或等于10
     *
     * @param hp
     * @return
     */
    - (BOOL)isHoldBig:(NSArray<Poker *> *)hp {
        if (hp[0].value >= GAP_VALUE
                && hp[1].value >= GAP_VALUE)
            return true;
        return false;
    }

    - (BOOL)isHoldSmall:(NSArray<Poker *> *)hp {
        if (hp[0].value < GAP_VALUE
                && hp[1].value < GAP_VALUE)
            return true;
        return false;
    }



    /**
     * 判断手牌是否同花色
     *
     * @param hp
     * @return
     */
    - (BOOL)isHoldSameColor:(NSArray<Poker *> *)hp {
        
        if (hp[0].colorTyp == hp[1].colorTyp)
            return true;
        return false;
    }


    /**
     * 获取本手牌已下注的玩家下的最大注
     *
     * @param betStates
     * @return
     */
    - (int)getMaxBet:(NSArray<BetState *> *)betStates {
        int maxBet = 0;
        
        for (int i = 0; i < betStates.count; i++) {
            if (betStates[i].bet > maxBet)
                maxBet = betStates[i].bet;
        }
        return maxBet;
    }

    /**
     * 获取本手牌自己已下注的筹码
     *
     * @param betStates
     * @return
     */
    - (int)getSelfBet:(NSArray<BetState *> *)betStates {
        for (int i = 0; i < betStates.count; i++) {
            
            if ([betStates[i].playerID isEqualToString:self.playerID])
                return betStates[i].bet;
        }
        return 0;
    }

    - (BOOL)isHoldPair:(NSArray<Poker *> *)hp {
        if (hp[0].value == hp[1].value)
            return true;
        return false;
    }
    
    /**
     * 获取公共牌与手牌组成的对子的value
     *
     * @param hp
     * @param pp
     * @return
     */
- (NSMutableArray<NSNumber *> *)getHoldPubPairValue:(NSArray<Poker *> *)hp
                                   pp:(NSArray<Poker *> *)pp {
    
        NSMutableArray<NSNumber *> *res = [NSMutableArray array];
        for (int i = 0; i < hp.count; i++) {
            for (int j = 0; j < pp.count; j++) {
                if (hp[i].value == pp[j].value) {
                    
                    [res addObject:@(hp[i].value)];
                    break;
                }
            }
        }
        return res;
    }

    /**
     * 获取公共牌中组成对子的值，返回的ArrayList包含的是这些对子的value
     *
     * @param pp
     * @return
     */

- (NSArray<NSNumber *> *)getPubPairValue:(NSArray<Poker *> *)pp {
    
    NSMutableArray<NSNumber *> *counter = [NSMutableArray arrayWithArray: @[
        @(0),@(0),@(0),@(0),@(0),
        @(0),@(0),@(0),@(0),@(0),
        @(0),@(0),@(0),@(0),@(0)]];
     

    for (int i = 0; i < pp.count; i++) {
       NSInteger valueIndex = pp[i].value;
        NSInteger conNum = [counter[valueIndex] integerValue];
        conNum++;
    }
    NSMutableArray<NSNumber *> *res = [NSMutableArray array];
    for (int i = 2; i <= 14; i++) {
        NSInteger numI = [counter[i] integerValue];
        if (numI == 2)
            [res addObject:@(i)];
    }
    return res;
}

    /**
     * 获取手牌与公共牌组成对子的值
     *
     * @param hp
     * @param pp
     * @return
     */
- (int)getPairValue:(NSArray<Poker *> *)hp pp:(NSArray<Poker *> *)pp {
        for (int i = 0; i < hp.count; i++) {
            for (int j = 0; j < pp.count; j++) {
                if (hp[i].value == pp[j].value)
                    return hp[i].value;
            }
        }
        return -1;
    
    
    }


//    @Override
    - (NSString *)thinkAfterHold:(NSArray<BetState *> *)betStates {
        
        NSMutableArray<Poker *> *hp = self.holdPokers;
    
        // 计算自己与最大押注的差距，得出需要押注的大小
        int maxBet = [self getMaxBet:betStates];
        int selfBet = [self getSelfBet:betStates];
        int diff = maxBet - selfBet;
        
        // 如果手牌是大对：AA, KK, QQ, JJ, 1010等
        if ([self isHoldBigPair:hp]) {
            // 加注至 MIDDLE_RAISE_MULTIPLE * blind
            if (hp[0].value >= 12)
                
                return [self raiseByDiff:diff multiple:2 maxMultiple:100];
            else
                return [self raiseByDiff:diff multiple:1 maxMultiple:100];
        }
        // 手牌是小对：2~9中的一对
        else if ([self isHoldSmallPair:hp]) {
            if (hp[0].value >= 7)
                
                return [self callByDiff:diff maxMultiple:50];
            else if (hp[0].value >= 5)
                return [self callByDiff:diff maxMultiple:30];
            else {
                return [self callByDiff:diff maxMultiple:15];
            }
        }
        
        
        // 手牌不相等且都大于GAP_VALUE
        else if ([self isHoldBig:hp]) {
            if ([self isHoldSameColor:hp])
                return [self callByDiff:diff maxMultiple:20];
            return [self callByDiff:diff maxMultiple:10];
        }
        // 手牌其中有一个大于GAP_VALUE
        else if (hp[0].value >= GAP_VALUE
                || hp[0].value >= GAP_VALUE) {
            // 如果需要下注小于可接受下等下注金额且(手牌同花色(有可能组成同花)或者相差小于4(有可能组成顺子))
            if ([self isHoldSameColor:hp] || [self isHoldLessThanFour:hp])
                    return [self callByDiff:diff maxMultiple:3];
            return [self callByDiff:diff maxMultiple:1];
        }
        // 手牌都小于10
        else {
            // 手牌同花色或者相差小于4
            if ([self isHoldSameColor:hp]) {
                return [self callByDiff:diff maxMultiple:1];
            }
        }
        
        return [self getResponse:diff jetton:0];
    }

    /**
     * 发出三张公共牌之后思考策略
     *
     * @param betStates
     *            各玩家的当前押注状态
     * @return 押注策略 "check|call|raise num|all_in|fold"
     */
//    @Override
    - (NSString *)thinkAfterFlop:(NSArray<BetState *> *)betStates {
        NSMutableArray<Poker *> *hp = self.holdPokers;
        NSMutableArray<Poker *> *pp = self.publicPokers;
        
        
        
        MaxCardComputer *mmax = [[MaxCardComputer alloc] init];
        [mmax maxCardComputer:hp publicPokers:pp];
        CardGroup *maxGroup = mmax.maxGroup;
    
        int maxBet = [self getMaxBet:betStates];
        int selfBet = [self getSelfBet:betStates];
        int diff = (maxBet - selfBet);
    
        long power = maxGroup.power;
        // 两对
        if (power > (long) 3 * pow(10, 10)
                && power < (long) 4 * pow(10, 10)) {
            //诈唬
            if (self.isTheLastOne && diff <= self.blind) {
                // 随机生成0-100
                if (arc4random() % 100 + 1 <= PROB_NUM) {
                    return [self raiseByDiff:diff multiple:arc4random() % 3 + 5 maxMultiple:2];
                }
            }
            
            NSMutableArray<NSNumber *> *holdPairValues = [self getHoldPubPairValue:hp pp:pp]; // 获取手牌与公共牌组成对子的value
            // 手牌中只有一张与公共牌组成对子，说明另一对是在公共牌里的
            if (holdPairValues.count == 1) {
                // 大对
                if (holdPairValues[0] >= GAP_VALUE) {
                    return [self raiseByDiff:diff multiple:2 maxMultiple:50];
                }
                // 小对
                else {
                    return [self raiseByDiff:diff multiple:1 maxMultiple:30]; // TODO 加注还是跟注好？
                }
            }
            // 手牌中的两张分别与公共牌中的一张组成对子
            else if (holdPairValues.count == 2) {
                // 两对都是大对，加高倍注
                if (holdPairValues[0] >= GAP_VALUE
                        && holdPairValues[1] >= GAP_VALUE)
                    return [self raiseByDiff:diff multiple:5 maxMultiple:100];
                // 其中一个为大对，加中倍注
                else if (holdPairValues[0] >= GAP_VALUE
                        || holdPairValues[1] >= GAP_VALUE)
                    return [self raiseByDiff:diff multiple:3 maxMultiple:100];
                // 两对都是小对，加低倍注
                else
                    return [self raiseByDiff:diff multiple:1 maxMultiple:30];
            }
        }
        // 三条
        else if (power > (long) 4 * pow(10, 10)
                && power < (long) 5 * pow(10, 10)) {
            //诈唬
            if (arc4random() % 100 + 1 <= PROB_NUM + 10) {
                return [self raiseByDiff:diff multiple:1 maxMultiple:100];
            }
            
            // 手牌相等
            if (hp[0].value == hp[1].value) {
                return [self raiseByDiff:diff multiple:6 maxMultiple:100]; // 加高倍注
            }
            // 手牌不相等
            else {
                NSMutableArray<NSNumber *> *pairValues = [self getPubPairValue:pp];
                // 公共牌中有一对，说明三条中有两个是在公共牌里的
                if (pairValues.count == 1) {
                    if (pairValues[0] >= GAP_VALUE)
                        return [self raiseByDiff:diff multiple:6 maxMultiple:100];
                    else
                        return [self raiseByDiff:diff multiple:5 maxMultiple:100];
                }
                // 说明三条是出现在公共牌里
                else if (pairValues.count == 0) {
                    // 手牌都是大牌
                    if ([self isHoldBig:hp]) {
                        if (diff <=  LESS_MIDDLE_BET_MULTIPLE
                                * self.blind)
                            return [self raiseByDiff:diff multiple:2 maxMultiple:100];
                    } else if (hp[0].value >= GAP_VALUE
                            || hp[0].value >= GAP_VALUE) {
                        return [self raiseByDiff:diff multiple:1 maxMultiple:30];
                    } else
                        return [self callByDiff:diff maxMultiple:1];
                }
            }
        }
        // 顺子及以上
        else if (power > (long) 5 * pow(10, 10)) {
            //诈唬
            if (arc4random() % 100 + 1 <= PROB_NUM + 10) {
                return [self raiseByDiff:diff multiple:2 maxMultiple:100];
            }
            
            return [self raiseByDiff:diff multiple:8 maxMultiple:100];
        }
        // 一对
        else if (power > (long) 2 * pow(10, 10)
                && power < (long) 3 * pow(10, 10)) {
            //诈唬
            if (self.isTheLastOne && diff <= 0) {
                if (arc4random() % 100 + 1 <= PROB_NUM) {
                    return [self raiseByDiff:diff multiple:arc4random() % 3 + 3 maxMultiple:2];
                }
            }
            
            // 手牌是大对，加中倍注
            if ([self isHoldBigPair:hp])
                return [self raiseByDiff:diff multiple:1 maxMultiple:30];
            // 手牌是小对，跟注
            else if ([self isHoldSmallPair:hp]) {
                return [self callByDiff:diff maxMultiple:10];
            }
            else {
                NSMutableArray<NSNumber *> *pubPair = [self getPubPairValue:pp]; // 获取公共牌中的对子的值
                // 公共牌中有一对，说明手牌没有和公共牌中的某一张组成对子 ，这种情况跟高牌差不多
                if (pubPair.count == 1) {
                    if ([self isHoldBig:hp]) {
                        return [self callByDiff:diff maxMultiple:8];
                    }
                    // 手牌中有一个大牌
                    else if (hp[0].value >= GAP_VALUE
                            || hp[1].value >= GAP_VALUE) {
                        return [self callByDiff:diff maxMultiple:5];
                    }
                }
                // 说明手牌中的一张牌与公共牌中的一张牌组成对子
                else if (pubPair.count == 0) {
                    NSMutableArray<NSNumber *> *pairValues = [self getHoldPubPairValue:hp pp:pp]; // 在这里，pairValues中有且只有一个值
                    // 大对，加低倍注
                    if (pairValues[0] >= GAP_VALUE)
                        return [self raiseByDiff:diff multiple:1 maxMultiple:10];
                    // 小对，跟注
                    return [self callByDiff:diff maxMultiple:6];
                }
            }
        }
        // 同花或顺子差一张
        else if ([self computeFlush:hp publicPokers:pp] <= 1
                || [self computeStraight:hp publicPokers:pp] <= 1) {
          //诈唬
            if (self.isTheLastOne && diff <= 0) {
              
                if (arc4random() % 100 + 1 <= PROB_NUM) {
                    return [self raiseByDiff:diff multiple:arc4random() % 3 + 3 maxMultiple:2];
                }
            }
            
            if ([self isHoldBig:hp]) {
                return [self callByDiff:diff maxMultiple:5];
            }
            return [self callByDiff:diff maxMultiple:3];
        }
    
        // 高牌
        else if ([self isHoldBig:hp]) {
          //诈唬
            if (self.isTheLastOne && diff <= 0) {
                if (arc4random() % 100 + 1 <= PROB_NUM) {
                    return [self raiseByDiff:diff multiple:arc4random() % 3 + 3 maxMultiple:2];
                }
            }
            return [self callByDiff:diff maxMultiple:10];
        }
        //诈唬
        if (self.isTheLastOne && diff <= 0) {
           
            if (arc4random() % 100 + 1 <= PROB_NUM) {
                return [self raiseByDiff:diff multiple:arc4random() % 3 + 2 maxMultiple:2];
            
            }
        }
        
        return [self getResponse:diff jetton:0];
    }

    /**
     * 发出一张转牌之后思考策略
     *
     * @param betStatesb
     *            各玩家的当前押注状态
     * @return 押注策略 "check|call|raise num|all_in|fold"
     */
//    @Override
    - (NSString *)thinkAfterTurn:(NSArray<BetState *> *)betStates {
        NSMutableArray<Poker *> *hp = self.holdPokers;
        NSMutableArray<Poker *> *pp = self.publicPokers;
        MaxCardComputer *mmax = [[MaxCardComputer alloc] init];
        [mmax maxCardComputer:hp publicPokers:pp];
        CardGroup *maxGroup = mmax.maxGroup;

        int maxBet = [self getMaxBet:betStates];
        int selfBet = [self getSelfBet:betStates];
        int diff = (maxBet - selfBet);

        long power = maxGroup.power;
        
        // 两对
        if (power > (long) 3 * pow(10, 10)
                && power < (long) 4 * pow(10, 10)) {
          //诈唬
            if (self.isTheLastOne && diff <= self.blind) {
                
                if (arc4random() % 100 + 1 <= PROB_NUM) {
                    
                    return [self raiseByDiff:diff multiple:arc4random() % 3 + 5 maxMultiple:2];
                }
            }
            
            NSMutableArray<NSNumber *> *holdPairValues = [self getHoldPubPairValue:hp pp:pp];  // 获取手牌与公共牌组成对子的value
            // 手牌中只有一张与公共牌组成对子，说明另一对是在公共牌里的
            if (holdPairValues.count == 1) {
                // 大对
                if (holdPairValues[0] >= GAP_VALUE) {
                    return [self raiseByDiff:diff multiple:3 maxMultiple:30];
                }
                // 小对
                return [self raiseByDiff:diff multiple:1 maxMultiple:15]; // TODO 加注还是跟注好？
            }
            // 手牌中的两张分别与公共牌中的一张组成对子
            else if (holdPairValues.count == 2) {
                // 两对都是大对，加中倍注
                if (holdPairValues[0] >= GAP_VALUE
                        && holdPairValues[1] >= GAP_VALUE)
                    return [self raiseByDiff:diff multiple:6 maxMultiple:50];
                // 其中一个为大对，加低倍注
                else if (holdPairValues[0] >= GAP_VALUE
                        || holdPairValues[1] >= GAP_VALUE)
                    return [self raiseByDiff:diff multiple:3 maxMultiple:30];
                return [self raiseByDiff:diff multiple:1 maxMultiple:10];
            }
        }
        // 三条
        else if (power > (long) 4 * pow(10, 10)
                && power < (long) 5 * pow(10, 10)) {
          //诈唬
            if (arc4random() % 100 + 1 <= PROB_NUM + 10) {
                return [self raiseByDiff:diff multiple:3 maxMultiple:100];
            }
            
            // 手牌相等
            if (hp[0].value == hp[1].value) {
                if (hp[0].value >= GAP_VALUE)
                    return [self raiseByDiff:diff multiple:10 maxMultiple:100]; // 加高倍注
                else
                    return [self raiseByDiff:diff multiple:8 maxMultiple:100]; // 加中倍注
            }
            // 手牌不相等
            else {
                
                NSMutableArray<NSNumber *> *pairValues = [self getPubPairValue:pp];
                // 公共牌中有一对，说明三条中有两个是在公共牌里的
                if (pairValues.count == 1) {
                    if (pairValues[0] >= GAP_VALUE)
                        return [self raiseByDiff:diff multiple:8 maxMultiple:100];
                    else
                        return [self raiseByDiff:diff multiple:6 maxMultiple:100];
                }
                // 说明三条是出现在公共牌里
                else if (pairValues.count == 0) {
                    // 手牌都是大牌
                    if ([self isHoldBig:hp]) {
                        return [self callByDiff:diff maxMultiple:15];
                    }
                    return [self callByDiff:diff maxMultiple:1];
                }
            }
        }
        // 顺子及以上
        else if (power > (long) 5 * pow(10, 10)) {
//            return raiseByDiff(diff,  LESS_HIGH_RAISE_MULTIPLE); // 加高倍注
            //诈唬
            if (arc4random() % 100 + 1 <= PROB_NUM + 10) {
                return [self raiseByDiff:diff multiple:4 maxMultiple:100];
            }
            
            return [self raiseByDiff:diff multiple:15 maxMultiple:1000];
        }
        // 一对
        else if (power > (long) 2 * pow(10, 10)
                && power < (long) 3 * pow(10, 10)) {
          //诈唬
            if (self.isTheLastOne && diff <= 0) {
                 
                if (arc4random() % 100 + 1 <= PROB_NUM) {
                    return [self raiseByDiff:diff multiple:arc4random() % 3 + 5 maxMultiple:2];
                }
            }
            
            // 手牌是大对，加低倍注
            if ([self isHoldBigPair:hp])
                return [self raiseByDiff:diff multiple:2 maxMultiple:10];
            // 手牌是小对
            else if ([self isHoldSmallPair:hp]) {
                return [self callByDiff:diff maxMultiple:6];
            }
            else {
                NSMutableArray<NSNumber *> *pubPair = [self getPubPairValue:pp]; // 获取公共牌中的对子的值
                // 公共牌中有一对，说明手牌没有和公共牌中的某一张组成对子 ，这种情况跟高牌差不多
                if (pubPair.count == 1) {
                    if ([self isHoldBig:hp]) {
                        return [self callByDiff:diff maxMultiple:1];
                    }
                    // 手牌中有一个大牌
                    else if (hp[0].value >= GAP_VALUE
                            || hp[1].value >= GAP_VALUE) {
                        return [self callByDiff:diff maxMultiple:1];
                    }
                }
                // 说明手牌中的一张牌与公共牌中的一张牌组成对子
                else if (pubPair.count == 0) {
                    NSMutableArray<NSNumber *> *pairValues = [self getHoldPubPairValue:hp pp:pp]; // 在这里，pairValues中有且只有一个值
                    // 大对，加低倍注
                    if (pairValues[0] >= GAP_VALUE)
                        return [self raiseByDiff:diff multiple:1 maxMultiple:8];
                    // 小对，跟注
                    return [self callByDiff:diff maxMultiple:2];
                }
            }
        }
        
        // 同花或顺子差一张
        else if ([self computeFlush:hp publicPokers:pp] <= 1
                || [self computeStraight:hp publicPokers:pp] <= 1) {
            //诈唬
            if (self.isTheLastOne && diff <= 0) {
                 
                if (arc4random() % 100 + 1 <= PROB_NUM) {
                    return [self raiseByDiff:diff multiple:arc4random() % 3 + 5 maxMultiple:2];
                }
            }
            
            if ([self isHoldBig:hp]) {
                return [self callByDiff:diff maxMultiple:3];
            }
            return [self callByDiff:diff maxMultiple:1];
        }
    
        // 高牌
        else if ([self isHoldBig:hp]) {
          //诈唬
            if (self.isTheLastOne && diff <= 0) {
                 
                if (arc4random() % 100 + 1 <= PROB_NUM) {
                    return [self raiseByDiff:diff multiple:arc4random() % 3 + 5 maxMultiple:2];
                }
            }
            
            return [self callByDiff:diff maxMultiple:1];
        }
        //诈唬
        if (self.isTheLastOne && diff <= 0) {
             
            if (arc4random() % 100 + 1 <= PROB_NUM) {
                return [self raiseByDiff:diff multiple:arc4random() % 3 + 2 maxMultiple:2];
            }
        }
        
        return [self getResponse:diff jetton:0];
    }

    /**
     * 发出一张河牌之后思考策略
     *
     * @param betStates
     *            各玩家的当前押注状态
     * @return 押注策略 "check|call|raise num|all_in|fold"
     */
//    @Override
    - (NSString *)thinkAfterRiver:(NSArray<BetState *> *)betStates {
        NSMutableArray<Poker *> *hp = self.holdPokers;
        NSMutableArray<Poker *> *pp = self.publicPokers;
        MaxCardComputer *mmax = [[MaxCardComputer alloc] init];
        [mmax maxCardComputer:hp publicPokers:pp];
        CardGroup *maxGroup = mmax.maxGroup;

        int maxBet = [self getMaxBet:betStates];
        int selfBet = [self getSelfBet:betStates];
        int diff = (maxBet - selfBet);

        long power = maxGroup.power;
        // 两对
        if (power > (long) 3 * pow(10, 10)
                && power < (long) 4 * pow(10, 10)) {
            NSMutableArray<NSNumber *> *holdPairValues = [self getHoldPubPairValue:hp pp:pp]; // 获取手牌与公共牌组成对子的value
            // 手牌中只有一张与公共牌组成对子，说明另一对是在公共牌里的
            //诈唬
            if (self.isTheLastOne && diff <= 0) {
                 
                if (arc4random() % 100 + 1 <= PROB_NUM) {
                    return [self raiseByDiff:diff multiple:arc4random() % 3 + 3 maxMultiple:2];
                }
            }
            
            if (holdPairValues.count == 1) {
                // 大对
                if (holdPairValues[0] >= GAP_VALUE) {
                    return [self raiseByDiff:diff multiple:5 maxMultiple:30];
                }
                // 小对
                return [self raiseByDiff:diff multiple:3 maxMultiple:5]; // TODO 加注还是跟注好？
            }
            // 手牌中的两张分别与公共牌中的一张组成对子
            else if (holdPairValues.count == 2) {
                // 两对都是大对，加中倍注
                if (holdPairValues[0] >= GAP_VALUE
                        && holdPairValues[1] >= GAP_VALUE)
                    return [self raiseByDiff:diff multiple:10 maxMultiple:50];
                // 其中一个为大对，加低倍注
                else if (holdPairValues[0] >= GAP_VALUE
                        || holdPairValues[1] >= GAP_VALUE)
                    return [self raiseByDiff:diff multiple:5 maxMultiple:30];
                return [self raiseByDiff:diff multiple:3 maxMultiple:15];
            }
        }
        // 三条
        else if (power > (long) 4 * pow(10, 10)
                && power < (long) 5 * pow(10, 10)) {
            // 手牌相等
            if (hp[0].value == hp[1].value) {
                if (hp[0].value >= GAP_VALUE)
                    return [self raiseByDiff:diff multiple:15 maxMultiple:50]; // 加高倍注
                else
                    return [self raiseByDiff:diff multiple:12 maxMultiple:30]; // 加中倍注
            }
            // 手牌不相等
            else {
                NSMutableArray<NSNumber *> *pairValues = [self getPubPairValue:pp];
                // 公共牌中有一对，说明三条中有两个是在公共牌里的
                if (pairValues.count == 1) {
                    if (pairValues[0] >= GAP_VALUE)
                        return [self raiseByDiff:diff multiple:15 maxMultiple:50];
                    else
                        return [self raiseByDiff:diff multiple:10 maxMultiple:30];
                }
                // 说明三条是出现在公共牌里
                else if (pairValues.count == 0) {
                    // 手牌都是大牌
                    if ([self isHoldBig:hp]) {
                        return [self callByDiff:diff maxMultiple:6];
                    }
                    return [self callByDiff:diff maxMultiple:1];
                }
            }
        }
        // 顺子及以上
        else if (power > (long) 5 * pow(10, 10)) {
//            return raiseByDiff(diff,  LESS_HIGH_RAISE_MULTIPLE); // 加高倍注
            
            return [self raiseByDiff:diff multiple:15 maxMultiple:100];
        }
        // 一对
        else if (power > (long) 2 * pow(10, 10)
                && power < (long) 3 * pow(10, 10)) {
            //诈唬
            if (self.isTheLastOne && diff <= 0) {
                 
                if (arc4random() % 100 + 1 <= PROB_NUM) {
                    return [self raiseByDiff:diff multiple:arc4random() % 3 + 5 maxMultiple:2];
                }
            }
            // 手牌是大对，加低倍注
            if ([self isHoldBigPair:hp])
                return [self raiseByDiff:diff multiple:2 maxMultiple:20];
            // 手牌是小对
            else if ([self isHoldSmallPair:hp]) {
                return [self callByDiff:diff maxMultiple:5];
            }
            else {
                NSMutableArray<NSNumber *> *pubPair = [self getPubPairValue:pp]; // 获取公共牌中的对子的值
                // 公共牌中有一对，说明手牌没有和公共牌中的某一张组成对子 ，这种情况跟高牌差不多
                if (pubPair.count == 1) {
                    return [self callByDiff:diff maxMultiple:4];
                }
                // 说明手牌中的一张牌与公共牌中的一张牌组成对子
                else if (pubPair.count == 0) {
//                    ArrayList<Integer> pairValues = self.getHoldPubPairValue(
//                            hp, pp); // 在这里，pairValues中有且只有一个值
//                    // 大对，加低倍注
//                    if (pairValues[0] >= GAP_VALUE)
//                        return raiseByDiff(diff,
//                                 LESS_LOW_RAISE_MULTIPLE);
//                    // 小对，跟注
//                    else if (diff <=  LESS_MIDDLE_BET_MULTIPLE * self.blind)
                    return [self callByDiff:diff maxMultiple:3];
                }
            }
        }
        //诈唬
        if (self.isTheLastOne && diff <= 0) {
           
            if (arc4random() % 100 + 1 <= 50) {
                return  [self raiseByDiff:diff multiple:arc4random() % 3 + 2 maxMultiple:2];
            }
        }
        return [self getResponse:diff jetton:0];
    }

    /**
     * 判断手牌是否是大对：AA, KK, QQ, JJ, 1010等
     *
     * @param hp
     *            手牌
     * @return 大对返回true, 否则返回false
     */
    - (BOOL)isHoldBigPair:(NSArray<Poker *> *)hp {
        // 避免出错
        if (hp == nil || hp.count < 2)
            return false;
        // 手牌是大对：AA, KK, QQ, JJ, 1010等
        else if (hp[0].value == hp[1].value
                && hp[0].value >= 10)
            return true;
        return false;
    }

    /**
     * 判断手牌是否是小对：2~9中的一对
     *
     * @param hp
     *            手牌
     * @return 小对返回true，否则返回false
     */
    - (BOOL)isHoldSmallPair:(NSArray<Poker *> *)hp {
        // 避免出错
        if (hp == nil || hp.count < 2)
            return false;
        // 手牌是大对：AA, KK, QQ, JJ, 1010等
        else if (hp[0].value == hp[1].value
                && hp[0].value < 10)
            return true;
        return false;
    }

    /**
     * 计算当前牌组成同花最少还差多少张
     *
     * @param backPokers
     * @param publicPokers
     * @return
     */
  
-(int)computeFlush:(NSArray<Poker *> *)holdPokers
publicPokers:(NSArray<Poker *> *)publicPokers {
    NSMutableArray<NSNumber *> *count = [NSMutableArray arrayWithArray: @[
        @(0),@(0),@(0),@(0),@(0)]];
    
    
    for (Poker *p in holdPokers) {
        switch (p.colorTyp) {
            case SPADES: {
                NSInteger AA = [count[0] integerValue];
                AA++;
            }
            break;
        case HEARTS:
            {
                NSInteger AA = [count[1] integerValue];
                AA++;
            }
            break;
        case CLUBS:
            {
                NSInteger AA = [count[2] integerValue];
                AA++;
            }
            break;
        case DIAMONDS:
            {
                NSInteger AA = [count[3] integerValue];
                AA++;
            }
            break;
        }
    }
    for (Poker *p in publicPokers) {
        switch (p.colorTyp) {
        case SPADES:
            {
                NSInteger AA = [count[0] integerValue];
                AA++;
            }
            break;
        case HEARTS:
            {
                NSInteger AA = [count[1] integerValue];
                AA++;
            }
            break;
        case CLUBS:
            {
                NSInteger AA = [count[2] integerValue];
                AA++;
            }
            break;
        case DIAMONDS:
            {
                NSInteger AA = [count[3] integerValue];
                AA++;
            }
            break;
        }
    }

    int maxCount = 0;
    for (int i = 0; i < count.count; i++)
        if (count[i] > maxCount)
            maxCount = count[i];
    return 5 - maxCount;
}



    /**
     * 计算当前牌组成顺子最少需要多少张牌
     *
     * @param holdPokers
     * @param publicPokers
     * @return
     */
-(int)computeStraight:(NSArray<Poker *> *)holdPokers
publicPokers:(NSArray<Poker *> *)publicPokers {
    NSMutableArray<NSNumber *> *visited = [NSMutableArray arrayWithArray: @[
        @(0),@(0),@(0),@(0),@(0),
        @(0),@(0),@(0),@(0),@(0),
        @(0),@(0),@(0),@(0),@(0)]];
     

    // 将所有出现的牌值标记
    
    for (Poker *poker in holdPokers) {
        if (poker.value == 14) {
           NSInteger temp1 = [visited[1] integerValue];
            NSInteger temp14 = [visited[14] integerValue];
            temp1 = temp14 = true;
//                visited[1] = visited[14] = true;
        } else {
            NSInteger temp1 = [visited[poker.value] integerValue];
             temp1  = true;
//                visited[poker.value] = true;
        }
    }
    for (Poker *poker in publicPokers) {
        if (poker.value == 14) {
            NSInteger temp1 = [visited[1] integerValue];
             NSInteger temp14 = [visited[14] integerValue];
             temp1 = temp14 = true;
            
//                visited[1] = visited[14] = true;
        } else {
            NSInteger temp1 = [visited[poker.value] integerValue];
             temp1  = true;
//                visited[poker.value] = true;
        }
    }
    int maxCount = 0;
    for (int i = 1; i <= 10; i++) {
        int count = 0;
        for (int j = 0; j < 5; j++) {
            if (visited[i + j]) {
                count++;
            }
        }
        if (count > maxCount) {
            maxCount = count;
        }
    }

    return 5 - maxCount;
}


@end
