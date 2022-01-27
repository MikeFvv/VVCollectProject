//
//  MXVTabBarController.h
//  BTCMining
//
//  Created by blom on 2021/6/24.
//  Copyright © 2021年 MXV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MXVTabBar.h"
#import "MXVNavController.h"

@interface MXVTabBarController : UITabBarController
{
    
}
@property (nonatomic, assign) NSInteger upperIndex; //突出项的索引
@property (nonatomic, strong) MXVTabBar *mxvTabBar;

@end



