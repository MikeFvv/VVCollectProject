//
//  FYSocketManager.h
//  VVCollectProject
//
//  Created by Mike on 2019/3/30.
//  Copyright © 2019 Mike. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  socket状态
 */
typedef NS_ENUM(NSInteger,FYSocketStatus){
    FYSocketStatusConnected,// 已连接
    FYSocketStatusFailed,// 失败
    FYSocketStatusClosedByServer,// 系统关闭
    FYSocketStatusClosedByUser,// 用户关闭
    FYSocketStatusReceived// 接收消息
};
/**
 *  消息类型
 */
typedef NS_ENUM(NSInteger,FYSocketReceiveType){
    FYSocketReceiveTypeForMessage,
    FYSocketReceiveTypeForPong
};
/**
 *  连接成功回调
 */
typedef void(^FYSocketDidConnectBlock)();
/**
 *  失败回调
 */
typedef void(^FYSocketDidFailBlock)(NSError *error);
/**
 *  关闭回调
 */
typedef void(^FYSocketDidCloseBlock)(NSInteger code,NSString *reason,BOOL wasClean);
/**
 *  消息接收回调
 */
typedef void(^FYSocketDidReceiveBlock)(id message ,FYSocketReceiveType type);




@interface FYSocketManager : NSObject
/**
 *  连接回调
 */
@property (nonatomic,copy)FYSocketDidConnectBlock connect;
/**
 *  接收消息回调
 */
@property (nonatomic,copy)FYSocketDidReceiveBlock receive;
/**
 *  失败回调
 */
@property (nonatomic,copy)FYSocketDidFailBlock failure;
/**
 *  关闭回调
 */
@property (nonatomic,copy)FYSocketDidCloseBlock close;
/**
 *  当前的socket状态
 */
@property (nonatomic,assign,readonly)FYSocketStatus FY_socketStatus;
/**
 *  超时重连时间，默认1秒
 */
@property (nonatomic,assign)NSTimeInterval overtime;
/**
 *  重连次数,默认5次
 */
@property (nonatomic, assign)NSUInteger reconnectCount;
/**
 *  单例调用
 */
+ (instancetype)shareManager;
/**
 *  开启socket
 *
 *  @param urlStr  服务器地址
 *  @param connect 连接成功回调
 *  @param receive 接收消息回调
 *  @param failure 失败回调
 */
- (void)fy_open:(NSString *)urlStr connect:(FYSocketDidConnectBlock)connect receive:(FYSocketDidReceiveBlock)receive failure:(FYSocketDidFailBlock)failure;
/**
 *  关闭socket
 *
 *  @param close 关闭回调
 */
- (void)fy_close:(FYSocketDidCloseBlock)close;
/**
 *  发送消息，NSString 或者 NSData
 *
 *  @param data Send a UTF8 String or Data.
 */
- (void)fy_send:(id)data;

@end
