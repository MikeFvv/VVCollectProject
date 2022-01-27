//
//  MasonryController.m
//  VVCollectProject
//
//  Created by blom on 2019/3/15.
//  Copyright © 2019 Mike. All rights reserved.
//

#import "MasonryController.h"

@interface MasonryController ()

@end

@implementation MasonryController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
// https://www.jianshu.com/p/e3162f3c61fa
    
    /*
    全屏居中： make.center.equalTo(self.window)
    make.top.equalTo(self.window).with.offset(15.0)  上边界
        或  make.top.equalTo(15.0)   上边界
    上边界、左边界：make.top.left.equalTo(15.0)
    下边界、右边界：make.bottom.right.equalTo(-15.0)
    
    
    3、equalTo与mas_equalTo有什么区别？
    equalTo比较的是view
    mas_equalTo比较的是数值
     
     4、and和with？
     什么事情都没做，只是增加代码可读性。
     
     
     5、倍数设置
     设置宽度为self.view的一半，multipliedBy是倍数的意思，也就是，使宽度等于self.view宽度的0.5倍
     make.width.equalTo(self.view.mas_width).multipliedBy(0.5);
     
     make.left.right.equalTo(0);
     
     make.edges.equalTo(self.view);
     
     */
}



@end
