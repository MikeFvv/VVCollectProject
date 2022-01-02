//
//  BGameRecordAlertView.h
//  VVCollectProject
//
//  Created by Admin on 2022/1/2.
//  Copyright © 2022 Mike. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BGameRecordAlertView : UIView
/// 结果数据
@property (nonatomic, strong) NSMutableArray *zhuPanLuResultDataArray;

-(void)showAlertAnimation;
@end

NS_ASSUME_NONNULL_END
