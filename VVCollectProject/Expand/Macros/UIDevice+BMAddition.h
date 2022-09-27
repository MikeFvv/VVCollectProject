//
//  UIDevice+BMAddition.h
//  VVCollectProject
//
//  Created by BLOM on 9/27/22.
//  Copyright © 2022 Mike. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIDevice (BMAddition)
/// 顶部安全区高度
+ (CGFloat)bm_safeDistanceTop;

/// 底部安全区高度
+ (CGFloat)bm_safeDistanceBottom;

/// 顶部状态栏高度（包括安全区）
+ (CGFloat)bm_statusBarHeight;

/// 导航栏高度
+ (CGFloat)bm_navigationBarHeight;

/// 状态栏+导航栏的高度
+ (CGFloat)bm_navigationFullHeight;

/// 底部导航栏高度
+ (CGFloat)bm_tabBarHeight;

/// 底部导航栏高度（包括安全区）
+ (CGFloat)bm_tabBarFullHeight;


+ (CGFloat)statusBarHeight;

@end

NS_ASSUME_NONNULL_END

