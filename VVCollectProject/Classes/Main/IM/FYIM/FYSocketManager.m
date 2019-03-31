//
//  FYSocketManager.m
//  VVCollectProject
//
//  Created by Mike on 2019/3/30.
//  Copyright © 2019 Mike. All rights reserved.
//

#import "FYSocketManager.h"
#import "SRWebSocket.h"

@interface FYSocketManager ()<SRWebSocketDelegate>
@property (nonatomic,strong)SRWebSocket *webSocket;

@property (nonatomic,assign)FYSocketStatus FY_socketStatus;

@property (nonatomic,weak)NSTimer *timer;

@property (nonatomic,copy)NSString *urlString;

@end

@implementation FYSocketManager{
    NSInteger _reconnectCounter;
}


+ (instancetype)shareManager{
    static FYSocketManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        instance.overtime = 1;
        instance.reconnectCount = 5;
    });
    return instance;
}

- (void)fy_open:(NSString *)urlStr connect:(FYSocketDidConnectBlock)connect receive:(FYSocketDidReceiveBlock)receive failure:(FYSocketDidFailBlock)failure{
    [FYSocketManager shareManager].connect = connect;
    [FYSocketManager shareManager].receive = receive;
    [FYSocketManager shareManager].failure = failure;
    [self fy_open:urlStr];
}

- (void)fy_close:(FYSocketDidCloseBlock)close{
    [FYSocketManager shareManager].close = close;
    [self fy_close];
}

// Send a UTF8 String or Data.
- (void)fy_send:(id)data{
    switch ([FYSocketManager shareManager].FY_socketStatus) {
        case FYSocketStatusConnected:
        case FYSocketStatusReceived:{
            NSLog(@"发送中。。。");
            [self.webSocket send:data];
            break;
        }
        case FYSocketStatusFailed:
            NSLog(@"发送失败");
            break;
        case FYSocketStatusClosedByServer:
            NSLog(@"已经关闭");
            break;
        case FYSocketStatusClosedByUser:
            NSLog(@"已经关闭");
            break;
    }
    
}

#pragma mark -- private method
- (void)fy_open:(id)params{
//    NSLog(@"params = %@",params);
    NSString *urlStr = nil;
    if ([params isKindOfClass:[NSString class]]) {
        urlStr = (NSString *)params;
    }
    else if([params isKindOfClass:[NSTimer class]]){
        NSTimer *timer = (NSTimer *)params;
        urlStr = [timer userInfo];
    }
    [FYSocketManager shareManager].urlString = urlStr;
    [self.webSocket close];
    self.webSocket.delegate = nil;
    
    self.webSocket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
    self.webSocket.delegate = self;
    
    [self.webSocket open];
}

- (void)fy_close{
    
    [self.webSocket close];
    self.webSocket = nil;
    [self.timer invalidate];
    self.timer = nil;
}

- (void)fy_reconnect{
    // 计数+1
    if (_reconnectCounter < self.reconnectCount - 1) {
        _reconnectCounter ++;
        // 开启定时器
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:self.overtime target:self selector:@selector(FY_open:) userInfo:self.urlString repeats:NO];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        self.timer = timer;
    }
    else{
        NSLog(@"Websocket Reconnected Outnumber ReconnectCount");
        if (self.timer) {
            [self.timer invalidate];
            self.timer = nil;
        }
        return;
    }
    
}

#pragma mark -- SRWebSocketDelegate
- (void)webSocketDidOpen:(SRWebSocket *)webSocket{
    NSLog(@"Websocket Connected");
    
    [FYSocketManager shareManager].connect ? [FYSocketManager shareManager].connect() : nil;
    [FYSocketManager shareManager].FY_socketStatus = FYSocketStatusConnected;
    // 开启成功后重置重连计数器
    _reconnectCounter = 0;
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error{
    NSLog(@":( Websocket Failed With Error %@", error);
    [FYSocketManager shareManager].FY_socketStatus = FYSocketStatusFailed;
    [FYSocketManager shareManager].failure ? [FYSocketManager shareManager].failure(error) : nil;
    // 重连
    [self fy_reconnect];
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message{
    NSLog(@":( Websocket Receive With message %@", message);
    [FYSocketManager shareManager].FY_socketStatus = FYSocketStatusReceived;
    [FYSocketManager shareManager].receive ? [FYSocketManager shareManager].receive(message,FYSocketReceiveTypeForMessage) : nil;
}

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean{
    NSLog(@"Closed Reason:%@  code = %zd",reason,code);
    if (reason) {
        [FYSocketManager shareManager].FY_socketStatus = FYSocketStatusClosedByServer;
        // 重连
        [self fy_reconnect];
    }
    else{
        [FYSocketManager shareManager].FY_socketStatus = FYSocketStatusClosedByUser;
    }
    [FYSocketManager shareManager].close ? [FYSocketManager shareManager].close(code,reason,wasClean) : nil;
    self.webSocket = nil;
}

- (void)webSocket:(SRWebSocket *)webSocket didReceivePong:(NSData *)pongPayload{
    [FYSocketManager shareManager].receive ? [FYSocketManager shareManager].receive(pongPayload,FYSocketReceiveTypeForPong) : nil;
}

- (void)dealloc{
    // Close WebSocket
    [self fy_close];
}

@end
