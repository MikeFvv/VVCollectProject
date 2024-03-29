//
//  FYStatusBarHUD.h
//  Project
//
//  Created by blom on 2019/5/26.
//  Copyright © 2019 CDJay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FYStatusBarHUD : NSObject

/**
 *  显示普通信息
 *
 *  @param msg   内容
 *  @param image 图片
 */
+ (void)showMessage:(NSString *)msg image:(UIImage *)image;

/**
 *  显示普通信息
 */
+ (void)showMessage:(NSString *)msg;

/**
 *  显示成功信息
 */
+ (void)showSuccess:(NSString *)msg;

/**
 *  显示失败信息
 */
+ (void)showError:(NSString *)msg;

/**
 *  显示正在处理信息
 */
+ (void)showLoading:(NSString *)msg;

/**
 *  隐藏
 */
+ (void)hide;




@end
