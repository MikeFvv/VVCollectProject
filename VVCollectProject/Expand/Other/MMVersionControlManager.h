//
//  MZVersionControlManager.h
//  MZVersionControl
//
//  Created by Mr.Z on 2019/12/18.
//  Copyright © 2019 Mr.Z. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>

NS_ASSUME_NONNULL_BEGIN

@class UIViewController;

/// ****** C版本控制管理器 ******
@interface MMVersionControlManager : NSObject

/// 单例
+ (instancetype)shareManager;

/********** 调用例子 ********
 1.  里面封装了简单的系统弹框提示
 [MMVersionControlManager checkNewVersionWithAppId:@"1472485134" viewController:self];
 2. 自定义视图
 [MMVersionControlManager checkNewVersionWithAppId:@"1472485134" showUpdate:^(NSDictionary * _Nonnull versionInfo) {
     // 自定义版本跟新的视图
     [self customAlertView:versionInfo];
 }];
 */

/// 检查更新版本
/// @param appId  AppStore 商城应用的id
/// @param viewController 所在的vc
+ (void)checkNewVersionWithAppId:(NSString *)appId viewController:(UIViewController *)viewController;

/// 检查更新版本
/// @param appId  AppStore 商城应用的id
/// @param showUpdate 回调version数据
+ (void)checkNewVersionCustomViewWithAppId:(NSString *)appId showUpdate:(void(^)(NSDictionary *))showUpdate;



@end

NS_ASSUME_NONNULL_END
