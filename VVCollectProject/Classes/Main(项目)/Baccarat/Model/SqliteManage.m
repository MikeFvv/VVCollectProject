//
//  SqliteManage.m
//  WRHB
//
//  Created by AFan on 2019/11/9.
//  Copyright © 2018年 AFan. All rights reserved.
//

#import "SqliteManage.h"
#import "WHC_ModelSqlite.h"
#import "BUserData.h"

@implementation SqliteManage
+ (SqliteManage *)sharedInstance {
    static SqliteManage *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;
}

-(BOOL)insertSql:(BUserData *)userData {
    
    BOOL isSuccess = NO;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        BOOL isSuccess = [WHCSqlite insert:userData];
        if (isSuccess) {
            NSLog(@"成功");
        }
        NSLog(@"线程1.存储单个模型对象到数据库演示代码");
    });
    return isSuccess;
}

-(BOOL)updateSql:(BUserData *)userData {
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
      BOOL result = [WHCSqlite update:userData
                          where:@"name = '吴超1000' OR age >= 1000"];
        if (result) {
            NSLog(@"成功");
        }
        
    });
    return YES;
}




+ (BUserData *)queryPushMessageNumModelById:(NSInteger)sessionId {
    NSString *queryWhere = [NSString stringWithFormat:@"sessionId='%ld' AND userId='%ld'",(long)sessionId,(long)[AppModel sharedInstance].user_info.userId];
    return [[WHC_ModelSqlite query:[BUserData class] where:queryWhere] firstObject];
}


// 删除数据库
+ (void)clean {
    [WHC_ModelSqlite removeModel:[BUserData class]];
}


// 删除本地所有数据库
//[WHCSqlite removeAllModel];


@end
