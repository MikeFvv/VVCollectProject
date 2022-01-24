//
//  BGameTopupRecordAlertView.h
//  VVCollectProject
//
//  Created by Admin on 2022/1/25.
//  Copyright © 2022 Mike. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BTopupRecordAlertView : UIView
/// 结果数据
@property (nonatomic, strong) NSArray *dataArray;

-(void)showAlertAnimation;
@end

NS_ASSUME_NONNULL_END
