//
//  BaccaratChipsView.h
//  VVCollectProject
//
//  Created by Admin on 2021/12/19.
//  Copyright © 2021 Mike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChipsModel.h"

NS_ASSUME_NONNULL_BEGIN


@protocol ChipsViewDelegate <NSObject>
@optional
/// 选中筹码后
/// @param selectedModel 选中筹码模型
- (void)chipsSelectedModel:(ChipsModel *)selectedModel;
/// 确定下注
- (void)sureBetBtnClick;
/// 取消注码
- (void)cancelBetChipsBtnClick;

@end

/// 筹码视图
@interface ChipsView : UIView
@property (nonatomic, strong) NSMutableArray<ChipsModel *> *dataArray;
@property (nonatomic, weak) id<ChipsViewDelegate> delegate;

- (void)showView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
