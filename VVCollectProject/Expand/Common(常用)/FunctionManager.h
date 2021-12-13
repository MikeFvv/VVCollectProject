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





/// 一天只执行一次 是否第一次 YES   NO
/// @param dateKey 当前日期Key  存储在偏好设置中  例如： @“ nowDate”
+ (BOOL)executeOnceDayKey:(NSString *)dateKey;

@end

NS_ASSUME_NONNULL_END
