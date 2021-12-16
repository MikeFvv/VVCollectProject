

#import <Foundation/Foundation.h>



// 每张牌模型
@interface PokerCardModel : NSObject

/// 花色符号  ♦️
@property (nonatomic, copy) NSString *suitSymbol;
/// 花色名称  Diamonds
@property (nonatomic, copy) NSString *suitText;
/// 花色类型
@property (nonatomic, assign) CardColorType colorTyp;

/// 牌面大小 1-13
@property (nonatomic, assign) NSInteger cardSizeValue;
/// 计算点数 1   L-11也算10
@property (nonatomic, assign) NSInteger cardValue;
/// 变化点数  11
@property (nonatomic, assign) NSInteger alterValue;

/// 牌面字符  例如 A
@property (nonatomic, copy) NSString *cardStr;
/// 牌字符 +花色符号  例如  A♦️
@property (nonatomic, copy) NSString *cardText;
/// 牌名称 + 花色名称  例如  Ace of Diamonds
@property (nonatomic, copy) NSString *longName;


@end
