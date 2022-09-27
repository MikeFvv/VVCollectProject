//
//  UIDevice+BMAddition.m
//  VVCollectProject
//
//  Created by BLOM on 9/27/22.
//  Copyright © 2022 Mike. All rights reserved.
//

#import "UIDevice+BMAddition.h"

@implementation UIDevice (BMAddition)

/// 顶部安全区高度
+ (CGFloat)bm_safeDistanceTop {
    if (@available(iOS 13.0, *)) {
        NSSet *set = [UIApplication sharedApplication].connectedScenes;
        UIWindowScene *windowScene = [set anyObject];
        UIWindow *window = windowScene.windows.firstObject;
        return window.safeAreaInsets.top;
    } else if (@available(iOS 11.0, *)) {
        UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
        return window.safeAreaInsets.top;
    }
    return 0;
}

/// 底部安全区高度
+ (CGFloat)bm_safeDistanceBottom {
    if (@available(iOS 13.0, *)) {
        NSSet *set = [UIApplication sharedApplication].connectedScenes;
        UIWindowScene *windowScene = [set anyObject];
        UIWindow *window = windowScene.windows.firstObject;
        return window.safeAreaInsets.bottom;
    } else if (@available(iOS 11.0, *)) {
        UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
        return window.safeAreaInsets.bottom;
    }
    return 0;
}


/// 顶部状态栏高度（包括安全区）
+ (CGFloat)bm_statusBarHeight {
    if (@available(iOS 13.0, *)) {
        NSSet *set = [UIApplication sharedApplication].connectedScenes;
        UIWindowScene *windowScene = [set anyObject];
        UIStatusBarManager *statusBarManager = windowScene.statusBarManager;
        return statusBarManager.statusBarFrame.size.height;
    } else {
        return [UIApplication sharedApplication].statusBarFrame.size.height;
    }
}

/// 导航栏高度
+ (CGFloat)bm_navigationBarHeight {
    return 44.0f;
}

/// 状态栏+导航栏的高度
+ (CGFloat)bm_navigationFullHeight {
    return [UIDevice bm_statusBarHeight] + [UIDevice bm_navigationBarHeight];
}

/// 底部导航栏高度
+ (CGFloat)bm_tabBarHeight {
    return 49.0f;
}

/// 底部导航栏高度（包括安全区）
+ (CGFloat)bm_tabBarFullHeight {
    return [UIDevice bm_statusBarHeight] + [UIDevice bm_safeDistanceBottom];
}




+ (CGFloat)statusBarHeight {
    NSSet *set = [UIApplication sharedApplication].connectedScenes;
    UIWindowScene *windowScene = [set anyObject];
    UIStatusBarManager *statusBarManager = windowScene.statusBarManager;
    CGFloat statusBarHeight = statusBarManager.statusBarFrame.size.height;
    if( @available(iOS 16.0, *)) {
        //Xcode13编译的包，在iPhone14Pro及Max取到的状态栏高度是44，实际是59，需要做调整（模拟器数据）
        BOOL needAdjust = (statusBarHeight == 44);
        if(windowScene.windows.firstObject.safeAreaInsets.top == 59 && needAdjust) {
            statusBarHeight = 59;
            
        }
    }
    return statusBarHeight;
}


@end
