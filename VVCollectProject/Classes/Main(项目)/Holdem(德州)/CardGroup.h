//
//  CardGroup.h
//  VVCollectProject
//
//  Created by Admin on 2021/12/10.
//  Copyright © 2021 Mike. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Poker.h"

NS_ASSUME_NONNULL_BEGIN


/**
 * 一套牌（包含5张），可计算该套牌的大小，表示为十进制数abcdef。
 * 1<=a<=9：用1～9分别表示高牌，一对，两对，三条，顺子，同花，葫芦，四条，同花顺
 * 2<=(b-f)<=14：用2～14分别表示牌的点数，从2-10和J-A
 *
 */
@interface CardGroup : NSObject

/// 5张牌
@property (nonatomic, strong) NSMutableArray<Poker *> *pokers;
/// 牌型
@property (nonatomic, assign) CardType type;
/// 牌的大小
@property (nonatomic, assign) NSInteger power;

-(void)CardGroup:(NSMutableArray<Poker *> *)pokers;

@end

NS_ASSUME_NONNULL_END
