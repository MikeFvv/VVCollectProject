//
//  AppDelegate.h
//  VVCollectProject
//
//  Created by Mike on 2019/1/11.
//  Copyright © 2019 Mike. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

/// 设置根控制器
/// @param isToLogin 是否到登录页面
-(void)setRootViewController:(BOOL)isToLogin;
/**
 退出登录
 */
- (void)logOut;

@end

