//
//  MBProgressHUD+JDragon.h
//  JDragonHUD
//
//  Created by JDragon on 2017/1/17.
//  Copyright © 2017年 JDragon. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (JDragon)

// ****** 默认2s消失 ******
+ (void)showTipMessageInWindow:(NSString*)message;
+ (void)showTipMessageInView:(NSString*)message;
+ (void)showTipMessageInWindow:(NSString*)message timer:(int)aTimer;
+ (void)showTipMessageInView:(NSString*)message timer:(int)aTimer;

// ****** 加载框 需要调用 hideHUD 才能消失 ******
+ (void)showActivityMessageInWindow:(NSString*)message;
+ (void)showActivityMessageInView:(NSString*)message;
+ (void)showActivityMessageInWindow:(NSString*)message timer:(int)aTimer;
+ (void)showActivityMessageInView:(NSString*)message timer:(int)aTimer;


// ****** 带图片的提示框 默认2s消失  ******
+ (void)showSuccessMessage:(NSString *)Message;
+ (void)showErrorMessage:(NSString *)Message;
+ (void)showInfoMessage:(NSString *)Message;
+ (void)showWarnMessage:(NSString *)Message;

// ****** 自定义图片提示框  ******
+ (void)showCustomIconInWindow:(NSString *)iconName message:(NSString *)message;
+ (void)showCustomIconInView:(NSString *)iconName message:(NSString *)message;


+ (void)hideHUD;


@end
