//
//  CardGroupComparator.m
//  VVCollectProject
//
//  Created by Admin on 2021/12/10.
//  Copyright © 2021 Mike. All rights reserved.
//

#import "CardGroupComparator.h"

@implementation CardGroupComparator
+ (int)compare:(CardGroup *)arg0 arg1:(CardGroup *)arg1 {
    CardGroup *group1 = (CardGroup *)arg0;
    CardGroup *group2 = (CardGroup *)arg1;
    if (group2.power > group1.power)
        return 1;
    else if (group2.power < group1.power)
        return -1;
    return 0;
}


@end
