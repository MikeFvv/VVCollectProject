//
//  HackerViewController.m
//  VVCollectProject
//
//  Created by 罗耀生 on 2019/4/13.
//  Copyright © 2019 Mike. All rights reserved.
//

#import "HackerViewController.h"

@interface HackerViewController ()

@end

@implementation HackerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
  NSString *stt =  [self imageToString:[UIImage imageNamed:@"test-11"]];
    NSLog(@"11");
    
}


- (NSString *)imageToString:(UIImage *)image {
    NSData *imagedata = UIImagePNGRepresentation(image);NSString *image64 = [imagedata base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];return image64;
    
}


//类方法  图片 转换为二进制
-(NSData *)Image_TransForm_Data:(UIImage *)image
{
    NSData *imageData = UIImageJPEGRepresentation(image , 0.5);
    //几乎是按0.5图片大小就降到原来的一半 比如这里 24KB 降到11KB
    return imageData;
}

// Base64编码：
- (NSString *)encode:(NSString *)string{
    //先将string转换成data
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSData *base64Data = [data base64EncodedDataWithOptions:0];
    NSString *baseString = [[NSString alloc]initWithData:base64Data encoding:NSUTF8StringEncoding];
    return baseString;
}

// Base64解码：
- (NSString *)dencode:(NSString *)base64String {
    NSData *data = [[NSData alloc]initWithBase64EncodedString:base64String options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSString *string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    return string;
}

/**
 当前时间是否在时间段内 (忽略年月日)
 
 @param startTime @"HH:mm"
 @param expireTime @"HH:mm"
 @return BOOL
 */
- (BOOL)judgeTimeByStartAndEnd:(NSString *)startTime withExpireTime:(NSString *)expireTime {
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    // 时间格式,此处遇到过坑,建议时间HH大写,手机24小时进制和12小时禁止都可以完美格式化
    [dateFormat setDateFormat:@"HH:mm"];
    NSString *todayStr=[dateFormat stringFromDate:today];//将日期转换成字符串
    today=[ dateFormat dateFromString:todayStr];//转换成NSDate类型。日期置为方法默认日期
    //startTime格式为 02:22   expireTime格式为 12:44
    NSDate *start = [dateFormat dateFromString:startTime];
    NSDate *expire = [dateFormat dateFromString:expireTime];
    
    if ([today compare:start] == NSOrderedDescending && [today compare:expire] == NSOrderedAscending) {
        return YES;
    }
    return NO;
}

@end
