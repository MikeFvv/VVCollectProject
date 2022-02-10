//
//  BaccaratComputer.h
//  VVCollectProject
//
//  Created by Admin on 2021/12/17.
//  Copyright © 2021 Mike. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaccaratCom.h"


NS_ASSUME_NONNULL_BEGIN

@interface BaccaratComputer : NSObject

#pragma mark -  路单发牌功能
/// 路单发牌功能
/// @param index 发牌下标
+ (NSString *)roadListSendCardIndex:(NSInteger)index winType:(WinType)winType pxsType:(PXSType)pxsType;

@end

NS_ASSUME_NONNULL_END
