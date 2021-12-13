//
//  NSAttributedStringManager.h
//  VVCollectProject
//
//  Created by Admin on 2021/12/13.
//  Copyright © 2021 Mike. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSAttributedStringManager : NSObject

#pragma mark -单纯改变一句话中的某些字的颜色（一种颜色）
/**
 *  单纯改变一句话中的某些字的颜色（一种颜色）
 *
 *  @param color    需要改变成的颜色
 *  @param str 总的字符串
 *  @param subStringArr 需要改变颜色的文字数组(字符串中所有的 相同的字)
 *
 *  @return 生成的富文本
 */
+(NSMutableAttributedString *)changeTextColorWithColor:(UIColor *)color string:(NSString *)str andSubString:(NSArray *)subStringArr;




#pragma mark - 获取某个子字符串在某个总字符串中位置数组
/**
 *  获取某个字符串中子字符串的位置数组 (字符串中所有的 相同的字)
 *
 *  @param totalString 总的字符串
 *  @param subString   子字符串
 *
 *  @return 位置数组
 */
+ (NSMutableArray *)getRangeWithTotalString:(NSString *)totalString SubString:(NSString *)subString;



#pragma mark - 改变某些文字的颜色 并单独设置其字体

/**
 *  改变某些文字的颜色 并单独设置其字体
 *
 *  @param font        设置的字体
 *  @param color       颜色
 *  @param totalString 总的字符串
 *  @param subArray    想要变色的字符数组
 *
 *  @return 生成的富文本
 */
+ (NSMutableAttributedString *)changeFontAndColor:(UIFont *)font Color:(UIColor *)color TotalString:(NSString *)totalString SubStringArray:(NSArray *)subArray;


#pragma mark - 为某些文字下面画线   (中画线 / 下画线)
/**
 *  为某些文字下面画线
 *
 *  @param totalString 总的字符串
 *  @param subArray    需要画线的文字数组
 *  @param lineColor   线条的颜色
 *  @return 生成的富文本
 */
+ (NSMutableAttributedString *)addLinkWithTotalString:(NSString *)totalString andLineColor:(UIColor *)lineColor SubStringArray:(NSArray *)subArray;



/**
 给label一部分字符串设置不同颜色
 
 @param allString 整体字符串内容
 @param colorStr  要改变颜色的字符串
 @param color     设置的颜色
 @param font      字号
 @return          获得可变字符串
 */
+ (NSMutableAttributedString *)attrStrFrom:(NSString *)allString colorStr:(NSString *)colorStr color:(UIColor *)color font:(UIFont *)font;

@end

NS_ASSUME_NONNULL_END
