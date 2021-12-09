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


/// 洗牌方法
/// @param dataArray 一副牌模型数组
/// @param pokerPairsNum 多少副牌进入
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


/// 点数转化为 牌面字符  例如 1 转化为 A
/// @param num 牌点数
+ (NSString *)pokerCharacter:(NSInteger)num {
    switch (num) {
        case 1:
            return @"A";
            break;
        case 2:
            case 3:
            case 4:
            case 5:
            case 6:
            case 7:
            case 8:
            case 9:
        case 10:
            return [NSString stringWithFormat:@"%ld", num];
        case 11:
            return @"L";
            break;
        case 12:
            return @"Q";
            break;
        case 13:
            return @"K";
            break;
        default:
            break;
    }
    return nil;
}

@end
