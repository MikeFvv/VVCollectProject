//
//  BPBTButton.h
//  VVCollectProject
//
//  Created by Admin on 2022/2/10.
//  Copyright © 2022 Mike. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BPBTButtonViewDelegate <NSObject>
@optional
- (void)contentBtnClick:(UIButton *)sender;

@end


@interface BPBTButtonView : UIView

@property (nonatomic, strong) UIButton *contentBtn;
/// 庄对
@property (nonatomic, strong) UIView *bankerPairView;
/// 闲对
@property (nonatomic, strong) UIView *playerPairView;
/// 幸运6
@property (nonatomic, assign) UIView *superSixView;
@property (nonatomic, weak) id<BPBTButtonViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
