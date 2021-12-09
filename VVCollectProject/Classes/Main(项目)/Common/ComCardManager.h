//
//  ComCardManager.h
//  VVCollectProject
//
//  Created by Admin on 2021/12/10.
//  Copyright © 2021 Mike. All rights reserved.
//

#import <Foundation/Foundation.h>


// 花色 从小到大
typedef NS_ENUM(NSInteger, CardColorType) {
    CardColorType_Diamonds = 0,   //  方块(方片)
    CardColorType_Clubs = 1,   // 梅花
    CardColorType_Hearts = 2,    // 红桃（红心）
    CardColorType_Spades = 3,       // 黑桃
};

// 牌面大小 从小到大
typedef NS_ENUM(NSInteger, CardType) {
    HIGH_CARD,          //高牌
    ONE_PAIR,           //一对
    TWO_PAIR,           //二对
    THREE_OF_A_KIND,    //三条
    STRAIGHT,           //顺子
    FLUSH,              //同花
    FULL_HOUSE,         //葫芦
    FOUR_OF_A_KIND,     //四条
    STRAIGHT_FLUSH,     //同花顺
};





//typedef NS_ENUM(NSInteger, MlHoldCardType) {
//    MlHoldCardType_BIG_PAIR,       //两张底牌为9～A的对子
//    MlHoldCardType_SMALL_PAIR,     //为2～8的对子
//    MlHoldCardType_BIG_FLUSH,      //同花色，且都大于等于9
//    MlHoldCardType_SMALL_FLUSH,    //同花色，不都大于等于9
//    MlHoldCardType_HIGH_SINGLE,    //单牌，且都大于9
//    MlHoldCardType_LOW_SINGLE,     //小的单牌
//};
//
///**
// * 用于机器学习的牌型
// *
// */
//typedef NS_ENUM(NSInteger, MlCardType) {
//    MlCardType_HIGH_CARD,          //高牌
//    MlCardType_LOW_ONE_PAIR,       //小对子
//    MlCardType_HIGH_ONE_PAIR,      //大对子
//    MlCardType_LOW_TWO_PAIR,       //小两对
//    MlCardType_HIGH_TWO_PAIR,      //大两对
//    MlCardType_THREE_OF_A_KIND,    //三条
//    MlCardType_STRAIGHT,           //顺子
//    MlCardType_FLUSH,              //同花
//    MlCardType_FULL_HOUSE_UP,      //葫芦及葫芦以上
//    MlCardType_FLUSH_1,            //同花缺一张
//    MlCardType_STRAIGHT_1,         //顺子缺一张
//};



NS_ASSUME_NONNULL_BEGIN

@interface ComCardManager : NSObject

@end

NS_ASSUME_NONNULL_END
