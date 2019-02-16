//
//  AppDelegate.m
//  VVCollectProject
//
//  Created by Mike on 2019/1/11.
//  Copyright © 2019 Mike. All rights reserved.
//

#import "AppDelegate.h"
#import "WRNavigationBar.h"
#import "BaseNavigationController.h"
#import "UIImage+GradientColor.h"
#import "ViewController.h"
#import "JSPatchCode.h"
#import "HomeViewController.h"
#import "YYFPSLabel.h"
#import "UIColor+Random.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

#pragma mark程序启动
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
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
    
    BaseNavigationController *firstNav = [[BaseNavigationController alloc] initWithRootViewController:[HomeViewController new]];
    UITabBarController *tabBarVC = [UITabBarController new];
    tabBarVC.viewControllers = @[firstNav];
    self.window.rootViewController = tabBarVC;
    
//    self.window.rootViewController = [ViewController new];
//    [self setNavBarAppearence];
    
    
    // 刷新率
    [self.window addSubview:[[YYFPSLabel alloc] initWithFrame:CGRectMake(20, 70, 0, 0)]];
    
    //程序崩溃检测记录
//    [self recordCrashCount];
//    //判断app是否更新了更新软件后删除js文件,没更新运行本地js文件
//    [self judgeIfAppUpdate];
    
    
    
//    [self.window makeKeyAndVisible];
    return YES;
}


- (void)setNavBarAppearence
{
    
    CGSize size = CGSizeMake(376.0f, 83.0f);
    UIColor *topleftColor = [UIColor colorWithRed:148/255.0f green:127/255.0f blue:202/255.0f alpha:1.0f];
    UIColor *bottomrightColor = [UIColor colorWithRed:(141/255.0) green:(137/255.0) blue:(244/255.0) alpha:(1)];
    UIImage *bgImg = [UIImage gradientColorImageFromColors:@[topleftColor, bottomrightColor] gradientType:1 imgSize:size];
    
    // 设置导航栏默认的背景颜色
    [WRNavigationBar wr_setDefaultNavBarBarTintColor:[UIColor colorWithPatternImage:bgImg]];
    // 设置导航栏所有按钮的默认颜色
    [WRNavigationBar wr_setDefaultNavBarTintColor:[UIColor whiteColor]];
    // 设置导航栏标题默认颜色
    [WRNavigationBar wr_setDefaultNavBarTitleColor:[UIColor whiteColor]];
    // 统一设置状态栏样式
    [WRNavigationBar wr_setDefaultStatusBarStyle:UIStatusBarStyleLightContent];
    // 如果需要设置导航栏底部分割线隐藏，可以在这里统一设置
    [WRNavigationBar wr_setDefaultNavBarShadowImageHidden:YES];
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
    NSString*path = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,NSUserDomainMask,YES) lastObject];
//    NSString*path2 = [path stringByAppendingString:@"/main.js"];
     NSString*path2 = [path stringByAppendingString:@"/JSPatch/1.0/demo.js"];
    NSLog(@"%@",path2);
    //获取内容
    NSString*js = [NSString stringWithContentsOfFile:path2 encoding:NSUTF8StringEncoding error:nil];
    
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
    
    NSString*isCrash = [[NSUserDefaults standardUserDefaults] valueForKey:@"isCrash"];
    
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
    
    NSString*appVersion = [[NSUserDefaults standardUserDefaults] valueForKey:@"appVersion"];
    NSDictionary* dicInfo =[[NSBundle mainBundle] infoDictionary];
    NSString* currentAppVersion =[dicInfo objectForKey:@"CFBundleShortVersionString"];
    
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
    NSString*path = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,NSUserDomainMask,YES) lastObject];
    NSString*path2 = [path stringByAppendingString:@"/main.js"];
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
            
            NSString*downloadUrl = [jsDic valueForKey:@"download_url"];
            
            //删除原先的js文件
            [self deleteJSPatchFile];
            
            //从服务器下载js文件
            [self downLoadJSFileWithUrlString:downloadUrl jsVersion:version];
            
        }
        
    }];
    
}

//下载JSPatch文件(使用的是AFNetworking框架)
- (void)downLoadJSFileWithUrlString:(NSString*)urlString jsVersion:(NSString*)jsVersion{
    
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
- (UIWindow *)window
{
    if(!_window)
    {
        _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//        _window.backgroundColor = [UIColor RandomColor];
        [_window makeKeyAndVisible];
    }
    return _window;
}

@end
