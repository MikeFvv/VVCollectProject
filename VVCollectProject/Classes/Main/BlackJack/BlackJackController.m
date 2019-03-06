//
//  BlackJackController.m
//  VVCollectProject
//
//  Created by Mike on 2019/2/27.
//  Copyright © 2019 Mike. All rights reserved.
//

#import "BlackJackController.h"
#import "PhysicalCard.h"
#import "BJHeart.h"
#import "BJClub.h"
#import "BJSpade.h"
#import "BlackJackDataSource.h"
#import "PlayCardModel.h"

#define kFontSizeLabel 23

@interface BlackJackController ()

@property (strong, nonatomic) UILabel *playerOneLabel;
@property (strong, nonatomic) UILabel *playerTwoLabel;
@property (strong, nonatomic) UILabel *playerThreeLabel;
@property (strong, nonatomic) UILabel *playerFourLabel;
@property (strong, nonatomic) UILabel *playerFiveLabel;
@property (strong, nonatomic) UILabel *playerTotalLabel;
@property (strong, nonatomic) NSMutableArray *playershandofCardsArray;
@property (strong, nonatomic) NSMutableArray *playerCountsArray;

//////banker Properties
@property (strong, nonatomic) UILabel *bankerOneLabel;
@property (strong, nonatomic) UILabel *bankerTotalLabel;
@property (strong, nonatomic) UILabel *bankerTwoLabel;
@property (strong, nonatomic) UILabel *bankerThreeLabel;
@property (strong, nonatomic) UILabel *bankerFourLabel;
@property (strong, nonatomic) UILabel *bankerFiveLabel;
@property (strong, nonatomic) NSMutableArray *bankershandofCardsArray;
@property (strong, nonatomic) NSMutableArray *bankerCountsArray;

@property (nonatomic, assign) BOOL aceFlag;
@property (nonatomic, assign) NSInteger pTotal;
@property (nonatomic, assign) NSInteger aTotal;
@property (nonatomic, assign) NSInteger dTotal;
@property (nonatomic, assign) NSInteger adTotal;

@property (strong, nonatomic) UIButton *hitButton;
@property (strong, nonatomic) BlackJackDataSource *referenceDeck;
@property (strong, nonatomic) NSMutableArray *blackjackDataArray;

@end

@implementation BlackJackController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self referenceDeck];
    self.playershandofCardsArray = [[NSMutableArray alloc] initWithCapacity:10];
    self.bankershandofCardsArray = [[NSMutableArray alloc] initWithCapacity:5];
    
    //    PhysicalCard *aCard = [[PhysicalCard alloc] initWithFrame:CGRectMake(0, 50, 100, 100)];
    //    aCard.backgroundColor = [UIColor yellowColor];
    //    [self.view addSubview:aCard];
    //    RSPhysicalCard *bCard = [[RSPhysicalCard alloc] initWithFrame:CGRectMake(100, 200, 100, 100)];
    //    bCard.backgroundColor = [UIColor blueColor];
    //    [self.view addSubview:bCard];
    
    //    PhysicalCard *aCard = [[PhysicalCard alloc] initWithFrame:CGRectMake(-80, 100, 200, 300)];
    //    [self.view addSubview:aCard];
    //    PhysicalCard *bCard = [[PhysicalCard alloc] initWithFrame:CGRectMake(-80, -80, 200, 300)];
    //    [self.view addSubview:bCard];
    
    //    BJHeart *aHeart = [[BJHeart alloc] initWithFrame:CGRectMake(50, 50, 50, 60)];
    //    [self.view addSubview:aHeart];
    
    //    BJClub *aClub = [[BJClub alloc] initWithFrame:CGRectMake(50, 120, 50, 60)];
    //    [self.view addSubview:aClub];
    
    //    BJSpade *aSpade = [[BJSpade alloc] initWithFrame:CGRectMake(50, 240, 50, 60)];
    //    [self.view addSubview:aSpade];
    
    [self initUI];
    
    [self resetPlay];
}




- (void)buttonPressed:(id)sender
{
    switch ([sender tag]) {
        case 101:
            [self playerLogic];
            [self randomoneoutofFour];
            break;
        case 102:
            if ((self.aceFlag == TRUE) && (self.aTotal <= 21)) {
                self.pTotal = self.aTotal;
            }
            self.aceFlag = FALSE;
            [self bankerLogic];
            [self.hitButton setEnabled:NO];
            break;
        case 103:
            [self resetPlay];
            break;
        default:
            break;
    }
}


#pragma mark - 玩家逻辑  玩家Hit
- (void)playerLogic
{
    //TODO: Handle 'Split' condition
    
    if ([self.playershandofCardsArray count] == 5)
    {
        [self.playershandofCardsArray removeAllObjects]; //TODO: Extraneous? Might be, remove if so.
    }
    
    self.pTotal = [self.playerTotalLabel.text intValue];
    
    self.playerTotalLabel.textColor = [UIColor whiteColor];
    self.playerTotalLabel.backgroundColor = [UIColor clearColor];
    
    PlayCardModel* nextCard = [self dealCard:FALSE toPlayer:@"player"];
    [self.playershandofCardsArray addObject:nextCard];
    
    self.pTotal = self.pTotal + [nextCard.cardValue intValue];
    self.aTotal = self.pTotal + 10;
    
    if ([nextCard.cardValue intValue] == 1)
    {
        self.aceFlag = TRUE;
    }
    
    //Set label text appropriately
    switch ([self.playershandofCardsArray count])
    {
        case 1:
            self.playerOneLabel.text = nextCard.cardText;
            break;
        case 2:
            self.playerTwoLabel.text = nextCard.cardText;
            break;
        case 3:
            self.playerThreeLabel.text = nextCard.cardText;
            break;
        case 4:
            self.playerFourLabel.text = nextCard.cardText;
            break;
        case 5:
            self.playerFiveLabel.text = nextCard.cardText;
            break;
        default:
            break;
    }
    
    if (self.pTotal > 21)
    {
        self.playerTotalLabel.text = @"Bust!";
        self.playerTotalLabel.backgroundColor = [UIColor redColor];
        [self.playershandofCardsArray removeAllObjects];
        [self resultHandler];
    }
    else
    {
        self.playerTotalLabel.text = [NSString stringWithFormat:@"%i", self.pTotal];
        if (self.aceFlag && self.aTotal <= 21)
        {
            self.playerTotalLabel.text = [self.playerTotalLabel.text stringByAppendingFormat:@" or %i", self.aTotal];
        }
        if ([self.playershandofCardsArray count] == 1)
        {
            [self performSelector:@selector(playerLogic) withObject:nil afterDelay:0.65];
        }
    }
}


#pragma mark - Stand停牌
- (void)bankerLogic
{
    self.dTotal = [self.bankerTotalLabel.text intValue];
    
    PlayCardModel* nextCard = [self dealCard:FALSE toPlayer:@"banker"];
    [self.bankershandofCardsArray addObject:nextCard];
    
    self.dTotal = self.dTotal + [nextCard.cardValue intValue];
    self.adTotal = self.dTotal + 10; //only used when there's aces in places ;)
    
    //Ace detector
    if ([nextCard.cardValue intValue] == 1)
    {
        self.aceFlag = TRUE; //Ace is back and he told you so.
    }
    
    //Set label text appropriately
    switch ([self.bankershandofCardsArray count])
    {
        case 1:
            self.bankerOneLabel.text = nextCard.cardText;
            break;
        case 2:
            self.bankerTwoLabel.text = nextCard.cardText;
            break;
        case 3:
            self.bankerThreeLabel.text = nextCard.cardText;
            break;
        case 4:
            self.bankerFourLabel.text = nextCard.cardText;
            break;
        case 5:
            self.bankerFiveLabel.text = nextCard.cardText;
            break;
        default:
            break;
    }
    
    // 爆牌
    if (self.dTotal > 21) //bust condition
    {
        NSLog(@"Over 21: Bust, %i/%i", self.dTotal, self.adTotal); //DEBUG
        self.bankerTotalLabel.text = @"Bust!";
        self.bankerTotalLabel.backgroundColor = [UIColor redColor];
        [self resultHandler];
    }
    else if (self.dTotal > self.pTotal) //stand if bankers won but could still draw a card
    {
        NSLog(@"banker beats player: Stand, %i/%i", self.dTotal, self.adTotal); //DEBUG
        self.bankerTotalLabel.text = [NSString stringWithFormat:@"%i", self.dTotal];
        [self performSelector:@selector(resultHandler) withObject:nil afterDelay:0.75];
    }
    else if ((self.aceFlag == TRUE) && (self.adTotal > self.pTotal) && (self.adTotal <= 21)) //alt stand if bankers won but could still draw a card
    {
        NSLog(@"Alt banker beats player: Stand, %i/%i", self.dTotal, self.adTotal); //DEBUG
        self.bankerTotalLabel.text = [NSString stringWithFormat:@"%i", self.adTotal];
        self.dTotal = self.adTotal;
        [self performSelector:@selector(resultHandler) withObject:nil afterDelay:0.75];
    }
    else if ((self.dTotal < self.pTotal) && ([self.bankershandofCardsArray count] < 5))  //always draw when losing to player
    {
        NSLog(@"Under pTotal and no 5CT: Draw, %i/%i", self.dTotal, self.adTotal); //DEBUG
        self.bankerTotalLabel.text = [NSString stringWithFormat:@"%i", self.dTotal];
        if (self.aceFlag && self.adTotal <= 21)
        {
            NSLog(@"Ace in the hand, appending alt score, %i/%i", self.dTotal, self.adTotal); //DEBUG
            self.bankerTotalLabel.text = [self.bankerTotalLabel.text stringByAppendingFormat:@" or %i", self.adTotal];
        }
        [self performSelector:@selector(bankerLogic) withObject:nil afterDelay:0.75];
    }
    else if ((self.dTotal >= self.pTotal)) //stand if over or equal to player or 5 card trick //站立，如果超过或等于玩家或5卡技巧
        //DEBUG  || ([bankershandofCardsArray count] == 5)
    {
        NSLog(@">=19 or 5CT: Stand, %i/%i vs %i", self.dTotal, self.adTotal, self.pTotal); //DEBUG
        self.bankerTotalLabel.text = [NSString stringWithFormat:@"%i", self.dTotal];
        if ((self.aceFlag == TRUE) && (self.adTotal <= 21))
        {
            NSLog(@"Ace in the hand, appending alt score, %i/%i", self.dTotal, self.adTotal); //DEBUG
            self.bankerTotalLabel.text = [self.bankerTotalLabel.text stringByAppendingFormat:@" or %i", self.adTotal];
            self.dTotal = self.adTotal;
        }
        [self performSelector:@selector(resultHandler) withObject:nil afterDelay:0.75];
    }
    else if ([self.bankershandofCardsArray count] == 5)
    {
        NSLog(@"Five Card Trick, %i/%i", self.dTotal, self.adTotal); //DEBUG
        self.dTotal = 21, self.adTotal = 21;
        self.bankerTotalLabel.text = @"Five card trick";
        [self performSelector:@selector(resultHandler) withObject:nil afterDelay:0.75];
    }
}

- (void)betHandler
{
    
}

- (PlayCardModel*)dealCard:(BOOL)newHand toPlayer:(NSString*)player
{
    if (newHand)
    {
        [self newDeal]; //shuffles the deck
    }
    NSInteger nextentry = 0;
    NSInteger nextshufflebanker = 0;
    PlayCardModel *dealtCard;
    
    if ([player isEqualToString:@"player"])
    {
        nextentry = [self.playershandofCardsArray count]; //effectively gives you the next index to deal a card to AND from. Nice. //有效地为您提供下一个索引来处理来自AND的卡。尼斯。
        nextshufflebanker = [[[self blackjackDataArray] objectAtIndex:nextentry] intValue];
        dealtCard = [[self referenceDeck].sortedDeckArray objectAtIndex:nextshufflebanker];
    }
    
    if ([player isEqualToString:@"banker"])
    {
        nextentry = [self.bankershandofCardsArray count] + 10; //yes, it's duplicated code but it's only 3 lines so deal with it. 'Deal'. Ha!  //是的，它是重复的代码，但它只有3行所以处理它。“交易”。 哈！
        nextshufflebanker = [[[self blackjackDataArray] objectAtIndex:nextentry] intValue];
        dealtCard = [[self referenceDeck].sortedDeckArray objectAtIndex:nextshufflebanker];
    }
    return dealtCard;
}

- (void)resultHandler
{
    //TODO: Pay bet amount.
    
    NSLog(@"Player: %i/%i. banker: %i/%i", self.pTotal, self.aTotal, self.dTotal, self.adTotal);
    
    //TODO: This really doesn't work properly yet
    NSInteger playershighestHand = 0;
    NSInteger bankershighestHand = 0;
    NSString *titleString = [[NSString alloc] init];
    NSString *messageString = [[NSString alloc] init];
    
    if (self.pTotal > 21)
    {
        playershighestHand = 0;
    } else {
        playershighestHand = self.pTotal;
    }
    
    if (self.dTotal > 21)
    {
        bankershighestHand = 0;
    } else {
        bankershighestHand = self.dTotal;
    }
    
    if (playershighestHand > bankershighestHand)
    {
        titleString = @"You won!";
        messageString = [NSString stringWithFormat:@"You scored %i, I scored %i", self.pTotal, self.dTotal];
    } else if (bankershighestHand > playershighestHand)
    {
        titleString = @"You lost...";
        messageString = [NSString stringWithFormat:@"I scored %i, you scored %i", self.dTotal, self.pTotal];
    } else if (playershighestHand == bankershighestHand)
    {
        titleString = @"It's a draw";
        messageString = [NSString stringWithFormat:@"We both scored %i", self.pTotal];
    }
    
    UIAlertView *resultView = [[UIAlertView alloc] initWithTitle:titleString
                                                         message:messageString
                                                        delegate:self
                                               cancelButtonTitle:@"Play Again"
                                               otherButtonTitles: nil]; //TODO: Replace this with a custom presentation.
    [resultView show];
}

- (BOOL)randomoneoutofFour
{
    //TODO: No longer used.
    int randomNumber = arc4random() % 25; //random number from 0-25
    if ((randomNumber % 5) == 0) //does it divide evenly by 5?
    {
        return TRUE;
    }
    return FALSE;
}





- (BlackJackDataSource*)referenceDeck
{
    if (_referenceDeck == nil)
    {
        _referenceDeck = [[BlackJackDataSource alloc] init];
    }
    return _referenceDeck;
}

- (void)newDeal
{
    [_blackjackDataArray removeAllObjects];
    _blackjackDataArray = nil;
    [self blackjackDataArray];
}

#pragma mark - 洗牌方法
- (NSMutableArray*)blackjackDataArray
{
    if (_blackjackDataArray == nil)
    {
        _blackjackDataArray = [[NSMutableArray alloc] init];
        //fill with random numbers from 0 - 52 as index references against the referenceDeck.
        int n = 52;
        NSMutableArray *numbers = [NSMutableArray array];
        for (int i = 0; i < n; i++)
        {
            [numbers addObject:[NSNumber numberWithInt:i]];
        }
        NSMutableArray *result = [NSMutableArray array];
        while ([numbers count] > 0)
        {
            int r = arc4random() % [numbers count];
            NSNumber *randomElement = [numbers objectAtIndex:r];
            [result addObject:randomElement];
            [numbers removeObjectAtIndex:r];
        }
        _blackjackDataArray = result;
    }
    return _blackjackDataArray;
}




#pragma mark - 重置
- (void)resetPlay
{
    self.playerOneLabel.text = nil;
    self.playerTwoLabel.text = nil;
    self.playerThreeLabel.text = nil;
    self.playerFourLabel.text = nil;
    self.playerFiveLabel.text = nil;
    self.bankerOneLabel.text = nil;
    self.bankerTwoLabel.text = nil;
    self.bankerThreeLabel.text = nil;
    self.bankerFourLabel.text = nil;
    self.bankerFiveLabel.text = nil;
    self.playerTotalLabel.text = nil;
    self.bankerTotalLabel.text = nil;
    self.pTotal = 0, self.dTotal = 0, self.aTotal = 0, self.adTotal = 0;
    self.playerTotalLabel.backgroundColor = [UIColor clearColor];
    self.bankerTotalLabel.backgroundColor = [UIColor clearColor];
    self.aceFlag = FALSE;
    [self.playershandofCardsArray removeAllObjects];
    [self.bankershandofCardsArray removeAllObjects];
    [self newDeal];
    [self.hitButton setEnabled:YES];
    [self performSelector:@selector(playerLogic) withObject:nil afterDelay:0.75];

}





#pragma mark - UI界面
- (void)initUI {
    
    self.view.backgroundColor = [UIColor colorWithRed:0.031 green:0.486 blue:0.255 alpha:1.000];
    
    UILabel *playerLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 20, 100, 35)];
    playerLabel.text = @"Player";
    playerLabel.textColor = [UIColor whiteColor];
    playerLabel.font = [UIFont systemFontOfSize:kFontSizeLabel];
    [self.view addSubview:playerLabel];
    
    UILabel *bankerLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 20, 100, 35)];
    bankerLabel.text = @"Banker";
    bankerLabel.textColor = [UIColor whiteColor];
    bankerLabel.font = [UIFont systemFontOfSize:kFontSizeLabel];
    [self.view addSubview:bankerLabel];
    
    
    UILabel *playerOneLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 60, 100, 20)];
    playerOneLabel.text = @"Player";
    playerOneLabel.textColor = [UIColor whiteColor];
    playerOneLabel.font = [UIFont fontWithName:@"Futura" size:kFontSizeLabel];
    [self.view addSubview:playerOneLabel];
    _playerOneLabel = playerOneLabel;
    
    UILabel *playerTwoLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 90, 100, 20)];
    playerTwoLabel.text = @"Player";
    playerTwoLabel.textColor = [UIColor whiteColor];
    playerTwoLabel.font = [UIFont fontWithName:@"Futura" size:kFontSizeLabel];
    [self.view addSubview:playerTwoLabel];
    _playerTwoLabel = playerTwoLabel;
    
    UILabel *playerThreeLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 120, 100, 20)];
    playerThreeLabel.text = @"Player";
    playerThreeLabel.textColor = [UIColor whiteColor];
    playerThreeLabel.font = [UIFont fontWithName:@"Futura" size:kFontSizeLabel];
    [self.view addSubview:playerThreeLabel];
    _playerThreeLabel = playerThreeLabel;
    
    UILabel *playerFourLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 150, 100, 20)];
    playerFourLabel.text = @"Player";
    playerFourLabel.textColor = [UIColor whiteColor];
    playerFourLabel.font = [UIFont fontWithName:@"Futura" size:kFontSizeLabel];
    [self.view addSubview:playerFourLabel];
    _playerFourLabel = playerFourLabel;
    
    UILabel *playerFiveLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 180, 100, 20)];
    playerFiveLabel.text = @"Player";
    playerFiveLabel.textColor = [UIColor whiteColor];
    playerFiveLabel.font = [UIFont fontWithName:@"Futura" size:kFontSizeLabel];
    [self.view addSubview:playerFiveLabel];
    _playerFiveLabel = playerFiveLabel;
    
    UILabel *playerTotalLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 220, 100, 20)];
    playerTotalLabel.text = @"Player";
    playerTotalLabel.textColor = [UIColor whiteColor];
    playerTotalLabel.font = [UIFont fontWithName:@"Futura" size:kFontSizeLabel];
    [self.view addSubview:playerTotalLabel];
    _playerTotalLabel = playerTotalLabel;
    
    
    
    UILabel *bankerOneLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 60, 100, 20)];
    bankerOneLabel.text = @"Player";
    bankerOneLabel.textColor = [UIColor whiteColor];
    bankerOneLabel.font = [UIFont fontWithName:@"Futura" size:kFontSizeLabel];
    [self.view addSubview:bankerOneLabel];
    _bankerOneLabel = bankerOneLabel;
    
    UILabel *bankerTwoLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 90, 100, 20)];
    bankerTwoLabel.text = @"Player";
    bankerTwoLabel.textColor = [UIColor whiteColor];
    bankerTwoLabel.font = [UIFont fontWithName:@"Futura" size:kFontSizeLabel];
    [self.view addSubview:bankerTwoLabel];
    _bankerTwoLabel = bankerTwoLabel;
    
    UILabel *bankerThreeLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 120, 100, 20)];
    bankerThreeLabel.text = @"Player";
    bankerThreeLabel.textColor = [UIColor whiteColor];
    bankerThreeLabel.font = [UIFont fontWithName:@"Futura" size:kFontSizeLabel];
    [self.view addSubview:bankerThreeLabel];
    _bankerThreeLabel = bankerThreeLabel;
    
    UILabel *bankerFourLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 150, 100, 20)];
    bankerFourLabel.text = @"Player";
    bankerFourLabel.textColor = [UIColor whiteColor];
    bankerFourLabel.font = [UIFont fontWithName:@"Futura" size:kFontSizeLabel];
    [self.view addSubview:bankerFourLabel];
    _bankerFourLabel = bankerFourLabel;
    
    UILabel *bankerFiveLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 180, 100, 20)];
    bankerFiveLabel.text = @"Player";
    bankerFiveLabel.textColor = [UIColor whiteColor];
    bankerFiveLabel.font = [UIFont fontWithName:@"Futura" size:kFontSizeLabel];
    [self.view addSubview:bankerFiveLabel];
    _bankerFiveLabel = bankerFiveLabel;
    
    UILabel *bankerTotalLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 220, 100, 20)];
    bankerTotalLabel.text = @"Player";
    bankerTotalLabel.textColor = [UIColor whiteColor];
    bankerTotalLabel.font = [UIFont fontWithName:@"Futura" size:kFontSizeLabel];
    [self.view addSubview:bankerTotalLabel];
    _bankerTotalLabel = bankerTotalLabel;
    
    
    
    
    
    UIButton *hitButton = [[UIButton alloc] initWithFrame:CGRectMake(50, 350, 100, 40)];
    hitButton.titleLabel.font = [UIFont boldSystemFontOfSize:kFontSizeLabel];
    [hitButton setTitle:@"Hit" forState:UIControlStateNormal];
    [hitButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    hitButton.tag = 101;
    hitButton.backgroundColor = [UIColor colorWithRed:0.255 green:0.412 blue:0.882 alpha:1.000];
    hitButton.layer.cornerRadius = 5;
    [self.view addSubview:hitButton];
    _hitButton = hitButton;
    
    UIButton *standButton = [[UIButton alloc] initWithFrame:CGRectMake(200, 350, 100, 40)];
    standButton.titleLabel.font = [UIFont boldSystemFontOfSize:kFontSizeLabel];
    [standButton setTitle:@"Stand" forState:UIControlStateNormal];
    [standButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    standButton.tag = 102;
    standButton.backgroundColor = [UIColor colorWithRed:0.804 green:0.804 blue:0.004 alpha:1.000];
    standButton.layer.cornerRadius = 5;
    [self.view addSubview:standButton];
    
    
    UIButton *resetButton = [[UIButton alloc] initWithFrame:CGRectMake(150, 400, 100, 40)];
    resetButton.titleLabel.font = [UIFont boldSystemFontOfSize:kFontSizeLabel];
    [resetButton setTitle:@"Reset" forState:UIControlStateNormal];
    [resetButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    resetButton.tag = 103;
    resetButton.backgroundColor = [UIColor colorWithRed:0.678 green:1.000 blue:0.184 alpha:1.000];
    resetButton.layer.cornerRadius = 5;
    [self.view addSubview:resetButton];
    
}

@end
