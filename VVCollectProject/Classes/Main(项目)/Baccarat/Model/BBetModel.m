//
//  BBetModel.m
//  VVCollectProject
//
//  Created by Admin on 2021/12/26.
//  Copyright © 2021 Mike. All rights reserved.
//

#import "BBetModel.h"

@implementation BBetModel

- (NSInteger)total_bet_money {
    _total_bet_money = self.playerPair_money + self.tie_money + self.superSix_money + self.bankerPair_money + self.player_money + self.banker_money;
    return _total_bet_money;
}


- (NSInteger)winLose_money {
    _winLose_money = self.total_winLose_money - self.total_bet_money;
    return _winLose_money;
}

- (instancetype)modelCopy {
    id newObj = [[[self class] alloc] init];
    unsigned int count = 0;
    objc_property_t *props = class_copyPropertyList([self class], &count);
    for (unsigned int i = 0; i < count; i++) {
        const char *propName = property_getName(props[i]);
        if (!propName) continue;
        NSString *key = [NSString stringWithUTF8String:propName];
        @try {
            id value = [self valueForKey:key];
            if (!value || value == [NSNull null]) continue;
            if ([value respondsToSelector:@selector(copy)]) {
                id copyValue = [value copy];
                [newObj setValue:copyValue forKey:key];
            } else {
                [newObj setValue:value forKey:key];
            }
        } @catch (NSException *exception) {
            // 忽略不可 KVC 的属性（readonly 或 非对象类型等）
        }
    }
    free(props);
    return newObj;
}

@end
