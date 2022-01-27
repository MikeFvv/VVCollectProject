//
//  AppModel.h
//  BTCMining
//
//  Created by blom on 2019/11/1.
//  Copyright © 2018年 AFan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UserInfo;

@interface AppModel : NSObject<NSCoding,NSCopying>
/// 是否已登录
@property (nonatomic, assign) BOOL isLogined;
/// 3个月变更   如果有退出也会变更
@property (nonatomic, copy) NSString *token;




+ (instancetype)sharedInstance;
- (void)loginFromToken:(NSString *)token;



/// ***** 没使用到的 ******
@property (nonatomic, copy) NSString *channel;
@property (nonatomic, copy) NSString *event;
@property (nonatomic, assign) BOOL set_trade_password;
/// 用户信息
@property (nonatomic ,strong) UserInfo *user_info;

/// 是否测试模式    NO 正式版    YES 测试版
@property (nonatomic ,assign) BOOL isDebugMode;

@property (nonatomic ,copy) NSString *serverApiUrl;
/// ws URL  Socket
@property (nonatomic ,copy) NSString *wsSocketURL;
@property (nonatomic ,strong) NSDictionary *commonInfo;

- (void)handleModelFromDic:(NSDictionary*)dic;
- (void)saveAppModel;   ///<登录存档>
- (UIViewController *)rootVc;


@end
