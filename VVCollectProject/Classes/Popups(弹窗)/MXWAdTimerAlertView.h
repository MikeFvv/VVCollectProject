//
//  MXWAdTimerAlertView.h
//  小黄鸭
//
//  Created by Admin on 2021/12/3.
//  Copyright © 2021 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MXWAdTimerAlertViewDelegate <NSObject>

-(void)clickAlertViewAtIndex:(NSInteger)index;

@end

@interface MXWAdTimerAlertView : UIView

@property (nonatomic, assign)id<MXWAdTimerAlertViewDelegate> delegate;

+(MXWAdTimerAlertView *)showInView:(UIView *)view theDelegate:(id)delegate theADInfo: (NSArray *)dataList placeHolderImage: (NSString *)placeHolderStr;

@end


@interface MXWItemView : UIView
/// 记录当前第几个item
@property (nonatomic, assign)NSInteger index;
/// 自定义视图
@property (nonatomic,strong)UIImageView *imageView;
/// 倒计时Label
@property (nonatomic,strong)UILabel *countdownTimeLabel;
/// 倒计时
@property (nonatomic,strong) NSTimer *mxwTimer;
///  倒计时时长
@property (nonatomic, assign) NSTimeInterval count_down;

@end

NS_ASSUME_NONNULL_END


