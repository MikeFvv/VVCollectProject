//
//  MXWNotchScreen.m
//  VVCollectProject
//
//  Created by Admin on 2021/12/21.
//  Copyright © 2021 Mike. All rights reserved.
//

#import "MXWNotchScreen.h"

@implementation MXWNotchScreen

+ (BOOL)isIPhoneNotchScreen{
    BOOL result = NO;
    if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {
        return result;
    }
    if (@available(iOS 11.0, *)) {
        UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
        if (mainWindow.safeAreaInsets.bottom > 0.0) {
            result = YES;
        }
    }
    return result;
}

+ (CGFloat)getIPhoneNotchScreenHeight {
    /*
     * iPhone8 Plus  UIEdgeInsets: {20, 0, 0, 0}
     * iPhone8       UIEdgeInsets: {20, 0, 0, 0}
     * iPhone XR     UIEdgeInsets: {44, 0, 34, 0}
     * iPhone XS     UIEdgeInsets: {44, 0, 34, 0}
     * iPhone XS Max UIEdgeInsets: {44, 0, 34, 0}
     */
    CGFloat bottomSpace = 0;
    if (@available(iOS 11.0, *)) {
        UIEdgeInsets safeAreaInsets = UIApplication.sharedApplication.windows.firstObject.safeAreaInsets;
        switch (UIApplication.sharedApplication.statusBarOrientation) {
            case UIInterfaceOrientationPortrait:
            {
                bottomSpace = safeAreaInsets.bottom;
            }
                break;
            case UIInterfaceOrientationLandscapeLeft:
            {
                bottomSpace = safeAreaInsets.right;
            }
                break;
            case UIInterfaceOrientationLandscapeRight:
            {
                bottomSpace = safeAreaInsets.left;
            }
                break;
            case UIInterfaceOrientationPortraitUpsideDown:
            {
                bottomSpace = safeAreaInsets.top;
            }
                break;
            default:
            {
                bottomSpace = safeAreaInsets.bottom;
            }
                break;
        }
    }
    return bottomSpace;
}

@end
