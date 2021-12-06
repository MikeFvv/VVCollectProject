//
//  UIView+Function.m
//  VVCollectProject
//
//  Created by Admin on 2021/11/12.
//  Copyright © 2021 Mike. All rights reserved.
//

#import "UIView+Function.h"

@implementation UIView (Function)


- (UIImage *)image {
    UIGraphicsBeginImageContext(self.frame.size);
    [[self layer] renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
@end
