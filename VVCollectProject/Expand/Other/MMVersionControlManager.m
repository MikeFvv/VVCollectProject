//
//  MZVersionControlManager.m
//  MZVersionControl
//
//  Created by Mr.Z on 2019/12/18.
//  Copyright © 2019 Mr.Z. All rights reserved.
//

#import "MMVersionControlManager.h"
#import <UIKit/UIKit.h>


//APP ID
#define kAppID @"1035505672"  // 随便找的


@implementation MMVersionControlManager

#pragma mark - 单例
+ (instancetype)shareManager {
    static MMVersionControlManager *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

#pragma mark - API

/// 检查更新版本
/// @param appId  AppStore 商城应用的id
/// @param viewController 所在的vc
+ (void)checkNewVersionWithAppId:(NSString *)appId viewController:(UIViewController *)viewController {
    [[self shareManager] checkNewVersion:appId viewController:viewController];
}

/// 检查更新版本
/// @param appId  AppStore 商城应用的id
/// @param showUpdate 回调version数据
+ (void)checkNewVersionCustomViewWithAppId:(NSString *)appId showUpdate:(void(^)(NSDictionary *))showUpdate {
    [[self shareManager] checkNewVersion:appId showUpdate:showUpdate];
}


/// 检查更新版本
/// @param appId  AppStore 商城应用的id
/// @param viewController 所在的vc
- (void)checkNewVersion:(NSString *)appId viewController:(UIViewController *)viewController {
    BOOL hasConnection = [self hasConnection];
    if (!hasConnection) return;
    
    [self getAppStoreVersion:appId update:^(NSDictionary *versionInfo) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self showAlertWithInfo:versionInfo viewController:viewController];
        });
    }];
}

/// 检查更新版本
/// @param appId  AppStore 商城应用的id
/// @param showUpdate 回调version数据
- (void)checkNewVersion:(NSString *)appId showUpdate:(void(^)(NSDictionary *))showUpdate {
    BOOL hasConnection = [self hasConnection];
    if (!hasConnection) return;
    
    [self getAppStoreVersion:appId update:^(NSDictionary *versionInfo) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (showUpdate) {
                showUpdate(versionInfo);
            }
        });
    }];
}




- (BOOL)hasConnection
{
    const char *host = "itunes.apple.com";
    BOOL reachable;
    BOOL success;
    
    // Link SystemConfiguration.framework! <SystemConfiguration/SystemConfiguration.h>
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithName(NULL, host);
    SCNetworkReachabilityFlags flags;
    success = SCNetworkReachabilityGetFlags(reachability, &flags);
    reachable = success && (flags & kSCNetworkFlagsReachable) && !(flags & kSCNetworkFlagsConnectionRequired);
    CFRelease(reachability);
    return reachable;
}



#pragma mark - 获取AppStore上的版本信息
- (void)getAppStoreVersion:(NSString *)appId update:(void(^)(NSDictionary *))update {
    [self getAppStoreInfo:appId success:^(NSDictionary *resDic) {
        NSInteger resultCount = [resDic[@"resultCount"] integerValue];
        if (resultCount == 1) {
            NSDictionary *versionInfo = [resDic[@"results"] firstObject];
            // 是否提示更新
            BOOL result = [self isEqualNewVersion:versionInfo[@"version"]];
            if (result && update) {
                update(versionInfo);
            }
        } else {
        #ifdef DEBUG
            NSLog(@"AppStore上面没有找到对应id的App");
        #endif
        }
    }];
}

#pragma mark - 获取AppStore的info信息
- (void)getAppStoreInfo:(NSString *)appId success:(void(^)(NSDictionary *))success {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/lookup?id=%@", appId]];
        [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (!error && data && data.length > 0) {
                NSDictionary *resDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                if (success) {
                    success(resDic);
                }
            }
        }] resume];
    });
}


#pragma mark - 版本号比对 返回是否提示更新
/// 版本和比对 返回是否提示更新
/// @param newVersion 新的版本号
- (BOOL)isEqualNewVersion:(NSString *)newVersion {
    // 获得忽略的版本
    NSString *ignoreVersion = [[NSUserDefaults standardUserDefaults] objectForKey:@"ingoreVersion"];
    // 获得当前的版本
    NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    
    // [A compare:B]
    // NSOrderedAscending 判断两对象值的大小(按字母顺序进行比较，B大于A为真)
    // NSOrderedDescending 判断两对象值的大小(按字母顺序进行比较，B小于A为真)
    // NSOrderedSame 判断两者内容是否相同
    if ([currentVersion compare:newVersion] == NSOrderedDescending || [currentVersion compare:newVersion] == NSOrderedSame || [ignoreVersion isEqualToString:newVersion]) {
        return NO;
    } else {
        return YES;
    }
}


#pragma mark - AlertController
- (void)showAlertWithInfo:(NSDictionary *)versionInfo viewController:(UIViewController *)viewController {
    NSString *title = [NSString stringWithFormat:@"有新的版本(%@)", versionInfo[@"version"]];  // 版本号
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:versionInfo[@"releaseNotes"]   preferredStyle:UIAlertControllerStyleAlert];   // releaseNotes 更新日志
    UIAlertAction *updateAction = [UIAlertAction actionWithTitle:@"立即更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self updateRightNow:versionInfo[@"trackViewUrl"]];  // AppStore地址
    }];
    UIAlertAction *delayAction = [UIAlertAction actionWithTitle:@"稍后再说" style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction *ignoreAction = [UIAlertAction actionWithTitle:@"忽略" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self ignoreNewVersion:versionInfo[@"version"]];
    }];
    [alertController addAction:updateAction];
    [alertController addAction:delayAction];
    [alertController addAction:ignoreAction];
    [viewController presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - 立即升级
- (void)updateRightNow:(NSString *)trackViewUrl {
    NSURL *url = [NSURL URLWithString:trackViewUrl];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
    }
}

#pragma mark - 忽略新版本
- (void)ignoreNewVersion:(NSString *)version {
    // 保存忽略的版本号
    [[NSUserDefaults standardUserDefaults] setObject:version forKey:@"ingoreVersion"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
