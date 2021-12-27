//
//  BUserChipssView.h
//  VVCollectProject
//
//  Created by Admin on 2021/12/27.
//  Copyright © 2021 Mike. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BUserChipssView : UIView
/// 用户名称
@property (nonatomic, strong) UILabel *nameLabel;
/// 用户头像
@property (nonatomic, strong) UIImageView *imgView;
/// 用户筹码量
@property (nonatomic, strong) UILabel *userMoneyLabel;

@end

NS_ASSUME_NONNULL_END
