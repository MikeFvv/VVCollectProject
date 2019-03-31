//
//  FYSocketMessageManager.m
//  VVCollectProject
//
//  Created by Mike on 2019/3/30.
//  Copyright © 2019 Mike. All rights reserved.
//

#import "FYSocketMessageManager.h"

#import "FYSocketManager.h"
#import <MJExtension/MJExtension.h>


@interface FYSocketMessageManager ()

@end

@implementation FYSocketMessageManager

+ (FYSocketMessageManager *)shareInstance{
    static FYSocketMessageManager *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.isConnect = NO;
        [self startConnecting];
    }
    return self;
}

- (void)startConnecting {
    NSString *url = @"ws://10.10.15.161:8888?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJsaWNlbnNlIjoibWFkZSBieSBwaWciLCJ1c2VyX25hbWUiOiIxMDAwMDAwMjUwNiIsInNjb3BlIjpbInNlcnZlciJdLCJleHAiOjE1NTYzNDYwNjUsInVzZXJJZCI6MjUwNiwiYXV0aG9yaXRpZXMiOlsiUk9MRV9QTEFZRVIiLCJST0xFX1VTRVIiXSwianRpIjoiZGEyMTFlYjUtNDBlNy00MjNkLTg2Y2EtNTMzMjgyYzRjOWEzIiwiY2xpZW50X2lkIjoiYXBwIn0.0ux3v8RCrIuN1UC_bup5Xe5Q0ZFruHSNA3WwAk1XWg4";
    [[FYSocketManager shareManager] fy_open:url connect:^{
        self.isConnect = YES;
        NSLog(@"成功连接");
    } receive:^(id message, FYSocketReceiveType type) {
        if (type == FYSocketReceiveTypeForMessage) {
            NSLog(@"接收 类型1--%@",message);
            NSDictionary *dict = (NSDictionary *)[message mj_JSONObject];
            
            if ([dict[@"command"] integerValue] == 6) {
                NSLog(@"第一次接收消息成功cheng");
            } else if ([dict[@"command"] integerValue] == 12) {
                NSLog(@"发送消息成功");
            } else if ([dict[@"command"] integerValue] == 11) {
                NSLog(@"接收消息成功");
                
              NSMutableDictionary *dictMu = [[NSMutableDictionary alloc] initWithDictionary:dict[@"data"]];
              [dictMu setObject:@"2" forKey:@"sendFrom"];  // 发送方
                
                //调用delegate
                if (self.delegate && [self.delegate respondsToSelector:@selector(onFYIMReceiveMessage:left:)]) {
                    [self.delegate onFYIMReceiveMessage:dictMu left:0];
                }
                
//                [self receiveMessage:dict];
            }
        } else if (type == FYSocketReceiveTypeForPong){
            NSLog(@"🔴接收 类型2--%@",message);
        }
    } failure:^(NSError *error) {
        self.isConnect = NO;
        NSLog(@"🔴连接失败");
    }];
}





@end



