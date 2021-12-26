//
//  BBetModel.h
//  VVCollectProject
//
//  Created by Admin on 2021/12/26.
//  Copyright © 2021 Mike. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BBetModel : NSObject
///
@property (nonatomic, assign) NSInteger playerPair_money;
///
@property (nonatomic, assign) NSInteger tie_money;
///
@property (nonatomic, assign) NSInteger superSix_money;
///
@property (nonatomic, assign) NSInteger bankerPair_money;
///
@property (nonatomic, assign) NSInteger player_money;
///
@property (nonatomic, assign) NSInteger banker_money;

/// 最后一次下注筹码  需要确定 对子 这些
@property (nonatomic, assign) NSInteger last_money;

@end

NS_ASSUME_NONNULL_END
