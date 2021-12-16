

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
        NSArray *suitsAsText = [NSArray arrayWithObjects:
                                @"Diamonds",
                                @"Clubs",
                                @"Hearts",
                                @"Spades",
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
                aCard.suitText = [suitsAsText objectAtIndex:suitloopIndex];
                
                aCard.colorTyp = [[colorTypeArray objectAtIndex:suitloopIndex] integerValue];
                
                aCard.cardSizeValue = valueIndex +1;
                aCard.cardStr = [VVFunctionManager pokerCharacter:valueIndex+1];
                
                switch (valueIndex) {
                    case 0:
                        aCard.cardValue =  1;
                        aCard.alterValue = 11;
                        aCard.cardText = [NSString stringWithFormat:@"%@%@", @"A", aCard.suitSymbol];
                        aCard.longName = [NSString stringWithFormat:@"%@ of %@", [cardTextValues objectAtIndex:valueIndex], [suitsAsText objectAtIndex:suitloopIndex]];
                        break;
                    case 1:
                        aCard.cardValue = valueIndex + 1;
                        aCard.alterValue = 0;
                        aCard.cardText = [NSString stringWithFormat:@"%@%@", [NSNumber numberWithInt:valueIndex + 1], aCard.suitSymbol];
                        aCard.longName = [NSString stringWithFormat:@"%@ of %@", [cardTextValues objectAtIndex:valueIndex], [suitsAsText objectAtIndex:suitloopIndex]];
                        break;
                    case 2:
                        aCard.cardValue = valueIndex + 1;
                        aCard.alterValue = 0;
                        aCard.cardText = [NSString stringWithFormat:@"%@%@", [NSNumber numberWithInt:valueIndex + 1], aCard.suitSymbol];
                        aCard.longName = [NSString stringWithFormat:@"%@ of %@", [cardTextValues objectAtIndex:valueIndex], [suitsAsText objectAtIndex:suitloopIndex]];
                        break;
                    case 3: 
                        aCard.cardValue = valueIndex + 1;
                        aCard.alterValue = 0;
                        aCard.cardText = [NSString stringWithFormat:@"%@%@", [NSNumber numberWithInt:valueIndex + 1], aCard.suitSymbol];
                        aCard.longName = [NSString stringWithFormat:@"%@ of %@", [cardTextValues objectAtIndex:valueIndex], [suitsAsText objectAtIndex:suitloopIndex]];
                        break;
                    case 4:
                        aCard.cardValue = valueIndex + 1;
                        aCard.alterValue = 0;
                        aCard.cardText = [NSString stringWithFormat:@"%@%@", [NSNumber numberWithInt:valueIndex + 1], aCard.suitSymbol];
                        aCard.longName = [NSString stringWithFormat:@"%@ of %@", [cardTextValues objectAtIndex:valueIndex], [suitsAsText objectAtIndex:suitloopIndex]];
                        break;
                    case 5: 
                        aCard.cardValue = valueIndex + 1;
                        aCard.alterValue = 0;
                        aCard.cardText = [NSString stringWithFormat:@"%@%@", [NSNumber numberWithInt:valueIndex + 1], aCard.suitSymbol];
                        aCard.longName = [NSString stringWithFormat:@"%@ of %@", [cardTextValues objectAtIndex:valueIndex], [suitsAsText objectAtIndex:suitloopIndex]];
                        break;
                    case 6:
                        aCard.cardValue = valueIndex + 1;
                        aCard.alterValue = 0;
                        aCard.cardText = [NSString stringWithFormat:@"%@%@", [NSNumber numberWithInt:valueIndex + 1], aCard.suitSymbol];
                        aCard.longName = [NSString stringWithFormat:@"%@ of %@", [cardTextValues objectAtIndex:valueIndex], [suitsAsText objectAtIndex:suitloopIndex]];
                        break;
                    case 7: 
                        aCard.cardValue = valueIndex + 1;
                        aCard.alterValue = 0;
                        aCard.cardText = [NSString stringWithFormat:@"%@%@", [NSNumber numberWithInt:valueIndex + 1], aCard.suitSymbol];
                        aCard.longName = [NSString stringWithFormat:@"%@ of %@", [cardTextValues objectAtIndex:valueIndex], [suitsAsText objectAtIndex:suitloopIndex]];
                        break;
                    case 8:
                        aCard.cardValue = valueIndex + 1;
                        aCard.alterValue = 0;
                        aCard.cardText = [NSString stringWithFormat:@"%@%@", [NSNumber numberWithInt:valueIndex + 1], aCard.suitSymbol];
                        aCard.longName = [NSString stringWithFormat:@"%@ of %@", [cardTextValues objectAtIndex:valueIndex], [suitsAsText objectAtIndex:suitloopIndex]];
                        break;
                    case 9:
                        aCard.cardValue = valueIndex + 1;
                        aCard.alterValue = 0;
                        aCard.cardText = [NSString stringWithFormat:@"%@%@", [NSNumber numberWithInt:valueIndex + 1], aCard.suitSymbol];
                        aCard.longName = [NSString stringWithFormat:@"%@ of %@", [cardTextValues objectAtIndex:valueIndex], [suitsAsText objectAtIndex:suitloopIndex]];
                        break;
                    case 10: 
                        aCard.cardValue = 10;
                        aCard.alterValue = 0;
                        aCard.cardText = [NSString stringWithFormat:@"%@%@", @"J", aCard.suitSymbol];
                        aCard.longName = [NSString stringWithFormat:@"%@ of %@", [cardTextValues objectAtIndex:valueIndex], [suitsAsText objectAtIndex:suitloopIndex]];
                        break;
                    case 11:
                        aCard.cardValue = 10;
                        aCard.alterValue = 0;
                        aCard.cardText = [NSString stringWithFormat:@"%@%@", @"Q", aCard.suitSymbol];
                        aCard.longName = [NSString stringWithFormat:@"%@ of %@", [cardTextValues objectAtIndex:valueIndex], [suitsAsText objectAtIndex:suitloopIndex]];
                        break;
                    case 12:
                        aCard.cardValue = 10;
                        aCard.alterValue = 0;
                        aCard.cardText = [NSString stringWithFormat:@"%@%@", @"K", aCard.suitSymbol];
                        aCard.longName = [NSString stringWithFormat:@"%@ of %@", [cardTextValues objectAtIndex:valueIndex], [suitsAsText objectAtIndex:suitloopIndex]];
                        break;
                        
                    default:
                        break;
                }
                [_sortedDeckArray addObject:aCard];
                //NSLog(@"%@", aCard.longName); DEBUG
            }
        }
        
        NSLog(@"1");
        
    }
    return self;
}

@end
