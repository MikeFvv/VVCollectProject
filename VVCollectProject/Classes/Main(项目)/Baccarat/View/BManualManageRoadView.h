//
//  BManualManageRoadView.h
//  VVCollectProject
//
//  Created by Admin on 2022/2/10.
//  Copyright © 2022 Mike. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BManualManageRoadViewDelegate <NSObject>
@optional

/// 手动选择路子
/// @param buttonTag 选择 buttonTag  闲 1  庄 2 和 3 后退 4
- (void)didManualManageRoadSelectedClickButtonTag:(NSInteger)buttonTag;
/// 特殊选择
/// @param buttonTag 选择 buttonTag   闲对 5 庄对 6 超级6 7   赢 8
/// @param isSelected 是否选中
- (void)specialSelectedClickButtonTag:(NSInteger)buttonTag isSelected:(BOOL)isSelected;

@end


@interface BManualManageRoadView : UIView
@property (nonatomic, weak) id<BManualManageRoadViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
