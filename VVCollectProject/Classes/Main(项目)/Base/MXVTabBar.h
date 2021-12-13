//
//  MXVTabBar.h
//  BTCMining
//
//  Created by Mike on 2021/6/24.
//  Copyright © 2021年 MXV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MXVUpperButton.h"

@interface MXVTabBar : UITabBar

@property (nonatomic, strong) MXVUpperButton *UpperBtn;

/**
 *  原始方式：单例
 *  @return 返回一个实例
 */
+ (MXVTabBar *)singleton;

@end
