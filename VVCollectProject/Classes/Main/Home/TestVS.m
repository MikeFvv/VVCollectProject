//
//  TestVS.m
//  VVCollectProject
//
//  Created by 罗耀生 on 2019/6/5.
//  Copyright © 2019 Mike. All rights reserved.
//

#import "TestVS.h"

@interface TestVS ()

@end

@implementation TestVS


- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"1");
}

- (void)viewDidAppear:(BOOL)animated {
    NSLog(@"2");
}

+ (void)load {
    NSLog(@"3");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 3 4 1 5 2  // 正常 是这个   需要考虑 不加载显示控制器 直接算view 还有动画影响
    NSLog(@"4");
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"5");
    });
}



@end
