//
//  HXQMarqueeView.h
//  hxquan
//
//  Created by Tiny on 2018/3/2.
//  Copyright © 2018年 Tiny. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HXQMarqueeModel;
@interface HXQMarqueeView : UIView

/// 是否向左滑动
@property (nonatomic, assign) BOOL isLeftSlide;

-(void)setItems:(NSArray <HXQMarqueeModel *>*)items;

-(void)addMarueeViewItemClickBlock:(void(^)(HXQMarqueeModel *model))block;

-(void)stopAnimation;

-(void)startAnimation;


@end
