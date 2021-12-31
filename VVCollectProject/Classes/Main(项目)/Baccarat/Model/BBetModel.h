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
/// 闲对下注金额
@property (nonatomic, assign) NSInteger playerPair_money;
/// 和下注金额
@property (nonatomic, assign) NSInteger tie_money;
/// 超级6下注金额
@property (nonatomic, assign) NSInteger superSix_money;
/// 庄对下注金额
@property (nonatomic, assign) NSInteger bankerPair_money;
/// 闲下注金额
@property (nonatomic, assign) NSInteger player_money;
/// 庄下注金额
@property (nonatomic, assign) NSInteger banker_money;

/// 最后一次下注筹码  需要确定 对子 这些
@property (nonatomic, assign) NSInteger last_money;

/// 本次总下注金额
@property (nonatomic, assign) NSInteger total_bet_money;
/// 本次总输赢金额
@property (nonatomic, assign) NSInteger total_winLose_money;
/// 本次输赢金额  减去了本金
@property (nonatomic, assign) NSInteger winLose_money;
@end

NS_ASSUME_NONNULL_END
