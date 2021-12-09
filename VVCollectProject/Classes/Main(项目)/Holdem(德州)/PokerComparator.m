//
//  PokerComparator.m
//  VVCollectProject
//
//  Created by Admin on 2021/12/10.
//  Copyright © 2021 Mike. All rights reserved.
//

#import "PokerComparator.h"


@implementation PokerComparator

+ (int)compare:(Poker *)arg0 arg1:(Poker *)arg1 {
    Poker *poker1 = (Poker *)arg0;
    Poker *poker2 = (Poker *)arg1;
    return poker2.value - poker1.value;
}

@end
