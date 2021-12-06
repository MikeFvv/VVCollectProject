//
//  MXWAdModel.m
//  小黄鸭
//
//  Created by blom on 2021/12/3.
//  Copyright © 2021 iOS. All rights reserved.
//

#import "MXWAdModel.h"

@implementation MXWAdModel
/**
 *  将属性名换为其他key去字典中取值
 *
 *  @return 字典中的key是属性名，value是从字典中取值用的key
 */
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
        @"ID": @"id",
        @"imgStr": @"img_url",
    };
}
@end
