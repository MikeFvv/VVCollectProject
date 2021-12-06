//
//  FunctionManager.h
//  LotteryBoxT
//
//  Created by Mike on 06/02/2020.
//  Copyright © 2020 fhcq. All rights reserved.
//

#import <Foundation/Foundation.h>


//@class FLAnimatedImage;

NS_ASSUME_NONNULL_BEGIN

@interface FunctionManager : NSObject
/**
 gif图片转换
 
 @param imgName 图片名称
 @return 转换后的 gif FLAnimatedImage
 */
//+ (FLAnimatedImage *)gifFLAnimatedImageStr:(NSString *)imgName;



#pragma mark - 版本号比对 返回是否提示更新
/// 版本和比对 返回是否提示更新
/// @param newVersion 新的版本号
+ (BOOL)isEqualNewVersion:(NSString *)newVersion;


/**
 *  强制屏幕转屏
 *
 *  @param orientation 屏幕方向
 */
+ (void)interfaceOrientation:(UIInterfaceOrientation)orientation;


/// 把大长串的数字做单位处理 转换万单位
/// @param amountStr 需要转换的数字
+ (NSString *)changeAsset:(NSString *)amountStr;



/**
 给label一部分字符串设置不同颜色
 
 @param allString 整体字符串内容
 @param colorStr  要改变颜色的字符串
 @param color     设置的颜色
 @param font      字号
 @return          获得可变字符串
 */
+ (NSMutableAttributedString *)attrStrFrom:(NSString *)allString colorStr:(NSString *)colorStr color:(UIColor *)color font:(UIFont *)font;

/// 一天只执行一次 是否第一次 YES   NO
/// @param dateKey 当前日期Key  存储在偏好设置中  例如： @“ nowDate”
+ (BOOL)executeOnceDayKey:(NSString *)dateKey;

@end

NS_ASSUME_NONNULL_END
