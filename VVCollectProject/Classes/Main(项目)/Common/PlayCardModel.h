

#import <Foundation/Foundation.h>

// 花色 从小到大
typedef NS_ENUM(NSInteger, PokerColorType) {
    PokerColorType_Diamonds = 0,   //  方块
    PokerColorType_Clubs = 1,   // 梅花
    PokerColorType_Hearts = 2,    // 红桃（红心）
    PokerColorType_Spades = 3,       // 黑桃
};


@interface PlayCardModel : NSObject

/// 花色符号  ♦️
@property (nonatomic, copy) NSString* suitSymbol;
/// 花色名称  Diamonds
@property (nonatomic, copy) NSString* suitText;
/// 花色类型
@property (nonatomic, assign) PokerColorType colorTyp;

/// 牌面大小 1-13
@property (nonatomic, assign) NSInteger cardSizeValue;
/// 计算点数 1   L-11也算10
@property (nonatomic, strong) NSNumber* cardValue;
/// 变化点数  11
@property (nonatomic, strong) NSNumber* alterValue;

/// 牌面字符  例如 A
@property (nonatomic, copy) NSString *cardStr;
/// 牌字符 +花色符号  例如  A♦️
@property (nonatomic, copy) NSString *cardText;
/// 牌名称 + 花色名称  例如  Ace of Diamonds
@property (nonatomic, copy) NSString* longName;


@end
