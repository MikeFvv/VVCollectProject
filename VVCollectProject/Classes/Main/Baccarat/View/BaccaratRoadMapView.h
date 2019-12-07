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

@interface BaccaratRoadMapView : UIView

@property (nonatomic, copy) HeadClickBlock headClickBlock;

+ (BaccaratRoadMapView *)headViewWithModel:(id)model;

@property (nonatomic,strong) id model;
// 路类型  0 庄闲路  1  大路
@property (nonatomic, assign) NSInteger roadType;


@end

NS_ASSUME_NONNULL_END

