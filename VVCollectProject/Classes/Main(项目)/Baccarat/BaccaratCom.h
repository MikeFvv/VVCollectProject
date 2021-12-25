//
//  BaccaratCom.h
//  VVCollectProject
//
//  Created by Admin on 2021/12/19.
//  Copyright © 2021 Mike. All rights reserved.
//

#ifndef BaccaratCom_h
#define BaccaratCom_h


// 输赢类型
typedef NS_ENUM(NSInteger, WinType) {
    WinType_TIE = 0,   // 和
    WinType_Banker = 1,   // 庄赢
    WinType_Player = 2,    // 闲赢(玩家)
};

// 下三路颜色类型
typedef NS_ENUM(NSInteger, MapColorType) {
    ColorType_Undefined = 0,   // 未知
    ColorType_Red = 1,   // 蓝色
    ColorType_Blue = 2,   // 蓝色
};

// 下三路 路图类型
typedef NS_ENUM(NSInteger, RoadMapType) {
    RoadMapType_Undefined = 0,   // 未知
    RoadMapType_DYL = 1,   // 大眼路
    RoadMapType_XL = 2,   // 小路
    RoadMapType_XQL = 3,   //  曱甴路(小强路) [yuē yóu]
};


/// 下三路 Size
static const int kItemSizeWidth = 10;
/// 大路 Size
static const int kDLItemSizeWidth = 14;
/// 珠盘路 Size
static const int kZPLItemSizeWidth = 17;
/// 总网格数量
static const int kTotalGridsNum = 300;
/// 分析视图高度
static const int kTrendViewHeight = 120;

#endif /* BaccaratCom_h */
