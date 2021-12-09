//
//  CardConstants.h
//  VVCollectProject
//
//  Created by Admin on 2021/12/10.
//  Copyright © 2021 Mike. All rights reserved.
//

#ifndef CardConstants_h
#define CardConstants_h


//    static const int HIGH_BET_MULTIPLE = 20; // 下注时最大跟注的倍数，超过这个倍数时就弃牌
//    static const int MIDDLE_BET_MULTIPLE = 10;
//    static const int LOW_BET_MULTIPLE = 5;
//
//    static const int MAX_TOTAL_MULTIPLE = 100; // MAX_TOTAL_MULTIPLE * blind 超过剩余的金币与筹码总和
//
//    static const int GAP_VALUE = 10;     // 分界值，大于或等于这个值为Big，小于这个值为Small
//
//    static const int HIGH_RAISE_MULTIPLE = 10;
//    static const int MIDDLE_RAISE_MULTIPLE = 5;
//    static const int LOW_RAISE_MULTIPLE = 3;
    
    static const int PLAYER_NUM = 4;
    static const int GAP_VALUE = 10;     // 分界值，大于或等于这个值为Big，小于这个值为Small
    static const int MAX_TOTAL_MULTIPLE = 3;
    static const int MAX_BET_MULTIPLE_EACH_HAND = 2;
    static const int HIGH_BET_MULTIPLE = 10; // 下注时最大跟注的倍数，超过这个倍数时就弃牌
    static const int MIDDLE_BET_MULTIPLE = 5;
    static const int LOW_BET_MULTIPLE = 3;

    static const int HIGH_RAISE_MULTIPLE = 5;
    static const int MIDDLE_RAISE_MULTIPLE = 3;
    static const int LOW_RAISE_MULTIPLE = 2;
    
    static const int MAX_FOLD_MULTIPLE = 3; // 当剩余筹码占初始金币不到 1 / MAX_FOLD_MULTIPLE 时，会变得比较保守
    // MoreAI
    static const int MORE_MAX_BET_MULTIPLE = 10;
    static const int MORE_HIGH_BET_MULTIPLE = 5; // 下注时最大跟注的倍数，超过这个倍数时就弃牌 // 6 4 2
    static const int MORE_MIDDLE_BET_MULTIPLE = 3;
    static const int MORE_LOW_BET_MULTIPLE = 2;

    static const int MORE_MAX_RAISE_MULTIPLE = 15;
    static const int MORE_HIGH_RAISE_MULTIPLE = 6;
    static const int MORE_MIDDLE_RAISE_MULTIPLE = 4;
    static const int MORE_LOW_RAISE_MULTIPLE = 2;
    
    static const int MORE_CALL_PERCENTAGE = 25;
    static const int MORE_GAP_VALUE = 11;
    // LessAI
    static const int LESS_MAX_BET_MULTIPLE = 13;
    static const int LESS_HIGH_BET_MULTIPLE = 6; // 下注时最大跟注的倍数，超过这个倍数时就弃牌
    static const int LESS_MIDDLE_BET_MULTIPLE = 4;
    static const int LESS_LOW_BET_MULTIPLE = 3;
    
    static const int LESS_MAX_RAISE_MULTIPLE = 20;
    static const int LESS_HIGH_RAISE_MULTIPLE = 6;
    static const int LESS_MIDDLE_RAISE_MULTIPLE = 4;
    static const int LESS_LOW_RAISE_MULTIPLE = 2;
    
    static const int LESS_CALL_PERCENTAGE = 35; // 牌型不是很好的时候，跟注的概率百分比
    static const int LESS_GAP_VALUE = 11;



#endif /* CardConstants_h */
