//
//  MXWHelper.h
//  VVCollectProject
//
//  Created by Admin on 2021/12/22.
//  Copyright © 2021 Mike. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MXWHelper : NSObject

@end



@interface MXWHelper (Device)

/// 如 iPhone12,5、iPad6,8
/// @NEW_DEVICE_CHECKER
@property(class, nonatomic, readonly) NSString *deviceModel;

/// 如 iPhone 11 Pro Max、iPad Pro (12.9 inch)，如果是模拟器，会在后面带上“ Simulator”字样。
/// @NEW_DEVICE_CHECKER
@property(class, nonatomic, readonly) NSString *deviceName;

@property(class, nonatomic, readonly) BOOL isIPad;
@property(class, nonatomic, readonly) BOOL isIPod;
@property(class, nonatomic, readonly) BOOL isIPhone;
@property(class, nonatomic, readonly) BOOL isSimulator;
@property(class, nonatomic, readonly) BOOL isMac;

/// 带物理凹槽的刘海屏或者使用 Home Indicator 类型的设备
/// @NEW_DEVICE_CHECKER
//@property(class, nonatomic, readonly) BOOL isNotchedScreen;

/// 用于获取 isNotchedScreen 设备的 insets，注意对于无 Home 键的新款 iPad 而言，它不一定有物理凹槽，但因为使用了 Home Indicator，所以它的 safeAreaInsets 也是非0。
/// @NEW_DEVICE_CHECKER
//@property(class, nonatomic, readonly) UIEdgeInsets safeAreaInsetsForDeviceWithNotch;


@end



@interface MXWHelper (SystemVersion)

/// 数字操作系统版本
+ (NSInteger)numbericOSVersion;

/// 比较系统版本
/// @param currentVersion 当前版本到版本
/// @param targetVersion 目标版本
+ (NSComparisonResult)compareSystemVersion:(nonnull NSString *)currentVersion toVersion:(nonnull NSString *)targetVersion;

/// 是否当前系统至少版本
/// @param targetVersion 目标版本
+ (BOOL)isCurrentSystemAtLeastVersion:(nonnull NSString *)targetVersion;

/// 是否当前系统低于版本
/// @param targetVersion 目标版本
+ (BOOL)isCurrentSystemLowerThanVersion:(nonnull NSString *)targetVersion;
@end



NS_ASSUME_NONNULL_END
