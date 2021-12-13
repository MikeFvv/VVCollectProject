//
//  MXWAdModel.h
//  小黄鸭
//
//  Created by blom on 2021/12/3.
//  Copyright © 2021 iOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MXWAdModel : NSObject
/// int 商品id
@property (nonatomic, assign) NSInteger ID;
/// string 商品描述
@property (nonatomic, assign) NSInteger desc;
/// string 商品图片地址
@property (nonatomic,copy) NSString *imgStr;
///  int 倒计时 以秒数为单位
@property (nonatomic, assign) NSTimeInterval countdown;
/// int 弹窗次数
@property (nonatomic, assign) NSInteger rem_frecy;



///
@property (nonatomic,copy) NSString *linkUrl;

@end

