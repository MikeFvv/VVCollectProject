//
//  WinLoseModel.h
//  VVCollectProject
//
//  Created by Admin on 2022/2/18.
//  Copyright © 2022 Mike. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WinLoseModel : NSObject
/// 创建时间
@property (nonatomic, copy) NSString *create_time;
/// 更新时间
@property (nonatomic, copy) NSString *update_time;
/// 赢输金额
@property (nonatomic, strong) NSString *money;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *des;


+ (instancetype)dealWithDict:(NSDictionary *)dictionary;

@end
