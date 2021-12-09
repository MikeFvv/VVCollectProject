//
//  CardGroup.m
//  VVCollectProject
//
//  Created by Admin on 2021/12/10.
//  Copyright © 2021 Mike. All rights reserved.
//

#import "CardGroup.h"

@implementation CardGroup


-(void)CardGroup:(NSArray<Poker *> *)pokers {
    
    if (pokers.count == 5) {
        self.pokers = pokers;
        
            // Key: 按照排序的key; ascending: YES为升序, NO为降序。
            NSSortDescriptor *sorter = [[NSSortDescriptor alloc] initWithKey:@"creationDate" ascending:NO];
            NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:&sorter count:1];
            NSArray *sortedArray = [pokers sortedArrayUsingDescriptors:sortDescriptors];
            NSLog(@"%@", sortedArray);
        
//        Collections.sort(self.pokers, new PokerComparator());
        self.power = [self computePower];
    }
        
        
}


// pow 计算以x为底数的y次幂
/**
     * 为当前牌组计算power
     * @return
     */
-(NSInteger)computePower {
        //同花顺
        if (self.isFlush && self.isStraight) {
            self.type = STRAIGHT_FLUSH;
            return (long)(9 * pow(10, 10)) +
            [self computeCardPoint];
        }
        
        //同花
        if (self.isFlush) {
            self.type = FLUSH;
            return (long)(6 * pow(10, 10)) +
            [self computeCardPoint];
        }
        //顺子
        if (self.isStraight) {
            self.type = STRAIGHT;
            return (long)(5 * pow(10, 10)) +
            [self computeCardPoint];
        }
        //其他牌型
    self.type = [self getOtherType];
        switch (self.type) {
        case FOUR_OF_A_KIND:
            return (long)(8 * pow(10, 10)) + [self computeCardPoint];
        case FULL_HOUSE:
            return (long)(7 * pow(10, 10)) +
                [self computeCardPoint];
        case THREE_OF_A_KIND:
            return (long)(4 * pow(10, 10)) +
                [self computeCardPoint];
        case TWO_PAIR:
            return (long)(3 * pow(10, 10)) +
                [self computeCardPoint];
        case ONE_PAIR:
            return (long)(2 * pow(10, 10)) +
                [self computeCardPoint];
        case HIGH_CARD:
            return (long)(1 * pow(10, 10)) +
                [self computeCardPoint];
        default:
            break;
        }
        return 0;
}
    
- (NSInteger)computeCardPoint {
        long res = 0;
    for (Poker *p in self.pokers) {
        res = res * 100 + p.value;
    }
        return res;
}

    /**
     * 判断5张牌是否为同花
     * @return
     */
    -(BOOL)isFlush {
        BOOL flag = true;
        for (int i = 1; i < 5; i++) {
           Poker *p = self.pokers[i];
            Poker *p1 = self.pokers[i-1];
            if (p.colorTyp != p1.colorTyp) {
                flag = false;
                break;
            }
        }
        return flag;
    }

    /**
     * 判断5张牌是否为顺子
     * @return
     */
-(BOOL)isStraight {
    BOOL flag = true;
        for (int i = 1; i < 5; i++) {
            Poker *p = self.pokers[i];
             Poker *p1 = self.pokers[i-1];
            
            if (p.value != p1.value - 1) {
                flag = false;
                break;
            }
        }

        //A5432特殊情况
        if (self.pokers[0].value == 14 &&
            self.pokers[1].value == 5 &&
            self.pokers[2].value == 4 &&
            self.pokers[3].value == 3 &&
            self.pokers[4].value == 2) {
            flag = true;
            //将A移动到最后，方便比较
            Poker *pokerA = self.pokers[0];
            for (int i = 0; i < 4; i++) {
                self.pokers[i] = self.pokers[i+1];
            }
            self.pokers[4] = pokerA;
        }

        return flag;
    }

    /**
     * 判断5张牌为同花和顺子以外的其他具体牌型
     * @return
     */
    - (CardType)getOtherType {
        int count = 0;
        for (int i = 0; i < 5; i++) {
            for (int j = i + 1; j < 5; j++) {
                if (self.pokers[j].value == self.pokers[i].value) {
                    count += 1;
                }
            }
        }
        if (count == 6) {
            [self changeCardPositionForFourKind];
            return FOUR_OF_A_KIND;
        }
        else if (count == 4) {
            [self changeCardPositionForFullHouse];
            return FULL_HOUSE;
        }
        else if (count == 3) {
            [self changeCardPositionForThreeKind];
            return THREE_OF_A_KIND;
        }
        else if (count == 2) {
            [self changeCardPositionForTwoPair];
            return TWO_PAIR;
        }
        else if (count == 1) {
            [self changeCardPositionForOnePair];
            return ONE_PAIR;
        }
        return HIGH_CARD;
    }

    /**
     * 为“四条“牌型修正牌的顺序
     */
    - (void)changeCardPositionForFourKind {
        if (self.pokers[0].value != self.pokers[1].value) {
            Poker *tmpPoker = self.pokers[0];
            self.pokers[0] = self.pokers[4];
            self.pokers[4] = tmpPoker;
        }
    }

    /**
     * 为“葫芦“牌型修正牌的顺序
     */
- (void)changeCardPositionForFullHouse {
        if (self.pokers[1].value != self.pokers[2].value) {
            Poker *tmpPoker = self.pokers[0];
            self.pokers[0] = self.pokers[3];
            self.pokers[3] = tmpPoker;

            tmpPoker = self.pokers[1];
            self.pokers[0] = self.pokers[4];
            self.pokers[4] = tmpPoker;
        }
    }

    /**
     * 为“三条“牌型修正牌的顺序
     */
- (void)changeCardPositionForThreeKind {
        if (self.pokers[0].value != self.pokers[2].value) {
            Poker *tmpPoker = self.pokers[0];
            self.pokers[0] = self.pokers[3];
            self.pokers[3] = tmpPoker;
        }
        if (self.pokers[1].value != self.pokers[2].value) {
            Poker *tmpPoker = self.pokers[1];
            self.pokers[1] = self.pokers[4];
            self.pokers[4] = tmpPoker;
        }
    }

    /**
     * 为“两对“牌型修正牌的顺序
     */
- (void)changeCardPositionForTwoPair {
        if (self.pokers[0].value != self.pokers[1].value) {
            Poker *tmpPoker = self.pokers[0];
            self.pokers[0] = self.pokers[2];
            self.pokers[2] = tmpPoker;
        }
        if (self.pokers[2].value != self.pokers[3].value) {
            Poker *tmpPoker = self.pokers[2];
            
            self.pokers[2] = self.pokers[4];
            self.pokers[4] = tmpPoker;
        }
    }

    /**
     * 为“一对“牌型修正牌的顺序
     */
- (void)changeCardPositionForOnePair {
        int c = 0;
        for (c; c < 4; c++) {
            if (self.pokers[c].value == self.pokers[c+1].value) {
                break;
            }
        }
        Poker *tp1 = self.pokers[c];
        Poker *tp2 = self.pokers[c+1];
        for (int i = c - 1; i >= 0; i--) {
            
            self.pokers[i+2] = self.pokers[i];
        }
    self.pokers[0] = tp1;
    self.pokers[1] = tp2;
}


@end
