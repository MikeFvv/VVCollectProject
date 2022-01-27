//
//  AppDelegate.m
//  VVCollectProject
//
//  Created by blom on 2019/1/11.
//  Copyright © 2019 Mike. All rights reserved.
//

#import "AppDelegate.h"
//#import "WRNavigationBar.h"
#import "BaseNavigationController.h"
#import "UIImage+GradientColor.h"
#import "ViewController.h"

#import "JSPatchCode.h"
#import "YYFPSLabel.h"

#import "HomeViewController.h"
#import "LoginViewController.h"
#import "MXVNavController.h"



@interface AppDelegate ()

@end

@implementation AppDelegate
/// 如果属性值为YES，仅允许屏幕向左旋转，否则仅允许竖屏。
- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    if (self.allowRotation == YES) {
        // 横屏
        return UIInterfaceOrientationMaskLandscape;
    } else {
        // 竖屏
        return (UIInterfaceOrientationMaskPortrait);
    }
}
#pragma mark程序启动
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
//    RootController *vc = [[RootController alloc]init];
//    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
//    self.window.backgroundColor = [UIColor whiteColor];
//    self.window.rootViewController = [[UINavigationController alloc]initWithRootViewController:vc];
//    [self.window makeKeyAndVisible];
//    return YES;
    
    
//#if TARGET_IPHONE_SIMULATOR
//    [JPEngine startEngine];
//    NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"main" ofType:@"js"];
//    NSString *script = [NSString stringWithContentsOfFile:sourcePath encoding:NSUTF8StringEncoding error:nil];
//    [JPEngine evaluateScript:script];
//#elif TARGET_OS_IPHONE
    //热更新加载
    [JSPatchCode asyncUpdate:YES];
//#endif
//    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    self.window.backgroundColor = [UIColor whiteColor];
    
    [self setRootViewController:NO];
    
    
    
    
    // 刷新率
//    [self.window addSubview:[[YYFPSLabel alloc] initWithFrame:CGRectMake(20, 70, 0, 0)]];
    
    //程序崩溃检测记录
//    [self recordCrashCount];
//    //判断app是否更新了更新软件后删除js文件,没更新运行本地js文件
//    [self judgeIfAppUpdate];
    
    
    
    [self.window makeKeyAndVisible];
    return YES;
    
    
    
}


/// 设置根控制器
/// @param isToLogin 是否到登录页面
-(void)setRootViewController:(BOOL)isToLogin {
    
//    if ([AppModel sharedInstance].isLogined) {
    if (!isToLogin) {
        [self.window.layer addAnimation:self.animation forKey:nil];
        self.window.rootViewController = [[NSClassFromString(@"MXVTabBarController") alloc] init];
    } else {

        if (![AppModel sharedInstance].isLogined) {
            UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
            LoginViewController *vc = [[LoginViewController alloc] init];
            MXVNavController *nav = [[MXVNavController alloc] initWithRootViewController:vc];
            nav.modalPresentationStyle = UIModalPresentationFullScreen;
            [rootViewController presentViewController:nav animated:YES completion:nil];
            return;
        }

//        LoginViewController *vc =  [[LoginViewController alloc] init];
//        self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:vc];
    }
    
    
    /*
    
    // 没有tabbar
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    BaseNavigationController *firstNav = [[BaseNavigationController alloc] initWithRootViewController:[[HomeViewController alloc]init]];
//    UITabBarController *tabBarVC = [UITabBarController new];
//    tabBarVC.viewControllers = @[firstNav];
    self.window.rootViewController = firstNav;
    
    */
}

/**
 退出登录
 */
- (void)logOut {
    
    [AppModel sharedInstance].token = nil;
    [AppModel sharedInstance].isLogined = NO;
    [AppModel sharedInstance].user_info = [UserInfo new];
    [[AppModel sharedInstance] saveAppModel];
    
    __weak __typeof(self)weakSelf = self;
    dispatch_async(dispatch_get_main_queue(),^{
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        [strongSelf setRootViewController:NO];
    });
}
- (CATransition *)animation {
    CATransition *animation = [CATransition animation];
    animation.duration = 0.3;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    animation.type =  @"cube";
    animation.subtype = kCATransitionFromTop;
    return animation;
}



- (void)setNavBarAppearence
{
    
    CGSize size = CGSizeMake(376.0f, 83.0f);
    UIColor *topleftColor = [UIColor colorWithRed:148/255.0f green:127/255.0f blue:202/255.0f alpha:1.0f];
    UIColor *bottomrightColor = [UIColor colorWithRed:(141/255.0) green:(137/255.0) blue:(244/255.0) alpha:(1)];
    UIImage *bgImg = [UIImage gradientColorImageFromColors:@[topleftColor, bottomrightColor] gradientType:1 imgSize:size];
    
    // 设置导航栏默认的背景颜色
//    [WRNavigationBar wr_setDefaultNavBarBarTintColor:[UIColor colorWithPatternImage:bgImg]];
//    // 设置导航栏所有按钮的默认颜色
//    [WRNavigationBar wr_setDefaultNavBarTintColor:[UIColor whiteColor]];
//    // 设置导航栏标题默认颜色
//    [WRNavigationBar wr_setDefaultNavBarTitleColor:[UIColor whiteColor]];
//    // 统一设置状态栏样式
//    [WRNavigationBar wr_setDefaultStatusBarStyle:UIStatusBarStyleLightContent];
//    // 如果需要设置导航栏底部分割线隐藏，可以在这里统一设置
//    [WRNavigationBar wr_setDefaultNavBarShadowImageHidden:YES];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}

#pragma mark程序恢复活跃
- (void)applicationDidBecomeActive:(UIApplication *)application {
    //请求jspatch信息并下载
//    [self requestJSPatchInfo];
    
}

#pragma mark程序退出
- (void)applicationWillTerminate:(UIApplication *)application {
    //程序被杀的时候把isCrush改为NO
    [[NSUserDefaults standardUserDefaults] setObject:@"NO"forKey:@"isCrush"];
}



//请求JSPatch信息
- (void)requestJSPatchInfo {
    NSString *requestJStime = [[NSUserDefaults standardUserDefaults] valueForKey:@"requestJStime"];
    NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
    CGFloat timeSpace = currentTime - [requestJStime floatValue];
    // 判断距离上次请求数据是否超过3600秒
    if (requestJStime.length==0 | timeSpace >200) {
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%f",currentTime] forKey:@"requestJStime"];
        // 检查服务器JS版本信息
//        [self checkJSPatchVersion];
        
//        [self HSDevaluateScript];
//        [JSPatchCode asyncUpdate:YES];
    }
}



//运行本地JS文件
-(void)HSDevaluateScript {
    //从本地获取下载的JS文件
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,NSUserDomainMask,YES) lastObject];
//    NSString *path2 = [path stringByAppendingString:@"/main.js"];
     NSString *path2 = [path stringByAppendingString:@"/JSPatch/1.0/demo.js"];
    NSLog(@"%@",path2);
    //获取内容
    NSString *js = [NSString stringWithContentsOfFile:path2 encoding:NSUTF8StringEncoding error:nil];
    
    NSLog(@"%@",js);
    
    //如果有内容
    if (js.length>0)  {
        //运行
        [JPEngine startEngine];
        [JPEngine evaluateScript:js];
    }
}









/****************************************************************************************/



/*


//记录崩溃次数
- (void)recordCrashCount{
    
    NSString *isCrash = [[NSUserDefaults standardUserDefaults] valueForKey:@"isCrash"];
    
    //读取本地的崩溃标识是否为YES,是则代表上次退出程序时是崩溃,为NO则代表上次是正常被退出
    
    if ([isCrash isEqualToString:@"YES"]) {
        
        //获取到本地存储的崩溃次数
        
        NSNumber*crashCount = [[NSUserDefaults standardUserDefaults] valueForKey:@"crashCount"];
        
        NSInteger count =0;
        
        if (crashCount !=nil) {
            
            count = [crashCount integerValue];
            
        }
        
        count++;
        
        //判断崩溃次数达到多少次时执行操作
        
        if (count >=3) {
            
            NSLog(@"多次崩溃");
            
            //将本地文件崩溃次数重新置为0
            
            [[NSUserDefaults standardUserDefaults] setObject:@0 forKey:@"crashCount"];
            
            [[NSUserDefaults standardUserDefaults] setObject:@"0.0"forKey:@"oldJSversion"];
            
            //删除本地的js文件
            
            [self deleteJSPatchFile];
            
            return;
            
        }
        
        //崩溃次数未达到3次则向本地存储崩溃次数
        
        crashCount = [NSNumber numberWithInteger:count];
        
        [[NSUserDefaults standardUserDefaults] setObject:crashCount forKey:@"crashCount"];
        
    }else{
        
        //上次正常退出把本地崩溃标识置为YES
        
        [[NSUserDefaults standardUserDefaults] setObject:@"YES"forKey:@"isCrash"];
        
    }
    
}

// 判断app是否更新了更新软件后删除js文件,没更新运行本地js文件
- (void)judgeIfAppUpdate{
    
    NSString *appVersion = [[NSUserDefaults standardUserDefaults] valueForKey:@"appVersion"];
    NSDictionary* dicInfo =[[NSBundle mainBundle] infoDictionary];
    NSString *currentAppVersion =[dicInfo objectForKey:@"CFBundleShortVersionString"];
    
    int result = [currentAppVersion compare:appVersion];
    //如果app更新
    if (result >0) {
        //删除js文件
        [self deleteJSPatchFile];
    }else{
        //运行下载到本地的js文件
        [self HSDevaluateScript];
    }
}

//删除JSPatch文件
- (void)deleteJSPatchFile{
    NSFileManager* fileManager=[NSFileManager defaultManager];
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,NSUserDomainMask,YES) lastObject];
    NSString *path2 = [path stringByAppendingString:@"/main.js"];
    [fileManager removeItemAtPath:path2 error:nil];
}




//检查JSPatch版本
- (void)checkJSPatchVersion{
    // 使用封装的网络请求方法向服务器请求JSPatch文件版本信息
    [Request ToolrequestWithType:GET RRLString:kCheckJSPatchURL parameter:nil HTTPHeader:nil callBlock:^(NSData*data,NSError*error) {
        
        NSDictionary*dic = [NSJSONSerialization JSONObjectWithData:dataoptions:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dic);
        NSArray *array = dic[@"patch_list"];
        NSDictionary *jsDic = [array lastObject];
        if (!jsDic) {
            return;
        }
        
        // 如果服务器里有js文件版本信息则取得最新的版本号
        NSString *version = [jsDic valueForKey:@"version_name"];
        
        // 获取上次下载的js文件的版本号
        NSString *oldJSversion = [[NSUserDefaultsstandardUserDefaults] valueForKey:@"oldJSversion"];
        
        // 比较旧的js文件版本号和js文件版本号
        int result = [version compare:oldJSversion];
        
        // 如果js文件版本更新了就删除旧js文件下载新的js文件
        if (!oldJSversion || result >0) {
            
            NSString *downloadUrl = [jsDic valueForKey:@"download_url"];
            
            //删除原先的js文件
            [self deleteJSPatchFile];
            
            //从服务器下载js文件
            [self downLoadJSFileWithUrlString:downloadUrl jsVersion:version];
            
        }
        
    }];
    
}

//下载JSPatch文件(使用的是AFNetworking框架)
- (void)downLoadJSFileWithUrlString:(NSString *)urlString jsVersion:(NSString *)jsVersion{
    
    //1.创建管理者对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //2.确定请求的URL地址
    NSURL*url = [NSURL URLWithString:urlString];
    
    //3.创建请求对象
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    //4.下载任务
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:^(NSProgress*_NonnulldownloadProgress) {
        
        //打印下载进度
        // @property int64_t totalUnitCount;需要下载文件的总大小
        // @property int64_t completedUnitCount;当前已经下载的大小
        NSLog(@"%lf",1.0* downloadProgress.completedUnitCount/ downloadProgress.totalUnitCount);
        
    }destination:^NSURL*_Nonnull(NSURL*_NonnulltargetPath,NSURLResponse*_Nonnullresponse) {
        
        //获取Library路径
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,NSUserDomainMask,YES) lastObject];
        
        //自己为文件取一个名字
        NSString *path2 = [path stringByAppendingString:@"/main.js"];
        
        NSURL *url = [NSURL fileURLWithPath:path2];
        // 下载文件的存放路径
        return url;
        
    }completionHandler:^(NSURLResponse*_Nonnullresponse,NSURL*_NullablefilePath,NSError*_Nullableerror) {
        
        NSLog(@"%@",error);
        
        // 下载完成存储此次下载的js版本号
        [[NSUserDefaultsstandardUserDefaults] setObject:jsVersion forKey:@"oldJSversion"];
        
    }];
    
    //开始启动任务
    [task resume];
    
}

 
 */


#pragma mark - getter
//- (UIWindow *)window
//{
//    if(!_window)
//    {
//        _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
////        _window.backgroundColor = [UIColor RandomColor];
////        [_window makeKeyAndVisible];
//    }
//    return _window;
//}

@end











//  ******************************* 每个程序创建刚开始生成的方法 *******************************
// *1*
/*
// 程序 开始运行
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    // 应用程序启动后覆盖自定义的点。
    return YES;
}

 // *2*
// 程序 挂起（有电话进来 或者 锁屏(拉下状态栏、双击Home键使App界面上移) 的时候）
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    
    //当应用程序即将从活动状态转换为非活动状态时发送。 对于某些类型的临时中断（例如来电或SMS消息）或当用户退出应用程序并且它开始转换到后台状态时，可能会发生这种情况。
         //使用此方法暂停正在进行的任务，禁用计时器，并使图形渲染回调无效。 游戏应该使用这种方法暂停游戏。
 
 
 /**
 程序将要失去Active状态时调用，比如有电话进来或者按下Home键，之后程序进入后台状态，对应的applicationWillEnterForeground(即将进入前台)方法。
 
 该函数里面主要执行操作:
 a . 暂停正在执行的任务
 b. 禁止计时器
 c. 减少OpenGL ES帧率
 d. 若为游戏应暂停游戏

 */

//}

// *3*
// 程序 进入后台
//- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    //使用此方法释放共享资源，保存用户数据，使计时器无效，并存储足够的应用程序状态信息，以便将应用程序恢复到当前状态，以防以后终止。
         //如果您的应用程序支持后台执行，则在用户退出时调用此方法而不是applicationWillTerminate：
    
    /**
     对应applicationDidBecomeActive(已经变成前台)
     
     该方法用来:
     a. 释放共享资源
     b. 保存用户数据(写到硬盘)
     c. 作废计时器
     d. 保存足够的程序状态以便下次修复;
     */
//}

// *4*
// 程序 进入前台
//- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    //被称为从背景到活动状态的过渡的一部分; 在这里，您可以撤消进入后台时所做的许多更改。

/**
 程序即将进入前台时调用，对应applicationWillResignActive(即将进入后台)，
 这个方法用来: 撤销applicationWillResignActive中做的改变。
 */

//}

// *5*
// 程序 重新激活（复原）注意：应用程序在启动时，在调用了“applicationDidFinishLaunching”方法之后 同样也会 调用“applicationDidBecomeActive”方法!
//- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    //在应用程序处于非活动状态时重新启动暂停（或尚未启动）的任何任务。 如果应用程序以前在后台，则可以选择刷新用户界面。

/**
 程序已经变为Active(前台)时调用。对应applicationDidEnterBackground(已经进入后台)。
 注意: 若程序之前在后台，在此方法内刷新用户界面
 */
    
//}


// *6*
// 程序 终止（注：如果点击主按钮强制退出，则不会调用该方法。）
//- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    //在应用程序即将终止时调用。 如果合适，保存数据。 另请参见applicationDidEnterBackground：。

/**
 程序即将退出时调用。记得保存数据，如applicationDidEnterBackground方法一样。
 */

//}

//*/
