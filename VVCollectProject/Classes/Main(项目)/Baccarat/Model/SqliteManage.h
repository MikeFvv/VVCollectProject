//
//  SqliteManage.h
//  WRHB
//
//  Created by AFan on 2019/11/9.
//  Copyright © 2018年 AFan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BUserData;
@interface SqliteManage : NSObject

+ (SqliteManage *)sharedInstance;

//数据库增删改查
-(BOOL)insertSql:(BUserData *)userData;
-(BOOL)updateSql:(BUserData *)userData;
-(BOOL)deleteSql;
-(BOOL)deleteAllSql;



+ (void)removePushMessageNumModelSql:(NSInteger)groupId;
+ (BUserData *)queryPushMessageNumModelById:(NSInteger)groupId;

+ (void)clean;


@end
