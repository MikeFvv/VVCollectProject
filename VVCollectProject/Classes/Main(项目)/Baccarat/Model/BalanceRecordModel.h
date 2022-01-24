//
//  BalanceRecordModel.h
//  VVCollectProject
//
//  Created by Admin on 2022/1/25.
//  Copyright © 2022 Mike. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 余额记录
@interface BalanceRecordModel : NSObject

/// 用户ID
@property (nonatomic, copy) NSString *userId;
/// 充值ID
@property (nonatomic, copy) NSString *topupId;
/// 创建时间
@property (nonatomic, copy) NSString *create_time;
/// 更新时间
@property (nonatomic, copy) NSString *update_time;

/// 充值
@property (nonatomic, copy) NSString *title;
/// 充值金额
@property (nonatomic, assign) NSInteger money;
/// 充值类型
@property (nonatomic, copy) NSString *rechargeType;

@end

NS_ASSUME_NONNULL_END
