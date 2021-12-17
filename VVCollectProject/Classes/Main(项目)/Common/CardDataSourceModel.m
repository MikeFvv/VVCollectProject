

#import "CardDataSourceModel.h"
#import "PokerCardModel.h"
#import "VVFunctionManager.h"


@implementation CardDataSourceModel

@synthesize sortedDeckArray = _sortedDeckArray;

- (id)init
{
    self = [super init];
    if (self) 
    {
        //initialise deck of cards...
        _sortedDeckArray = [[NSMutableArray alloc] init];
        
        //Array of possible values and symbols
        NSArray *suitsAsSymbols = [NSArray arrayWithObjects:
                                   @"♦️",
                                   @"♣️",
                                   @"♥️",
                                   @"♠️",
                                   nil];
        
        NSArray *colorTypeArray = [NSArray arrayWithObjects:
                                   @(DIAMONDS),
                                   @(CLUBS),
                                   @(HEARTS),
                                   @(SPADES),
                                   nil];
        
        NSArray *cardTextValues = [NSArray arrayWithObjects:
                                   @"Ace",
                                   @"Two",
                                   @"Three",
                                   @"Four",
                                   @"Five",
                                   @"Six",
                                   @"Seven",
                                   @"Eight",
                                   @"Nine",
                                   @"Ten",
                                   @"Jack",
                                   @"Queen",
                                   @"King"
                                   , nil];
    
     
        for (int suitloopIndex = 0; suitloopIndex < 4; suitloopIndex++)
        {
            
            for (int valueIndex = 0; valueIndex < 13; valueIndex++)
            {
                PokerCardModel *aCard = [[PokerCardModel alloc] init];
                aCard.suitSymbol = [suitsAsSymbols objectAtIndex:suitloopIndex];
                aCard.colorTyp = [[colorTypeArray objectAtIndex:suitloopIndex] integerValue];
                
                aCard.cardSizeValue = valueIndex +1;
                aCard.cardStr = [VVFunctionManager pokerCharacter:valueIndex+1];
                
                switch (valueIndex) {
                    case 0:
                        aCard.cardValue =  1;
                        aCard.bCardValue =  1;
                        aCard.alterValue = 11;
                        aCard.cardText = [NSString stringWithFormat:@"%@%@", @"A", aCard.suitSymbol];
                        
                        
                        break;
                    case 1:
                        aCard.cardValue = valueIndex + 1;
                        aCard.bCardValue =  valueIndex + 1;
                        aCard.alterValue = 0;
                        aCard.cardText = [NSString stringWithFormat:@"%@%@", [NSNumber numberWithInt:valueIndex + 1], aCard.suitSymbol];
                        break;
                    case 2:
                        aCard.cardValue = valueIndex + 1;
                        aCard.bCardValue =  valueIndex + 1;
                        aCard.alterValue = 0;
                        aCard.cardText = [NSString stringWithFormat:@"%@%@", [NSNumber numberWithInt:valueIndex + 1], aCard.suitSymbol];
                        break;
                    case 3: 
                        aCard.cardValue = valueIndex + 1;
                        aCard.bCardValue =  valueIndex + 1;
                        aCard.alterValue = 0;
                        aCard.cardText = [NSString stringWithFormat:@"%@%@", [NSNumber numberWithInt:valueIndex + 1], aCard.suitSymbol];
                        break;
                    case 4:
                        aCard.cardValue = valueIndex + 1;
                        aCard.bCardValue =  valueIndex + 1;
                        aCard.alterValue = 0;
                        aCard.cardText = [NSString stringWithFormat:@"%@%@", [NSNumber numberWithInt:valueIndex + 1], aCard.suitSymbol];
                        break;
                    case 5: 
                        aCard.cardValue = valueIndex + 1;
                        aCard.bCardValue =  valueIndex + 1;
                        aCard.alterValue = 0;
                        aCard.cardText = [NSString stringWithFormat:@"%@%@", [NSNumber numberWithInt:valueIndex + 1], aCard.suitSymbol];
                        break;
                    case 6:
                        aCard.cardValue = valueIndex + 1;
                        aCard.bCardValue =  valueIndex + 1;
                        aCard.alterValue = 0;
                        aCard.cardText = [NSString stringWithFormat:@"%@%@", [NSNumber numberWithInt:valueIndex + 1], aCard.suitSymbol];
                        break;
                    case 7: 
                        aCard.cardValue = valueIndex + 1;
                        aCard.bCardValue =  valueIndex + 1;
                        aCard.alterValue = 0;
                        aCard.cardText = [NSString stringWithFormat:@"%@%@", [NSNumber numberWithInt:valueIndex + 1], aCard.suitSymbol];
                        break;
                    case 8:
                        aCard.cardValue = valueIndex + 1;
                        aCard.bCardValue =  valueIndex + 1;
                        aCard.alterValue = 0;
                        aCard.cardText = [NSString stringWithFormat:@"%@%@", [NSNumber numberWithInt:valueIndex + 1], aCard.suitSymbol];
                        break;
                    case 9:
                        aCard.cardValue = valueIndex + 1;
                        aCard.bCardValue =  0;
                        aCard.alterValue = 0;
                        aCard.cardText = [NSString stringWithFormat:@"%@%@", [NSNumber numberWithInt:valueIndex + 1], aCard.suitSymbol];
                        break;
                    case 10: 
                        aCard.cardValue = 10;
                        aCard.bCardValue =  0;
                        aCard.alterValue = 0;
                        aCard.cardText = [NSString stringWithFormat:@"%@%@", @"J", aCard.suitSymbol];
                        break;
                    case 11:
                        aCard.cardValue = 10;
                        aCard.bCardValue =  0;
                        aCard.alterValue = 0;
                        aCard.cardText = [NSString stringWithFormat:@"%@%@", @"Q", aCard.suitSymbol];
                        break;
                    case 12:
                        aCard.cardValue = 10;
                        aCard.bCardValue =  0;
                        aCard.alterValue = 0;
                        aCard.cardText = [NSString stringWithFormat:@"%@%@", @"K", aCard.suitSymbol];
                       
                        break;
                        
                    default:
                        break;
                }
                [_sortedDeckArray addObject:aCard];
            }
        }
        
        NSLog(@"1");
        
    }
    return self;
}

@end
