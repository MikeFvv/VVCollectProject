//
//  BAutoRunView.h
//  VVCollectProject
//
//  Created by Admin on 2022/2/6.
//  Copyright © 2022 Mike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BAutoRunModel.h"
NS_ASSUME_NONNULL_BEGIN


@protocol BAutoRunViewDelegate <NSObject>
@optional
/// 自动运行
- (void)didAutoRunModel:(BAutoRunModel *)model;

@end


@interface BAutoRunView : UIView
/// 数据
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, weak) id<BAutoRunViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
