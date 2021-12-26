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


/// 下注视图
@interface BaccaratBetView : UIView
@property (nonatomic, strong) ChipsModel *selectedModel;


/// 取消下注筹码
- (void)cancelBetChips;

@end

NS_ASSUME_NONNULL_END
