//
//  MaxCardManager.m
//  VVCollectProject
//
//  Created by Admin on 2021/12/10.
//  Copyright © 2021 Mike. All rights reserved.
//

#import "MaxCardComputer.h"

@implementation MaxCardComputer



-(void)maxCardComputer:(NSMutableArray<Poker *> *)holdPokers publicPokers:(NSMutableArray<Poker *> *)publicPokers {
    self.pokers = [NSMutableArray array];
    if (holdPokers != nil)
        [self.pokers addObjectsFromArray:holdPokers];
    if (publicPokers != nil)
        [self.pokers addObjectsFromArray:publicPokers];
    
    [self computeMaxCardGroup];
}

-(void)maxCardComputer:(MaxCardComputer *)oldComputer poker:(Poker *)poker {
    self.pokers = [NSMutableArray array];
    [self.pokers addObjectsFromArray:self.pokers];
    
    [self computeMaxCardGroup_New:poker];
    [self.pokers addObject:poker];
}


/**
 * 计算最大的五张牌
 */
//    @SuppressWarnings("unchecked")
- (void)computeMaxCardGroup {
    if (self.pokers.count == 5) {
        
        CardGroup *group = [[CardGroup alloc] init];
        [group CardGroup:self.pokers];
        self.maxGroup = group;
    }
    else if (self.pokers.count == 6) {
        NSMutableArray<CardGroup *> *groups = [NSMutableArray array];
        
        for (int i = 0; i < 6; i++) {
            NSMutableArray<Poker *> *pokerList = [NSMutableArray array];
            pokerList = self.pokers;
            
            [pokerList removeObjectAtIndex:i];
            
            CardGroup *group = [[CardGroup alloc] init];
            [group CardGroup:pokerList];
            [groups addObject:group];
        }
        
        NSArray *sortArray = [groups sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            return [obj1 compare:obj2 options:NSNumericSearch];
        }];
        
        self.maxGroup = sortArray[0];
    }
    else if (self.pokers.count == 7) {
        NSMutableArray<CardGroup *> *groups = [NSMutableArray array];
        for (int i = 0; i < 7; i++) {
            for (int j = 0; j < 7; j++) {
                if (i == j) continue;
                NSMutableArray<Poker *> *pokerList = [NSMutableArray array];
                pokerList = self.pokers;
                
                Poker *pi = pokerList[i];
                Poker *pj = pokerList[j];
                
                [pokerList removeObject:pi];
                [pokerList removeObject:pj];
                
                CardGroup *group = [[CardGroup alloc] init];
                [group CardGroup:pokerList];
                [groups addObject:group];
            }
        }
        NSArray *sortArray = [groups sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            return [obj1 compare:obj2 options:NSNumericSearch];
        }];
        self.maxGroup = sortArray[0];
    }
    
}




//@SuppressWarnings("unchecked")
- (void) computeMaxCardGroup_New:(Poker *)poker {
    if (self.pokers.count == 5) {
        NSMutableArray<CardGroup *> *groups = [NSMutableArray array];
        for (int i = 0; i < 5; i++) {
            NSMutableArray<Poker *> *pokerList = [NSMutableArray array];
            pokerList = self.pokers;
            
            [pokerList removeObjectAtIndex:i];
            [pokerList addObject:poker];
            
            CardGroup *group = [[CardGroup alloc] init];
            [group CardGroup:pokerList];
            [groups addObject:group];
        }
        
        NSArray *sortArray = [groups sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            return [obj1 compare:obj2 options:NSNumericSearch];
        }];
        self.maxGroup = sortArray[0];
    }
    else if (self.pokers.count == 6) {
        NSMutableArray<CardGroup *> *groups = [NSMutableArray array];
        for (int i = 0; i < 6; i++) {
            for (int j = 0; j < 6; j++) {
                if (i == j) continue;
                NSMutableArray<Poker *> *pokerList = [NSMutableArray array];
                pokerList = self.pokers;
                
                Poker *pi = pokerList[i];
                Poker *pj = pokerList[j];
                
                [pokerList removeObject:pi];
                [pokerList removeObject:pj];
                
                [pokerList addObject:poker];
                
                CardGroup *group = [[CardGroup alloc] init];
                [group CardGroup:pokerList];
                [groups addObject:group];
            }
        }
        NSArray *sortArray = [groups sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            return [obj1 compare:obj2 options:NSNumericSearch];
        }];
        self.maxGroup = sortArray[0];
    }
}


@end
