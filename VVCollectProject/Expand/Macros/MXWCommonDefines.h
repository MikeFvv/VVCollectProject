//
//  MXWCommonDefines.h
//  VVCollectProject
//
//  Created by Admin on 2021/12/21.
//  Copyright © 2021 Mike. All rights reserved.
//

#ifndef MXWCommonDefines_h
#define MXWCommonDefines_h

#import "MXWNotchScreen.h"


#pragma mark - 变量-设备相关

/// 设备类型
#define IS_IPAD [MXWHelper isIPad]
#define IS_IPOD [MXWHelper isIPod]
#define IS_IPHONE [MXWHelper isIPhone]
#define IS_SIMULATOR [MXWHelper isSimulator]
#define IS_MAC [MXWHelper isMac]

/// 操作系统版本号，只获取第二级的版本号，例如 10.3.1 只会得到 10.3
#define IOS_VERSION ([[[UIDevice currentDevice] systemVersion] doubleValue])

/// 数字形式的操作系统版本号，可直接用于大小比较；如 110205 代表 11.2.5 版本；根据 iOS 规范，版本号最多可能有3位
#define IOS_VERSION_NUMBER [MXWHelper numbericOSVersion]

/// 是否横竖屏
/// 用户界面横屏了才会返回YES
#define IS_LANDSCAPE UIInterfaceOrientationIsLandscape(UIApplication.sharedApplication.statusBarOrientation)
/// 无论支不支持横屏，只要设备横屏了，就会返回YES
#define IS_DEVICE_LANDSCAPE UIDeviceOrientationIsLandscape([[UIDevice currentDevice] orientation])

/// 屏幕宽度，会根据横竖屏的变化而变化
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)

/// 屏幕高度，会根据横竖屏的变化而变化
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

/// 设备宽度，跟横竖屏无关
#define DEVICE_WIDTH MIN([[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)

/// 设备高度，跟横竖屏无关
#define DEVICE_HEIGHT MAX([[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)



/// bounds && nativeBounds / scale && nativeScale
/// 屏幕宽高
#define ScreenBoundsSize ([[UIScreen mainScreen] bounds].size)
/// /// 像素   iPhone 12 Pro Max  =1284  x  2778
#define ScreenNativeBoundsSize ([[UIScreen mainScreen] nativeBounds].size)
/// 屏幕点数   iPhone 12 Pro Max  =3
#define ScreenScale ([[UIScreen mainScreen] scale])
/// 屏幕点数  iPhone 12 Pro Max  =3
#define ScreenNativeScale ([[UIScreen mainScreen] nativeScale])


/// 状态栏高度(来电等情况下，状态栏高度会发生变化，所以应该实时计算，iOS 13 起，来电等情况下状态栏高度不会改变)    iPhone 12 Pro Max  =47
#define StatusBarHeight (UIApplication.sharedApplication.statusBarHidden ? 0 : UIApplication.sharedApplication.statusBarFrame.size.height)


/// 是否全面屏设备  刘海屏、缺口屏幕
#define IS_NOTCHED_SCREEN [MXWNotchScreen isIPhoneNotchScreen]
/// 获取刘海屏高度  iPhone 12 Pro Max  =34
#define getNotchScreenHeight [MXWNotchScreen getIPhoneNotchScreenHeight]



#endif /* MXWCommonDefines_h */
