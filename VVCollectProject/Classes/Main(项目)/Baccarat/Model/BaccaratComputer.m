//
//  BaccaratComputer.m
//  VVCollectProject
//
//  Created by Admin on 2021/12/17.
//  Copyright © 2021 Mike. All rights reserved.
//

#import "BaccaratComputer.h"

@implementation BaccaratComputer


#pragma mark -  算法数据


#pragma mark -  路单发牌功能
/// 路单发牌功能
/// @param index 发牌下标
+ (NSString *)roadListSendCardIndex:(NSInteger)index winType:(WinType)winType pxsType:(PXSType)pxsType {
    NSString *tempNuStr = nil;
    
    if (pxsType == PXSType_None) {
        if (index == 1) {
            tempNuStr = @"10";
        } else if (index == 3) {
            tempNuStr = @"1";
        } else if (index == 2) {
            tempNuStr = @"10";
        } else if (index == 4) {
            tempNuStr = @"1";
        }
    } else if (pxsType == PXSType_PlayerPair) {
        if (index == 1 || index == 3) {
            tempNuStr = @"10";
        } else if (index == 2) {
            tempNuStr = @"10";
        } else if (index == 4) {
            tempNuStr = @"1";
        }
    } else if (pxsType == PXSType_BankerPair) {
        if (index == 2 || index == 4) {
            tempNuStr = @"10";
        } else if (index == 1) {
            tempNuStr = @"10";
        } else if (index == 3) {
            tempNuStr = @"1";
        }
    } else if (pxsType == (PXSType_PlayerPair | PXSType_BankerPair)) {
        if (index == 1 || index == 2 || index == 3 || index == 4) {
            tempNuStr = @"10";
        }
    } else if (winType == WinType_Banker && pxsType == PXSType_SuperSix) {
        if (index == 1) {
            tempNuStr = @"10";
        } else if (index == 3) {
            tempNuStr = @"1";
        } if (index == 2) {
            tempNuStr = @"10";
        } else if (index == 4) {
            tempNuStr = @"6";
        } else if (index == 5) {
            tempNuStr = @"10";
        }
        return tempNuStr;
    } else if (winType == WinType_Banker && pxsType == (PXSType_PlayerPair | PXSType_BankerPair | PXSType_SuperSix)) {  // 开庄 闲对 庄对 超级6
        if (index == 1 || index == 2 || index == 3 || index == 4) {
            tempNuStr = @"10";
        } else if (index == 5) {
            tempNuStr = @"1";
        } else if (index == 6) {
            tempNuStr = @"6";
        }
        return tempNuStr;
    } else if (winType == WinType_Banker && pxsType == (PXSType_PlayerPair | PXSType_SuperSix)) {  // 开庄 闲对 超级6
        if (index == 1 || index == 3) {
            tempNuStr = @"10";
        } else if (index == 2) {
            tempNuStr = @"10";
        } else if (index == 4) {
            tempNuStr = @"6";
        } else if (index == 5) {
            tempNuStr = @"1";
        }
        return tempNuStr;
    } else if (winType == WinType_Banker && pxsType == (PXSType_BankerPair | PXSType_SuperSix)) {  // 开庄 庄对 超级6
        if (index == 2 || index == 4) {
            tempNuStr = @"8";
        } else if (index == 1) {
            tempNuStr = @"1";
        } else if (index == 3) {
            tempNuStr = @"2";
        } else if (index == 5) {
            tempNuStr = @"1";
        }
        return tempNuStr;
    } else if (winType == WinType_Player && pxsType == (PXSType_PlayerPair | PXSType_BankerPair | PXSType_SuperSix)) {  // 开闲 闲对 庄对 超级6
        if (index == 1 || index == 2 || index == 3 || index == 4) {
            tempNuStr = @"10";
        }
    } else if (pxsType == PXSType_SkyCard) {
        if (index == 1) {
            tempNuStr = @"1";
        } else if (index == 3) {
            tempNuStr = @"2";
        } if (index == 2) {
            tempNuStr = @"1";
        } else if (index == 4) {
            tempNuStr = @"2";
        } else if (index == 5 || index == 6) {
            tempNuStr = @"9";
        }
    }
    
    if (tempNuStr && index <= 4) {
        return tempNuStr;
    }
    
    // 路单使用
    if (winType == WinType_Player) {
        if (index == 5) {
            tempNuStr = @"4";
        } else if (index == 6) {
            tempNuStr = @"1";
        } else {
            tempNuStr = [NSString stringWithFormat:@"%zd",index-1];
        }
        
    } else if (winType == WinType_Banker) {
        if (index == 5) {
            tempNuStr = @"1";
        } else if (index == 6) {
            tempNuStr = @"3";
        } else {
            tempNuStr = [NSString stringWithFormat:@"%zd",index-1];
        }
    } else if (winType == WinType_TIE) {
        if (index == 5) {
            tempNuStr = @"1";
        } else if (index == 6) {
            tempNuStr = @"1";
        }
    }
    
    return tempNuStr;
}



@end
