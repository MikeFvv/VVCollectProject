//
//  NSUserDefaultsManager.h
//  小黄鸭
//
//  Created by Admin on 2021/12/6.
//  Copyright © 2021 iOS. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSUserDefaultsManager : NSObject
/// 获取活动弹窗次数
/// @param position_id 位置 例如：首页1
+ (NSInteger)getActivePopupAlertNumPositionId:(NSString *)position_id;
/// 保存弹窗次数  OOO<<<
/// /// @param position_id 位置 例如：首页1
/// @param num 已经弹窗次数
+ (void)setSaseActivePopupAlertNumPositionId:(NSString *)position_id num:(NSInteger)num;

@end

NS_ASSUME_NONNULL_END
