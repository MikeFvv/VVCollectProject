//
//  TestViewController.m
//  VVCollectProject
//
//  Created by 罗耀生 on 2019/2/18.
//  Copyright © 2019 Mike. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self testNSStringType];
}



/**
 字符串类型
 */
- (void)testNSStringType {
    
    NSString *str1 = nil;
    NSString *str2 = Nil;
    NSString *str3 = NULL;
    NSString *str4 = [NSNull null];
//     NSNull*str4 = [NSNull null];
    NSString *str5 = @"";
    NSLog(@" \r str1:%p\r str2:%p\r str3:%p\r str4:%p\r str5:%p\r", nil, NULL, Nil, [NSNull null], @"");
    NSLog(@"\r str1:%@\r str2:%@\r str3:%@\r str4:%@\r str5:%@\r", str1, str2, str3, str4, str5);
    
//    只有NSNull 对象类型不能，不能使用
    if ([str4 isEqual: @""]) { //程序崩溃  不能识别isEqual方法
        NSLog(@"1");
    }
    if (str4.length > 0) {   // 程序又崩溃 不能识别length属性
        NSLog(@"2");
    }
    
}



@end
