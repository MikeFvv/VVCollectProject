//
//  VVFunctionManager.m
//  VVCollectProject
//
//  Created by Mike on 2019/3/11.
//  Copyright © 2019 Mike. All rights reserved.
//

#import "VVFunctionManager.h"

@implementation VVFunctionManager

#pragma mark - 洗牌方法
+ (NSMutableArray *)shuffleArray:(NSArray *)dataArray pokerPairsNum:(NSInteger)pokerPairsNum {
    NSMutableArray *tempArray = [NSMutableArray arrayWithArray:dataArray];
    // 添加牌副数
    for (NSInteger index = 1; index < pokerPairsNum; index++) {
        [tempArray addObjectsFromArray:dataArray];
    }
    
    NSInteger pokerTotalNum = tempArray.count/2;
    
    // 洗牌
    for (NSInteger index = 1; index <= pokerTotalNum; index++) {
        int pokerIndexA = (arc4random() % (pokerTotalNum*2)) + 0;
        int pokerIndexB = (arc4random() % (pokerTotalNum*2)) + 0;
        
        [tempArray exchangeObjectAtIndex:pokerIndexA withObjectAtIndex:pokerIndexB];
    }
    
    return tempArray;
}

@end
