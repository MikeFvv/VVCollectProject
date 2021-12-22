//
//  MXWNotchScreen.h
//  VVCollectProject
//
//  Created by Admin on 2021/12/21.
//  Copyright © 2021 Mike. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/*
 * iPhone刘海屏工具类
 */
@interface MXWNotchScreen : NSObject
// 判断是否是刘海屏
+(BOOL)isIPhoneNotchScreen;

// 获取刘海屏高度
+(CGFloat)getIPhoneNotchScreenHeight;
@end

NS_ASSUME_NONNULL_END
