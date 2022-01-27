//
//  Macros.h
//  Project
//
//  Created by blom on 2019/1/13.
//  Copyright © 2019 CDJay. All rights reserved.
//

#ifndef Macros_h
#define Macros_h


#pragma mark - DebugLog 输出打印
#ifdef DEBUG
# define DLog(format, ...) printf("\n%s HHLog %s(line%d) %s\n%s\n\n", __TIME__, [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, __PRETTY_FUNCTION__, [[NSString stringWithFormat:(format), ##__VA_ARGS__] UTF8String]);
#else
# define DLog(...);
#endif


#pragma mark - weakify 弱引用
/**
Synthsize a weak or strong reference.

Example:
@weakify(self)
[self doSomething^{
@strongify(self)
if (!self) return;
...
}];

*/
#ifndef weakify
    #if DEBUG
        #if __has_feature(objc_arc)
            #define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
        #else
            #define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
        #endif
    #else
        #if __has_feature(objc_arc)
            #define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
        #else
            #define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
        #endif
    #endif
#endif


#ifndef strongify
    #if DEBUG
        #if __has_feature(objc_arc)
            #define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
        #else
            #define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
        #endif
    #else
        #if __has_feature(objc_arc)
            #define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
        #else
            #define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
        #endif
    #endif
#endif


#pragma mark - RGB颜色
#define RGB(r,g,b)          [UIColor colorWithRed:(r)/255.f \
green:(g)/255.f \
blue:(b)/255.f \
alpha:1.f]


#pragma mark - 图片URL路径path  主URL拼接 暂用 这里不可用
//
#define SERVER_IMAGE(image) \
    [image hasPrefix:@"http://"] || [image hasPrefix:@"https://"] ? \
    [NSURL URLWithString:image] : \
    [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", @"www.baidu.com", image]]


#endif /* Macros_h */
