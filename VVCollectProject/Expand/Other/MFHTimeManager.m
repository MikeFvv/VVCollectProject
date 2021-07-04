//
//  MFHTimeManager.m
//  LotteryBoxT
//
//  Created by Mike on 2021/1/21.
//  Copyright © 2021 fhcq. All rights reserved.
//

#import "MFHTimeManager.h"
#import "NSDate+OST_DATE.h"


@implementation MFHTimeManager


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
+ (NSString *)getNowTimeWithDateFormat:(NSString *)dateFormat
{
    NSDate *date = [[NSDate alloc] init];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = dateFormat;
    NSString *dateStr = [formatter stringFromDate:date];
    
    return dateStr;
}

// 获取当前天数
+ (NSString *)getDayOfNow
{
    // 获取date格式时间的年  月  日
    NSDateComponents *comp = [self getComponents];
    return [NSString stringWithFormat:@"%ld",(long)[comp day]];
}

// 获取当前月份
+ (NSString *)getMonthOfNow
{
    NSDateComponents *comp = [self getComponents];
    return [NSString stringWithFormat:@"%ld",(long)[comp month]];
}

// 获取当前年份
+ (NSString *)getYearOfNow
{
    NSDateComponents *comp = [self getComponents];
    return [NSString stringWithFormat:@"%ld",(long)[comp year]];
}

// 获取当前星期
+ (NSString *)getWeakDayOfNow
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekOfYear |  NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal fromDate:[NSDate date]];
    
    NSString *weekStr = nil;
    switch ([components weekday]) {
        case 2:
            weekStr = @"星期一";
            break;
        case 3:
            weekStr = @"星期二";
            break;
        case 4:
            weekStr = @"星期三";
            break;
        case 5:
            weekStr = @"星期四";
            break;
        case 6:
            weekStr = @"星期五";
            break;
        case 7:
            weekStr = @"星期六";
            break;
        case 1:
            weekStr = @"星期天";
            break;
        default:
            break;
    }
    return weekStr;
}

// 获取NSDateComponents对象
+(NSDateComponents *)getComponents
{
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:[NSDate date]];
    return comp;
}

//时间转化成时间戳 yyyy年MM月dd日 @"YYYY-MM-dd HH:mm:ss"
+ (NSString *)timeToTimeStamp:(NSString *)stringTime DateFormat:(NSString *)dateFormat withMs:(BOOL)isMs
{
    NSDateFormatter *dfmatter = [[NSDateFormatter alloc]init];
    dfmatter.dateFormat = dateFormat;
    NSDate *date = [dfmatter dateFromString:stringTime];
    NSTimeInterval dateStamp = [date timeIntervalSince1970];
    if (isMs) {
        dateStamp = [date timeIntervalSince1970]*1000;
    }
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)dateStamp];
    return timeSp;
}
//时间戳转化成时间
+(NSString *)timeStampToTime:(NSString *)timeStamp DateFormat:(NSString *)dateFormat withMs:(BOOL)isMs
{
    NSString *timeStr = timeStamp;
    NSTimeInterval dateStamp = timeStr.doubleValue;
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = dateFormat;
    if (isMs) {
        dateStamp = dateStamp / 1000;
    }
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:dateStamp];
    return [formatter stringFromDate:date];
}


// 获取当前时间戳
+ (NSString *)getTimeStampOfNowWithMs:(BOOL)Ms
{
    NSString *time = [self getNowTimeWithDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    return [self timeToTimeStamp:time DateFormat:@"YYYY-MM-dd HH:mm:ss" withMs:Ms];
    
}





/// *******************

/**  时间戳转HH:mm   */
+ (NSString *)getTimeFromTimestamp:(double)timeSp {
    
    //将对象类型的时间转换为NSDate类型
    if (timeSp == 0) {
        return @"休息中~";
    }
    
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:timeSp];
    
    //设置时间格式
    NSDateFormatter * formatter=[[NSDateFormatter alloc]init];
    
    [formatter setDateFormat:@"HH:mm"];
    
    //将时间转换为字符串
    NSString *timeStr=[formatter stringFromDate:date];
    
    return timeStr;
    
}


/**  时间戳转 YYYY-MM-dd HH:mm   */
+ (NSString *)getDateFromTimestamp:(double)timeSp {
    
    //将对象类型的时间转换为NSDate类型
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:timeSp];
    
    //设置时间格式
    NSDateFormatter * formatter=[[NSDateFormatter alloc]init];
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    
    //将时间转换为字符串
    NSString *timeStr=[formatter stringFromDate:date];
    
    return timeStr;
    
}


/**  时间戳转 YYYY年MM月dd日 HH:mm   */
+ (NSString *)getDateDetailsFromTimestamp:(double)timeSp {
    
    //将对象类型的时间转换为NSDate类型
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:timeSp];
    
    //设置时间格式
    NSDateFormatter * formatter=[[NSDateFormatter alloc]init];
    
    [formatter setDateFormat:@"YYYY年MM月dd日 HH:mm"];
    
    //将时间转换为字符串
    NSString *timeStr=[formatter stringFromDate:date];
    
    return timeStr;
    
}


#pragma mark - 时间戳转时间
// 时间戳转时间,时间戳为13位是精确到毫秒的，10位精确到秒
+ (NSString *)convertStrToTime:(NSString *)str {
    NSTimeInterval time=[str doubleValue];//传入的时间戳str如果是精确到毫秒的记得要/1000
    NSDate *detailDate=[NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; //实例化一个NSDateFormatter对象
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    NSString *currentDateStr = [dateFormatter stringFromDate: detailDate];
    return currentDateStr;
}


/// 传入 秒  得到 xx:xx:xx 或 xx:xx
+ (NSString *)getHHMMSSFromSS:(NSString *)totalTime {
    NSInteger seconds = [totalTime integerValue];
    
    // 小时
    NSString *str_hour = nil;
    if(seconds/3600/24 > 0) {
        //        str_hour = [NSString stringWithFormat:@"%ld天%02ld",seconds/3600/24,seconds%(3600*24)/3600];
        str_hour = [NSString stringWithFormat:@"%02ld",seconds/3600];
    }else{
        str_hour = [NSString stringWithFormat:@"%02ld",seconds/3600];
    }
    // 分钟
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(seconds%3600)/60];
    // 秒
    NSString *str_second = [NSString stringWithFormat:@"%02ld",seconds%60];
    
    // 时间格式
    NSString *format_time;
    if(![str_hour isEqualToString:@"00"]) {
        format_time = [NSString stringWithFormat:@"%@:%@:%@",str_hour,str_minute,str_second];
    } else if (![str_minute isEqualToString:@"00"] || ![str_second isEqualToString:@"00"]) {
        format_time = [NSString stringWithFormat:@"%@:%@",str_minute,str_second];
    } else {
        format_time = @"00:00";
    }
    return format_time;
}

/// 传入秒 转换 为时间类型字符串  得到 xx:xx:xx 或 xx:xx
/// @param totalTime 总秒数
/// @param isShowDay 是否显示天数 ， NO 直接显示小时数
+ (NSString *)getHHMMSSFromSS:(NSString *)totalTime isShowDay:(BOOL)isShowDay {
    NSInteger seconds = [totalTime integerValue];
    // 小时
    NSString *str_hour = nil;
    if(seconds/3600/24 > 0) {
        if (isShowDay) {
            str_hour = [NSString stringWithFormat:@"%ld天%02ld",seconds/3600/24,seconds%(3600*24)/3600];
        } else {
            str_hour = [NSString stringWithFormat:@"%02ld",seconds/3600];
        }
    } else {
        str_hour = [NSString stringWithFormat:@"%02ld",seconds/3600];
    }
    // 分钟
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(seconds%3600)/60];
    // 秒
    NSString *str_second = [NSString stringWithFormat:@"%02ld",seconds%60];
    
    // 时间格式
    NSString *format_time;
    if(![str_hour isEqualToString:@"00"]) {
        format_time = [NSString stringWithFormat:@"%@:%@:%@",str_hour,str_minute,str_second];
    } else if (![str_minute isEqualToString:@"00"] || ![str_second isEqualToString:@"00"]) {
        format_time = [NSString stringWithFormat:@"%@:%@",str_minute,str_second];
    } else {
        format_time = @"00:00";
    }
    return format_time;
}


/// 字符串转时间戳 如：2017-4-10 17:15:10
/// 时间格式   如：YYYY-MM-dd HH:mm:ss
/// 是否精确到毫秒 默认秒
+ (NSString *)getTimeStrWithString:(NSString *)str timeFormat:(NSString *)timeFormat {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];// 创建一个时间格式化对象
    [dateFormatter setDateFormat:timeFormat]; //设定时间的格式
    NSDate *tempDate = [dateFormatter dateFromString:str];//将字符串转换为时间对象
    NSString *timeStr = [NSString stringWithFormat:@"%ld", (long)[tempDate timeIntervalSince1970]];//字符串转成时间戳,精确到毫秒*1000
    return timeStr;
}





#pragma mark -  一个类
+ (NSDateComponents *)getDateComponents
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *now = [NSDate date];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    
    NSDateComponents *comps = [calendar components:unitFlags fromDate:now];
    return comps;
}

+ (NSDateComponents *)getDateComponentsWithDate:(NSDate *)date
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    
    NSDateComponents *comps = [calendar components:unitFlags fromDate:date];
    return comps;
}
+ (NSDateComponents *)convertTimeToDateComponents:(long long)time
{
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:time/1000];
    
    return [MFHTimeManager getDateComponentsWithDate:date];
}

+ (long long)convertDateToSecondTime:(NSDate *)date
{
    return [date timeIntervalSince1970]*1000;
}


+ (NSDate *)convertSecondsToDate:(long long)time
{
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:time/1000];
    return date;
}

+ (NSMutableArray *)getNextPageDays:(int)page
{
    int count = 10;
    NSMutableArray * arr = [[NSMutableArray alloc]init];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd EEEE";
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    [dateFormatter setTimeZone:timeZone];
    
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    for (int i = 0; i<count; i++) {
        [comps setDay:-(((page-1) * count)+i)];
        NSDate *newdate = [calendar dateByAddingComponents:comps toDate:[NSDate date] options:0];
        [arr addObject:[dateFormatter stringFromDate:newdate]];
    }
    return arr;
}

+ (NSString *)getWeekDayInweekWithDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"EEEE";
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    [dateFormatter setTimeZone:timeZone];
    NSString *weekDayStr = [dateFormatter stringFromDate:date];
    return weekDayStr;
}

+ (NSDate *)getYesterDay:(NSDate *)date
{

    NSDate *yesterday = [date dateAfterDay:-1];
    
    return yesterday;
}

//
+ (NSDate *)getBeginDateInWeekWith:(NSDate *)date
{
    NSDate *weekDate = [date beginningOfWeek];
    NSDate *beginDate = [weekDate dateAfterDay:1];
    return beginDate;
}

+ (NSDate *)getEndDateInWeekWithDate:(NSDate *)date
{
    NSDate *SaturdayDate = [date endOfWeek];
    NSDate *endDate = [SaturdayDate dateAfterDay:1];
    return endDate;
}

+ (NSDate *)getlastWeekDayDateWithDate:(NSDate *)date
{
    NSDate *weekDate = [date beginningOfWeek];
    return weekDate;
}

+ (NSDate *)getlastFirstDayDateWithDate:(NSDate *)date
{
    NSDate *lastWeekDate = [MFHTimeManager getlastWeekDayDateWithDate:date];
    NSDate *firstDayDate = [lastWeekDate dateAfterDay:-6];
    return firstDayDate;
}

+ (NSDate *)getFirstDayDateInCurrentDateMonthWithDate:(NSDate *)date
{
    NSDate *firstDate = [date beginningOfMonth];
    return firstDate;
}

+ (NSDate *)getEndDayDateInCurrentDateMonthWithDate:(NSDate *)date
{
    NSDate *endDate = [date endOfMonth];
    return endDate;
}


+ (NSDate *)getEndDayDateInLastMonthOfDateWithDate:(NSDate *)date
{
    NSDate *beginDateInCurrentMonth = [MFHTimeManager getFirstDayDateInCurrentDateMonthWithDate:date];
    NSDate *lastMonthEndDate = [beginDateInCurrentMonth dateAfterDay:-1];
    return lastMonthEndDate;
}

+ (NSDate *)getFirstDayDateInLastMonthOfDateWithDate:(NSDate *)date
{
    NSDate *endDateForLastMonth = [MFHTimeManager getEndDayDateInLastMonthOfDateWithDate:date];
    NSDate *firstDateForLastMonth = [MFHTimeManager getFirstDayDateInCurrentDateMonthWithDate:endDateForLastMonth];
    return firstDateForLastMonth;
}

+ (NSDate *)dateFromString:(NSString *)str
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    NSTimeZone *timeZone = [NSTimeZone defaultTimeZone];
    [dateFormatter setTimeZone:timeZone];
    NSDate *date = [dateFormatter dateFromString:str];
    return date;
}

+ (NSDate *)timeFromString:(NSString *)str andFormat:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = format;
    NSTimeZone *timeZone = [NSTimeZone defaultTimeZone];
    [dateFormatter setTimeZone:timeZone];
    NSDate *date = [dateFormatter dateFromString:str];
    return date;
}

+ (NSString *)getYearMonthDayWithDate:(NSDate *)date
{
    NSDateComponents *comps = [MFHTimeManager getDateComponentsWithDate:date];
    NSString *dateStr = [NSString stringWithFormat:@"%ld-%02ld-%02ld",(long)comps.year,(long)comps.month,(long)comps.day];
    return dateStr;
}

+ (NSString *)getYearMonthDayWithDateInChinese:(NSDate *)date
{
    NSDateComponents *comps = [MFHTimeManager getDateComponentsWithDate:date];
    NSString *dateStr = [NSString stringWithFormat:@"%ld年%02ld月%02ld日",(long)comps.year,(long)comps.month,(long)comps.day];
    return dateStr;
}

+ (NSString *)getDateStringWithDate:(NSDate *)date andFormat:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = format;
    NSTimeZone *timeZone = [NSTimeZone defaultTimeZone];
    [dateFormatter setTimeZone:timeZone];
    NSString *dateStr = [dateFormatter stringFromDate:date];
    return dateStr;
}

@end
