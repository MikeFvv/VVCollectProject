//
//  MXWHelper.m
//  VVCollectProject
//
//  Created by Admin on 2021/12/22.
//  Copyright © 2021 Mike. All rights reserved.
//

#import "MXWHelper.h"
//#import <math.h>
#import <sys/utsname.h>


@implementation MXWHelper

@end



@implementation MXWHelper (Device)

+ (NSString *)deviceModel {
    if (IS_SIMULATOR) {
        // Simulator doesn't return the identifier for the actual physical model, but returns it as an environment variable
        // 模拟器不返回物理机器信息，但会通过环境变量的方式返回
        return [NSString stringWithFormat:@"%s", getenv("SIMULATOR_MODEL_IDENTIFIER")];
    }
    
    // See https://www.theiphonewiki.com/wiki/Models for identifiers
    struct utsname systemInfo;
    uname(&systemInfo);
    return [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
}

+ (NSString *)deviceName {
    static dispatch_once_t onceToken;
    static NSString *name;
    dispatch_once(&onceToken, ^{
        NSString *model = [self deviceModel];
        if (!model) {
            name = @"Unknown Device";
            return;
        }
        
        NSDictionary *dict = @{
            // See https://www.theiphonewiki.com/wiki/Models
            @"iPhone1,1" : @"iPhone 1G",
            @"iPhone1,2" : @"iPhone 3G",
            @"iPhone2,1" : @"iPhone 3GS",
            @"iPhone3,1" : @"iPhone 4 (GSM)",
            @"iPhone3,2" : @"iPhone 4",
            @"iPhone3,3" : @"iPhone 4 (CDMA)",
            @"iPhone4,1" : @"iPhone 4S",
            @"iPhone5,1" : @"iPhone 5",
            @"iPhone5,2" : @"iPhone 5",
            @"iPhone5,3" : @"iPhone 5c",
            @"iPhone5,4" : @"iPhone 5c",
            @"iPhone6,1" : @"iPhone 5s",
            @"iPhone6,2" : @"iPhone 5s",
            @"iPhone7,1" : @"iPhone 6 Plus",
            @"iPhone7,2" : @"iPhone 6",
            @"iPhone8,1" : @"iPhone 6s",
            @"iPhone8,2" : @"iPhone 6s Plus",
            @"iPhone8,4" : @"iPhone SE",
            @"iPhone9,1" : @"iPhone 7",
            @"iPhone9,2" : @"iPhone 7 Plus",
            @"iPhone9,3" : @"iPhone 7",
            @"iPhone9,4" : @"iPhone 7 Plus",
            @"iPhone10,1" : @"iPhone 8",
            @"iPhone10,2" : @"iPhone 8 Plus",
            @"iPhone10,3" : @"iPhone X",
            @"iPhone10,4" : @"iPhone 8",
            @"iPhone10,5" : @"iPhone 8 Plus",
            @"iPhone10,6" : @"iPhone X",
            @"iPhone11,2" : @"iPhone XS",
            @"iPhone11,4" : @"iPhone XS Max",
            @"iPhone11,6" : @"iPhone XS Max CN",
            @"iPhone11,8" : @"iPhone XR",
            @"iPhone12,1" : @"iPhone 11",
            @"iPhone12,3" : @"iPhone 11 Pro",
            @"iPhone12,5" : @"iPhone 11 Pro Max",
            @"iPhone12,8" : @"iPhone SE (2nd generation)",
            @"iPhone13,1" : @"iPhone 12 mini",
            @"iPhone13,2" : @"iPhone 12",
            @"iPhone13,3" : @"iPhone 12 Pro",
            @"iPhone13,4" : @"iPhone 12 Pro Max",
            @"iPhone14,4" : @"iPhone 13 mini",
            @"iPhone14,5" : @"iPhone 13",
            @"iPhone14,2" : @"iPhone 13 Pro",
            @"iPhone14,3" : @"iPhone 13 Pro Max",
            
            @"iPad1,1" : @"iPad 1",
            @"iPad2,1" : @"iPad 2 (WiFi)",
            @"iPad2,2" : @"iPad 2 (GSM)",
            @"iPad2,3" : @"iPad 2 (CDMA)",
            @"iPad2,4" : @"iPad 2",
            @"iPad2,5" : @"iPad mini 1",
            @"iPad2,6" : @"iPad mini 1",
            @"iPad2,7" : @"iPad mini 1",
            @"iPad3,1" : @"iPad 3 (WiFi)",
            @"iPad3,2" : @"iPad 3 (4G)",
            @"iPad3,3" : @"iPad 3 (4G)",
            @"iPad3,4" : @"iPad 4",
            @"iPad3,5" : @"iPad 4",
            @"iPad3,6" : @"iPad 4",
            @"iPad4,1" : @"iPad Air",
            @"iPad4,2" : @"iPad Air",
            @"iPad4,3" : @"iPad Air",
            @"iPad4,4" : @"iPad mini 2",
            @"iPad4,5" : @"iPad mini 2",
            @"iPad4,6" : @"iPad mini 2",
            @"iPad4,7" : @"iPad mini 3",
            @"iPad4,8" : @"iPad mini 3",
            @"iPad4,9" : @"iPad mini 3",
            @"iPad5,1" : @"iPad mini 4",
            @"iPad5,2" : @"iPad mini 4",
            @"iPad5,3" : @"iPad Air 2",
            @"iPad5,4" : @"iPad Air 2",
            @"iPad6,3" : @"iPad Pro (9.7 inch)",
            @"iPad6,4" : @"iPad Pro (9.7 inch)",
            @"iPad6,7" : @"iPad Pro (12.9 inch)",
            @"iPad6,8" : @"iPad Pro (12.9 inch)",
            @"iPad6,11": @"iPad 5 (WiFi)",
            @"iPad6,12": @"iPad 5 (Cellular)",
            @"iPad7,1" : @"iPad Pro (12.9 inch, 2nd generation)",
            @"iPad7,2" : @"iPad Pro (12.9 inch, 2nd generation)",
            @"iPad7,3" : @"iPad Pro (10.5 inch)",
            @"iPad7,4" : @"iPad Pro (10.5 inch)",
            @"iPad7,5" : @"iPad 6 (WiFi)",
            @"iPad7,6" : @"iPad 6 (Cellular)",
            @"iPad7,11": @"iPad 7 (WiFi)",
            @"iPad7,12": @"iPad 7 (Cellular)",
            @"iPad8,1" : @"iPad Pro (11 inch)",
            @"iPad8,2" : @"iPad Pro (11 inch)",
            @"iPad8,3" : @"iPad Pro (11 inch)",
            @"iPad8,4" : @"iPad Pro (11 inch)",
            @"iPad8,5" : @"iPad Pro (12.9 inch, 3rd generation)",
            @"iPad8,6" : @"iPad Pro (12.9 inch, 3rd generation)",
            @"iPad8,7" : @"iPad Pro (12.9 inch, 3rd generation)",
            @"iPad8,8" : @"iPad Pro (12.9 inch, 3rd generation)",
            @"iPad8,9" : @"iPad Pro (11 inch, 2nd generation)",
            @"iPad8,10" : @"iPad Pro (11 inch, 2nd generation)",
            @"iPad8,11" : @"iPad Pro (12.9 inch, 4th generation)",
            @"iPad8,12" : @"iPad Pro (12.9 inch, 4th generation)",
            @"iPad11,1" : @"iPad mini (5th generation)",
            @"iPad11,2" : @"iPad mini (5th generation)",
            @"iPad11,3" : @"iPad Air (3rd generation)",
            @"iPad11,4" : @"iPad Air (3rd generation)",
            @"iPad11,6" : @"iPad (WiFi)",
            @"iPad11,7" : @"iPad (Cellular)",
            @"iPad13,1" : @"iPad Air (4th generation)",
            @"iPad13,2" : @"iPad Air (4th generation)",
            @"iPad13,4" : @"iPad Pro (11 inch, 3rd generation)",
            @"iPad13,5" : @"iPad Pro (11 inch, 3rd generation)",
            @"iPad13,6" : @"iPad Pro (11 inch, 3rd generation)",
            @"iPad13,7" : @"iPad Pro (11 inch, 3rd generation)",
            @"iPad13,8" : @"iPad Pro (12.9 inch, 5th generation)",
            @"iPad13,9" : @"iPad Pro (12.9 inch, 5th generation)",
            @"iPad13,10" : @"iPad Pro (12.9 inch, 5th generation)",
            @"iPad13,11" : @"iPad Pro (12.9 inch, 5th generation)",
            @"iPad14,1" : @"iPad mini (6th generation)",
            @"iPad14,2" : @"iPad mini (6th generation)",
            
            @"iPod1,1" : @"iPod touch 1",
            @"iPod2,1" : @"iPod touch 2",
            @"iPod3,1" : @"iPod touch 3",
            @"iPod4,1" : @"iPod touch 4",
            @"iPod5,1" : @"iPod touch 5",
            @"iPod7,1" : @"iPod touch 6",
            @"iPod9,1" : @"iPod touch 7",
            
            @"i386" : @"Simulator x86",
            @"x86_64" : @"Simulator x64",
            
            @"Watch1,1" : @"Apple Watch 38mm",
            @"Watch1,2" : @"Apple Watch 42mm",
            @"Watch2,3" : @"Apple Watch Series 2 38mm",
            @"Watch2,4" : @"Apple Watch Series 2 42mm",
            @"Watch2,6" : @"Apple Watch Series 1 38mm",
            @"Watch2,7" : @"Apple Watch Series 1 42mm",
            @"Watch3,1" : @"Apple Watch Series 3 38mm",
            @"Watch3,2" : @"Apple Watch Series 3 42mm",
            @"Watch3,3" : @"Apple Watch Series 3 38mm (LTE)",
            @"Watch3,4" : @"Apple Watch Series 3 42mm (LTE)",
            @"Watch4,1" : @"Apple Watch Series 4 40mm",
            @"Watch4,2" : @"Apple Watch Series 4 44mm",
            @"Watch4,3" : @"Apple Watch Series 4 40mm (LTE)",
            @"Watch4,4" : @"Apple Watch Series 4 44mm (LTE)",
            @"Watch5,1" : @"Apple Watch Series 5 40mm",
            @"Watch5,2" : @"Apple Watch Series 5 44mm",
            @"Watch5,3" : @"Apple Watch Series 5 40mm (LTE)",
            @"Watch5,4" : @"Apple Watch Series 5 44mm (LTE)",
            @"Watch5,9" : @"Apple Watch SE 40mm",
            @"Watch5,10" : @"Apple Watch SE 44mm",
            @"Watch5,11" : @"Apple Watch SE 40mm",
            @"Watch5,12" : @"Apple Watch SE 44mm",
            @"Watch6,1"  : @"Apple Watch Series 6 40mm",
            @"Watch6,2"  : @"Apple Watch Series 6 44mm",
            @"Watch6,3"  : @"Apple Watch Series 6 40mm",
            @"Watch6,4"  : @"Apple Watch Series 6 44mm",
            
            @"AudioAccessory1,1" : @"HomePod",
            @"AudioAccessory1,2" : @"HomePod",
            @"AudioAccessory5,1" : @"HomePod mini",
            
            @"AirPods1,1" : @"AirPods (1st generation)",
            @"AirPods2,1" : @"AirPods (2nd generation)",
            @"iProd8,1"   : @"AirPods Pro",
            
            @"AppleTV2,1" : @"Apple TV 2",
            @"AppleTV3,1" : @"Apple TV 3",
            @"AppleTV3,2" : @"Apple TV 3",
            @"AppleTV5,3" : @"Apple TV 4",
            @"AppleTV6,2" : @"Apple TV 4K",
        };
        name = dict[model];
        if (!name) name = model;
        if (IS_SIMULATOR) name = [name stringByAppendingString:@" Simulator"];
    });
    return name;
}

static NSInteger isIPad = -1;
+ (BOOL)isIPad {
    if (isIPad < 0) {
        // [[[UIDevice currentDevice] model] isEqualToString:@"iPad"] 无法判断模拟器 iPad，所以改为以下方式
        isIPad = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? 1 : 0;
    }
    return isIPad > 0;
}

static NSInteger isIPod = -1;
+ (BOOL)isIPod {
    if (isIPod < 0) {
        NSString *string = [[UIDevice currentDevice] model];
        isIPod = [string rangeOfString:@"iPod touch"].location != NSNotFound ? 1 : 0;
    }
    return isIPod > 0;
}

static NSInteger isIPhone = -1;
+ (BOOL)isIPhone {
    if (isIPhone < 0) {
        NSString *string = [[UIDevice currentDevice] model];
        isIPhone = [string rangeOfString:@"iPhone"].location != NSNotFound ? 1 : 0;
    }
    return isIPhone > 0;
}


static NSInteger isSimulator = -1;
+ (BOOL)isSimulator {
    if (isSimulator < 0) {
#if TARGET_OS_SIMULATOR
        isSimulator = 1;
#else
        isSimulator = 0;
#endif
    }
    return isSimulator > 0;
}


+ (BOOL)isMac {
    if (@available(iOS 14.0, *)) {
        return [NSProcessInfo processInfo].isiOSAppOnMac || [NSProcessInfo processInfo].isMacCatalystApp;
    }
    if (@available(iOS 13.0, *)) {
        return [NSProcessInfo processInfo].isMacCatalystApp;
    }
    return NO;
}

@end



@implementation MXWHelper (SystemVersion)

+ (NSInteger)numbericOSVersion {
    NSString *OSVersion = [[UIDevice currentDevice] systemVersion];
    NSArray *OSVersionArr = [OSVersion componentsSeparatedByString:@"."];
    
    NSInteger numbericOSVersion = 0;
    NSInteger pos = 0;
    
    while ([OSVersionArr count] > pos && pos < 3) {
        numbericOSVersion += ([[OSVersionArr objectAtIndex:pos] integerValue] * pow(10, (4 - pos * 2)));
        pos++;
    }
    
    return numbericOSVersion;
}

+ (NSComparisonResult)compareSystemVersion:(NSString *)currentVersion toVersion:(NSString *)targetVersion {
    return [currentVersion compare:targetVersion options:NSNumericSearch];
}

+ (BOOL)isCurrentSystemAtLeastVersion:(NSString *)targetVersion {
    return [MXWHelper compareSystemVersion:[[UIDevice currentDevice] systemVersion] toVersion:targetVersion] == NSOrderedSame || [MXWHelper compareSystemVersion:[[UIDevice currentDevice] systemVersion] toVersion:targetVersion] == NSOrderedDescending;
}

+ (BOOL)isCurrentSystemLowerThanVersion:(NSString *)targetVersion {
    return [MXWHelper compareSystemVersion:[[UIDevice currentDevice] systemVersion] toVersion:targetVersion] == NSOrderedAscending;
}

@end
