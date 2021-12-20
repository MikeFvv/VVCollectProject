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
- (void)getXSLDataWithCurrentModel:(BaccaratResultModel *)currentModel wenLuDataArray:(NSMutableArray *)wenLuDataArray dylDataArray:(NSMutableArray *)dylDataArray xlDataArray:(NSMutableArray *)xlDataArray xqlDataArray:(NSMutableArray *)xqlDataArray;

@end

/// *** 大路 ***
@interface BBigRoadMapView : UIView

@property (nonatomic, strong) id model;
@property (nonatomic, weak) id<BBigRoadMapViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END

