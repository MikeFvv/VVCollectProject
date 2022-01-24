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


static const NSString *kUserIdStr = @"10000";

/// 左边视图一半 + 这里多添加的宽度
static const CGFloat kBAddWidth = 50;
/// 左边U型槽间距 刘海屏缺口间距 spacing
static const CGFloat kBUNotchSpacing = 30;


/// 下三路 Size
static const int kBItemSizeWidth = 8;
/// 大路 Size
static const int kBDLItemSizeWidth = 12;
/// 珠盘路 Size
static const int kBZPLItemSizeWidth = 15;
/// 总网格数量
static const int kBTotalGridsNum = 300;

/// 分析视图高度
static const int kBTrendViewLineSpacingHeight = 20;
/// 分析视图高度
static const int kBTrendViewHeight = kBTrendViewLineSpacingHeight *4+5 + 20;

/// 下注视图按钮高度
static const CGFloat kBBetViewBtnHeight = 60;

/// 最大下注筹码
static const int kMaxBetChipsNum = 2000000;
/// 最小下注筹码
static const int kMinBetChipsNum = 1000;


/// 更多列表每列高度
static const CGFloat kBMoreColHeight = 40;

#endif /* BaccaratCom_h */
