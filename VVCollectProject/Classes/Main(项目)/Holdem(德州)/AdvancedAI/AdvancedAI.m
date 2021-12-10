//
//  AdvancedAI.m
//  VVCollectProject
//
//  Created by Admin on 2021/12/11.
//  Copyright © 2021 Mike. All rights reserved.
//

#import "AdvancedAI.h"
#import "CardGroup.h"
#import "MaxCardComputer.h"
#import "BetState.h"


@interface AdvancedAI ()
/// 用来计算fold的局数
@property (nonatomic, assign) NSInteger foldCounter;
@end

@implementation AdvancedAI


    -(NSString *)fold:(NSMutableArray<BetState *> *)betStates {
//        String colors[] = { "SPADES", // 黑桃
//                "HEARTS", // 红桃
//                "CLUBS", // 梅花
//                "DIAMONDS" // 方片
//        };
//        String logName = "/home/wenzhu/area/fold_log.txt";
//        try {
//            FileWriter writer = new FileWriter(logName, true);
//            foldCounter ++;
//            writer.write("fold " + Integer.toString(foldCounter) + "\n");
//            writer.write("Current Hand Number: " + Integer.toString(self.getHandNum()) + "\n");
//            writer.write("Hold pokers:\n");
//            NSMutableArray<Poker *> *hp = self.holdPokers;
//            for (int i = 0; i < hp.count; i++)
//                writer.write(colors[getIndex(hp[i].colorTyp)] + " "
//                        + hp[i].getValue() + "\n");
//
//            writer.write("Public pokers:\n");
//            NSMutableArray<Poker *> *pp = self.publicPokers;
//            for (int i = 0; i < pp.count; i++)
//                writer.write(colors[getIndex(pp[i].colorTyp)] + " "
//                        + pp[i].getValue() + "\n");
//
//            int maxBet = [self getMaxBet:betStates];
//            int selfBet = [self getSelfBet:betStates];
//            int diff = maxBet - selfBet;
//            writer.write("MaxBet: " + Integer.toString(maxBet) + "\n");
//            writer.write("SelfBet " + Integer.toString(selfBet) + "\n");
//            writer.write("Diff: " + Integer.toString(diff) + "\n");
//            writer.write("Rest Jetton: "
//                    + Integer.toString(self.totalJetton) + "\n");
//            writer.write("Rest Money: "
//                    + Integer.toString(self.getTotalMoney()) + "\n");
//            writer.write("Money and Jetton: "
//                    + Integer.toString(self.getTotalMoneyAndJetton()) + "\n");
//            writer.close();
//        } catch (IOException e) {
//            e.printStackTrace();
//        } finally {
//        }
        return @"fold";
    }

//    @Override
    -(NSString *)thinkAfterHold:(NSMutableArray<BetState *> *)betStates {
        NSMutableArray<Poker *> *hp = self.holdPokers;

        // 计算自己与最大押注的差距，得出需要押注的大小
        int maxBet = [self getMaxBet:betStates];
        int selfBet = [self getSelfBet:betStates];
        int diff = (maxBet - selfBet);

        int maxBlindBet = HIGH_BET_MULTIPLE * self.blind; // 可接受（跟注）最大下注筹码
        int midBlindBet = MIDDLE_BET_MULTIPLE * self.blind; // 可接受（跟注）中等下注筹码

        // 如果手牌是大对：AA, KK, QQ, JJ, 1010等
        if ([self isHoldBigPair:hp]) {
            int raise_bet = LOW_RAISE_MULTIPLE * self.blind;
            // 如果需要加注的筹码小于"BLIND_RAISE_MULTIPLE * 盲注金额"， 则自己加注至
            // "BLIND_RAISE_MULTIPLE * 盲注金额"
            if (diff < raise_bet) {
                if (raise_bet - diff > self.totalJetton)
                    return @"all_in";
                else
                    
                    return [NSString stringWithFormat:@"raise%zd",raise_bet - diff];
            }
            // 如果需要加注的筹码大于"BLIND_RAISE_MULTIPLE * 盲注金额"时，不加注，但跟注
            else
                return [self callByDiff:diff];
            
        }
        // 其它牌的情况，如果需要下注超过可打接受最大下注金额，弃牌
        else if (diff >= maxBlindBet)
            return [self fold:betStates];
        // 需要跟注的筹码大于剩余总金币与筹码的一个比例时则弃牌(相对于剩余的金币与筹码来说，下注太多了，比较保守的做法的就是弃牌)
        // else if (diff * MAX_TOTAL_MULTIPLE > this
        // .getTotalMoneyAndJetton())
        // return [self fold:betStates];
        // 手牌是小对：2~9中的一对
        else if ([self isHoldSmallPair:hp]) {
            // 如果需要下注小于可接受最大下注金额，则跟注
            if (diff <= maxBlindBet)
                return [self callByDiff:diff];
        }
        // 手牌不相等且都大于GAP_VALUE
        else if ([self isHoldBig:hp]) {
            // 如果需要下注小于可接受中等下注金额，则跟注
            if (diff <= midBlindBet)
                return [self callByDiff:diff];
            else
                return [self fold:betStates];
        }
        // 手牌其中有一个大于GAP_VALUE
        else if (hp[0].value >= GAP_VALUE
                || hp[0].value >= GAP_VALUE) {
            // 如果需要下注小于可接受中等下注金额且(手牌同花色(有可能组成同花)或者相差小于4(有可能组成顺子))
            if (diff <= midBlindBet) {
                if ([self isHoldSameColor:hp]
                        || [self isHoldLessThanFour:hp]
                        || (hp[0].value >= 11 || hp[1].value >= 11))
                    return [self callByDiff:diff];
            } else
                return [self fold:betStates];
        }
        return [self fold:betStates];
    }

    /**
     * 判断手牌是否相差小于等于4(有可能组成顺子)
     *
     * @param hp
     * @return
     */
    - (BOOL)isHoldLessThanFour:(NSMutableArray<Poker *> *)hp {
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
    - (BOOL)isHoldBig:(NSMutableArray<Poker *> *)hp {
        if (hp[0].value >= GAP_VALUE
                && hp[1].value >= GAP_VALUE)
            return true;
        return false;
    }

    - (BOOL)isHoldSmall:(NSMutableArray<Poker *> *)hp {
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
    - (BOOL)isHoldSameColor:(NSMutableArray<Poker *> *)hp {
        if (hp[0].colorTyp == hp[1].colorTyp)
            return true;
        return false;
    }

    /**
     * 跟注
     *
     * @param diff
     * @return
     */
-(NSString *)callByDiff:(int)diff {
        // 不需要跟注的时候，则让牌(check)
        if (diff == 0)
            return @"check";
        // 剩余筹码足够，则跟注
        else if (diff < self.totalJetton)
            return @"call";
        // 剩余筹码不够，则全押
        else
            return @"all_in";
    }

    /**
     * 获取本手牌已下注的玩家下的最大注
     *
     * @param betStates
     * @return
     */
    -(int)getMaxBet:(NSMutableArray<BetState *> *)betStates {
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
    -(int)getSelfBet:(NSMutableArray<BetState *> *)betStates {
        for (int i = 0; i < betStates.count; i++) {
           NSString *ID = betStates[i].playerID;
            if ([ID isEqualToString: self.playerID])
                return betStates[i].bet;
        }
        return 0;
    }

    /**
     * 发出三张公共牌之后思考策略
     *
     * @param betStates
     *            各玩家的当前押注状态
     * @return 押注策略 "check|call|raise num|all_in|fold"
     */
//    @Override
    -(NSString *)thinkAfterFlop:(NSMutableArray<BetState *> *)betStates {
        NSMutableArray<Poker *> *hp = self.holdPokers;
        NSMutableArray<Poker *> *pp = self.publicPokers;
        MaxCardComputer *mmax = [[MaxCardComputer alloc] init];
        [mmax maxCardComputer:hp publicPokers:pp];
        CardGroup *maxGroup = mmax.maxGroup;

        
        int maxBet = [self getMaxBet:betStates];
        int selfBet = [self getSelfBet:betStates];
        int diff = (maxBet - selfBet);
        
        long power = maxGroup.power;
        // 一对
        if (power > (long) 2 * pow(10, 10)
                && power < (long) 3 * pow(10, 10)) {
            // 手牌是大对
            if ([self isHoldBigPair:hp])
               
                return [self callByDiff:diff];
            // 手牌是小对
            else if ([self isHoldSmallPair:hp]) {
                if (diff <= HIGH_BET_MULTIPLE * self.blind)
                    return [self callByDiff:diff];
                else
                    return [self fold:betStates];
            }
            // 手牌不是对，说明公共牌有一对
            else {
                if (hp[0].value >= GAP_VALUE
                        || hp[1].value >= GAP_VALUE) {
                    if (diff < MIDDLE_BET_MULTIPLE * self.blind)
                        return [self callByDiff:diff];
                    else
                        return [self fold:betStates];
                }
                // 两张牌都是小牌
                else if (diff <= LOW_BET_MULTIPLE)
                    return [self callByDiff:diff];
                else
                    return [self fold:betStates];
            }
        }
        // 两对
        else if (power > (long) 3 * pow(10, 10)
                && power < (long) 4 * pow(10, 10)) {
            // 手牌是大对，说明另一对是公共牌中出现的，这种情况相当于只有一对
            if ([self isHoldBigPair:hp]) {
                if (diff >= HIGH_BET_MULTIPLE * self.blind) {
                    // 剩余金币与筹码还比较多，使用比较积极的打法
                    if (diff * MAX_TOTAL_MULTIPLE < [self getTotalMoneyAndJetton])
                        return [self callByDiff:diff];
                    else
                        return [self fold:betStates];
                }
                return [self callByDiff:diff];
            }
            // 手牌是小对
            else if ([self isHoldSmallPair:hp]) {
                if (diff <= MIDDLE_BET_MULTIPLE * self.blind)
                    return [self callByDiff:diff];
                else
                    return [self fold:betStates];
            }
            // 手牌不相等，说明此时是与公共牌中的两张牌组成两对
            else {
                // 两对都是大对
                if ([self isHoldBig:hp]) {
                    return [self raiseByDiff:diff multiple:HIGH_RAISE_MULTIPLE];
                }
                // 其中一个是大对
                else if (hp[0].value >= GAP_VALUE
                        || hp[1].value >= GAP_VALUE) {
                    return [self raiseByDiff:diff multiple:MIDDLE_RAISE_MULTIPLE];
                }
                // 两对都是小对
                else {
                    if (diff <= HIGH_BET_MULTIPLE * self.blind)
                        return [self callByDiff:diff];
                    else
                        return [self fold:betStates];
                }
            }
        }
        // 三条
        else if (power > (long) 4 * pow(10, 10)
                && power < (long) 5 * pow(10, 10)) {
            // 手牌相等
            if (hp[0].value == hp[1].value) {
                return [self raiseByDiff:diff multiple:HIGH_RAISE_MULTIPLE]; // 加高倍注
            }
            // 手牌不相等，说明三条中的两个是在公共牌里的
            else {
                return [self raiseByDiff:diff multiple:MIDDLE_RAISE_MULTIPLE]; // 加中倍注
            }
        }
        // 顺子及以上
        else if (power > (long) 5 * pow(10, 10)) {
            return [self raiseByDiff:diff multiple:HIGH_RAISE_MULTIPLE]; // 加高倍注
        }
        
        // 在当前剩余金币与筹码总和下，下注太多，弃牌
        if (diff * MAX_TOTAL_MULTIPLE > [self getTotalMoneyAndJetton])
            return [self fold:betStates];
        // 同花或顺子差一张
        else if ([self computeFlush:hp publicPokers:pp] <= 1
                || [self computeStraight:hp publicPokers:pp] <= 1) {
            if (diff <= MIDDLE_BET_MULTIPLE * self.blind)
                return [self callByDiff:diff];
            else
                return [self fold:betStates];
        }
        // 高牌
        else if ([self isHoldBig:hp]) {
            if (diff <= LOW_BET_MULTIPLE * self.blind)
                return [self callByDiff:diff];
            else
                return [self fold:betStates];
        } else if (diff == 0)
            return @"check";
        return [self fold:betStates];
    }

    /**
     * 加注：加注金额为mutiple * blind
     *
     * @param diff
     *            根据前面玩家下注，需要跟注的最小数量
     * @param multiple
     * @return
     */
-(NSString *)raiseByDiff:(int)diff  multiple:(int)multiple {
    if (diff < multiple * self.blind) {
        NSString *str = [NSString stringWithFormat:@"raise %zd", multiple * self.blind - diff];
        return str;
    } else
            return @"call";
    }

    /**
     * 发出一张转牌之后思考策略
     *
     * @param betStates
     *            各玩家的当前押注状态
     * @return 押注策略 "check|call|raise num|all_in|fold"
     */
//    @Override
    -(NSString *)thinkAfterTurn:(NSMutableArray<BetState *> *)betStates {
        
        return [self thinkAfterFlop:betStates];
        // NSMutableArray<Poker *> *hp = self.holdPokers;
        // NSMutableArray<Poker *> *pp = self.publicPokers;
        // MaxCardComputer *mmax = [[MaxCardComputer alloc] init];
//        [mmax maxCardComputer:hp publicPokers:pp];
//        CardGroup *maxGroup = mmax.maxGroup;
        //
        // int diff = self.computeDifference(betStates);
        // int bet = 0;
        // if (maxGroup.getPower() > (long) 3 * pow(10, 10)) {
        // // 两对及两对以上
        // if (diff >= self.totalJetton)
        // return "all_in";
        // else if (diff == 0)
        // return "raise " + 3 * self.blind;
        // else
        // return "call";
        // } else if ([self computeFlush:hp publicPokers:pp] <= 1
        // || [self computeStraight:hp publicPokers:pp] <= 1) {
        // // 同花或顺子差一张
        // if (diff >= 5 * self.blind)
        // return [self fold:betStates];
        // else if (diff == 0)
        // return "check";
        // else if (diff > self.totalJetton)
        // return "all_in";
        // else
        // return "call";
        // } else if (self.isOneMaxPair(maxGroup, hp)) {
        // // 最大对子
        // if (diff >= 3 * self.blind)
        // return [self fold:betStates];
        // else if (diff == 0)
        // return "check";
        // else if (diff > self.totalJetton)
        // return "all_in";
        // else
        // return "call";
        // } else {
        // if (diff == 0)
        // return "check";
        // else
        // return [self fold:betStates];
        // }
        
        
    }

    /**
     * 发出一张河牌之后思考策略
     *
     * @param betStates
     *            各玩家的当前押注状态
     * @return 押注策略 "check|call|raise num|all_in|fold"
     */
//    @Override
    -(NSString *)thinkAfterRiver:(NSMutableArray<BetState *> *)betStates {
        return  [self thinkAfterFlop:betStates];
//        return [self computeStraight:hp publicPokers:pp]
        
        // NSMutableArray<Poker *> *hp = self.holdPokers;
        // NSMutableArray<Poker *> *pp = self.publicPokers;
        // MaxCardComputer *mmax = [[MaxCardComputer alloc] init];
//        [mmax maxCardComputer:hp publicPokers:pp];
//        CardGroup *maxGroup = mmax.maxGroup;
        //
        // int diff = self.computeDifference(betStates);
        // int bet = 0;
        // if (maxGroup.getPower() > (long) 3 * pow(10, 10)) {
        // // 两对及两对以上
        // if (diff >= self.totalJetton)
        // return "all_in";
        // else if (diff == 0)
        // return "raise " + 3 * self.blind;
        // else
        // return "call";
        // } else if ([self computeFlush:hp publicPokers:pp] <= 1
        // || [self computeStraight:hp publicPokers:pp] <= 1) {
        // // 同花或顺子差一张
        // if (diff >= 5 * self.blind)
        // return [self fold:betStates];
        // else if (diff == 0)
        // return "check";
        // else if (diff > self.totalJetton)
        // return "all_in";
        // else
        // return "call";
        // } else if (self.isOneMaxPair(maxGroup, hp)) {
        // // 最大对子
        // if (diff >= 3 * self.blind)
        // return [self fold:betStates];
        // else if (diff == 0)
        // return "check";
        // else if (diff > self.totalJetton)
        // return "all_in";
        // else
        // return "call";
        // } else {
        // if (diff == 0)
        // return "check";
        // else
        // return [self fold:betStates];
        // }
    }

    /**
     * 计算自己与其他押最大注玩家的差距，用于决定自己押注的多少
     *
     * @param betStates
     * @return
     */
    -(int)computeDifference:(NSMutableArray<BetState *> *)betStates {
        int maxBet = 0, selfBet = 0;
        for (int i = 0; i < betStates.count; i++) {
            if (betStates[i].bet > maxBet)
                maxBet = betStates[i].bet;
            if (betStates[i].playerID == self.playerID)
                selfBet = betStates[i].bet;
        }
        return maxBet - selfBet;
    }

    /**
     * 判断手牌是否是大对：AA, KK, QQ, JJ, 1010等
     *
     * @param hp
     *            手牌
     * @return 大对返回true, 否则返回false
     */
    - (BOOL)isHoldBigPair:(NSMutableArray<Poker *> *)hp {
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
    - (BOOL)isHoldSmallPair:(NSMutableArray<Poker *> *)hp {
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
     * 根据两张底牌判断是否应该弃牌
     *
     * @param holdPokers
     * @return
     */
    - (BOOL)shouldFold:(NSMutableArray<Poker *> *)hp {
        int v1 = hp[0].value;
        int v2 = hp[1].value;
        // 两张牌都小于10且不可能组成顺子，弃牌
        if ((v1 < 10 && v2 < 10) && abs(v1 - v2) > 4)
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

    /**
     * 如果为一对，判断是否为最大对
     *
     * @param group
     * @return
     */
- (BOOL)isOneMaxPair:(CardGroup *)group hp:(NSMutableArray<Poker *> *)hp {
        if ((group.power / (long) pow(10, 10)) != 2) {
            return false;
        }
        BOOL flag = false;
        for (Poker *poker in hp) {
            if (poker.value == group.pokers[0].value) {
                flag = true;
                break;
            }
        }

        return flag;
    }

@end
