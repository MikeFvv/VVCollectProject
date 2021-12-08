

#import <Foundation/Foundation.h>


// 花色 从小到大
typedef NS_ENUM(NSInteger, PokerColorType) {
    PokerColorType_Diamonds = 0,   //  方块
    PokerColorType_Clubs = 1,   // 梅花
    PokerColorType_Hearts = 2,    // 红桃（红心）
    PokerColorType_Spades = 3,       // 黑桃
};


@interface BlackJackDataSourceModel : NSObject

/// 花色类型
@property (nonatomic, assign) PokerColorType colorTyp;


@property (strong, nonatomic) NSMutableArray *sortedDeckArray;

@end
