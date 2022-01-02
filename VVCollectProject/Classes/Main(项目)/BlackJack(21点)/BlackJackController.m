

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
#import "CardDataSourceModel.h"
#import "PokerCardModel.h"
#import "BZhuPanLuCollectionView.h"
#import "BJDetailsController.h"
#import "VVFunctionManager.h"
#import "MXWPokerView.h"
#import "BJSendPokerView.h"
#import "BlackJackManager.h"
#import "BJWinOrLoseResultModel.h"

#define kFontSizeLabel 20
//#define kFontName  @"Futura"
#define kFontName  @"Futuraaaae"


#define kTrendViewHeight 138

@interface BlackJackController ()

@property (nonatomic, strong) BJSendPokerView *playerSendPokerView;
@property (nonatomic, strong) BJSendPokerView *bankerSendPokerView;
// 每盘数据
@property (strong, nonatomic) NSMutableArray *playershandofCardsArray;
@property (strong, nonatomic) NSMutableArray *bankershandofCardsArray;


@property (strong, nonatomic) UILabel *resultlLabel;

@property (strong, nonatomic) UIButton *hitButton;
@property (strong, nonatomic) UIButton *standButton;

@property (strong, nonatomic) UILabel *resultOneLabel;
@property (strong, nonatomic) UILabel *resultTwoLabel;
@property (strong, nonatomic) UILabel *resultThreeLabel;

@property (nonatomic, strong) BZhuPanLuCollectionView *trendView;
@property (nonatomic, strong) UITextField *boardNumTextField;

/// 玩家总点数
@property (nonatomic, assign) NSInteger playerTotal;
/// 庄家总点数
@property (nonatomic, assign) NSInteger bankerTotal;

@property (strong, nonatomic) CardDataSourceModel *blackJackDataModel;
/// 初始数据
@property (strong, nonatomic) NSMutableArray *blackjackDataArray;
/// 全部盘数结果
@property (strong, nonatomic) NSMutableArray<BJWinOrLoseResultModel *> *resultDataArray;

// 是否有出现过A
@property (nonatomic, assign) BOOL isPlayer_A;
@property (nonatomic, assign) BOOL isBanker_A;
@property (nonatomic, assign) BOOL isAutoRun;
// 加倍 加倍只能拿一张牌
@property (nonatomic, assign) BOOL isDoubleOne;
// 自动处理局数
@property (nonatomic, assign) NSInteger autoTotalIndex;


@end


@implementation BlackJackController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.playershandofCardsArray = [[NSMutableArray alloc] init];
    self.bankershandofCardsArray = [[NSMutableArray alloc] init];
    self.resultDataArray = [[NSMutableArray alloc] init];
    self.isAutoRun = NO;
    
    UIBarButtonItem *barBtn1 = [[UIBarButtonItem alloc]initWithTitle:@"详情" style:UIBarButtonItemStylePlain target:self action:@selector(onDetailsData)];
    self.navigationItem.rightBarButtonItem = barBtn1;
    
    
    [self createUI];
    
    [self resetPlay];
    
   
}

#pragma mark - 重置
- (void)resetPlay {
    
    self.playerTotal = 0;
    self.bankerTotal = 0;
    
    self.isPlayer_A = NO;
    self.isBanker_A = NO;
    self.isDoubleOne = NO;

    
    [self.playershandofCardsArray removeAllObjects];
    [self.bankershandofCardsArray removeAllObjects];
    
    if (!self.isAutoRun) {
        self.resultlLabel.text = nil;
        self.resultlLabel.backgroundColor = [UIColor clearColor];
        
        self.hitButton.enabled = YES;
        self.standButton.enabled = YES;
        self.hitButton.backgroundColor = [UIColor colorWithRed:0.255 green:0.412 blue:0.882 alpha:1.000];
        self.standButton.backgroundColor = [UIColor colorWithRed:0.804 green:0.804 blue:0.004 alpha:1.000];
    }
    
    
    [self performSelector:@selector(startCard) withObject:nil afterDelay:0.5];
    
    if (self.blackjackDataArray.count < 20) {
        [self newDeal];
    }
}

/// 开始运行
-(void)startCard {
    if (self.isAutoRun) {
        [self autoAIPlayerLogic];
        NSLog(@"AutoNum = %zd",self.autoTotalIndex);
    } else {
        [self getPlayerOneCardLogic];
        [self bankerLogic];
    }
}




- (NSMutableArray*)blackjackDataArray
{
    if (!_blackjackDataArray) {
        _blackjackDataArray = [NSMutableArray arrayWithArray:[VVFunctionManager shuffleArray:self.blackJackDataModel.sortedDeckArray pokerPairsNum:6]];
    }
    return _blackjackDataArray;
}


#pragma mark - 详情
- (void)onDetailsData {
    BJDetailsController *vc = [[BJDetailsController alloc] init];
    vc.dataArray = self.resultDataArray;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - 自动->运行
- (void)onAutoAction:(UIButton *)sender {
    
    self.isAutoRun = YES;
    self.autoTotalIndex = 0;
    self.autoTotalIndex = self.boardNumTextField.text.integerValue;
    sender.backgroundColor = [UIColor darkGrayColor];
    sender.enabled = YES;
    
    BOOL isStand = [BlackJackManager autoRunPlayerStandTakeCards:self.playerTotal isPlayer_A:self.isPlayer_A bankerTotal:self.bankerTotal];
    if (isStand) {
        [self onStandButton];
    } else {
        [self autoAIPlayerLogic];
    }
}


#pragma mark - 按钮点击事件
- (void)buttonPressed:(id)sender
{
    switch ([sender tag]) {
        case 101:
            [self getPlayerOneCardLogic];
            break;
        case 102:
            [self onStandButton];
            break;
        case 103:
            [self resetPlay];
            break;
        default:
            break;
    }
}



/// 发牌器
/// @param isPlayer 是否玩家  YES 玩家  NO 庄家
- (void)sendCardMethodIsP:(BOOL)isPlayer {
    
    PokerCardModel *nextCard = (PokerCardModel *)self.blackjackDataArray.firstObject;
    [self.blackjackDataArray removeObjectAtIndex:0];
    if (isPlayer) {
        [self.playershandofCardsArray addObject:nextCard];
        
        // 计算结果
        self.playerTotal = self.playerTotal + nextCard.cardValue;
        if (nextCard.alterValue > 0) {
            self.isPlayer_A = YES;
        }
        
        if (!self.isAutoRun) {
            self.playerSendPokerView.sendCardDataArray = self.playershandofCardsArray;
        }
        
    } else {
        [self.bankershandofCardsArray addObject:nextCard];
    
        // 计算结果
        self.bankerTotal = self.bankerTotal + nextCard.cardValue;
        if (nextCard.alterValue > 0) {
            self.isBanker_A = YES;
        }
        
        if (!self.isAutoRun) {
            self.bankerSendPokerView.sendCardDataArray = self.bankershandofCardsArray;
        }
    }
}

#pragma mark - 玩家拿牌(玩家Hit)
- (void)getPlayerOneCardLogic {
    self.isAutoRun = NO;
    
    [self sendCardMethodIsP:YES];


    if (self.playershandofCardsArray.count >= 2 && self.playerTotal > 21) {
        [self resultHandler];
    }
}



#pragma mark - 手动Banker发牌
- (void)bankerLogic {
    
    [self sendCardMethodIsP:NO];
    
    if (self.bankershandofCardsArray.count == 1) {
        [self getPlayerOneCardLogic];
        return;
    }
    
    
    // 庄家爆牌
    if (self.bankerTotal > 21) {
        [self resultHandler];
        return;
    }
    
    
    BOOL isStand = [BlackJackManager bankerStandTakeCards:self.bankerTotal isBanker_A:self.isBanker_A playerTotal:self.playerTotal];
    if (isStand) {
        if (self.isBanker_A) {
            if (self.bankerTotal + 10 <= 21) {
                self.bankerTotal = self.bankerTotal + 10;
            }
        }
        [self resultHandler];
    } else {
        [self bankerLogic];
    }
    
}
#pragma mark - 停牌
- (void)onStandButton {
    
    if (self.isPlayer_A) {
        if (self.playerTotal + 10 <= 21) {
            self.playerTotal = self.playerTotal + 10;
        }
    }
    
    if (self.isAutoRun) {
        [self autoAIBankerLogic];
    } else {
        [self bankerLogic];
    }
    
}








#pragma mark - 结果处理判断
- (void)resultHandler {
    //TODO: Pay bet amount.  // TODO：支付下注金额。
    
    BJWinOrLoseResultModel *resultModel = [[BJWinOrLoseResultModel alloc] init];
    [resultModel blackJackResultComputer:self.playershandofCardsArray bankerArray:self.bankershandofCardsArray isPlayerDoubleOne:self.isDoubleOne];
    [self.resultDataArray addObject:resultModel];
    
    [self endThisRun];
    
}

- (void)endThisRun {
    if (self.isAutoRun) {
        if (self.autoTotalIndex > 0) {
            self.autoTotalIndex--;
            [self resetPlay];
        } else {
//            [self resultStatisticsContinuous];
            self.trendView.model = self.resultDataArray;
            
            [MBProgressHUD hideHUD];
        }
    } else {
//        [self resultStatisticsContinuous];
        self.trendView.model = self.resultDataArray;
        
        self.hitButton.enabled = NO;
        self.standButton.enabled = NO;
        self.hitButton.backgroundColor = [UIColor darkGrayColor];
        self.standButton.backgroundColor = [UIColor darkGrayColor];
    }
}





#pragma mark -  统计数据分析
- (void)resultStatisticsContinuous {
    NSString   *compareChar;          // 前一个字符
    NSString   *longestContinChar;    // 连续最长字符
    NSInteger iMaxLen            = 1;  // 最大次数
    NSInteger iCharCount         = 1;  // 当前次数
    NSString *lastBankerOrPlayer = nil;  // 最后一个BankerOrPlayer
    NSInteger lastiCharCount = iCharCount;  // 最后的连续次数
    
    
    NSInteger playerTotalCount = 0;
    NSInteger bankerTotalCount = 0;
    NSInteger tieTotalCount = 0;
    
    if (self.resultDataArray.count <= 0) {
        return;
    }
    
    NSDictionary *firstDict = (NSDictionary *)self.resultDataArray.firstObject;
    compareChar       = [[firstDict objectForKey:@"WinType"] stringValue];  // 从第一个字符开始比较
    longestContinChar = compareChar;
    
    if (![compareChar isEqualToString:@"2"]) {  // 记录最后一次的 Banker或者Player
        lastBankerOrPlayer = compareChar;
    }
    
    
    if (compareChar.integerValue == 1) {
        bankerTotalCount++;
    } else if (compareChar.integerValue == 2) {
        playerTotalCount++;
    } else {
        tieTotalCount++;
    }
    for (NSInteger indexFlag = 1; indexFlag < self.resultDataArray.count; indexFlag++) {
        
        NSDictionary *dict = (NSDictionary *)self.resultDataArray[indexFlag];
        NSString *tempStrWinType       = [[dict objectForKey:@"WinType"] stringValue];
        
        if (tempStrWinType.integerValue == 1) {
            bankerTotalCount++;
        } else if (tempStrWinType.integerValue == 2) {
            playerTotalCount++;
        } else {
            tieTotalCount++;
        }
        
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
    
    CGFloat p100 = playerTotalCount/((playerTotalCount +bankerTotalCount) *1.0)* 100.00;
    CGFloat b100 = bankerTotalCount*1.0/(playerTotalCount +bankerTotalCount) * 100.00;
    
    NSString *game = [NSString stringWithFormat:@"GAME  %ld  [Player %ld   %0.2f%]  [Banker %ld  %0.2f%]  庄闲相差 %0.2f%", self.resultDataArray.count, playerTotalCount,p100,bankerTotalCount,b100, b100 - p100];
    
//    NSString *aaa = [NSString stringWithFormat:@"连续最多 %@   次数 %ld   TIE %ld", [self bankerOrPlayerOrTie:longestContinChar], iMaxLen, tieTotalCount];
//    self.resultOneLabel.text = game;
//    self.resultTwoLabel.text = aaa;
}





















#pragma mark - 自动->玩家逻辑  玩家Hit
- (void)autoAIPlayerLogic {

    NSString *msg = [NSString stringWithFormat:@"正在自动运行...=%ld",self.autoTotalIndex];
    [MBProgressHUD showActivityMessageInView:msg];
    
    [self sendCardMethodIsP:YES];
    
    if (self.playershandofCardsArray.count == 1) {
        [self autoAIBankerLogic];
        return;
    }

    // 两张牌的时候
    if (self.playershandofCardsArray.count == 2) {
        
        BOOL isDoubleOne = [BlackJackManager autoRunPlayerDoubleOneTakeCards:self.playerTotal isPlayer_A:self.isPlayer_A bankerTotal:self.bankerTotal];
        if (isDoubleOne) {
            self.isDoubleOne = YES;
            [self autoAIPlayerLogic];
        } else {
            self.isDoubleOne = NO;
            
            BOOL isStand = [BlackJackManager autoRunPlayerStandTakeCards:self.playerTotal isPlayer_A:self.isPlayer_A bankerTotal:self.bankerTotal];
            
            if (isStand) {
                [self onStandButton];
            } else {
                [self autoAIPlayerLogic];
            }
        }
        
        return;
    }
    
    
    if (self.playerTotal > 21) {
        [self resultHandler];
        return;
    }
    

    if (self.isDoubleOne) {
        [self onStandButton];
    } else {
        BOOL isStand = [BlackJackManager autoRunPlayerStandTakeCards:self.playerTotal isPlayer_A:self.isPlayer_A bankerTotal:self.bankerTotal];
        
        if (isStand) {
            [self onStandButton];
        } else {
            [self autoAIPlayerLogic];
        }
    }
}


#pragma mark - 自动-> Banker发牌
- (void)autoAIBankerLogic {

    [self sendCardMethodIsP:NO];

    if (self.bankershandofCardsArray.count == 1) {
        [self autoAIPlayerLogic];
        return;
    }

    // 庄家爆牌
    if (self.bankerTotal > 21) {
        [self resultHandler];
        return;
    }
    
    BOOL isStand = [BlackJackManager bankerStandTakeCards:self.bankerTotal isBanker_A:self.isBanker_A playerTotal:self.playerTotal];
    if (isStand) {
        if (self.isBanker_A) {
            if (self.bankerTotal + 10 <= 21) {
                self.bankerTotal = self.bankerTotal + 10;
            }
        }
        [self resultHandler];
    } else {
        [self autoAIBankerLogic];
    }

}



- (CardDataSourceModel*)blackJackDataModel
{
    if (!_blackJackDataModel)
    {
        _blackJackDataModel = [[CardDataSourceModel alloc] init];
    }
    return _blackJackDataModel;
}

// 新的一局从新开始
- (void)newDeal
{
    [_blackjackDataArray removeAllObjects];
    _blackjackDataArray = nil;
    [self blackjackDataArray];
}


#pragma mark - UI界面
- (void)createUI {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *backImageView = [[UIImageView alloc] init];
    backImageView.userInteractionEnabled = YES;
    backImageView.image = [UIImage imageNamed:@"game_back_1242x2208.jpg"];
    [self.view addSubview:backImageView];
    
    [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self.view);
    }];
    
    
    [backImageView addSubview:self.playerSendPokerView];
//    [self.playerSendPokerView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(backImageView.mas_top).offset(10);
//        make.left.equalTo(backImageView.mas_left).offset(10);
//        make.right.equalTo(backImageView.mas_centerX).offset(-10);
//        make.height.mas_equalTo(180);
//    }];
    
    [backImageView addSubview:self.bankerSendPokerView];
//    [self.bankerSendPokerView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(backImageView.mas_top).offset(10);
//        make.left.equalTo(self.playerSendPokerView.mas_right).offset(20);
//        make.right.equalTo(backImageView.mas_right).offset(-10);
//        make.height.mas_equalTo(180);
//    }];
    


    UILabel *resultlLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 180, 80, 20)];
    resultlLabel.text = @"";
    resultlLabel.textColor = [UIColor whiteColor];
    resultlLabel.font = [UIFont boldSystemFontOfSize:17];
    [backImageView addSubview:resultlLabel];
    _resultlLabel = resultlLabel;
    
    
    [resultlLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.playerSendPokerView.mas_centerY);
        make.centerX.equalTo(backImageView.mas_centerX);
    }];


    UIView *btnBackView = [[UIView alloc] init];
    btnBackView.backgroundColor = [UIColor clearColor];
    [backImageView addSubview:btnBackView];

    [btnBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.playerSendPokerView.mas_bottom).offset(10);
        make.left.equalTo(backImageView.mas_left).offset(10);
        make.right.equalTo(backImageView.mas_right).offset(-10);
        make.height.mas_equalTo(50);
    }];

    UIButton *hitButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, 90, 50)];
    hitButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [hitButton setTitle:@"Hit(拿牌)" forState:UIControlStateNormal];
    [hitButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    hitButton.tag = 101;
    hitButton.backgroundColor = [UIColor colorWithRed:0.255 green:0.412 blue:0.882 alpha:1.000];
    [hitButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    hitButton.layer.cornerRadius = 5;
    [btnBackView addSubview:hitButton];
    _hitButton = hitButton;

    UIButton *standButton = [[UIButton alloc] initWithFrame:CGRectMake(120, 0, 90, 50)];
    standButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [standButton setTitle:@"Stand(停止)" forState:UIControlStateNormal];
    [standButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    standButton.tag = 102;
    standButton.backgroundColor = [UIColor colorWithRed:0.804 green:0.804 blue:0.004 alpha:1.000];
    [standButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    standButton.layer.cornerRadius = 5;
    [btnBackView addSubview:standButton];
    _standButton = standButton;


    UIButton *resetButton = [[UIButton alloc] initWithFrame:CGRectMake(240, 0, 90, 50)];
    resetButton.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    [resetButton setTitle:@"Reset(开始)" forState:UIControlStateNormal];
    [resetButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    resetButton.tag = 103;
    resetButton.backgroundColor = [UIColor colorWithRed:0.678 green:1.000 blue:0.184 alpha:1.000];
    [resetButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    resetButton.layer.cornerRadius = 5;
    [btnBackView addSubview:resetButton];

    BZhuPanLuCollectionView *trendView = [[BZhuPanLuCollectionView alloc] initWithFrame:CGRectMake(20, 450, [UIScreen mainScreen].bounds.size.width - 20*2, kTrendViewHeight)];
    //    trendView.backgroundColor = [UIColor redColor];
    trendView.layer.borderWidth = 1;
    trendView.layer.borderColor = [UIColor colorWithRed:0.643 green:0.000 blue:0.357 alpha:1.000].CGColor;
    [backImageView addSubview:trendView];
    _trendView = trendView;

    
    UIView *textBackView = [[UIView alloc] init];
    textBackView.backgroundColor = [UIColor clearColor];
    [backImageView addSubview:textBackView];

    [textBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btnBackView.mas_bottom).offset(10);
        make.left.equalTo(backImageView.mas_left).offset(10);
        make.right.equalTo(backImageView.mas_right).offset(-10);
        make.height.mas_equalTo(120);
    }];

    
    
    
    
    
    
    #pragma mark  统计
    UILabel *resultOneLabel = [[UILabel alloc] init];
    resultOneLabel.text = @"-";
    resultOneLabel.font = [UIFont systemFontOfSize:16];
    resultOneLabel.textColor = [UIColor darkGrayColor];
    resultOneLabel.numberOfLines = 0;
    resultOneLabel.textAlignment = NSTextAlignmentLeft;
    [backImageView addSubview:resultOneLabel];
    _resultOneLabel = resultOneLabel;

    [resultOneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(textBackView.mas_top);
        make.left.equalTo(textBackView.mas_left);
        make.right.equalTo(textBackView.mas_right);
    }];

    UILabel *resultTwoLabel = [[UILabel alloc] init];
    resultTwoLabel.text = @"-";
    resultTwoLabel.font = [UIFont systemFontOfSize:16];
    resultTwoLabel.textColor = [UIColor darkGrayColor];
    resultTwoLabel.numberOfLines = 0;
    resultTwoLabel.textAlignment = NSTextAlignmentLeft;
    [backImageView addSubview:resultTwoLabel];
    _resultTwoLabel = resultTwoLabel;

    [resultTwoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(resultOneLabel.mas_bottom);
        make.left.equalTo(textBackView.mas_left);
        make.right.equalTo(textBackView.mas_right);
    }];


    UILabel *resultThreeLabel = [[UILabel alloc] init];
    resultThreeLabel.text = @"-";
    resultThreeLabel.font = [UIFont systemFontOfSize:16];
    resultThreeLabel.textColor = [UIColor darkGrayColor];
    resultThreeLabel.numberOfLines = 0;
    resultThreeLabel.textAlignment = NSTextAlignmentLeft;
    [backImageView addSubview:resultThreeLabel];
    _resultThreeLabel = resultThreeLabel;

    [resultThreeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(resultTwoLabel.mas_bottom);
        make.left.equalTo(textBackView.mas_left);
        make.right.equalTo(textBackView.mas_right);
    }];

    
    
    UIView *bottomBgView = [[UIView alloc] init];
    bottomBgView.backgroundColor = [UIColor clearColor];
    [backImageView addSubview:bottomBgView];
    
    [bottomBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(backImageView.mas_bottom).offset(-mxwBottomSafeAreaHeight());
        make.left.equalTo(backImageView.mas_left).offset(10);
        make.right.equalTo(backImageView.mas_right).offset(-10);
        make.height.mas_equalTo(50);
    }];
   
    
    UIButton *autoButton = [[UIButton alloc] init];
    autoButton.titleLabel.font = [UIFont boldSystemFontOfSize:kFontSizeLabel];
    [autoButton setTitle:@"Auto" forState:UIControlStateNormal];
    [autoButton addTarget:self action:@selector(onAutoAction:) forControlEvents:UIControlEventTouchUpInside];
    autoButton.tag = 102;
    autoButton.backgroundColor = [UIColor colorWithRed:0.804 green:0.804 blue:0.004 alpha:1.000];
    autoButton.layer.cornerRadius = 5;
    [bottomBgView addSubview:autoButton];

    [autoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bottomBgView.mas_centerY);
        make.right.equalTo(bottomBgView.mas_right);
        make.size.mas_equalTo(CGSizeMake(50, 40));
    }];

    UITextField *boardNumTextField = [[UITextField alloc] init];
    boardNumTextField.text = @"1000";
    boardNumTextField.keyboardType = UIKeyboardTypeNumberPad;
    boardNumTextField.textColor = [UIColor grayColor];
    boardNumTextField.layer.cornerRadius = 5;
    boardNumTextField.layer.borderColor = [UIColor grayColor].CGColor;
    boardNumTextField.layer.borderWidth = 1;
    [bottomBgView addSubview:boardNumTextField];
    _boardNumTextField = boardNumTextField;

    [boardNumTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bottomBgView.mas_centerY);
        make.right.equalTo(autoButton.mas_left).offset(-10);
        make.size.mas_equalTo(CGSizeMake(50, 40));
    }];
    
}


-(BJSendPokerView *)playerSendPokerView {
    if (!_playerSendPokerView) {
        _playerSendPokerView = [[BJSendPokerView alloc] initWithFrame:CGRectMake(20, mxwStatusNavBarHeight()+10, mxwScreenWidth()/2-20*2, 200)];
        _playerSendPokerView.nameLabel.text = @"Player";
        
//        _playerSendPokerView.backgroundColor = [UIColor redColor];
    }
    return _playerSendPokerView;
}
-(BJSendPokerView *)bankerSendPokerView {
    if (!_bankerSendPokerView) {
        _bankerSendPokerView = [[BJSendPokerView alloc] initWithFrame:CGRectMake(20+mxwScreenWidth()/2, mxwStatusNavBarHeight()+10, mxwScreenWidth()/2-20*2, 200)];
        _bankerSendPokerView.nameLabel.text = @"Banker";
    }
    return _bankerSendPokerView;
}

@end


