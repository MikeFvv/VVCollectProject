//
//  UIViewController+MXW.h
//  小黄鸭
//
//  Created by Admin on 2021/12/6.
//  Copyright © 2021 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (MXW)
/**
 * 获取当前应用里最顶层的可见viewController
 * @warning 注意返回值可能为nil，要做好保护
 */
//- (nullable UIViewController *)visibleViewController;

- (UIViewController * )getTopViewController;

@end

NS_ASSUME_NONNULL_END
