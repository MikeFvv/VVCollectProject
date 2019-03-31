//
//  FYReceiveMessageDelegate.h
//  VVCollectProject
//
//  Created by Mike on 2019/3/30.
//  Copyright © 2019 Mike. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// 声明数据源协议
@protocol FYReceiveMessageDelegate <NSObject>

@optional
/*!
 接收消息的回调方法
 
 @param message     当前接收到的消息
 @param left        还剩余的未接收的消息数，left>=0
 
 @discussion 如果您设置了IMKit消息监听之后，SDK在接收到消息时候会执行此方法（无论App处于前台或者后台）。
 其中，left为还剩余的、还未接收的消息数量。比如刚上线一口气收到多条消息时，通过此方法，您可以获取到每条消息，left会依次递减直到0。
 您可以根据left数量来优化您的App体验和性能，比如收到大量消息时等待left为0再刷新UI。
 */
//- (void)onFYIMReceiveMessage:(RCMessage *)message left:(int)left;
- (void)onFYIMReceiveMessage:(NSDictionary *)message left:(int)left;

@end

NS_ASSUME_NONNULL_END
