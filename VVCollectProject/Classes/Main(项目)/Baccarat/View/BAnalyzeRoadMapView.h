//
//  BAnalyzeRoadMapView.h
//  VVCollectProject
//
//  Created by Admin on 2021/12/17.
//  Copyright © 2021 Mike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaccaratCom.h"
#import "BaccaratResultModel.h"
#import "BGameStatisticsModel.h"

NS_ASSUME_NONNULL_BEGIN

/// 分析路图  分析问路图 统计庄闲图
@interface BAnalyzeRoadMapView : UIView

@property (nonatomic, strong) BaccaratResultModel *currentModel;
/// 问路图数据
@property (nonatomic, strong) NSArray *wenLuDataArray;

@property (nonatomic, strong) BGameStatisticsModel *gameStatisticsModel;

@end

NS_ASSUME_NONNULL_END
