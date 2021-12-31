//
//  BStatisticsView.h
//  VVCollectProject
//
//  Created by Admin on 2021/12/31.
//  Copyright © 2021 Mike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BUserData.h"

NS_ASSUME_NONNULL_BEGIN

@interface BStatisticsAlertView : UIView
/// 用户数据
@property(nonatomic,strong) BUserData *bUserData;

-(void)showAlertAnimation;

@end

NS_ASSUME_NONNULL_END
