//
//  MXWTypeConversionManager.m
//  VVCollectProject
//
//  Created by Mike on 2021/7/4.
//  Copyright © 2021 Mike. All rights reserved.
//

#import "MXWTypeConversionManager.h"


/// ****** 数据类型转换类 ******
@implementation MXWTypeConversionManager


// 字符串格式说明符
// 苹果官网说明
// https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/Strings/Articles/formatSpecifiers.html


#pragma mark NSString 转 NSData

- (void)NSStringToNSData {
    NSString *str =@"str";
    NSData *data =[str dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@", data);
}

#pragma mark NSData 转 NSString
- (void)NSDataToNSString {
    int len = 2;
    Byte *bytes = malloc(sizeof(Byte) * len);
    NSData *data = [NSData dataWithBytes:bytes length:2];
//        free(bytes1);   // ??
    
    // 主要这句
    NSString *str =[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@", str);
}


#pragma mark BOOL 转 NSString
- (void)BOOLToNSString {
    BOOL  change = YES;
    NSString *string = [NSString stringWithFormat:@"%d",change];
    NSLog(@"%@", string);
}


#pragma mark NSString 转 int
- (void)NSStringToInt {
    NSString *str = @"123";
    int strInt = [str intValue];
    NSLog(@"%d", strInt);
}


#pragma mark NSString 转 float
- (void)NSStringToFloat {
    NSString *str = @"123.45";
    int strfloat = [str floatValue];
    NSLog(@"%f", strfloat);
}


#pragma mark 将基本类型转化成字符串类型-->字符串拼接
- (void)basicTypeToNSString {
    int count = 100;
    NSString *result = [NSString stringWithFormat:@"%d",count%4];
    NSLog(@"%@", result);
}



#pragma mark NSNumber 转 NSString
- (void)NSNumberToNSString {
    // 将int类型的10 包装成 一个NSNumber对象
    NSNumber *number = [NSNumber numberWithInt:10];
    NSLog(@"number=%@", number);
    
    NSString *string = [NSString stringWithFormat:@"%@",number];
    NSLog(@"%@", string);
}



#pragma mark NSData 转 char
- (void)NSDataTochar {
    NSData *data;
    char * haha=[data bytes];
}


#pragma mark char 转 NSData
- (void)charToNSData {
    Byte * byteData = malloc(sizeof(Byte)*16);
    NSData *content=[NSData dataWithBytes:byteData length:16];
}
#pragma mark int 转 NSNumber
- (void)intToNSNumber {
    NSNumber *numObj = [NSNumber numberWithInt: 2];
}


#pragma mark NSNumber 转 int
- (void)NSNumberToint {
    NSNumber *number = [NSNumber numberWithInt:10];
    NSString *string = [NSString stringWithFormat:@"%d",number];
    int Num = [string intValue];
    
    
   int numTest = [number intValue];  // ???
    
}



#pragma mark NSData 转 Byte数组

- (void)NSDataToByte {
    NSString *testStr3 = @"better";
    NSData *testData2 = [testStr3 dataUsingEncoding: NSUTF8StringEncoding];
    Byte *testByte1 = (Byte *)[testData2 bytes];
    for (int i = 0; i < [testData2 length]; i++)
    {
        NSLog(@"%d",testByte1[i]);
    }
}

#pragma mark Byte数组 转 NSData
- (void)ByteToNSData {
    Byte byteArr[] = {98,101,116,116,101,114};
    NSData *testData3 = [[NSData alloc] initWithBytes:byteArr length:sizeof(byteArr)/sizeof(Byte)];
    NSLog(@"%@",testData3);
}

#pragma mark 十六进制 转 十进制 (系统方法)
- (void)M16ToM10 {
    NSString *hexStr = @"A";
    NSUInteger testData4 = strtoul([hexStr UTF8String],0,16);
}
//十六进制字符串转数字
- (NSInteger)numberWithHexString:(NSString *)hexString {
    const char *hexChar = [hexString cStringUsingEncoding:NSUTF8StringEncoding];
    int hexNumber;
    sscanf(hexChar, "%x", &hexNumber);
    return (NSInteger)hexNumber;
}

#pragma mark 十进制 转 十六进制 (系统方法)
- (void)M10ToM16 {
    NSString *testHexStr = [NSString stringWithFormat:@"%@",[[NSString alloc] initWithFormat:@"%x",190]];
}

//数字转十六进制字符串
- (NSString *)stringWithHexNumber:(NSUInteger)hexNumber{
    
    char hexChar[6];
    sprintf(hexChar, "%x", (int)hexNumber);
    
    NSString *hexString = [NSString stringWithCString:hexChar encoding:NSUTF8StringEncoding];
    
    return hexString;
}





#pragma mark - 散方法

#pragma mark Josn字符串转字典
/// Josn字符串转字典 - 下面这个方法,就可以让json格式的字符串 转成 我们所需要的字典dict
/// @param jsonString json格式的字符串
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

#pragma mark 字典转json格式字符串
//字典转json格式字符串：
- (NSString *)dictionaryToJsonStr:(NSDictionary *)dict
{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&parseError];

    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}





#pragma mark - 一个类

//－－－－－－－－－－－－－－－－－－－－－－－－－－－包含了辩解码－－－－－－－－－－－－－－－－－－－－－－－－－－
+ (NSData *)dataWithString:(NSString *)aString
{
    if (aString == nil || aString.length == 0) {
        return nil;
    }
    NSData *data = [aString dataUsingEncoding:NSUTF8StringEncoding];
    return data;
}

+ (NSString *)stringWithData:(NSData *)aData
{
    if (aData == nil || aData.length == 0) {
        return nil;
    }
    NSString *str = [[NSString alloc] initWithData:aData encoding:NSUTF8StringEncoding];
    return str;
}


//－－－－－－－－－－－－－－－－－－－－－－－－－－－不含辩解码--------------------------------------
//NSData转成16进制字符串
+ (NSString *)stringWithHexBytes2:(NSData *)sender
{
    static const char hexdigits[] = "0123456789ABCDEF";
    const size_t numBytes = [sender length];
    const unsigned char* bytes = [sender bytes];
    char *strbuf = (char *)malloc(numBytes * 2 + 1);
    char *hex = strbuf;
    NSString *hexBytes = nil;
    
    for (int i = 0; i<numBytes; ++i) {
        const unsigned char c = *bytes++;
        *hex++ = hexdigits[(c >> 4) & 0xF];
        *hex++ = hexdigits[(c ) & 0xF];
    }
    
    *hex = 0;
    hexBytes = [NSString stringWithUTF8String:strbuf];
    
    free(strbuf);
    return hexBytes;
}

/*
 将16进制数据转化成NSData 数组
 */
+ (NSData*)dataWithHexBytesString:(NSString *)hexString
{
    int j=0;
    Byte bytes[hexString.length];
    for(int i=0;i<[hexString length];i++)
    {
        int int_ch;  /// 两位16进制数转化后的10进制数
        unichar hex_char1 = [hexString characterAtIndex:i]; ////两位16进制数中的第一位(高位*16)
        int int_ch1;
        if(hex_char1 >= '0' && hex_char1 <='9')
            int_ch1 = (hex_char1-48)*16;   //// 0 的Ascll - 48
        else if(hex_char1 >= 'A' && hex_char1 <='F')
            int_ch1 = (hex_char1-55)*16; //// A 的Ascll - 65
        else
            int_ch1 = (hex_char1-87)*16; //// a 的Ascll - 97
        i++;
        unichar hex_char2 = [hexString characterAtIndex:i]; ///两位16进制数中的第二位(低位)
        int int_ch2;
        if(hex_char2 >= '0' && hex_char2 <='9')
            int_ch2 = (hex_char2-48); //// 0 的Ascll - 48
        else if(hex_char2 >= 'A' && hex_char1 <='F')
            int_ch2 = hex_char2-55; //// A 的Ascll - 65
        else
            int_ch2 = hex_char2-87; //// a 的Ascll - 97
        
        int_ch = int_ch1+int_ch2;
        bytes[j] = int_ch;  ///将转化后的数放入Byte数组里
        j++;
    }
    
    NSData *newData = [[NSData alloc] initWithBytes:bytes length:hexString.length/2];
    return newData;
}

+(NSString *)parseByte2HexString:(Byte *)bytes
{
    NSMutableString *hexStr = [[NSMutableString alloc]init];
    int i = 0;
    if(bytes)
    {
        while (bytes[i] != '\0')
        {
            NSString *hexByte = [NSString stringWithFormat:@"%x",bytes[i] & 0xff];///16进制数
            if([hexByte length]==1)
                [hexStr appendFormat:@"0%@", hexByte];
            else
                [hexStr appendFormat:@"%@", hexByte];
            
            i++;
        }
    }
    return hexStr;
}

+(NSString *)parseByteArray2HexString:(Byte[])bytes
{
    NSMutableString *hexStr = [[NSMutableString alloc]init];
    int i = 0;
    if(bytes)
    {
        while (bytes[i] != '\0')
        {
            NSString *hexByte = [NSString stringWithFormat:@"%x",bytes[i] & 0xff];///16进制数
            if([hexByte length]==1)
                [hexStr appendFormat:@"0%@", hexByte];
            else
                [hexStr appendFormat:@"%@", hexByte];
            
            i++;
        }
    }
    return [hexStr uppercaseString];
}

+(NSString *) jsonStringWithString:(NSString *) string
{
    return [NSString stringWithFormat:@"\"%@\"",
            [[string stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"] stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""]
            ];
}

+(NSString *) jsonStringWithArray:(NSArray *)array
{
    NSMutableString *reString = [NSMutableString string];
    [reString appendString:@"["];
    NSMutableArray *values = [NSMutableArray array];
    for (id valueObj in array) {
        NSString *value = [MXWTypeConversionManager jsonStringWithObject:valueObj];
        if (value) {
            [values addObject:[NSString stringWithFormat:@"%@",value]];
        }
    }
    [reString appendFormat:@"%@",[values componentsJoinedByString:@","]];
    [reString appendString:@"]"];
    return reString;
}

+(NSString *) jsonStringWithDictionary:(NSDictionary *)dictionary
{
    NSArray *keys = [dictionary allKeys];
    NSMutableString *reString = [NSMutableString string];
    [reString appendString:@"{"];
    NSMutableArray *keyValues = [NSMutableArray array];
    for (int i=0; i<[keys count]; i++) {
        NSString *name = [keys objectAtIndex:i];
        id valueObj = [dictionary objectForKey:name];
        NSString *value = [MXWTypeConversionManager jsonStringWithObject:valueObj];
        if (value) {
            [keyValues addObject:[NSString stringWithFormat:@"\"%@\":%@",name,value]];
        }
    }
    [reString appendFormat:@"%@",[keyValues componentsJoinedByString:@","]];
    [reString appendString:@"}"];
    return reString;
}

+(NSString *) jsonStringWithObject:(id) object
{
    NSString *value = nil;
    if (!object) {
        return value;
    }
    if ([object isKindOfClass:[NSString class]]) {
        value = [MXWTypeConversionManager jsonStringWithString:object];
    }else if([object isKindOfClass:[NSDictionary class]]){
        value = [MXWTypeConversionManager jsonStringWithDictionary:object];
    }else if([object isKindOfClass:[NSArray class]]){
        value = [MXWTypeConversionManager jsonStringWithArray:object];
    }else if([object isKindOfClass:[NSNumber class]]){
        value =  [object stringValue];
    }
    return value;
}

@end
