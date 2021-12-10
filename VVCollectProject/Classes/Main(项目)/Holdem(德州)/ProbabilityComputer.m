//
//  ProbabilityComputer.m
//  VVCollectProject
//
//  Created by Admin on 2021/12/11.
//  Copyright © 2021 Mike. All rights reserved.
//

#import "ProbabilityComputer.h"
#import "MaxCardComputer.h"
#import "CardGroup.h"

@implementation ProbabilityComputer

/**
     * 赢牌(大于或等于一个玩家)的概率
     * 只能在flop, turn, river三个环节使用
     * 考虑到性能问题，flop和turn环节的概率并不为精确概率
     * @param holds
     * @param publics
     * @return
     */
-(CGFloat)computeProbability:(NSArray<Poker *> *)holds publics:(NSArray<Poker *> *)publics {
            
        if (publics.count == 3)
            return [self computeFlopProb:holds publics:publics];
        else if (publics.count == 4)
            return [self computeTurnProb:holds publics:publics];
        else if (publics.count == 5)
            return [self computeRiverProb:holds publics:publics];
        else
            return 0;
    }
    
    
    /**
     * 赢牌(大于或等于所有活跃玩家)的概率
     * 只能在flop, turn, river三个环节使用
     * 考虑到性能问题，flop和turn环节的概率并不为精确概率
     * @param holds
     * @param publics
     * @return
     */
-(CGFloat)computeProbability:(int)activePlayerNum
                       holds:(NSArray<Poker *> *)holds publics:(NSArray<Poker *> *)publics {
        float prob = 0;
        if (publics.count == 3)
            
            prob = [self computeFlopProb:holds publics:publics];
        else if (publics.count == 4)
            prob = [self computeTurnProb:holds publics:publics];
        else if (publics.count == 5)
            prob = [self computeRiverProb:holds publics:publics];
        else
            prob = 0;
        float res = 1;
        for (int i = 0; i < activePlayerNum - 1; i++)
            res *= prob;
        return res;
    }
    
-(CGFloat)computeFlopProb:(NSArray<Poker *> *)holds publics:(NSArray<Poker *> *)publics {
                
    MaxCardComputer *newMaxCardComputer = [[MaxCardComputer alloc] init];
    [newMaxCardComputer maxCardComputer:holds publicPokers:publics];
    long selfPower =newMaxCardComputer.maxGroup.power;
    
    
    NSMutableArray<Poker *> *otherHolds = [NSMutableArray array];
    
        int count = 0;
    
    
        for (int c1 = 0; c1 <= 3; c1++) {
            for (int v1 = 2; v1 <= 14; v1++) {
                
                
                Poker *poker1 = [[Poker alloc] init];
                poker1.colorTyp = c1;
                poker1.value = v1;
                
                if ([self existed:poker1 holds:holds publics:publics])
                    continue;
                
                [otherHolds addObject:poker1];
                for (int c2 = 0; c2 <= 3; c2++) {
                    for (int v2 = 2; v2 <= 14; v2++) {
                        Poker *poker2 = [[Poker alloc] init];
                        poker2.colorTyp = c2;
                        poker2.value = v2;
                        
                        if ([self existed:poker2 holds:holds publics:publics] ||
                                (c2 == c1 && v2 == v1))
                            continue;
                        [otherHolds addObject:poker2];
                        
                        MaxCardComputer *new2MaxCardComputer = [[MaxCardComputer alloc] init];
                        [new2MaxCardComputer maxCardComputer:otherHolds publicPokers:publics];
                        long power =new2MaxCardComputer.maxGroup.power;
                        if (selfPower >= power)
                            count++;
                        
                        [otherHolds removeObject:poker2];
                    }
                }
                
                [otherHolds removeObject:poker1];
            }
        }
        return (float) count / (47 * 46);
    }
    
-(CGFloat)computeTurnProb:(NSArray<Poker *> *)holds publics:(NSArray<Poker *> *)publics {
        MaxCardComputer *newMaxCardComputer = [[MaxCardComputer alloc] init];
    [newMaxCardComputer maxCardComputer:holds publicPokers:publics];
    long selfPower =newMaxCardComputer.maxGroup.power;
        
    NSMutableArray<Poker *> *otherHolds = [NSMutableArray array];
    
        int count = 0;
        for (int c1 = 0; c1 <= 3; c1++) {
            for (int v1 = 2; v1 <= 14; v1++) {
                Poker *poker1 = [[Poker alloc] init];
                poker1.colorTyp = c1;
                poker1.value = v1;
                if ([self existed:poker1 holds:holds publics:publics])
                    continue;
                [otherHolds addObject:poker1];
                
                MaxCardComputer *computer1 = [[MaxCardComputer alloc] init];
                [computer1 maxCardComputer:otherHolds publicPokers:publics];
                
                for (int c2 = 0; c2 <= 3; c2++) {
                    for (int v2 = 2; v2 <= 14; v2++) {
                        Poker *poker2 = [[Poker alloc] init];
                        poker2.colorTyp = c2;
                        poker2.value = v2;
                        if ([self existed:poker2 holds:holds publics:publics] ||
                                (c2 == c1 && v2 == v1))
                            continue;
                        [otherHolds addObject:poker2];
                        
                        MaxCardComputer *maxC11 = [[MaxCardComputer alloc] init];
                        [maxC11 maxCardComputer:computer1 poker:poker2];
                        long power = maxC11.maxGroup.power;
                        
                        if (selfPower >= power)
                            count++;
                        [otherHolds removeObject:poker2];
                    }
                }
                [otherHolds removeObject:poker1];
            }
        }
        return (float) count / (46 * 45);
    }
    
-(CGFloat)computeRiverProb:(NSArray<Poker *> *)holds publics:(NSArray<Poker *> *)publics {
        MaxCardComputer *newMaxCardComputer = [[MaxCardComputer alloc] init];
    [newMaxCardComputer maxCardComputer:holds publicPokers:publics];
    long selfPower =newMaxCardComputer.maxGroup.power;
    NSMutableArray<Poker *> *otherHolds = [NSMutableArray array];
    
    MaxCardComputer *computer = [[MaxCardComputer alloc] init];
    [computer maxCardComputer:otherHolds publicPokers:publics];
    
        int count = 0;
        for (int c1 = 0; c1 <= 3; c1++) {
            for (int v1 = 2; v1 <= 14; v1++) {
                Poker *poker1 = [[Poker alloc] init];
                poker1.colorTyp = c1;
                poker1.value = v1;
                if ([self existed:poker1 holds:holds publics:publics])
                    continue;
                
                MaxCardComputer *computer1 = [[MaxCardComputer alloc] init];
                [computer1 maxCardComputer:computer poker:poker1];
                for (int c2 = 0; c2 <= 3; c2++) {
                    for (int v2 = 2; v2 <= 14; v2++) {
                        Poker *poker2 = [[Poker alloc] init];
                        poker2.colorTyp = c2;
                        poker2.value = v2;
                        if ([self existed:poker2 holds:holds publics:publics] ||
                                (c2 == c1 && v2 == v1))
                            continue;
                        MaxCardComputer *maxC11 = [[MaxCardComputer alloc] init];
                        [maxC11 maxCardComputer:computer1 poker:poker2];
                        long power = maxC11.maxGroup.power;
                        if (selfPower >= power)
                            count++;
                    }
                }
            }
        }
        return (float) count / (45 * 44);
    }
    
    /**
     * 判断poker牌是否已经出现过
     * @param poker
     * @param holds
     * @param publics
     * @return
     */
-(BOOL)existed:(Poker *)poker holds:(NSArray<Poker *> *)holds publics:(NSArray<Poker *> *)publics {
    for (Poker *p in holds) {
            if (poker.colorTyp == p.colorTyp &&
                    poker.value == p.value)
                return true;
        }
    for (Poker *p in publics) {
        if (poker.colorTyp == p.colorTyp &&
                poker.value == p.value)
                return true;
        }
        return false;
    }

@end


