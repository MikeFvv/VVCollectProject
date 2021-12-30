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
- (void)sureBetBtnClick:(UIButton *)sender;
/// 取消注码
- (void)cancelBetChipsBtnClick:(UIButton *)sender;
/// 重复下注
- (void)repeatBetBtnClick;
/// 全押
- (void)allInBetBtnClick;


@end

/// 筹码视图
@interface ChipsView : UIView

@property (nonatomic, weak) id<ChipsViewDelegate> delegate;
/// 当前余额
@property (nonatomic, assign) NSInteger currentBalance;
/// 是否显示取消注码按钮
@property (nonatomic, assign) BOOL isShowCancelBtn;
/// 是否显示确定下注按钮
@property (nonatomic, assign) BOOL isShowSureButton;

/// 是否显示重复下注按钮
@property (nonatomic, assign) BOOL isRepeatBetBtn;
/// 是否显示全押下注按钮
@property (nonatomic, assign) BOOL isAllInBetBtn;

- (void)showView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
