//
//  BaccaratRoadMapView.h
//  VVCollectProject
//
//  Created by lvan Lewis on 2019/9/19.
//  Copyright © 2019 Mike. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^HeadClickBlock)(NSInteger index);

/// *** 大路 ***
@interface BaccaratRoadMapView : UIView

@property (nonatomic, copy) HeadClickBlock headClickBlock;

@property (nonatomic, strong) id model;

@end

NS_ASSUME_NONNULL_END

