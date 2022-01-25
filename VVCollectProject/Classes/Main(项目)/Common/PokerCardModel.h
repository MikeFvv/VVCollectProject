

#import <Foundation/Foundation.h>

// 每张牌模型
@interface PokerCardModel : NSObject<NSCoding>

/// 花色符号  ♦️
@property (nonatomic, copy) NSString *suitSymbol;
/// 牌面字符  例如 A
@property (nonatomic, copy) NSString *cardStr;
/// 花色类型
@property (nonatomic, assign) CardColorType colorTyp;
/// 牌面大小 1-13
@property (nonatomic, assign) NSInteger cardSizeValue;
/// 计算点数 1   L-11也算10   21点使用）
@property (nonatomic, assign) NSInteger cardValue;
/// 变化点数  11 （ 21点使用）
@property (nonatomic, assign) NSInteger alterValue;
/// 牌字符 +花色符号  例如  A♦️
@property (nonatomic, copy) NSString *cardText;
/// 计算点数    10-13也算0   （百家乐使用）
@property (nonatomic, assign) NSInteger bCardValue;
/// 扑克图片名称
@property (nonatomic, copy) NSString *pokerImg;

@end
