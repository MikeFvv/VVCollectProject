

#import <UIKit/UIKit.h>

@interface UIColor (Hex)


/// 十六进制字符串显示颜色
/// @param color 字符串颜色值
+ (UIColor *)colorWithHex:(NSString *)color;

/// 十六进制字符串显示颜色
/// @param color 字符串颜色值
/// @param alpha 透明度 0.0-1.0
+ (UIColor *)colorWithHex:(NSString *)color alpha:(CGFloat)alpha;




/// 16进制数字创建颜色
/// @param hex 16进制颜色值
+ (instancetype)colorWithHexInt:(uint32_t)hex;

/// 随机色
+ (instancetype)randomColor;

/// RGB颜色
/// @param red 256色值
/// @param green 256色值
/// @param blue 256色值
+ (instancetype)colorWithRed:(uint8_t)red green:(uint8_t)green blue:(uint8_t)blue;

/// @brief  渐变颜色
/// @param fromColor  开始颜色
///  @param toColor    结束颜色
/// @param height     渐变高度
+ (UIColor*)gradientFromColor:(UIColor*)fromColor toColor:(UIColor*)toColor withHeight:(CGFloat)height;


@end
