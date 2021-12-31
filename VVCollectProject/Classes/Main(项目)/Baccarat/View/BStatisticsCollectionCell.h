//
//  BStatisticsCollectionCell.h
//  VVCollectProject
//
//  Created by Admin on 2021/12/31.
//  Copyright © 2021 Mike. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BStatisticsCollectionCell : UICollectionViewCell

/// 标题
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *numLabel;

@end

NS_ASSUME_NONNULL_END
