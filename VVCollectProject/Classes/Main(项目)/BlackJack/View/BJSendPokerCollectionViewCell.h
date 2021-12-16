//
//  BJSendPokerCollectionViewCell.h
//  VVCollectProject
//
//  Created by Admin on 2021/12/11.
//  Copyright © 2021 Mike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PokerCardModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BJSendPokerCollectionViewCell : UICollectionViewCell

/// 设置模型数据
@property (nonatomic, strong) PokerCardModel *model;

- (void)clearDataContent;

@end

NS_ASSUME_NONNULL_END
