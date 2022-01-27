//
//  AppDelegate.h
//  VVCollectProject
//
//  Created by blom on 2019/1/11.
//  Copyright © 2019 Mike. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
/// 是否允许转向
@property(nonatomic,assign)BOOL allowRotation;

/// 设置根控制器
/// @param isToLogin 是否到登录页面
-(void)setRootViewController:(BOOL)isToLogin;
/**
 退出登录
 */
- (void)logOut;

@end

