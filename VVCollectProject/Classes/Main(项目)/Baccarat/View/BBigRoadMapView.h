//
//  BaccaratRoadMapView.h
//  VVCollectProject
//
//  Created by lvan Lewis on 2019/9/19.
//  Copyright © 2019 Mike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaccaratResultModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BBigRoadMapViewDelegate <NSObject>
@optional
// 下三路、问路 数据代理
- (void)getXSLDataWithCurrentModel:(BaccaratResultModel *)currentModel wenLuDataArray:(NSMutableArray *)wenLuDataArray dylDataArray:(NSMutableArray *)dylDataArray xlDataArray:(NSMutableArray *)xlDataArray xqlDataArray:(NSMutableArray *)xqlDataArray;

// 问路 数据代理
- (void)getWenLuDataWithCurrentModel:(BaccaratResultModel *)currentModel wenLuDataArray:(NSMutableArray *)wenLuDataArray;

@end

/// *** 大路 ***
@interface BBigRoadMapView : UIView
/// 珠盘路数据
@property (nonatomic, strong) NSMutableArray<BaccaratResultModel *> *zhuPanLuResultDataArray;
@property (nonatomic, weak) id<BBigRoadMapViewDelegate> delegate;
/// 是否显示和
@property (nonatomic, assign) BOOL isShowTie;

//- (void)clearData;

/// 移除最后一个
- (void)removeLastSubview;

@end

NS_ASSUME_NONNULL_END

