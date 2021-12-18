//
//  BaccaratXiaSanLuView.h
//  VVCollectProject
//
//  Created by Admin on 2021/12/19.
//  Copyright © 2021 Mike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaccaratCom.h"

NS_ASSUME_NONNULL_BEGIN

/// 下三路视图
@interface BaccaratXiaSanLuView : UIView
/// 路图类型
@property (nonatomic, assign) RoadMapType roadMapType;
@property (nonatomic, strong) NSMutableArray *dyl_DataArray;


@end

NS_ASSUME_NONNULL_END
