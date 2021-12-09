//
//  MaxCardManager.h
//  VVCollectProject
//
//  Created by Admin on 2021/12/10.
//  Copyright © 2021 Mike. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PokerModel.h"


NS_ASSUME_NONNULL_BEGIN
/// 用于从当前牌中提取最大牌
@interface MaxCardManager : NSObject
/// 自己可用的所有牌
@property (nonatomic, strong) NSArray<PokerModel *> *ArrayList;
/// 组成最大牌型的五张牌
@property (nonatomic, strong) NSArray *CardGroup;

@end

NS_ASSUME_NONNULL_END
