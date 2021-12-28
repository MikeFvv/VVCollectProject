//
//  BaccaratBetView.h
//  VVCollectProject
//
//  Created by Admin on 2021/12/19.
//  Copyright © 2021 Mike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChipsModel.h"
#import "BBetModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BaccaratBetViewDelegate <NSObject>
@optional
/// 每次下注回调
- (void)everyBetClick:(UIButton *)sender;

@end

/// 下注庄闲视图
@interface BaccaratBetView : UIView
/// 选中的筹码
@property (nonatomic, strong) ChipsModel *selectedModel;
/// 下注金额
@property (nonatomic, strong) BBetModel *betModel;
@property (nonatomic, weak) id<BaccaratBetViewDelegate> delegate;


/// 取消下注筹码
- (void)cancelBetChips;

@end

NS_ASSUME_NONNULL_END
