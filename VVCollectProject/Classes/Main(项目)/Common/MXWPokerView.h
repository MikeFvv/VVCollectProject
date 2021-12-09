//
//  MXWPokerView.h
//  VVCollectProject
//
//  Created by Admin on 2021/12/9.
//  Copyright © 2021 Mike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardDataSourceModel.h"
#import "PlayCardModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface MXWPokerView : UIView

/// 数据模型
@property (nonatomic, copy) PlayCardModel *model;

/// 来源类型  默认 21点   1 百家乐
@property (nonatomic, assign) NSInteger fromType;
/// 数据清空
- (void)dataClear;

@end

NS_ASSUME_NONNULL_END
