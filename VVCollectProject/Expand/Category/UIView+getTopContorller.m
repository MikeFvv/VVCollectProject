//
//  UIView+getTopContorller.m
//  EggplantVideo
//
//  Created by blom on 2021/8/27.
//  Copyright © 2021 iOS. All rights reserved.
//

#import "UIView+getTopContorller.h"

@implementation UIView (getTopContorller)

- (UIViewController * )getTopViewController {
    UIViewController *rootViewController = UIApplication.sharedApplication.delegate.window.rootViewController;
    UIViewController *resultVC;
    resultVC = [self recursiveTopViewController:rootViewController];
    
    while (resultVC.presentedViewController) {
        resultVC = [self recursiveTopViewController:resultVC.presentedViewController];
    }
    return resultVC;
}

- (UIViewController * )recursiveTopViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self recursiveTopViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self recursiveTopViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}

@end
