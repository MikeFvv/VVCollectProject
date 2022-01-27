//
//  MFHTimeManager.h
//  LotteryBoxT
//
//  Created by blom on 2021/1/21.
//  Copyright © 2021 fhcq. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// C时间管理类 日期管理
@interface MFHTimeManager : NSObject


/**************************** 获取当前时间 ******************************/
/**
 * 根据格式获取当前时间字符串
 * @"YYYY年MM月dd日 HH:mm:ss"  大H 24小时制
 * @"YYYY年MM月dd日 hh:mm:ss"  小h 12小时制
 * @"YYYY年MM月dd日"
 * @"HH:mm:ss"
 * @"YYYY-MM-dd HH:mm:ss"
 * @"YYYY-MM-dd"
 * @"HH:mm:ss"
 */
+ (NSString *)getNowTimeWithDateFormat:(NSString *)dateFormat;

/// 获取当前时间戳
/// @param Ms 是否毫秒
+ (NSString *)getTimeStampOfNowWithMs:(BOOL)Ms;

/**
 * 获取当前天数
 */
+ (NSString *)getDayOfNow;


/**
 * 获取当前月份
 */
+ (NSString *)getMonthOfNow;


/**
 * 获取当前年份
 */
+ (NSString *)getYearOfNow;


/**
 * 获取当前星期
 */
+ (NSString *)getWeakDayOfNow;


/**
 * 获取NSDateComponents对象
 */
+(NSDateComponents *)getComponents;

/**************************** 时间与时间戳转换 ******************************/

/**
 * 时间转化成时间戳
 * stringTime 传入的时间字符串
 * dateFormat 传入的日期格式  @"YYYY-MM-dd HH:mm:ss"
 * isMs       是否转换成毫秒
 */
+ (NSString *)timeToTimeStamp:(NSString *)stringTime DateFormat:(NSString *)dateFormat withMs:(BOOL)isMs;


/**
 * 时间戳转化成时间
 * timeStamp  传入的时间戳
 * dateFormat 选择将要转换的时间字符串格式 @"YYYY-MM-dd HH:mm:ss"
 * isMs       时间戳是否毫秒
 */
+(NSString *)timeStampToTime:(NSString *)timeStamp DateFormat:(NSString *)dateFormat withMs:(BOOL)isMs;





/// *******************

/**  时间戳转HH:mm   */
+ (NSString *)getTimeFromTimestamp:(double)timeSp;

/**  时间戳转 YYYY-MM-dd HH:mm   */
+ (NSString *)getDateFromTimestamp:(double)timeSp;

/**  时间戳转 YYYY年MM月dd日 HH:mm   */
+ (NSString *)getDateDetailsFromTimestamp:(double)timeSp;
#pragma mark - 时间戳转时间
// 时间戳转时间,时间戳为13位是精确到毫秒的，10位精确到秒
+ (NSString *)convertStrToTime:(NSString *)str;

/// 传入 秒  得到 xx:xx:xx 或 xx:xx
+ (NSString *)getHHMMSSFromSS:(NSString *)totalTime;

/// 传入秒 转换 为时间类型字符串  得到 xx:xx:xx 或 xx:xx
/// @param totalTime 总秒数
/// @param isShowDay 是否显示天数 ， NO 直接显示小时数
+ (NSString *)getHHMMSSFromSS:(NSString *)totalTime isShowDay:(BOOL)isShowDay;

/// 字符串转时间戳 如：2017-4-10 17:15:10
/// 时间格式   如：YYYY-MM-dd HH:mm:ss
/// 是否精确到毫秒 默认秒
+ (NSString *)getTimeStrWithString:(NSString *)str timeFormat:(NSString *)timeFormat;



/// 判断某个时间距离当天间隔几天
/// @param oldDate 某个时间
+ (NSInteger)getDifferenceByDate:(NSDate *)oldDate;

/// 判断某个时间距离当天间隔几天
/// @param oldDateStr 某个时间 字符串 yyyy-MM-dd HH:mm:ss
+ (NSInteger)getDifferenceByDateStr:(NSString *)oldDateStr;



/// 多少天执行一次 是否第一次 YES   NO
/// @param key Key 需唯一  存储在偏好设置中  例如：位置和功能 （首页广告）@“ kHomeAdNowDate”
/// @param betweenDaysNum 间隔天数
+ (BOOL)executeHowManyDaysKey:(NSString *)key betweenDaysNum:(NSInteger)betweenDaysNum;



#pragma mark -  一个类

/**
 *    @brief    获取当前时间的日期详细
 *
 *    @return    返回当前日期的详细信息
 */
+ (NSDateComponents *)getDateComponents;


/*
      convert NSDate to NSDateComponents
*/
+ (NSDateComponents *)getDateComponentsWithDate:(NSDate *)date;

/*
      convert time in long long type to NSDateComponents
 */
+ (NSDateComponents *)convertTimeToDateComponents:(long long)time;


/*
      convert NSDate to long long type
*/
+ (long long)convertDateToSecondTime:(NSDate *)date;

/*
      convert long long to NSDate type
 */
+ (NSDate *)convertSecondsToDate:(long long)time;


/**
 *    @brief    自当前日期开始获取时间列表，1个页面对应10个日期
 *
 *    @param     page  第xx页，从0开始
 *
 *    @return    返回一个日期的数组
 */
+ (NSMutableArray *)getNextPageDays:(int)page;


/**
 *    @brief    根据日期获取当日是星期几
 *
 *    @param     date     日期
 *
 *    @return    所在周的星期数
 */
+ (NSString *)getWeekDayInweekWithDate:(NSDate *)date;


/**
 *    @brief    获取当前日期所在周的周一
 *
 *    @param     date     要查询的日期
 *
 *    @return    该日期所在周的周一
 */
+ (NSDate *)getBeginDateInWeekWith:(NSDate *)date;

/**
 *    @brief    获取当前日期的前一天
 *
 *    @param     date     要查询的日期
 *
 *    @return    该日期的前一天
 */
+ (NSDate *)getYesterDay:(NSDate *)date;

/**
 *    @brief    获取当前日期所在周的周日
 *
 *    @param     date     要查询的日期
 *
 *    @return    该日期所在周的周日
 */
+ (NSDate *)getEndDateInWeekWithDate:(NSDate *)date;

/**
 *    @brief    获取当前日期所在周上周的周日
 *
 *    @param     date     要查询的日期
 *
 *    @return    该日期所在周上周的周日
 */
+ (NSDate *)getlastWeekDayDateWithDate:(NSDate *)date;

/**
 *    @brief    获取当前日期所在周上周的周一
 *
 *    @param     date     要查询的日期
 *
 *    @return    该日期所在周上周的周一
 */
+ (NSDate *)getlastFirstDayDateWithDate:(NSDate *)date;

/**
 *    @brief    返回当前日期所在月的第一天
 *
 *    @param     date     当前日期
 *
 *    @return    日期
 */
+ (NSDate *)getFirstDayDateInCurrentDateMonthWithDate:(NSDate *)date;

/**
 *    @brief    返回当前日期所在月的最后一天
 *
 *    @param     date     当前日期
 *
 *    @return    日期
 */
+ (NSDate *)getEndDayDateInCurrentDateMonthWithDate:(NSDate *)date;

/**
 *    @brief    返回当前日期所在月的上月的最后一天
 *
 *    @param     date     当前日期
 *
 *    @return    日期
 */
+ (NSDate *)getEndDayDateInLastMonthOfDateWithDate:(NSDate *)date;

/**
 *    @brief    返回当前日期所在月的上月的第一天
 *
 *    @param     date     当前日期
 *
 *    @return    日期
 */
+ (NSDate *)getFirstDayDateInLastMonthOfDateWithDate:(NSDate *)date;

/**
 *    @brief    返回当前日期的年-月-日
 *
 *    @param     date     当前日期
 *
 *    @return    @"年-月-日"
 */
+ (NSString *)getYearMonthDayWithDate:(NSDate *)date;

/**
 *    @brief    返回当前日期的XXXX年XX月XX日
 *
 *    @param     date     当前日期
 *
 *    @return    XXXX年XX月XX日
 */
+ (NSString *)getYearMonthDayWithDateInChinese:(NSDate *)date;

/**
 *    @brief    字符串转换成日期 目前只支持xxxx-xx-xx格式
 *
 *    @param     str     日期字符串
 *
 *    @return    date
 */
+ (NSDate *)dateFromString:(NSString *)str;

/**
 *    @brief    将字符串转换成nsdate
 *
 *    @param     str     待转换的字符串
 *    @param     format     转换格式
 *
 *    @return    nsdate
 */
+ (NSDate *)timeFromString:(NSString *)str andFormat:(NSString *)format;

/**
 *    @brief    将日期按照指定的格式转化成字符串
 *
 *    @param     date     日期
 *    @param     format     格式
 *
 *    @return    转化好的字符串
 */
+ (NSString *)getDateStringWithDate:(NSDate *)date andFormat:(NSString *)format;

@end

NS_ASSUME_NONNULL_END
