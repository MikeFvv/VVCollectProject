//
//  BaccaratComputer.m
//  VVCollectProject
//
//  Created by Admin on 2021/12/17.
//  Copyright © 2021 Mike. All rights reserved.
//

#import "BaccaratComputer.h"

@implementation BaccaratComputer


#pragma mark -   百家乐发牌停牌算法
/// 百家乐发牌停牌算法
/// @param index 发牌下标
/// @param player3 闲第张牌
/// @param playerTotalPoints 闲总点数
/// @param bankerTotalPoints 庄总点数
+ (BOOL)baccaratStopCardIndex:(NSInteger)index player3:(NSInteger)player3 playerTotalPoints:(NSInteger)playerTotalPoints bankerTotalPoints:(NSInteger)bankerTotalPoints {
    
    BOOL isStop = NO;
    
    if (index == 4) {
        if (playerTotalPoints >= 8 ||  bankerTotalPoints >= 8) {
            isStop = YES;
        } else if (playerTotalPoints >= 6 && bankerTotalPoints >= 6) {
            isStop = YES;
        }
    } else if (index == 5) {
        
        if (playerTotalPoints >= 6 && bankerTotalPoints < 6) {
            isStop = YES;
        } else if (bankerTotalPoints == 3 && player3 == 8) {
            isStop = YES;
        } else if (bankerTotalPoints == 4 && (player3 == 0 || player3 == 1 || player3 == 8 || player3 == 9)) {
            isStop = YES;
        } else if (bankerTotalPoints == 5 && (player3 == 0 || player3 == 1 || player3 == 2 || player3 == 3 || player3 == 8 || player3 == 9)) {
            isStop = YES;
        } else if (bankerTotalPoints == 6 && (player3 != 6 && player3 != 7)) {
            isStop = YES;
        } else if (bankerTotalPoints == 7) {
            isStop = YES;
        } else {
            NSLog(@"继续发牌");
        }
    } else if (index == 6) {
        isStop = YES;
    }
    
    return isStop;
}

/// 判断是否长龙
/// @param model 模型
/// @param colDataArray 列数据
+ (BOOL)isLongResultModel:(BaccaratResultModel *)model colDataArray:(NSArray *)colDataArray {
    BOOL isLong = NO;
    
    NSArray *oneArray = (NSArray *)colDataArray.lastObject;
    BaccaratResultModel *lastModel = oneArray.lastObject;
    
    // 处理上次和的情况，获取最后一个闲或庄
    BaccaratResultModel *lastBPModel = nil;
    if (lastModel.winType == WinType_TIE) {
        for (BaccaratResultModel *tempLastModel in oneArray) {
            if (tempLastModel.winType == WinType_Banker || tempLastModel.winType == WinType_Player) {
                lastBPModel = tempLastModel;
                break;
            } else {
                lastBPModel = lastModel;
            }
        }
    }
    
    // 1.本次是否和上次相同，2.本次等于和, 3.最后的庄闲和本次相同 4.或者最后只有和 第一局和情况
    if (model.winType == lastModel.winType || model.winType == WinType_TIE || model.winType == lastBPModel.winType || lastBPModel.winType == WinType_TIE) {
        isLong = YES;
    }
    return isLong;
}

/// 计算最多可使用空白格数
/// @param currentColX 当前列X值




/// 计算最多可使用空白格数
/// @param currentColX 当前列X值
/// @param allColLastLabelArray 全部的长龙拐弯的的最后一个数据
/// @param width 列宽度
+ (NSInteger)getMaxBlankColumnsCurrentColX:(CGFloat)currentColX allColLastLabelArray:(NSMutableArray *)allColLastLabelArray width:(CGFloat)width {
    
    // 计算最多可使用空白格数
    NSInteger maxBlankColumns = 6;
    
    CGFloat margin = kBMarginWidth;
    CGFloat w = width;
    
    // 获得最小的Y 值 Label
    UILabel *tempLabel = nil;
    CGFloat minY = (w + margin) * 6;
    for (UILabel *label in allColLastLabelArray.reverseObjectEnumerator) {  //  对数组逆序遍历，然后再删除元素就没有问题了。
        CGFloat oldX = CGRectGetMaxX(label.frame);
        CGFloat oldY = CGRectGetMaxY(label.frame);
        if (oldX >= currentColX) {  // 大于等于当前 X
            if (oldY < minY) {
                minY = oldY;
                tempLabel = label;  // 记录这个Label
            }
        } else {
            // 否则移除小于当前的X 值Label
            // 这里不能移除掉，因为后退后，还需要
            //            [allColLastLabelArray removeObject:label];
            NSLog(@"11");
        }
    }
    
    if (tempLabel) {
        CGFloat lastLabelX = CGRectGetMaxX(tempLabel.frame);
        CGFloat lastLabelY = CGRectGetMinY(tempLabel.frame);
        
        if (lastLabelX > 0) {
            maxBlankColumns = lastLabelY/(w +margin);
        }
    }
    
    return maxBlankColumns;
}

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


/// 测试使用  增加长庄长闲
+ (NSString *)testRandomRoadListIndex:(NSInteger)index testIndex:(NSInteger)testIndex {
    
    NSString *numStr = nil;
    
    
    if (testIndex > 35) {
        numStr = @"5";
    } else if (testIndex > 22) {
        numStr = @"7";
    }
    
    if (index == 5) {
        
        if (testIndex < 5) {
            numStr = @"10";
        } else if (testIndex > 10) {
            
            if (testIndex > 18) {
                if (testIndex > 27) {
                    if (testIndex > 36) {
                        if (testIndex > 45) {
                            if (testIndex > 54) {
                                numStr = @"1";
                            } else {
                                numStr = @"8";
                            }
                        } else {
                            numStr = @"1";
                        }
                    } else {
                        numStr = @"8";
                    }
                } else {
                    numStr = @"1";
                }
            } else {
                numStr = @"8";
            }
            
        } else {
            numStr = @"1";
        }
    }
    
    return numStr;
    
}


@end
