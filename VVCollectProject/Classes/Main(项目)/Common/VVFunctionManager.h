//
//  VVFunctionManager.h
//  VVCollectProject
//
//  Created by blom on 2019/3/11.
//  Copyright © 2019 Mike. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface VVFunctionManager : NSObject

#pragma mark - 洗牌方法
/// 洗牌方法
/// @param dataArray 一副牌模型数组
/// @param pokerPairsNum 多少副牌进入
+ (NSMutableArray *)shuffleArray:(NSArray *)dataArray pokerPairsNum:(NSInteger)pokerPairsNum;

/// 点数转化为 牌面字符  例如 1 转化为 A
/// @param num 牌点数
+ (NSString *)pokerCharacter:(NSInteger)num;

/// 转化输赢结果类型  返回字符
/// @param stringType 输赢类型
- (NSString *)bankerOrPlayerOrTie:(NSString *)stringType;

@end


