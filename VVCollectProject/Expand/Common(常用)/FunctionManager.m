//
//  FunctionManager.m
//  LotteryBoxT
//
//  Created by Mike on 06/02/2020.
//  Copyright © 2020 fhcq. All rights reserved.
//

#import "FunctionManager.h"
//#import "FLAnimatedImage.h"

@implementation FunctionManager
/**
 gif图片转换
 
 @param imgName 图片名称
 @return 转换后的 gif FLAnimatedImage
 */
//+ (FLAnimatedImage *)gifFLAnimatedImageStr:(NSString *)imgName {
//    NSURL *url1 = [[NSBundle mainBundle] URLForResource:imgName withExtension:@"gif"];
//    NSData *data1 = [NSData dataWithContentsOfURL:url1];
//    FLAnimatedImage *animatedImage1 = [FLAnimatedImage animatedImageWithGIFData:data1];
//    return  animatedImage1;
//}


#pragma mark - 版本号比对 返回是否提示更新
/// 版本和比对 返回是否提示更新
/// @param newVersion 新的版本号
+ (BOOL)isEqualNewVersion:(NSString *)newVersion {
    
    if (!newVersion || [newVersion isEqualToString:@""]) {
        return NO;
    }
    // 获得忽略的版本
    NSString *ignoreVersion = [[NSUserDefaults standardUserDefaults] objectForKey:@"ingoreVersion"];
    // 获得当前的版本
    NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    
    // [A compare:B]
    // NSOrderedAscending 判断两对象值的大小(按字母顺序进行比较，B大于A为真)
    // NSOrderedDescending 判断两对象值的大小(按字母顺序进行比较，B小于A为真)
    // NSOrderedSame 判断两者内容是否相同
    if ([currentVersion compare:newVersion] == NSOrderedDescending || [currentVersion compare:newVersion] == NSOrderedSame || [ignoreVersion isEqualToString:newVersion]) {
        return NO;
    } else {
        return YES;
    }
}


#pragma mark - 竖屏横屏
/**
 *  强制屏幕转屏
 *
 *  @param orientation 屏幕方向
 */
+ (void)interfaceOrientation:(UIInterfaceOrientation)orientation {
    // arc下
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector             = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val                  = orientation;
        // 从2开始是因为0 1 两个参数已经被selector和target占用
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}


#pragma mark - 把大长串的数字做单位处理 转换万单位

/// 把大长串的数字做单位处理 转换万单位
/// @param amountStr 需要转换的数字
+ (NSString *)changeAsset:(NSString *)amountStr {
    if (amountStr && ![amountStr isEqualToString:@""]) {
        NSInteger num = [amountStr integerValue];
        if (num<10000) {
            return amountStr;
        } else {
            NSString *str = [NSString stringWithFormat:@"%.2f",num/10000.00];
            NSRange range = [str rangeOfString:@"."];
            str = [str substringToIndex:range.location+3];
            if ([str hasSuffix:@".0"]) {
                return [NSString stringWithFormat:@"%@万",[str substringToIndex:str.length-2]];
            } else
                return [NSString stringWithFormat:@"%@万",str];
        }
    } else
        return @"0";
}



/// 一天只执行一次 是否第一次 YES   NO
/// @param dateKey 当前日期Key  存储在偏好设置中  例如： @“ nowDate”
+ (BOOL)executeOnceDayKey:(NSString *)dateKey {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    //    NSLog(@"之前时间：%@", [userDefault objectForKey:@"nowDate"]);//之前存储的时间
    //    NSLog(@"现在时间%@",[NSDate date]);//现在的时间
    NSDate *now = [NSDate date];
    NSDate *agoDate = [userDefault objectForKey:dateKey];
     
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
     
    NSString *ageDateString = [dateFormatter stringFromDate:agoDate];
    NSString *nowDateString = [dateFormatter stringFromDate:now];
    //    NSLog(@"日期比较：之前：%@ 现在：%@",ageDateString,nowDateString);
     
    if ([ageDateString isEqualToString:nowDateString]) {
        return NO;
     }else{
        // 需要执行的方法写在这里
         NSLog(@"一天就显示一次");
        NSDate *nowDate = [NSDate date];
        NSUserDefaults *dataUser = [NSUserDefaults standardUserDefaults];
        [dataUser setObject:nowDate forKey:dateKey];
        [dataUser synchronize];
        return YES;
     }
}

@end
