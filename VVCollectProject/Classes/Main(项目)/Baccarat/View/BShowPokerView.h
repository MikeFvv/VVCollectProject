//
//  BShowPokerView.h
//  VVCollectProject
//
//  Created by Admin on 2021/12/17.
//  Copyright © 2021 Mike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PokerCardModel.h"
#import "MXWPokerView.h"
#import "BaccaratResultModel.h"

NS_ASSUME_NONNULL_BEGIN


@protocol BShowPokerViewDelegate <NSObject>
@optional
/// 翻牌结束
- (void)endFlop;

@end

/// 展示牌型视图   扑克牌视图
@interface BShowPokerView : UIView
///
@property (nonatomic, strong) BaccaratResultModel *resultModel;
@property (nonatomic, weak) id<BShowPokerViewDelegate> delegate;

/// 移除视图
- (void)removeStackView;

@end

NS_ASSUME_NONNULL_END
