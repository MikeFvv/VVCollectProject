//
//  PokerModel.m
//  VVCollectProject
//
//  Created by Admin on 2021/12/10.
//  Copyright © 2021 Mike. All rights reserved.
//

#import "Poker.h"

@implementation Poker

//+ (void)poker:(CardColorType)colorTyp cardSizeValue:(NSInteger)cardSizeValue {
//    _colorTyp = colorTyp;
//    _cardSizeValue = cardSizeValue;
//
//}

//- (CardColorType)colorTyp {
//    if (!_colorTyp) {
//        _colorTyp = self.colorTyp;
//    }
//    return _colorTyp;
//}
    
- (void)setColorTyp:(CardColorType)colorTyp {
    _colorTyp = colorTyp;
}

//- (NSInteger)cardSizeValue {
//    if (_cardSizeValue) {
//        _cardSizeValue = self.cardSizeValue;
//    }
//    return _cardSizeValue;
//}

- (void)setValue:(NSInteger)value {
    if (value >= 2 && value <= 14) {
        _value = value;
    }
}

//- (void)setCardSizeValue:(NSInteger)cardSizeValue {
//    if (cardSizeValue >= 2 && cardSizeValue <= 14) {
//        _cardSizeValue = cardSizeValue;
//    }
//}

@end
