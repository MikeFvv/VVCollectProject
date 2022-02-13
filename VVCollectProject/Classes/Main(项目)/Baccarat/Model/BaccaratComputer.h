//
//  BaccaratComputer.h
//  VVCollectProject
//
//  Created by Admin on 2021/12/17.
//  Copyright © 2021 Mike. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaccaratCom.h"
#import "BaccaratResultModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface BaccaratComputer : NSObject

#pragma mark -   百家乐发牌停牌算法
/// 百家乐发牌停牌算法
/// @param index 发牌下标
/// @param player3 闲第张牌
/// @param playerTotalPoints 闲总点数
/// @param bankerTotalPoints 庄总点数
+ (BOOL)baccaratStopCardIndex:(NSInteger)index player3:(NSInteger)player3 playerTotalPoints:(NSInteger)playerTotalPoints bankerTotalPoints:(NSInteger)bankerTotalPoints;


/// 判断是否长龙
/// @param model 模型
/// @param colDataArray 列数据
+ (BOOL)isLongResultModel:(BaccaratResultModel *)model colDataArray:(NSArray *)colDataArray;
/// 计算最多可使用空白格数
/// @param currentColX 当前列X值
/// @param allColLastLabelArray 全部的长龙拐弯的的最后一个数据
/// @param width 列宽度
+ (NSInteger)getMaxBlankColumnsCurrentColX:(CGFloat)currentColX allColLastLabelArray:(NSMutableArray *)allColLastLabelArray width:(CGFloat)width;


#pragma mark -  路单发牌功能
/// 路单发牌功能
/// @param index 发牌下标
+ (NSString *)roadListSendCardIndex:(NSInteger)index winType:(WinType)winType pxsType:(PXSType)pxsType;

/// 测试使用  增加长庄长闲
+ (NSString *)testRandomRoadListIndex:(NSInteger)index testIndex:(NSInteger)testIndex;

@end

NS_ASSUME_NONNULL_END
