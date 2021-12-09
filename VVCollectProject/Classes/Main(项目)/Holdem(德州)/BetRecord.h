//
//  BetRecord.h
//  VVCollectProject
//
//  Created by Admin on 2021/12/10.
//  Copyright © 2021 Mike. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BetRecord : NSObject

/// 玩家ID
@property (nonatomic, copy) NSString *playerID;
/// 玩家的位置
@property (nonatomic, assign) NSInteger position;
/// 剩余筹码
@property (nonatomic, assign) CGFloat jetton;
/// 底牌牌型
@property (nonatomic, copy) NSString *holdType;
/// 底牌圈策略
@property (nonatomic, assign) CGFloat holdStrategy;
/// 三张公共牌之后的牌型
@property (nonatomic, copy) NSString *flopType;
/// 公共牌之后的策略
@property (nonatomic, assign) CGFloat flopStrategy;
/// 转牌圈牌型
@property (nonatomic, copy) NSString *turnType;

/// 转牌圈策略
@property (nonatomic, assign) CGFloat turnStrategy;
/// 河牌圈牌型
@property (nonatomic, copy) NSString *riverType;
/// 河牌圈策略
@property (nonatomic, assign) CGFloat riverStrategy;




@end

NS_ASSUME_NONNULL_END
