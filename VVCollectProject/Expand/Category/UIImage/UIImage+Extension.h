//
//  UIImage+Extension.h
//  VVCollectProject
//
//  Created by Admin on 2021/11/12.
//  Copyright © 2021 Mike. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Extension)

/// 返回一张颜色图片
+ (UIImage *)imageWithColor:(UIColor *)color;
/// 返回一张view图片
+ (UIImage *)imageWithView:(UIView *)view;
/// 返回一张Layer图片
+ (UIImage *)imageWithLayer:(CALayer *)layer;
/// 影像剪裁
- (UIImage *)trimImageWithMask:(CGRect)maskFrame;

/// 高斯模糊
- (UIImage *)blurredWithRadius:(CGFloat)radius;


@end

NS_ASSUME_NONNULL_END
