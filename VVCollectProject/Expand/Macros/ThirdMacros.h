//
//  ThirdMacros.h
//  Project
//
//  Created by blom on 2018/12/30.
//  Copyright © 2018 CDJay. All rights reserved.
//

#ifndef ThirdMacros_h
#define ThirdMacros_h

///**
// ****   融云环境  0测试  1生产
// ***/
//static int isLine = 0;
//
//// 生产服务器地址
//static NSString * const Server_url_Pro  = @"http://wcwcwc.175yqw.com/api/";
//// 测试服务器地址
//static NSString * const Server_url_Test  = @"http://10.10.15.176:8099/";
//
//
//
//#define SERVER_URL (isLine == 1? Server_url_Pro : Server_url_Test)
//
//
//
//
///**
// ****   融云
// ***/
//static NSString * const RyTestKey = @"qd46yzrfqi8wf";   // 测试
//static NSString * const RyKey = @"vnroth0kv85xo";     // 生产

/**
 ****   微信
 ***/
static NSString * const WXKey = @"wxb9a25b32bcf8449c";
static NSString * const WXSecret = @"2853774d619b53cef728d235874058ce";

/// 自定义红包 特殊字符判断
static NSString * const RedPacketString = @"~!@#$%^&*()";

/// 在线客服系统
static NSString * const ServiceLink  =  @"http://api.pop800.com/chat/366223";

// static NSString* const H_KEY  =  @"652e6f3c7dcf22227cc884ce9c5730b5";//临时请求，key固定 玩家接口i

#endif /* ThirdMacros_h */
