//
//  NSStringController.m
//  VVCollectProject
//
//  Created by Mike on 2019/3/18.
//  Copyright © 2019 Mike. All rights reserved.
//

#import "NSStringController.h"

@interface NSStringController ()

@end

@implementation NSStringController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    #pragma mark - 截取字符串
    // 截取中间需要字符 wangwangwhb
    NSString *string =  @"http://api.这是要截取的内容.com/api/";
    NSRange startRange = [string rangeOfString:@"//api."];
    NSRange endRange = [string rangeOfString:@".com"];
    NSRange range = NSMakeRange(startRange.location + startRange.length, endRange.location - startRange.location - startRange.length);
    NSString *result = [string substringWithRange:range];
    
    NSLog(@"%@",result);
    
    
    
    
    //截取掉下标7之前的字符串
    NSString *string1 = @"123456789";
    string1 = [string1  substringToIndex:7];//（length为7）
    NSLog(@"截取的值为：%@",string1);//输出结果为1234567
    
    //截取掉下标2之后的字符串
    NSString *string2 = @"123456789";
    string2  = [string2 substringFromIndex:2];
    NSLog(@"截取的值为：%@",string2);//输出结果为3456789
    
    //截取字符串最后3位
    NSString *string3 = @"123456789";
    string3 = [string3 substringFromIndex:string3.length- 3];
    NSLog(@"截取的值为：%@",string3);//输出结果为789
    //即当截取字符串后n位时,公式为：
    //string = [sting substringfromIndex:string.length-n];
    
}

 #pragma mark - 匹配字符串
- (void)bbbb {

NSString *string = @"18355161287";
//匹配得到的下标
NSRange range = [string rangeOfString:@"2"];
NSLog(@"range:%@",NSStringFromRange(range));//输出结果为{8,1}
NSRange range2 = [string rangeOfString:@"12"];
NSLog(@"%@",NSStringFromRange(range2));//输出结果为{7，2}
NSString *string1 = [string substringWithRange:range];//截取范围内的字符串
NSLog(@"截取的值为：%@",string1);//输出的值为2

    
}

#pragma mark - 替换中间部分字符
- (void)cccc {
    NSString *string = @"18355161287";
    NSString *numberString = [string stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"]; //隐藏手机号中间四位数
    NSLog(@"%@",numberString);//输出结果为183****1287
    
}
#pragma mark - 分隔字符串
- (void)dddd {
    NSString *string = @"18355161287";
    NSString *numberString = [string stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"]; //隐藏手机号中间四位数
    NSLog(@"%@",numberString);//输出结果为183****1287
    
}

#pragma mark - 拼接字符串
- (void)ffff {
    NSString *sting1 = @"1835516";
    NSString *string2 = @"1287";
    NSString *string = [sting1 stringByAppendingString:string2];
    //NSString *string = [NSString stringWithFormat:@"%@%@",string1,string2];
    //如果是可变字符串可用：[string1 appendString:string2]
    NSLog(@"%@",string); //输出结果为18355161287
    
    
}

#pragma mark - 字符串大小写转换
- (void)gggg {
    NSString *string1 = @"abcd123";
    NSString *string2 = @"XYZQ456";
    //将字符串的英文字符由小写转换成大写
    NSString *bigString = [string1 uppercaseString];
    NSLog(@"%@",bigString); //输出结果为ABCD123
    //将字符串的英文字符由大写转换为小写
    NSString *smallString = [string2 lowercaseString];
    NSLog(@"%@",smallString);//输出结果为xyzq456
    //将字符串的首字母改为大写
    NSString *firstbig = [string1 capitalizedString];
    NSLog(@"%@",firstbig);//输出结果为Abcd123
   
    
    
}

#pragma mark - 可变字符串的增删改查
- (void)hhhh {
    //可变字符串拼接
    NSMutableString *string = [[NSMutableString alloc]initWithString:@"123"];
    [string appendString:@"45"];
    NSLog(@"%@",string);//输出结果12345
    //可变字符串替换
    NSMutableString *string2 = [[NSMutableString alloc]initWithString:@"123"];
    [string2 replaceCharactersInRange:NSMakeRange(1,2) withString:@"78"];
    NSLog(@"%@",string2); //输出结果178
    //可变字符串的插入
    NSMutableString *string3 = [[NSMutableString alloc]initWithString:@"123"];
    [string3 insertString:@"56" atIndex:1];
    NSLog(@"%@",string3);//输出结果15623
    //可变字符串删除字符串
    NSMutableString *string4 = [[NSMutableString alloc]initWithString:@"123"];
    [string4 deleteCharactersInRange:NSMakeRange(1, 1)];
    NSLog(@"%@",string4);//输出结果13
    
    
}

#pragma mark - 给字符串某段字符润色
- (void)iiii {
    NSString *contentStr = @"已阅读并同意聚奢网平台协议";
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:contentStr];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, 6)];
    //同样如果是改变字符串中某段字体的大小可以这样写：
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(0, 6)];
    
    
}

@end
