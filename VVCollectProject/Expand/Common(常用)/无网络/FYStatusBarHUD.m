//
//  FYStatusBarHUD.m
//  Project
//
//  Created by blom on 2019/5/26.
//  Copyright © 2019 CDJay. All rights reserved.
//

#import "FYStatusBarHUD.h"


/** 提示信息显示时长 */
static CGFloat const FYMessageDuration = 2.0;
/** 提示信息显示\隐藏的动画时间间隔 */
static CGFloat const FYAnimationDuration = 0.25;


@implementation FYStatusBarHUD

/** 全局窗口 */
static UIWindow *window_;
/** 定时器 */
static NSTimer *timer_;

/**
 *  显示窗口
 */
+ (void)showWindow
{
    //01.frame数据
    CGFloat windowH = 20;
    CGFloat windowW = [UIScreen mainScreen].bounds.size.width;
    CGRect frame = CGRectMake(0, - windowH, windowW, windowH);
    
    //02.显示窗口
    window_.hidden = YES;
    window_ = [[UIWindow alloc] init];
    window_.frame = frame;
    window_.windowLevel = UIWindowLevelAlert;
//    window_.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.85];
    window_.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    window_.hidden = NO;
    
    //03.动画下滑
    frame.origin.y = Height_NavBar;
    [UIView animateWithDuration:FYAnimationDuration animations:^{
        window_.frame = frame;
    }];
}


/**
 *  显示普通信息
 *
 *  @param msg   内容
 *  @param image 图片
 */
+ (void)showMessage:(NSString *)msg image:(UIImage *)image
{
    //停止定时器
    [timer_ invalidate];
    
    //显示窗口
    [self showWindow];
    
    //添加显示信息按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:msg forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    if (image) {//如果有图片
        [btn setImage:image forState:UIControlStateNormal];
        [btn setImage:image forState:UIControlStateHighlighted];
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    }
    btn.frame = window_.bounds;
    [window_ addSubview:btn];
    
    //定时器(固定显示一段时间后消失)
    timer_ = [NSTimer scheduledTimerWithTimeInterval:FYMessageDuration target:self selector:@selector(hide) userInfo:nil repeats:NO];
}

/**
 *  显示普通信息
 */
+ (void)showMessage:(NSString *)msg
{
    [self showMessage:msg image:nil];
}

/**
 *  显示成功信息
 */
+ (void)showSuccess:(NSString *)msg
{
    [self showMessage:msg image:[UIImage imageNamed:@"FYStatusBarHUD.bundle/vv_success"]];
}

/**
 *  显示失败信息
 */
+ (void)showError:(NSString *)msg
{
    [self showMessage:msg image:[UIImage imageNamed:@"FYStatusBarHUD.bundle/vv_error"]];
}

/**
 *  显示正在处理信息
 */
+ (void)showLoading:(NSString *)msg
{
    //停止定时器
    [timer_ invalidate];
    timer_ = nil;
    
    //显示窗口
    [self showWindow];
    
    //添加显示文字
    UILabel *label = [[UILabel alloc] init];
    label.frame = window_.bounds;
    label.text = msg;
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:12];
    [window_ addSubview:label];
    
    //添加动作指示器
    UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [loadingView startAnimating];
    
    //根据文字宽度显示指示器位置
    CGFloat msgW = [msg sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12]}].width;
    CGFloat centerX = (window_.frame.size.width - msgW) * 0.5 - 20;
    CGFloat centerY = window_.frame.size.height * 0.5;
    loadingView.center = CGPointMake(centerX, centerY);
    [window_ addSubview:loadingView];
}

/**
 *  隐藏
 */
+ (void)hide
{
    [UIView animateWithDuration:FYAnimationDuration animations:^{
        CGRect frame = window_.frame;
        frame.origin.y = - frame.size.height;
        window_.frame = frame;
    } completion:^(BOOL finished) {
        window_ = nil;
        timer_ = nil;
    }];
}


@end
