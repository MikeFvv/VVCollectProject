//
//  AppModel.m
//  BTCMining
//
//  Created by Mike on 2019/11/1.
//  Copyright © 2018年 AFan. All rights reserved.
//

#import "AppModel.h"
#import "UserInfo.h"
//#import "LoginViewController.H"


static NSString *Path = @"com.blom.www";

@implementation AppModel

MJCodingImplementation


+ (void)load{
    [self performSelectorOnMainThread:@selector(sharedInstance) withObject:nil waitUntilDone:NO];
}

+ (instancetype)sharedInstance{
    static AppModel *appModel;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if(appModel == nil) {
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *filename = [[paths objectAtIndex:0] stringByAppendingPathComponent:Path];
            if ([[NSFileManager defaultManager] fileExistsAtPath:filename]) {
                appModel = [NSKeyedUnarchiver unarchiveObjectWithFile:filename];
                //               id aa = [NSKeyedUnarchiver unarchiveObjectWithFile:filename];
                if(appModel == nil){
                    appModel = [[AppModel alloc] init];
                }
            } else {
                appModel = [[AppModel alloc] init];
            }
            
        }
        
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        NSInteger serverIndex = [[ud objectForKey:@"serverIndex"] integerValue];
        
        
        if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]){
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
            //第一次启动
            
#if TARGET_IPHONE_SIMULATOR  // 模拟器 需要使用这个判断  TARGET_OS_IPHONE判断没有作用
            serverIndex = 1;
#else
        
#endif
            
        } else {
            
            //不是第一次启动了
#if TARGET_IPHONE_SIMULATOR  // 模拟器 需要使用这个判断  TARGET_OS_IPHONE判断没有作用
            serverIndex = 1;
#else
        
#endif
        }

        
        
    });
    return appModel;
}

- (instancetype)init{
    self = [super init];
    if (self) {
    }
    return self;
}


- (void)loginFromToken:(NSString *)token
{
    [AppModel sharedInstance].isLogined = YES;
    [AppModel sharedInstance].token = token;
    
    [AppModel sharedInstance].user_info.isLogined = YES;
    [[AppModel sharedInstance] saveAppModel];
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:@(0) forKey:@"userId"];
    [ud setObject:@"pyke1123123@gmail.com" forKey:@"account"];
//    [ud setObject:@"h10763829@gmail.com" forKey:@"account"];
    [ud synchronize];
}

- (void)handleModelFromDic:(NSDictionary*)dict
{
    AppModel *appModel = [AppModel mj_objectWithKeyValues:dict];
    [AppModel sharedInstance].token = appModel.token;
    [AppModel sharedInstance].channel = appModel.channel;
    [AppModel sharedInstance].event = appModel.event;
    [AppModel sharedInstance].user_info = appModel.user_info;
    [AppModel sharedInstance].set_trade_password = appModel.set_trade_password;
    
    [AppModel sharedInstance].user_info.isLogined = YES;
    
    [[AppModel sharedInstance] saveAppModel];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:@(appModel.user_info.userId) forKey:@"userId"];
    [ud setObject:appModel.user_info.mobile forKey:@"account"];
    [ud synchronize];
}

- (void)saveAppModel {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* filename = [[paths objectAtIndex:0] stringByAppendingPathComponent:Path];
    [NSKeyedArchiver archiveRootObject:self toFile:filename];
}

-(UserInfo *)user_info {
    if(_user_info == nil)
        _user_info = [[UserInfo alloc] init];
    return _user_info;
}


- (UIViewController *)rootVc {
    
    NSString *appVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    if (![[NSUserDefaults standardUserDefaults]objectForKey:appVersion]) {
        return [[NSClassFromString(@"GuideViewController") alloc]init];
    }
    else{
        //        dispatch_semaphore_t signal = dispatch_semaphore_create(3);
        //        __block UIViewController* rVC = [UIViewController new];
        //
        //        [NET_REQUEST_MANAGER requestMsgBannerWithId:OccurBannerAdsTypeLaunch success:^(id object) {
        //            BannerModel* model = [BannerModel mj_objectWithKeyValues:object];
        //            if (model.data.records.count>0) {
        ////                NSDictionary* dic = @{
        ////                                      kArr:
        ////                                          @[
        ////                                              @{kImg:@"msg_banner1",kUrl:@"https://www.baidu.com"},
        ////                                              @{kImg:@"msg_banner2",kUrl:@"https://news.baidu.com"}
        ////                                              ]
        ////                                      };
        //                UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:[[NSClassFromString(@"PreRootVC")alloc]init]];
        //                rVC = nav;
        //                dispatch_semaphore_signal(signal);
        //            }
        //        } fail:^(id object) {
        //            if ([AppModel sharedInstance].user.isLogined) {
        //                rVC = [[NSClassFromString(@"BaseTabBarController")alloc]init];
        //
        //
        //
        //            }else{
        //                UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:[[NSClassFromString(@"LoginViewController")alloc]init]];//PreLoginVC
        //                rVC = nav;
        //            }
        //            dispatch_semaphore_signal(signal);
        //
        //        }];
        //        dispatch_semaphore_wait(signal, DISPATCH_TIME_FOREVER);
        //        return rVC;
        //    }
        
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:[[NSClassFromString(@"PreRootVC")alloc]init]];//PreLoginVC
        return nav;
    }
    
}


- (id)copyWithZone:(NSZone *)zone {
    AppModel *appM = [[[self class] allocWithZone:zone] init];
    appM.token = self.token;
    appM.user_info = self.user_info;
    return appM;
}


@end
