//
//  NSUserDefaultsManager.m
//  小黄鸭
//
//  Created by Admin on 2021/12/6.
//  Copyright © 2021 iOS. All rights reserved.
//

#import "NSUserDefaultsManager.h"
#import "FunctionManager.h"

@implementation NSUserDefaultsManager

/// 获取活动弹窗次数
/// @param position_id 位置 例如：首页1
+ (NSInteger)getActivePopupAlertNumPositionId:(NSString *)position_id {
    
    NSString *onceKeyStr = [NSString stringWithFormat:@"ActivePopupAlertNowDate_%@_%@", @"10000",position_id];
    BOOL isOnce = [FunctionManager executeOnceDayKey:onceKeyStr];
    if (isOnce) {
        [self setSaseActivePopupAlertNumPositionId:position_id num:0]; // 每天更新
    }
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *keyStr = [NSString stringWithFormat:@"kSaveActivePopupAlertNum_%@_%@",@"10000",position_id];
    NSNumber *num = [userDefault objectForKey:keyStr];
    return [num integerValue];
}




/// 保存弹窗次数  OOO<<<
/// /// @param position_id 位置 例如：首页1
/// @param num 已经弹窗次数
+ (void)setSaseActivePopupAlertNumPositionId:(NSString *)position_id num:(NSInteger)num {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *keyStr = [NSString stringWithFormat:@"kSaveActivePopupAlertNum_%@_%@",@"10000",position_id];
    [userDefault setObject:@(num) forKey:keyStr];
    [userDefault synchronize];
}

@end
