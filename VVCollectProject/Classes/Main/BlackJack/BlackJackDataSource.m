

#import "BlackJackDataSource.h"
#import "PlayCardModel.h"


@implementation BlackJackDataSource

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
                                   @"♣",
                                   @"♦",
                                   @"♥",
                                   @"♠", nil];
        NSArray *suitsAsText = [NSArray arrayWithObjects:
                                @"Clubs",
                                @"Diamonds",
                                @"Hearts",
                                @"Spades", nil];
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
    
     
        for (int suitloop = 0; suitloop < 4; suitloop++) 
        {
            
            for (int valueloop = 0; valueloop < 13; valueloop++) 
            {
                PlayCardModel *aCard = [[PlayCardModel alloc] init];
                aCard.suitSymbol = [suitsAsSymbols objectAtIndex:suitloop];
                aCard.suitText = [suitsAsText objectAtIndex:suitloop];
                switch (valueloop) {
                    case 0:
                        aCard.cardValue =  [NSNumber numberWithInt:1];
                        aCard.altValue = [NSNumber numberWithInt:11];
                        aCard.cardText = [NSString stringWithFormat:@"%@%@", @"A", aCard.suitSymbol];
                        aCard.longName = [NSString stringWithFormat:@"%@ of %@", [cardTextValues objectAtIndex:valueloop], [suitsAsText objectAtIndex:suitloop]];
                        break;
                    case 1:
                        aCard.cardValue = [NSNumber numberWithInt:valueloop + 1];
                        aCard.altValue = nil;
                        aCard.cardText = [NSString stringWithFormat:@"%@%@", [NSNumber numberWithInt:valueloop + 1], aCard.suitSymbol];
                        aCard.longName = [NSString stringWithFormat:@"%@ of %@", [cardTextValues objectAtIndex:valueloop], [suitsAsText objectAtIndex:suitloop]];
                        break;
                    case 2:
                        aCard.cardValue = [NSNumber numberWithInt:valueloop + 1];
                        aCard.altValue = nil;
                        aCard.cardText = [NSString stringWithFormat:@"%@%@", [NSNumber numberWithInt:valueloop + 1], aCard.suitSymbol];
                        aCard.longName = [NSString stringWithFormat:@"%@ of %@", [cardTextValues objectAtIndex:valueloop], [suitsAsText objectAtIndex:suitloop]];
                        break;
                    case 3: 
                        aCard.cardValue = [NSNumber numberWithInt:valueloop + 1];
                        aCard.altValue = nil;
                        aCard.cardText = [NSString stringWithFormat:@"%@%@", [NSNumber numberWithInt:valueloop + 1], aCard.suitSymbol];
                        aCard.longName = [NSString stringWithFormat:@"%@ of %@", [cardTextValues objectAtIndex:valueloop], [suitsAsText objectAtIndex:suitloop]];
                        break;
                    case 4:
                        aCard.cardValue = [NSNumber numberWithInt:valueloop + 1];
                        aCard.altValue = nil;
                        aCard.cardText = [NSString stringWithFormat:@"%@%@", [NSNumber numberWithInt:valueloop + 1], aCard.suitSymbol];
                        aCard.longName = [NSString stringWithFormat:@"%@ of %@", [cardTextValues objectAtIndex:valueloop], [suitsAsText objectAtIndex:suitloop]];
                        break;
                    case 5: 
                        aCard.cardValue = [NSNumber numberWithInt:valueloop + 1];
                        aCard.altValue = nil;
                        aCard.cardText = [NSString stringWithFormat:@"%@%@", [NSNumber numberWithInt:valueloop + 1], aCard.suitSymbol];
                        aCard.longName = [NSString stringWithFormat:@"%@ of %@", [cardTextValues objectAtIndex:valueloop], [suitsAsText objectAtIndex:suitloop]];
                        break;
                    case 6:
                        aCard.cardValue = [NSNumber numberWithInt:valueloop + 1];
                        aCard.altValue = nil;
                        aCard.cardText = [NSString stringWithFormat:@"%@%@", [NSNumber numberWithInt:valueloop + 1], aCard.suitSymbol];
                        aCard.longName = [NSString stringWithFormat:@"%@ of %@", [cardTextValues objectAtIndex:valueloop], [suitsAsText objectAtIndex:suitloop]];
                        break;
                    case 7: 
                        aCard.cardValue = [NSNumber numberWithInt:valueloop + 1];
                        aCard.altValue = nil;
                        aCard.cardText = [NSString stringWithFormat:@"%@%@", [NSNumber numberWithInt:valueloop + 1], aCard.suitSymbol];
                        aCard.longName = [NSString stringWithFormat:@"%@ of %@", [cardTextValues objectAtIndex:valueloop], [suitsAsText objectAtIndex:suitloop]];
                        break;
                    case 8:
                        aCard.cardValue = [NSNumber numberWithInt:valueloop + 1];
                        aCard.altValue = nil;
                        aCard.cardText = [NSString stringWithFormat:@"%@%@", [NSNumber numberWithInt:valueloop + 1], aCard.suitSymbol];
                        aCard.longName = [NSString stringWithFormat:@"%@ of %@", [cardTextValues objectAtIndex:valueloop], [suitsAsText objectAtIndex:suitloop]];
                        break;
                    case 9:
                        aCard.cardValue = [NSNumber numberWithInt:valueloop + 1];
                        aCard.altValue = nil;
                        aCard.cardText = [NSString stringWithFormat:@"%@%@", [NSNumber numberWithInt:valueloop + 1], aCard.suitSymbol];
                        aCard.longName = [NSString stringWithFormat:@"%@ of %@", [cardTextValues objectAtIndex:valueloop], [suitsAsText objectAtIndex:suitloop]];
                        break;
                    case 10: 
                        aCard.cardValue = [NSNumber numberWithInt:10];
                        aCard.altValue = nil;
                        aCard.cardText = [NSString stringWithFormat:@"%@%@", @"J", aCard.suitSymbol];
                        aCard.longName = [NSString stringWithFormat:@"%@ of %@", [cardTextValues objectAtIndex:valueloop], [suitsAsText objectAtIndex:suitloop]];
                        break;
                    case 11:
                        aCard.cardValue = [NSNumber numberWithInt:10];
                        aCard.altValue = nil;
                        aCard.cardText = [NSString stringWithFormat:@"%@%@", @"Q", aCard.suitSymbol];
                        aCard.longName = [NSString stringWithFormat:@"%@ of %@", [cardTextValues objectAtIndex:valueloop], [suitsAsText objectAtIndex:suitloop]];
                        break;
                    case 12:
                        aCard.cardValue = [NSNumber numberWithInt:10];
                        aCard.altValue = nil;
                        aCard.cardText = [NSString stringWithFormat:@"%@%@", @"K", aCard.suitSymbol];
                        aCard.longName = [NSString stringWithFormat:@"%@ of %@", [cardTextValues objectAtIndex:valueloop], [suitsAsText objectAtIndex:suitloop]];
                        break;
                        
                    default:
                        break;
                }
                [_sortedDeckArray addObject:aCard];
                //NSLog(@"%@", aCard.longName); DEBUG
            }
        }
        
        
        
    }
    return self;
}

@end
