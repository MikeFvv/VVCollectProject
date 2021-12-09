//
//  BetState.h
//  VVCollectProject
//
//  Created by Admin on 2021/12/10.
//  Copyright © 2021 Mike. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/// 玩家的当前押注状态，用于Server的消息询问时
@interface BetState : NSObject

/// 玩家ID
@property (nonatomic, copy) NSString *playerID;
/// 手中筹码
@property (nonatomic, assign) NSInteger jetton;
/// 剩余金币数
@property (nonatomic, assign) NSInteger money;
/// 累计投注额
@property (nonatomic, assign) NSInteger bet;
/// 最近一次action
@property (nonatomic, copy) NSString *action;

@end

NS_ASSUME_NONNULL_END
