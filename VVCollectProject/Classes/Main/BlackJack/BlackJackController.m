

// 规则
// http://bbs.a9vg.com/thread-1482483-1-1.html
// 概率计算
// http://blog.sina.com.cn/s/blog_6660720f0102v35o.html

//庄家如何操作
//庄家是严格遵照规则来操作21点的。他不可以split或者double。
//•    庄家必须持续加牌如果他的牌没有超过17点
//•    A在庄家牌里永远是11点除非会使庄家牌点数超过21点
//•    如果庄家得到一个soft 17(A可以使1点或者11点在不爆点时)，庄家会继续加牌来保持soft18,或者hard(硬) 17或者更多。


//H (HIT)      D (DOUBLE)       Ds  (DOUBLE STAND)
//P (SPLIT)    S (STAND)        H/P (SPLIT HIT)
//P/R (SURRENDER SPLIT)      H/R (SURRENDER HIT)       S/R  (SURRENDER STAND)

// Ds 表示 Double（如果规则不允许就Stand）
//YOUR HAND: 你的牌
//Dealer&#39;s CARD: 庄家的牌
//hit/加牌，
//stand/保持，
//double/加倍，
//split/分拆，
//doublestand/加倍保持，
//splitHIT/分拆加牌，
//SurrenderSplit/投降分拆，
//SurrenderHit/投降加牌，
//SurrenderStand/投降保持
//Insurance/保险


//Surrender/投降
//•    在surrender时，你会损失初始赌注的一半。
//•    只可以在其它动作像hit,split,double之前的刚刚开始游戏时选择surrender。
//•    只在只有低于等于25%的赢得游戏的机会时选择serrender。



#import "BlackJackController.h"
#import "PhysicalCard.h"
#import "BJHeart.h"
#import "BJClub.h"
#import "BJSpade.h"
#import "BlackJackDataSource.h"
#import "PlayCardModel.h"
#import "BaccaratCollectionView.h"

#define kFontSizeLabel 20
#define kDelayTime 0.1
//#define kFontName  @"Futura"
#define kFontName  @"Futuraaaae"


#define kTrendViewHeight 138

@interface BlackJackController ()

// player Properties
@property (strong, nonatomic) UILabel *playerOneLabel;
@property (strong, nonatomic) UILabel *playerTwoLabel;
@property (strong, nonatomic) UILabel *playerThreeLabel;
@property (strong, nonatomic) UILabel *playerFourLabel;
@property (strong, nonatomic) UILabel *playerFiveLabel;
@property (strong, nonatomic) UILabel *playerTotalLabel;
@property (strong, nonatomic) NSMutableArray *playershandofCardsArray;

// banker Properties
@property (strong, nonatomic) UILabel *bankerOneLabel;
@property (strong, nonatomic) UILabel *bankerTwoLabel;
@property (strong, nonatomic) UILabel *bankerThreeLabel;
@property (strong, nonatomic) UILabel *bankerFourLabel;
@property (strong, nonatomic) UILabel *bankerFiveLabel;
@property (strong, nonatomic) UILabel *bankerTotalLabel;
@property (strong, nonatomic) NSMutableArray *bankershandofCardsArray;


@property (strong, nonatomic) UILabel *resultlLabel;

@property (strong, nonatomic) UIButton *hitButton;
@property (strong, nonatomic) UIButton *standButton;

@property (nonatomic, assign) NSInteger playerTotal;
@property (nonatomic, assign) NSInteger p_ATotal;
@property (nonatomic, assign) NSInteger bankerTotal;
@property (nonatomic, assign) NSInteger b_ATotal;

@property (strong, nonatomic) BlackJackDataSource *referenceDeck;
@property (strong, nonatomic) NSMutableArray *blackjackDataArray;
@property (strong, nonatomic) NSMutableArray *resultDataArray;
// 是否有出现过A
@property (nonatomic, assign) BOOL aceFlag_P;
@property (nonatomic, assign) BOOL aceFlag_B;

@property (nonatomic, strong) BaccaratCollectionView *trendView;

@end

@implementation BlackJackController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self referenceDeck];
    self.playershandofCardsArray = [[NSMutableArray alloc] initWithCapacity:10];
    self.bankershandofCardsArray = [[NSMutableArray alloc] initWithCapacity:5];
    self.resultDataArray = [[NSMutableArray alloc] init];
    
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
            if (self.p_ATotal > self.playerTotal) {
                self.playerTotal = self.p_ATotal;
            } else {
                self.p_ATotal = 0;
            }
            
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
    //TODO: Handle 'Split' condition  TODO：处理“拆分”状态
    
    if ([self.playershandofCardsArray count] == 5)
    {
        [self.playershandofCardsArray removeAllObjects]; //TODO: Extraneous? Might be, remove if so.  TODO：外来的？ 可能，如果是这样，删除。
    }
    
    self.playerTotal = [self.playerTotalLabel.text integerValue];
    
    self.playerTotalLabel.textColor = [UIColor whiteColor];
    self.playerTotalLabel.backgroundColor = [UIColor clearColor];
    
    PlayCardModel* nextCard = [self dealCard:NO toPlayerOrBanker:@"player"];
    [self.playershandofCardsArray addObject:nextCard];
    
    self.playerTotal = self.playerTotal + [nextCard.cardValue integerValue];
    self.p_ATotal = self.playerTotal + 10;
    
    if ([nextCard.cardValue integerValue] == 1)
    {
        self.aceFlag_P = YES;
    }
    
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
    
    if (self.playerTotal > 21) {
        self.playerTotalLabel.text = @"Bust!";
        self.playerTotalLabel.backgroundColor = [UIColor redColor];
        [self.playershandofCardsArray removeAllObjects];
        [self resultHandler];
    } else {
        self.playerTotalLabel.text = [NSString stringWithFormat:@"%ld", self.playerTotal];
        if (self.aceFlag_P && self.p_ATotal <= 21) {
            self.playerTotalLabel.text = [self.playerTotalLabel.text stringByAppendingFormat:@" or %ld", self.p_ATotal];
        } else if (!self.aceFlag_P || self.p_ATotal < self.playerTotal || self.p_ATotal > 21) {
            self.p_ATotal = 0;
        }
        if ([self.playershandofCardsArray count] == 1) {
            //            [self performSelector:@selector(playerLogic) withObject:nil afterDelay:kDelayTime];
            [self performSelector:@selector(bankerLogic) withObject:nil afterDelay:kDelayTime];
        }
    }
}


#pragma mark - Stand停牌 Banker发牌
- (void)bankerLogic
{
    self.bankerTotal = [self.bankerTotalLabel.text integerValue];
    
    PlayCardModel* nextCard = [self dealCard:NO toPlayerOrBanker:@"banker"];
    [self.bankershandofCardsArray addObject:nextCard];
    
    self.bankerTotal = self.bankerTotal + [nextCard.cardValue integerValue];
    
    
    // A 判断
    if ([nextCard.cardValue integerValue] == 1) {
        self.aceFlag_B = YES;
        self.b_ATotal = self.bankerTotal + 10;
    } else if (self.aceFlag_B) {
        self.b_ATotal = self.bankerTotal + 10;
    } else {
        self.b_ATotal = 0;
    }
    
    switch ([self.bankershandofCardsArray count])
    {
        case 1:
            self.bankerOneLabel.text = nextCard.cardText;
            if (self.aceFlag_B) {
                self.bankerTotalLabel.text = @"1 or 11";
            } else {
                self.bankerTotalLabel.text = [NSString stringWithFormat:@"%ld", self.bankerTotal];
            }
            
            [self performSelector:@selector(playerLogic) withObject:nil afterDelay:kDelayTime];
            return;
        case 2:
            self.bankerTwoLabel.text = nextCard.cardText;
            break;
        case 3:
            if ([nextCard.cardValue integerValue] == 1) {
                NSLog(@"11");
            }
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
    if (self.bankerTotal > 21) {
        self.bankerTotalLabel.text = @"Bust!";
        self.bankerTotalLabel.backgroundColor = [UIColor redColor];
        [self resultHandler];
        
    } else if (self.bankerTotal >= 17 || (self.b_ATotal >= 18 && self.b_ATotal <= 21) || (self.b_ATotal == 17 && self.b_ATotal > self.playerTotal)) {   // 不再拿牌
        
        if (self.aceFlag_B) {
            self.bankerTotal = self.b_ATotal;
        }
        self.bankerTotalLabel.text = [NSString stringWithFormat:@"%ld", self.bankerTotal];
        [self performSelector:@selector(resultHandler) withObject:nil afterDelay:kDelayTime];
        
    } else if ((self.bankerTotal < 17 || self.b_ATotal <= 17) && ([self.bankershandofCardsArray count] < 5)) {
        
        self.bankerTotalLabel.text = [NSString stringWithFormat:@"%ld", self.bankerTotal];
        if (self.aceFlag_B && self.b_ATotal <= 17) {
            self.bankerTotalLabel.text = [self.bankerTotalLabel.text stringByAppendingFormat:@" or %ld", self.b_ATotal];
        }
        [self performSelector:@selector(bankerLogic) withObject:nil afterDelay:kDelayTime];
        
    } else if ([self.bankershandofCardsArray count] == 5) {
        
        self.bankerTotal = 21;
        self.playerTotal = 21;
        self.b_ATotal = 21;
        self.bankerTotalLabel.text = @"满了5张牌算TIE";
        [self performSelector:@selector(resultHandler) withObject:nil afterDelay:kDelayTime];
        
    } else {
        NSLog(@"另外情况");
    }
}

- (void)betHandler
{
    
}

#pragma mark - 发牌
- (PlayCardModel*)dealCard:(BOOL)newHand toPlayerOrBanker:(NSString*)playerOrBanker
{
    if (newHand) {
        [self newDeal];
    }
    
    NSInteger nextentry = 0;
    NSInteger nextshufflebanker = 0;
    PlayCardModel *dealtCard;
    
    if ([playerOrBanker isEqualToString:@"player"]) {
        
        nextentry = [self.playershandofCardsArray count]; //effectively gives you the next index to deal a card to AND from. Nice. // 有效地为您提供下一个索引来处理来自AND的卡。尼斯。
        nextshufflebanker = [[[self blackjackDataArray] objectAtIndex:nextentry] integerValue];
        dealtCard = [[self referenceDeck].sortedDeckArray objectAtIndex:nextshufflebanker];
    }
    
    if ([playerOrBanker isEqualToString:@"banker"]) {
        nextentry = [self.bankershandofCardsArray count] + 10; //yes, it's duplicated code but it's only 3 lines so deal with it. 'Deal'. Ha!  //是的，它是重复的代码，但它只有3行所以处理它。“交易”。 哈！
        nextshufflebanker = [[[self blackjackDataArray] objectAtIndex:nextentry] integerValue];
        dealtCard = [[self referenceDeck].sortedDeckArray objectAtIndex:nextshufflebanker];
    }
    return dealtCard;
}


#pragma mark - 结果处理判断
- (void)resultHandler {
    //TODO: Pay bet amount.  // TODO：支付下注金额。
    
    NSLog(@"Player: %ld/%ld. Banker: %ld/%ld", self.playerTotal, self.p_ATotal, self.bankerTotal, self.b_ATotal);
    
    NSInteger playerShighestHand = 0;
    NSInteger bankerShighestHand = 0;
    NSString *titleString = [[NSString alloc] init];
    NSString *messageString = [[NSString alloc] init];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    if (self.playerTotal > 21) {
        playerShighestHand = 0;
        [dict setObject:@(1) forKey:@"PlayerBust"];
    } else {
        playerShighestHand = self.playerTotal;
    }
    
    if (self.bankerTotal > 21) {
        bankerShighestHand = 0;
        [dict setObject:@(1) forKey:@"BankerBust"];
    } else {
        bankerShighestHand = self.bankerTotal;
    }
    
    if (playerShighestHand > bankerShighestHand) {
        titleString = @"Player won!";
        messageString = [NSString stringWithFormat:@"Player %ld, Banker %ld", self.playerTotal, self.bankerTotal];
        self.resultlLabel.text = @"Player";
        self.resultlLabel.backgroundColor = [UIColor blueColor];
        [dict setObject:@(2) forKey:@"WinType"];
    } else if (bankerShighestHand > playerShighestHand) {
        titleString = @"Banker won!";
        messageString = [NSString stringWithFormat:@"Player %ld, Banker %ld", self.playerTotal, self.bankerTotal];
        self.resultlLabel.text = @"Banker";
        self.resultlLabel.backgroundColor = [UIColor redColor];
        [dict setObject:@(1) forKey:@"WinType"];
    } else if (playerShighestHand == bankerShighestHand) {
        titleString = @"TIE";
        messageString = [NSString stringWithFormat:@"TIE %ld", self.playerTotal];
        self.resultlLabel.text = @"TIE";
        self.resultlLabel.backgroundColor = [UIColor greenColor];
        [dict setObject:@(0) forKey:@"WinType"];
    }
    
    if ([[self.playerOneLabel.text substringToIndex:1] isEqualToString:[self.playerTwoLabel.text substringToIndex:1]]) {
        [dict setObject:@(YES) forKey:@"isPlayerPair"];
    }
//    if ([[self.bankerOneLabel.text substringToIndex:1] isEqualToString:[self.bankerTwoLabel.text substringToIndex:1]]) {
//        [dict setObject:@(YES) forKey:@"isBankerPair"];
//    }
    
    
    self.hitButton.enabled = NO;
    self.standButton.enabled = NO;
    self.hitButton.backgroundColor = [UIColor darkGrayColor];
    self.standButton.backgroundColor = [UIColor darkGrayColor];
    
    [self.resultDataArray addObject:dict];
    self.trendView.model = self.resultDataArray;
    
//    UIAlertView *resultView = [[UIAlertView alloc] initWithTitle:titleString
//                                                         message:messageString
//                                                        delegate:self
//                                               cancelButtonTitle:@"Play Again"
//                                               otherButtonTitles: nil];
//    [resultView show];
}


#pragma mark -  统计数据分析
- (void)resultStatisticsContinuous {
    NSString   *compareChar;          // 前一个字符
    BOOL   firstisBankerPair;          // 前一个字符
    BOOL   firstisPlayerPair;          // 前一个字符
    BOOL   firstisSuperSix;          // 前一个字符
    
    NSString   *longestContinChar;    // 连续最长字符
    NSInteger iMaxLen            = 1;  // 最大次数
    NSInteger iCharCount         = 1;  // 当前次数
    NSString *lastBankerOrPlayer = nil;  // 最后一个BankerOrPlayer
    NSInteger lastiCharCount = iCharCount;  // 最后的连续次数

    if (self.resultDataArray.count <= 0) {
        return;
    }
    
    NSDictionary *firstDict = (NSDictionary *)self.resultDataArray.firstObject;
    compareChar       = [[firstDict objectForKey:@"WinType"] stringValue];  // 从第一个字符开始比较
    longestContinChar = compareChar;
    firstisPlayerPair       = [[firstDict objectForKey:@"isPlayerPair"] boolValue];
    
    if (![compareChar isEqualToString:@"2"]) {  // 记录最后一次的 Banker或者Player
        lastBankerOrPlayer = compareChar;
    }
    
    for (NSInteger indexFlag = 1; indexFlag < self.resultDataArray.count; indexFlag++) {
        
        NSDictionary *dict = (NSDictionary *)self.resultDataArray[indexFlag];
        NSString *tempStrWinType       = [[dict objectForKey:@"WinType"] stringValue]; //
        BOOL tempIsPlayerPair       = [[dict objectForKey:@"isPlayerPair"] boolValue];
        
        
        if ([tempStrWinType isEqualToString:compareChar]) {
            iCharCount++;     // 对相同字符计数加1
            
            if (![tempStrWinType isEqualToString:@"0"]) {  // 记录最后一次的 Banker或者Player
                lastBankerOrPlayer = tempStrWinType;
                lastiCharCount = iCharCount;
            }
            
        } else {
            
            iCharCount   = 1;        // 字符不同时计数变为1
            compareChar = tempStrWinType;   // 重新比较新字符

            if (![tempStrWinType isEqualToString:@"0"]) {  // 记录最后一次的 Banker或者Player
                lastBankerOrPlayer = tempStrWinType;
                lastiCharCount = iCharCount;
            }
        }
        
        if (iCharCount > iMaxLen) { // 获取连续出现次数最多的字符及其出现次数
            iMaxLen            = iCharCount;
            longestContinChar = tempStrWinType;
        }
    }
    
//    NSString *aaa = [NSString stringWithFormat:@"连续最多 %@  次数 %ld  与前6相同 %ld   %ld  %0.2f%", [self bankerOrPlayerOrTie:longestContinChar], iMaxLen, self.front6SameCount, self.pokerCount -6- self.front6SameCount, self.front6SameCount*1.00/(self.pokerCount*1.00 -6)*100.0];
    
//    NSLog(aaa);
}


- (BOOL)randomoneoutofFour
{
    //TODO: No longer used.
    int randomNumber = arc4random() % 25; //random number from 0-25
    if ((randomNumber % 5) == 0) //does it divide evenly by 5?
    {
        return YES;
    }
    return NO;
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
    self.playerTotal = 0, self.bankerTotal = 0, self.p_ATotal = 0, self.b_ATotal = 0;
    self.playerTotalLabel.backgroundColor = [UIColor clearColor];
    self.bankerTotalLabel.backgroundColor = [UIColor clearColor];
    self.aceFlag_P = NO; 
    self.aceFlag_B = NO;
    self.resultlLabel.text = nil;
    self.resultlLabel.backgroundColor = [UIColor clearColor];
    [self.playershandofCardsArray removeAllObjects];
    [self.bankershandofCardsArray removeAllObjects];
    [self newDeal];
    [self.hitButton setEnabled:YES];
    
    self.hitButton.enabled = YES;
    self.standButton.enabled = YES;
    self.hitButton.backgroundColor = [UIColor colorWithRed:0.255 green:0.412 blue:0.882 alpha:1.000];
    self.standButton.backgroundColor = [UIColor colorWithRed:0.804 green:0.804 blue:0.004 alpha:1.000];

    [self performSelector:@selector(playerLogic) withObject:nil afterDelay:kDelayTime];
    
}





#pragma mark - UI界面
- (void)initUI {
    
    self.view.backgroundColor = [UIColor colorWithRed:0.031 green:0.486 blue:0.255 alpha:1.000];
    
    
    UIView *pbBackView = [[UIView alloc] init];
    pbBackView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:pbBackView];
    
    [pbBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(10);
        make.left.mas_equalTo(self.view.mas_left).offset(10);
        make.right.mas_equalTo(self.view.mas_right).offset(-10);
        make.height.mas_equalTo(210);
    }];
    
    
    UILabel *playerLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, 100, 35)];
    playerLabel.text = @"Player";
    playerLabel.textColor = [UIColor whiteColor];
    playerLabel.font = [UIFont systemFontOfSize:kFontSizeLabel];
    [pbBackView addSubview:playerLabel];
    
    UILabel *bankerLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 0, 100, 35)];
    bankerLabel.text = @"Banker";
    bankerLabel.textColor = [UIColor whiteColor];
    bankerLabel.font = [UIFont systemFontOfSize:kFontSizeLabel];
    [pbBackView addSubview:bankerLabel];
    
    
    UILabel *playerOneLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 30, 100, 20)];
    playerOneLabel.text = @"Player";
    playerOneLabel.textColor = [UIColor whiteColor];
    playerOneLabel.font = [UIFont fontWithName:kFontName size:kFontSizeLabel];
    [pbBackView addSubview:playerOneLabel];
    _playerOneLabel = playerOneLabel;
    
    UILabel *playerTwoLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 60, 100, 20)];
    playerTwoLabel.text = @"Player";
    playerTwoLabel.textColor = [UIColor whiteColor];
    playerTwoLabel.font = [UIFont fontWithName:kFontName size:kFontSizeLabel];
    [pbBackView addSubview:playerTwoLabel];
    _playerTwoLabel = playerTwoLabel;
    
    UILabel *playerThreeLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 90, 100, 20)];
    playerThreeLabel.text = @"Player";
    playerThreeLabel.textColor = [UIColor whiteColor];
    playerThreeLabel.font = [UIFont fontWithName:kFontName size:kFontSizeLabel];
    [pbBackView addSubview:playerThreeLabel];
    _playerThreeLabel = playerThreeLabel;
    
    UILabel *playerFourLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 120, 100, 20)];
    playerFourLabel.text = @"Player";
    playerFourLabel.textColor = [UIColor whiteColor];
    playerFourLabel.font = [UIFont fontWithName:kFontName size:kFontSizeLabel];
    [pbBackView addSubview:playerFourLabel];
    _playerFourLabel = playerFourLabel;
    
    UILabel *playerFiveLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 150, 100, 20)];
    playerFiveLabel.text = @"Player";
    playerFiveLabel.textColor = [UIColor whiteColor];
    playerFiveLabel.font = [UIFont fontWithName:kFontName size:kFontSizeLabel];
    [pbBackView addSubview:playerFiveLabel];
    _playerFiveLabel = playerFiveLabel;
    
    UILabel *playerTotalLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 180, 80, 20)];
    playerTotalLabel.text = @"Player";
    playerTotalLabel.textAlignment = NSTextAlignmentCenter;
    playerTotalLabel.textColor = [UIColor whiteColor];
    playerTotalLabel.font = [UIFont fontWithName:kFontName size:kFontSizeLabel];
    [pbBackView addSubview:playerTotalLabel];
    _playerTotalLabel = playerTotalLabel;
    
    
    
    UILabel *bankerOneLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 30, 100, 20)];
    bankerOneLabel.text = @"Player";
    bankerOneLabel.textColor = [UIColor whiteColor];
    bankerOneLabel.font = [UIFont fontWithName:kFontName size:kFontSizeLabel];
    [pbBackView addSubview:bankerOneLabel];
    _bankerOneLabel = bankerOneLabel;
    
    UILabel *bankerTwoLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 60, 100, 20)];
    bankerTwoLabel.text = @"Player";
    bankerTwoLabel.textColor = [UIColor whiteColor];
    bankerTwoLabel.font = [UIFont fontWithName:kFontName size:kFontSizeLabel];
    [pbBackView addSubview:bankerTwoLabel];
    _bankerTwoLabel = bankerTwoLabel;
    
    UILabel *bankerThreeLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 90, 100, 20)];
    bankerThreeLabel.text = @"Player";
    bankerThreeLabel.textColor = [UIColor whiteColor];
    bankerThreeLabel.font = [UIFont fontWithName:kFontName size:kFontSizeLabel];
    [pbBackView addSubview:bankerThreeLabel];
    _bankerThreeLabel = bankerThreeLabel;
    
    UILabel *bankerFourLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 120, 100, 20)];
    bankerFourLabel.text = @"Player";
    bankerFourLabel.textColor = [UIColor whiteColor];
    bankerFourLabel.font = [UIFont fontWithName:kFontName size:kFontSizeLabel];
    [pbBackView addSubview:bankerFourLabel];
    _bankerFourLabel = bankerFourLabel;
    
    UILabel *bankerFiveLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 150, 100, 20)];
    bankerFiveLabel.text = @"Player";
    bankerFiveLabel.textColor = [UIColor whiteColor];
    bankerFiveLabel.font = [UIFont fontWithName:kFontName size:kFontSizeLabel];
    [pbBackView addSubview:bankerFiveLabel];
    _bankerFiveLabel = bankerFiveLabel;
    
    UILabel *bankerTotalLabel = [[UILabel alloc] initWithFrame:CGRectMake(210, 180, 80, 20)];
    bankerTotalLabel.text = @"Player";
//    bankerTotalLabel.textAlignment = NSTextAlignmentCenter;
    bankerTotalLabel.textColor = [UIColor whiteColor];
    bankerTotalLabel.font = [UIFont fontWithName:kFontName size:kFontSizeLabel];
    [pbBackView addSubview:bankerTotalLabel];
    _bankerTotalLabel = bankerTotalLabel;
    
    
    UILabel *resultlLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 180, 55, 20)];
    resultlLabel.text = @"NO";
    resultlLabel.textColor = [UIColor whiteColor];
    resultlLabel.font = [UIFont fontWithName:kFontName size:kFontSizeLabel];
    [pbBackView addSubview:resultlLabel];
    _resultlLabel = resultlLabel;
    
    
    UIView *btnBackView = [[UIView alloc] init];
    btnBackView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:btnBackView];
    
    [btnBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(pbBackView.mas_bottom).offset(10);
        make.left.mas_equalTo(self.view.mas_left).offset(10);
        make.right.mas_equalTo(self.view.mas_right).offset(-10);
        make.height.mas_equalTo(50);
    }];
    
    UIButton *hitButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, 80, 50)];
    hitButton.titleLabel.font = [UIFont boldSystemFontOfSize:kFontSizeLabel];
    [hitButton setTitle:@"Hit" forState:UIControlStateNormal];
    [hitButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    hitButton.tag = 101;
    hitButton.backgroundColor = [UIColor colorWithRed:0.255 green:0.412 blue:0.882 alpha:1.000];
    hitButton.layer.cornerRadius = 5;
    [btnBackView addSubview:hitButton];
    _hitButton = hitButton;
    
    UIButton *standButton = [[UIButton alloc] initWithFrame:CGRectMake(120, 0, 80, 50)];
    standButton.titleLabel.font = [UIFont boldSystemFontOfSize:kFontSizeLabel];
    [standButton setTitle:@"Stand" forState:UIControlStateNormal];
    [standButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    standButton.tag = 102;
    standButton.backgroundColor = [UIColor colorWithRed:0.804 green:0.804 blue:0.004 alpha:1.000];
    standButton.layer.cornerRadius = 5;
    [btnBackView addSubview:standButton];
    _standButton = standButton;
    
    
    UIButton *resetButton = [[UIButton alloc] initWithFrame:CGRectMake(240, 0, 80, 50)];
    resetButton.titleLabel.font = [UIFont boldSystemFontOfSize:kFontSizeLabel];
    [resetButton setTitle:@"Reset" forState:UIControlStateNormal];
    [resetButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    resetButton.tag = 103;
    resetButton.backgroundColor = [UIColor colorWithRed:0.678 green:1.000 blue:0.184 alpha:1.000];
    resetButton.layer.cornerRadius = 5;
    [btnBackView addSubview:resetButton];
    
    BaccaratCollectionView *trendView = [[BaccaratCollectionView alloc] initWithFrame:CGRectMake(20, 450, [UIScreen mainScreen].bounds.size.width - 20*2, kTrendViewHeight)];
    //    trendView.backgroundColor = [UIColor redColor];
    trendView.layer.borderWidth = 1;
    trendView.layer.borderColor = [UIColor colorWithRed:0.643 green:0.000 blue:0.357 alpha:1.000].CGColor;
    [self.view addSubview:trendView];
    _trendView = trendView;
    
    UIView *textBackView = [[UIView alloc] init];
    textBackView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:textBackView];
    
    [textBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(btnBackView.mas_bottom).offset(10);
        make.left.mas_equalTo(self.view.mas_left).offset(10);
        make.right.mas_equalTo(self.view.mas_right).offset(-10);
        make.height.mas_equalTo(100);
    }];
}

@end


