//
//  MaxCardManager.h
//  VVCollectProject
//
//  Created by Admin on 2021/12/10.
//  Copyright © 2021 Mike. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Poker.h"
#import "CardGroup.h"


NS_ASSUME_NONNULL_BEGIN
/// 用于从当前牌中提取最大牌
@interface MaxCardComputer : NSObject
/// 自己可用的所有牌
@property (nonatomic, strong) NSMutableArray<Poker *> *pokers;
/// 组成最大牌型的五张牌
@property (nonatomic, strong) CardGroup *maxGroup;

-(void)maxCardComputer:(NSMutableArray<Poker *> *)holdPokers publicPokers:(NSMutableArray<Poker *> *)publicPokers;
-(void)maxCardComputer:(MaxCardComputer *)oldComputer poker:(Poker *)poker;

@end

NS_ASSUME_NONNULL_END
