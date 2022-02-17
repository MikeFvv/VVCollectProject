//
//  WinLoseModel.m
//  VVCollectProject
//
//  Created by Admin on 2022/2/18.
//  Copyright © 2022 Mike. All rights reserved.
//

#import "WinLoseModel.h"

@implementation WinLoseModel

+ (instancetype)dealWithDict:(NSDictionary *)dictionary
{
    WinLoseModel *deal = [[self alloc] init];
    
    //KVC
    [deal setValuesForKeysWithDictionary:dictionary];
    
    return deal;
}

@end
