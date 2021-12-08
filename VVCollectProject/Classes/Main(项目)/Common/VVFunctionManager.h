//
//  VVFunctionManager.h
//  VVCollectProject
//
//  Created by Mike on 2019/3/11.
//  Copyright © 2019 Mike. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface VVFunctionManager : NSObject

#pragma mark - 洗牌方法
/// 洗牌方法
/// @param dataArray <#dataArray description#>
/// @param pokerPairsNum <#pokerPairsNum description#>
+ (NSMutableArray *)shuffleArray:(NSArray *)dataArray pokerPairsNum:(NSInteger)pokerPairsNum;

/// 点数转化为 牌面字符  例如 1 转化为 A
/// @param num 牌点数
+ (NSString *)pokerCharacter:(NSInteger)num;
@end


