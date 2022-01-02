//
//  BPockerTextView.h
//  VVCollectProject
//
//  Created by Admin on 2022/1/2.
//  Copyright © 2022 Mike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PokerCardModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BPockerTextView : UIView
/// 设置模型数据
@property (nonatomic, strong) PokerCardModel *model;
@end

NS_ASSUME_NONNULL_END
