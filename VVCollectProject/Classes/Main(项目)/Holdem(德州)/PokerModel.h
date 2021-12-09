//
//  PokerModel.h
//  VVCollectProject
//
//  Created by Admin on 2021/12/10.
//  Copyright © 2021 Mike. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
//  表示一张扑克牌
@interface PokerModel : NSObject

/// 花色类型
@property (nonatomic, assign) CardColorType colorTyp;
/// 牌面大小 1-13
@property (nonatomic, assign) NSInteger cardSizeValue;

@end

NS_ASSUME_NONNULL_END
