

#import <Foundation/Foundation.h>

@interface PlayCardModel : NSObject

@property (strong, nonatomic) NSString* suitSymbol;
@property (strong, nonatomic) NSString* suitText;
@property (strong, nonatomic) NSNumber* cardValue;
@property (strong, nonatomic) NSNumber* altValue; 
@property (strong, nonatomic) NSString* cardText;
@property (strong, nonatomic) NSString* longName;

@end
