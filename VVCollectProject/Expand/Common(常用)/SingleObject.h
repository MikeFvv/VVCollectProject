//
//  SingleObject.h
//  DP_Single
//
//  Created by  ZhuHong on 2018/1/3.
//  Copyright © 2018年 CoderHG. All rights reserved.
//

// 单例例子
#import <Foundation/Foundation.h>

// 防止有子类 (感谢评论区网友提醒)
__attribute__((objc_subclassing_restricted))
@interface SingleObject : NSObject

/**
 单例类方法

 @return 返回一个共享对象
 */
+ (instancetype)sharedInstance;

// 姓名
@property (nonatomic, copy) NSString* name;

@end
