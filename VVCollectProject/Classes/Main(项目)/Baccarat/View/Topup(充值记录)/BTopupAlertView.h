//
//  BTopupAlertView.h
//  VVCollectProject
//
//  Created by Admin on 2022/1/25.
//  Copyright © 2022 Mike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BalanceRecordModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BTopupAlertViewDelegate <NSObject>
@optional
/// 充值
- (void)didTopup:(BalanceRecordModel *)model;

@end



@interface BTopupAlertView : UIView
/// 充值数据
@property (nonatomic, strong) NSArray *dataArray;

-(void)showAlertAnimation;

@property (nonatomic, weak) id<BTopupAlertViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
