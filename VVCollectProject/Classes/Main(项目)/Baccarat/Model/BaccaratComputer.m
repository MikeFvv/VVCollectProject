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
+ (NSMutableArray *)daYanLu_ComputerData:(NSMutableArray *)daLu_ResultDataArray {
    // *** 大眼路规则 ***
    // 大眼仔开始及对应位：第二列对第一列.第三列对第二列.第四列对第三列.第五列对第四列.如此类推。
    // 大眼仔：是从大路第二列(第一口不计)第二口开始向第一列第二口对(第一列不管开几多口庄或闲，是不写红蓝笔，只供大眼仔对应写红或蓝)。
    // (大眼仔开始的第一口)大路第二列.向下开闲，向左望第一列有对，写红。
    
    
    //    小路开始及对应位：第三列对第一列.第四列对第二列.第五列对第三列.第六列对第四列.如此类推。
    //    曱甴路开始及对应位：第四列对第一列.第五列对第二列.第六列对第三列.第七列对第四列.如此类推。
    
    NSInteger startColumn = 0;
    if (RoadMapType_DYL) {
        
    }
    
    
    
    if (daLu_ResultDataArray.count < 2) {
        return nil;
    }
    
    NSArray *currentColArray = (NSArray *)daLu_ResultDataArray.lastObject;
    
    if (daLu_ResultDataArray.count == 2 && currentColArray.count == 1) {
        return nil;
    }
    
    // 前一列
    NSArray *frontColArray = (NSArray *)daLu_ResultDataArray[daLu_ResultDataArray.count-2];
    
    
    MapColorType colorType = 0;
    if (currentColArray.count == 1) {
        // 路头牌
        
        // 前2列
        NSArray *frontTwoColArray = (NSArray *)daLu_ResultDataArray[daLu_ResultDataArray.count-3];
        // 假设  路头牌”之后在大眼仔上添加的颜色应该是假设大路中上一列继续的情况下我们本应在大眼仔上添加的颜色的相反颜色
        colorType = [self getDaYanLuColorCurrentColumnNum:frontColArray.count+1 frontColumnNum:frontTwoColArray.count];
        colorType = colorType == ColorType_Red ? ColorType_Blue : ColorType_Red;
    } else {
        // 路中牌
        colorType = [self getDaYanLuColorCurrentColumnNum:currentColArray.count frontColumnNum:frontColArray.count];
    }
    
//    [self.dyl_DataArray addObject:@(colorType)];
    
//    [self daYanLu_createItems];
    return nil;
}


+ (MapColorType)getDaYanLuColorCurrentColumnNum:(NSInteger)currentColumnNum frontColumnNum:(NSInteger)frontColumnNum {
    MapColorType mapColorType = ColorType_Undefined;
    if (currentColumnNum <= frontColumnNum) {   // 当前列小于等于前一列 「标红」  // -路中牌
        mapColorType = ColorType_Red;
    } else if (currentColumnNum -1 == frontColumnNum) {  // 当前列大于前一列 1个 「标蓝」  // -路中牌
        mapColorType = ColorType_Blue;
    } else if (currentColumnNum -1 > frontColumnNum) {  // 当前列大于前一列 2个及以上 「标红」  长闲长庄  // -路中牌
        mapColorType = ColorType_Red;
    } else {
        NSLog(@"🔴🔴🔴未知🔴🔴🔴");
    }
    return mapColorType;
}


@end
