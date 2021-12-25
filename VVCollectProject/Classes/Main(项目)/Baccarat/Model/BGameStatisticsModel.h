//
//  BGameStatisticsModel.h
//  VVCollectProject
//
//  Created by Admin on 2021/12/26.
//  Copyright © 2021 Mike. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 游戏统计模型
@interface BGameStatisticsModel : NSObject
/// 庄家次数
@property (nonatomic, assign) NSInteger bankerNum;
/// 闲家次数
@property (nonatomic, assign) NSInteger playerNum;
/// 和局数
@property (nonatomic, assign) NSInteger tieNum;
/// 庄家对子次数
@property (nonatomic, assign) NSInteger bankerPairNum;
/// 闲家对子次数
@property (nonatomic, assign) NSInteger playerPairNum;
/// 超级6 次数
@property (nonatomic, assign) NSInteger superNum;
/// 游戏总局数
@property (nonatomic, assign) NSInteger gameNum;

@end

NS_ASSUME_NONNULL_END
