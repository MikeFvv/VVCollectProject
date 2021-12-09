//
//  PairModel.h
//  VVCollectProject
//
//  Created by Admin on 2021/12/10.
//  Copyright © 2021 Mike. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Poker.h"


NS_ASSUME_NONNULL_BEGIN

@interface Pair : NSObject

/// 第一张
@property (nonatomic, strong) Poker *first;
/// 第二张
@property (nonatomic, strong) Poker *second;

@end

NS_ASSUME_NONNULL_END
