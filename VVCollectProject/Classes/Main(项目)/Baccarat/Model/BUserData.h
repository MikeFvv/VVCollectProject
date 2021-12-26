//
//  BUserData.h
//  VVCollectProject
//
//  Created by Admin on 2021/12/26.
//  Copyright © 2021 Mike. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 用户数据
@interface BUserData : NSObject

/// 下注输赢总金额
@property (nonatomic, assign) NSInteger betTotalMoney;
/// 最高总金额
@property (nonatomic, assign) NSInteger maxBetTotalMoney;
/// 最低总金额
@property (nonatomic, assign) NSInteger minBetTotalMoney;

@end

NS_ASSUME_NONNULL_END
