//
//  BaccaratController.m
//  VVCollectProject
//
//  Created by Mike on 2019/2/20.
//  Copyright © 2019 Mike. All rights reserved.
//

#import "BaccaratController.h"
#import "BaccaratCell.h"
#import "BaccaratCollectionView.h"

#define kBtnHeight 30
#define kBtnFontSize 16
#define kMarginHeight 10
// 边距
#define kMarginWidth 20
#define kTrendViewHeight 138



@interface BaccaratController ()<UITableViewDataSource, UITableViewDelegate>

//
@property (nonatomic,strong) NSMutableArray *dataArray;
// 牌副数
@property (nonatomic,assign) NSInteger pokerNum;
// 牌的总张数
@property (nonatomic,assign) NSInteger pokerTotalNum;
// 发牌局数
@property (nonatomic,assign) NSInteger pokerCount;

// 闲局数
@property (nonatomic,assign) NSInteger playerCount;
// 庄局数
@property (nonatomic,assign) NSInteger bankerCount;

// 闲对局数
@property (nonatomic,assign) NSInteger playerPairCount;
// 庄对局数
@property (nonatomic,assign) NSInteger bankerPairCount;
// 幸运6
@property (nonatomic,assign) NSInteger superSixCount;
// 和局
@property (nonatomic,assign) NSInteger tieCount;

@property (nonatomic, strong) UITextField *pokerNumTextField;

//@property (nonatomic, strong) UIView *trendView;
@property (nonatomic, strong) BaccaratCollectionView *trendView;


// 结果数据
@property (nonatomic, strong) NSMutableArray *resultDataArray;

//
@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic, strong) UILabel *pokerCountLabel;
@property (nonatomic,strong) UILabel *bankerCountLabel;
@property (nonatomic,strong) UILabel *playerCountLabel;
@property (nonatomic,strong) UILabel *tieCountLabel;
@property (nonatomic,strong) UILabel *bankerPairCountLabel;
@property (nonatomic,strong) UILabel *playerPairCountLabel;
@property (nonatomic,strong) UILabel *superSixCountLabel;


@end

@implementation BaccaratController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    Poker
    //    spade  黑桃
    //    heart  红桃（红心）
    //    club  梅花
    //   diamond 方块
    //    joker  大王 小王（小丑意思）
    //    PokerColor  花色
    
    //     ♡♢♤♧♣♦♥♠
    //    ♡♢♤♧♣♦♥♠
    
    //    🔵 💚
    //    4种
    //    1 2 3 4 5 6 7 8 9 10 11 12 13
    //    A 2 3 4 5 6 7 8 9 10 L Q K
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.pokerNum = 8;
    [self initData];
    [self initUI];
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[BaccaratCell class] forCellReuseIdentifier:@"BaccaratCell"];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [self configureNavigationBar];
    // 要刷新状态栏，让其重新执行该方法需要调用{-setNeedsStatusBarAppearanceUpdate}
//    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)initUI {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITextField *pokerNumTextField = [[UITextField alloc] initWithFrame:CGRectMake(kMarginWidth, kMarginHeight, 60, kBtnHeight)];
    pokerNumTextField.text = @"8";
    pokerNumTextField.keyboardType = UIKeyboardTypeNumberPad;
    pokerNumTextField.textColor = [UIColor grayColor];
    pokerNumTextField.layer.cornerRadius = 5;
    pokerNumTextField.layer.borderColor = [UIColor grayColor].CGColor;
    pokerNumTextField.layer.borderWidth = 1;
    _pokerNumTextField = pokerNumTextField;
    
    //    [pokerNumTextField mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.mas_equalTo(self.view.mas_left).offset(50);
    //        make.top.mas_equalTo(self.view.mas_top).offset(100);
    //        make.size.mas_equalTo(CGSizeMake(80, 40));
    //    }];
    
    [self.view addSubview:pokerNumTextField];
    
    UIButton *startButton = [[UIButton alloc] initWithFrame:CGRectMake(kMarginWidth + 60 + 10, kMarginHeight, 50, kBtnHeight)];
    startButton.titleLabel.font = [UIFont systemFontOfSize:kBtnFontSize];
    [startButton setTitle:@"全盘" forState:UIControlStateNormal];
    [startButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [startButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    startButton.backgroundColor = [UIColor colorWithRed:0.027 green:0.757 blue:0.376 alpha:1.000];
    startButton.layer.cornerRadius = 5;
    [startButton addTarget:self action:@selector(onStartButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startButton];
    
    
    UIButton *startOneButton = [[UIButton alloc] initWithFrame:CGRectMake(kMarginWidth + 60 + 10 +50 +10, kMarginHeight, 80, kBtnHeight)];
    [startOneButton setTitle:@"开始一局" forState:UIControlStateNormal];
    startButton.titleLabel.font = [UIFont systemFontOfSize:kBtnFontSize];
    [startOneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [startOneButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    startOneButton.backgroundColor = [UIColor colorWithRed:0.027 green:0.757 blue:0.376 alpha:1.000];
    startOneButton.layer.cornerRadius = 5;
    [startOneButton addTarget:self action:@selector(onStartOneButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startOneButton];
    
    UIButton *clearButton = [[UIButton alloc] initWithFrame:CGRectMake(kMarginWidth + 60 + 10 +50 +10 +80 +10, kMarginHeight, 50, kBtnHeight)];
    [clearButton setTitle:@"清除" forState:UIControlStateNormal];
    startButton.titleLabel.font = [UIFont systemFontOfSize:kBtnFontSize];
    [clearButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [clearButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    clearButton.backgroundColor = [UIColor colorWithRed:0.027 green:0.757 blue:0.376 alpha:1.000];
    clearButton.layer.cornerRadius = 5;
    [clearButton addTarget:self action:@selector(onClearButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:clearButton];
    
//    UIView *trendView = [[UIView alloc] initWithFrame:CGRectMake(20, kMarginHeight + 30 +5, [UIScreen mainScreen].bounds.size.width - 20*2, kTrendViewHeight)];
//    trendView.layer.borderWidth = 1;
//    trendView.layer.borderColor = [UIColor greenColor].CGColor;
//    [self.view addSubview:trendView];
//    _trendView = trendView;
//     baccCollectionView
    BaccaratCollectionView *trendView = [[BaccaratCollectionView alloc] initWithFrame:CGRectMake(20, kMarginHeight + 30 +5, [UIScreen mainScreen].bounds.size.width - 20*2, kTrendViewHeight)];
//    trendView.backgroundColor = [UIColor redColor];
    trendView.layer.borderWidth = 2;
    trendView.layer.borderColor = [UIColor colorWithRed:0.643 green:0.000 blue:0.357 alpha:1.000].CGColor;
    [self.view addSubview:trendView];
    _trendView = trendView;
    
    
    UILabel *pokerCountLabel = [[UILabel alloc] init];
    pokerCountLabel.font = [UIFont systemFontOfSize:14];
    //    pokerCountLabel.layer.borderWidth = 1;
    //    pokerCountLabel.layer.borderColor = [UIColor blueColor].CGColor;
    pokerCountLabel.numberOfLines = 0;
    pokerCountLabel.text = @"结果";
    pokerCountLabel.textColor = [UIColor darkGrayColor];
    [self.view addSubview:pokerCountLabel];
    _pokerCountLabel = pokerCountLabel;
    
    [pokerCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(trendView.mas_left);
        make.right.mas_equalTo(trendView.mas_right);
        make.top.mas_equalTo(trendView.mas_bottom).offset(5);
    }];
    
    UILabel *bankerCountLabel = [[UILabel alloc] init];
    bankerCountLabel.font = [UIFont systemFontOfSize:14];
    bankerCountLabel.numberOfLines = 0;
    bankerCountLabel.text = @"庄赢";
    bankerCountLabel.textColor = [UIColor darkGrayColor];
    [self.view addSubview:bankerCountLabel];
    _bankerCountLabel = bankerCountLabel;
    
    [bankerCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(trendView.mas_left);
        make.top.mas_equalTo(pokerCountLabel.mas_bottom);
    }];
    
    UILabel *playerCountLabel = [[UILabel alloc] init];
    playerCountLabel.font = [UIFont systemFontOfSize:14];
    playerCountLabel.numberOfLines = 0;
    playerCountLabel.text = @"闲赢";
    playerCountLabel.textColor = [UIColor darkGrayColor];
    [self.view addSubview:playerCountLabel];
    _playerCountLabel = playerCountLabel;
    
    [playerCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(trendView.mas_left);
        make.top.mas_equalTo(bankerCountLabel.mas_bottom);
    }];
    
    UILabel *tieCountLabel = [[UILabel alloc] init];
    tieCountLabel.font = [UIFont systemFontOfSize:14];
    tieCountLabel.numberOfLines = 0;
    tieCountLabel.text = @"和";
    tieCountLabel.textColor = [UIColor darkGrayColor];
    [self.view addSubview:tieCountLabel];
    _tieCountLabel = tieCountLabel;
    
    [tieCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(trendView.mas_left);
        make.top.mas_equalTo(playerCountLabel.mas_bottom);
    }];
    
    UILabel *bankerPairCountLabel = [[UILabel alloc] init];
    bankerPairCountLabel.font = [UIFont systemFontOfSize:14];
    bankerPairCountLabel.numberOfLines = 0;
    bankerPairCountLabel.text = @"庄对";
    bankerPairCountLabel.textColor = [UIColor darkGrayColor];
    [self.view addSubview:bankerPairCountLabel];
    _bankerPairCountLabel = bankerPairCountLabel;
    
    [bankerPairCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(trendView.mas_left);
        make.top.mas_equalTo(tieCountLabel.mas_bottom);
    }];
    
    UILabel *playerPairCountLabel = [[UILabel alloc] init];
    playerPairCountLabel.font = [UIFont systemFontOfSize:14];
    playerPairCountLabel.numberOfLines = 0;
    playerPairCountLabel.text = @"闲对";
    playerPairCountLabel.textColor = [UIColor darkGrayColor];
    [self.view addSubview:playerPairCountLabel];
    _playerPairCountLabel = playerPairCountLabel;
    
    [playerPairCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(trendView.mas_left);
        make.top.mas_equalTo(bankerPairCountLabel.mas_bottom);
    }];
    
    UILabel *superSixCountLabel = [[UILabel alloc] init];
    superSixCountLabel.font = [UIFont systemFontOfSize:14];
    superSixCountLabel.numberOfLines = 0;
    superSixCountLabel.text = @"superSix";
    superSixCountLabel.textColor = [UIColor darkGrayColor];
    [self.view addSubview:superSixCountLabel];
    _superSixCountLabel = superSixCountLabel;
    
    [superSixCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(trendView.mas_left);
        make.top.mas_equalTo(playerPairCountLabel.mas_bottom);
    }];
    
    
}

#pragma mark -  清除
- (void)onClearButton {
    self.trendView = nil;
    [self initData];
    [self.view layoutIfNeeded];
    [self.view layoutSubviews];
    [self.tableView reloadData];
    
}

#pragma mark -  开始一局
- (void)onStartOneButton {
    [self.view endEditing:YES];
    if (self.pokerTotalNum < 6) {  // 停止发牌
        self.pokerCountLabel.text = [NSString stringWithFormat:@"发了%ld局 剩余%ld张牌 已结束", self.pokerCount, self.pokerTotalNum];
        return;
    }
    
    self.pokerCount++;
    [self oncePoker];
//    [self resultView];
    
    self.trendView.model = self.resultDataArray;
    [self resultText];
    [self.tableView reloadData];
}

#pragma mark -  全盘
/**
 全盘
 */
- (void)onStartButton {
    self.pokerNum = self.pokerNumTextField.text.integerValue;
    [self opening];
//    [self resultView];
    self.trendView.model = self.resultDataArray;
    [self resultText];
    [self.tableView reloadData];
    
    
    //    NSString *stringAA =  [NSString stringWithFormat:@"\n发了%ld局\n剩余 %ld张牌\n闲赢%ld\n庄赢%ld\n闲对%ld 平均%ld\n庄对%ld 平均%ld\n幸运6%ld 平均%ld\n和局共%ld 平均%ld", self.pokerCount, self.pokerTotalNum, self.playerCount, self.bankerCount, self.playerPairCount, self.pokerCount/self.playerPairCount, self.bankerPairCount,self.pokerCount/self.bankerPairCount, self.superSixCount,self.pokerCount/self.superSixCount, self.tieCount, self.pokerCount/self.tieCount];
    //
    //    NSString *stringBB =  [NSString stringWithFormat:@"发了%ld局-剩余 %ld张牌-闲赢%ld-庄赢%ld-闲对%ld-平均%ld-庄对%ld -平均%ld-幸运Six%ld -平均%ld-和局共%ld -平均%ld", self.pokerCount, self.pokerTotalNum, self.playerCount, self.bankerCount, self.playerPairCount, self.pokerCount/self.playerPairCount, self.bankerPairCount,self.pokerCount/self.bankerPairCount, self.superSixCount,self.pokerCount/self.superSixCount, self.tieCount, self.pokerCount/self.tieCount];
}

#pragma mark -  开始
- (void)opening {
    [self initData];
    // 发牌局数
    for (NSInteger i = 1; i <= (self.pokerNum * 52 / 4); i++) {
        if (self.pokerTotalNum < 6) {
            break;
        }
        self.pokerCount++;
        [self oncePoker];
        NSLog(@"---%@", [NSThread currentThread]);
//        self.pokerCountLabel.text = [NSString stringWithFormat:@"%ld", self.pokerTotalNum];
//        self.pokerCountLabel.font = [UIFont systemFontOfSize:40];
    }
}

- (void)resultText {
    self.pokerCountLabel.text = [NSString stringWithFormat:@"发了%ld局 剩余%ld张牌", self.pokerCount, self.pokerTotalNum];
    self.bankerCountLabel.text = [NSString stringWithFormat:@"庄赢%ld", self.bankerCount];
    self.playerCountLabel.text = [NSString stringWithFormat:@"闲赢%ld", self.playerCount];
    self.tieCountLabel.text = [NSString stringWithFormat:@"和局共%ld 平均%ld", self.tieCount, self.tieCount ? self.pokerCount/self.tieCount : 0];
    self.bankerPairCountLabel.text = [NSString stringWithFormat:@"庄对%ld 平均%ld", self.bankerPairCount, self.bankerPairCount ? self.pokerCount/self.bankerPairCount : 0];
    self.playerPairCountLabel.text = [NSString stringWithFormat:@"闲对%ld 平均%ld", self.playerPairCount, self.playerPairCount ? self.pokerCount/self.playerPairCount : 0];
    self.superSixCountLabel.text = [NSString stringWithFormat:@"幸运Six%ld 平均%ld", self.superSixCount, self.superSixCount ? self.pokerCount/self.superSixCount : 0];
}

#pragma mark -  结果视图
- (void)resultView {
    for (NSInteger index = 0; index < self.pokerCount; index++) {
        
        NSMutableDictionary *dict = (NSMutableDictionary *)self.resultDataArray[index];
        NSInteger row = index / 6;  // 计算列号 决定y
        NSInteger col = index % 6;  // 计算行号 决定x
        
        CGFloat xxWidth = ([UIScreen mainScreen].bounds.size.width - 10*2 - 15*2) / (90/6+2);
        
        UIView *playerBankerView = [[UIView alloc] init];
        playerBankerView.layer.cornerRadius = xxWidth/2;
        playerBankerView.frame = CGRectMake(row * (xxWidth +2), col * (xxWidth + 2), xxWidth, xxWidth);
        [self.trendView addSubview:playerBankerView];
        
        UILabel *num = [[UILabel alloc] init];
        num.textAlignment = NSTextAlignmentCenter;
        num.font = [UIFont systemFontOfSize:12];
        num.text = [NSString stringWithFormat:@"%ld", index+1];
        [playerBankerView addSubview:num];
        
        [num mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(playerBankerView.mas_centerX);
            make.centerY.mas_equalTo(playerBankerView.mas_centerY);
        }];
        
        
        if ([[dict objectForKey:@"WinType"] integerValue] == 0) {
            playerBankerView.backgroundColor = [UIColor redColor];
        } else if ([[dict objectForKey:@"WinType"] integerValue] == 1) {
            playerBankerView.backgroundColor = [UIColor blueColor];
        } else {
            playerBankerView.backgroundColor = [UIColor greenColor];
        }
        
        if ([[dict objectForKey:@"isSuperSix"] boolValue]) {
            UIView *superSix = [[UIView alloc] init];
            superSix.layer.cornerRadius = 8/2;
            superSix.backgroundColor = [UIColor yellowColor];
            [playerBankerView addSubview:superSix];
            num.text = @"6";
            [superSix mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(playerBankerView.mas_left);
                make.bottom.mas_equalTo(playerBankerView.mas_bottom);
                make.size.mas_equalTo(CGSizeMake(8, 8));
            }];
        }
        
        if ([[dict objectForKey:@"isPlayerPair"] boolValue]) {
            UIView *playerPairView = [[UIView alloc] init];
            playerPairView.layer.cornerRadius = 8/2;
            playerPairView.backgroundColor = [UIColor blueColor];
            [playerBankerView addSubview:playerPairView];
            [playerPairView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(playerBankerView.mas_left);
                make.top.mas_equalTo(playerBankerView.mas_top);
                make.size.mas_equalTo(CGSizeMake(8, 8));
            }];
        }
        
        if ([[dict objectForKey:@"isBankerPair"] boolValue]) {
            UIView *bankerPairView = [[UIView alloc] init];
            bankerPairView.layer.cornerRadius = 8/2;
            bankerPairView.backgroundColor = [UIColor redColor];
            [playerBankerView addSubview:bankerPairView];
            [bankerPairView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(playerBankerView.mas_right);
                make.bottom.mas_equalTo(playerBankerView.mas_bottom);
                make.size.mas_equalTo(CGSizeMake(8, 8));
            }];
        }
        
    }
    
    [self.tableView reloadData];
}



#pragma mark -  数据初始化
- (void)initData {
    
    NSArray *pokerArray = @[ @(1),@(2),@(3),@(4),@(5),@(6),@(7),@(8),@(9),@(10),@(11),@(12),@(13),
                             @(1),@(2),@(3),@(4),@(5),@(6),@(7),@(8),@(9),@(10),@(11),@(12),@(13),
                             @(1),@(2),@(3),@(4),@(5),@(6),@(7),@(8),@(9),@(10),@(11),@(12),@(13),
                             @(1),@(2),@(3),@(4),@(5),@(6),@(7),@(8),@(9),@(10),@(11),@(12),@(13)
                             ];
    
    self.dataArray = [[NSMutableArray alloc] init];
    for (NSInteger index = 1; index <= self.pokerNum; index++) {
        [self.dataArray addObjectsFromArray:pokerArray];
    }
    
    self.pokerTotalNum = self.dataArray.count;
    
    // 洗牌
    for (NSInteger index = 1; index <= self.pokerTotalNum; index++) {
        int pokerIndexA = (arc4random() % self.pokerTotalNum) + 0;
        int pokerIndexB = (arc4random() % self.pokerTotalNum) + 0;
        
        [self.dataArray exchangeObjectAtIndex:pokerIndexA withObjectAtIndex:pokerIndexB];
    }
    
    self.pokerCount = 0;
    self.playerCount = 0;
    self.bankerCount = 0;
    self.playerPairCount = 0;
    self.bankerPairCount = 0;
    self.superSixCount = 0;
    self.tieCount = 0;
    self.resultDataArray = [NSMutableArray array];
}

#pragma mark -  Baccarat算法
- (void)oncePoker {
    // 闲
    NSInteger player1 = 0;
    NSInteger player2 = 0;
    NSString *player3;
    // 庄
    NSInteger banker1 = 0;
    NSInteger banker2 = 0;
    NSString *banker3;
    // 庄闲点数
    NSInteger playerPointsNum = 0;
    NSInteger bankerPointsNum = 0;
    
    for (NSInteger i = 1; i <= 6; i++) {
        
        // 洗牌
        //        int pokerIndex = (arc4random() % self.pokerTotalNum) + 0;
        //        NSNumber *num = (NSNumber *)self.dataArray[pokerPoints];
        //        [self.dataArray removeObjectAtIndex:pokerPoints];
        //        NSLog(@"🔴= %@", num.stringValue);
        
        NSNumber *num = (NSNumber *)self.dataArray.firstObject;
        [self.dataArray removeObjectAtIndex:0];
        self.pokerTotalNum--;
        
        if (i == 1) {
            player1 = num.integerValue;
        } else if (i == 2) {
            banker1 = num.integerValue;
        } else if (i == 3) {
            player2 = num.integerValue;
        } else if (i == 4) {
            banker2 = num.integerValue;
        }
        
        
        NSInteger tempPlayer1 = player1 >= 10 ? 0 : player1;
        NSInteger tempPlayer2 = player2 >= 10 ? 0 : player2;
        
        NSInteger tempBanker1 = banker1 >= 10 ? 0 : banker1;
        NSInteger tempBanker2 = banker2 >= 10 ? 0 : banker2;
        
        playerPointsNum = tempPlayer1 + tempPlayer2 >= 10 ? tempPlayer1 + tempPlayer2 - 10 : tempPlayer1 + tempPlayer2;
        bankerPointsNum = tempBanker1 + tempBanker2 >= 10 ? tempBanker1 + tempBanker2 - 10 : tempBanker1 + tempBanker2;
        
        if (i == 4) {
            if (playerPointsNum >= 8 ||  bankerPointsNum >= 8) {
                break;
            }
            if (playerPointsNum >= 6 && bankerPointsNum >= 6) {
                break;
            }
        } else if (i == 5) {
            if (playerPointsNum < 6) {
                player3 = num.stringValue;
            } else {
                if (bankerPointsNum < 6) {
                    banker3 = num.stringValue;
                    break;
                }
            }
            
            NSInteger tempPlayer3 = player3.integerValue >= 10 ? 0 : player3.integerValue;
            if (bankerPointsNum == 3 && tempPlayer3 == 8) {
                break;
            } else if (bankerPointsNum == 4 && (tempPlayer3 == 8 || tempPlayer3 == 9 || tempPlayer3 == 0 || tempPlayer3 == 1)) {
                break;
            } else if (bankerPointsNum == 5 && (tempPlayer3 == 8 || tempPlayer3 == 9 || tempPlayer3 == 0 || tempPlayer3 == 1 || tempPlayer3 == 2 || tempPlayer3 == 3)) {
                break;
            } else if (bankerPointsNum == 6 && (tempPlayer3 != 6 && tempPlayer3 != 7)) {
                break;
            }
        } else if (i == 6) {
            if (bankerPointsNum <= 6) {
                banker3 = num.stringValue;
            }
        }
    }
    
    
    NSInteger tempPlayer3 = player3.integerValue >= 10 ? 0 : player3.integerValue;
    NSInteger tempBanker3 = banker3.integerValue >= 10 ? 0 : banker3.integerValue;
    playerPointsNum = (playerPointsNum + tempPlayer3) >= 10 ? playerPointsNum + tempPlayer3 - 10 : playerPointsNum + tempPlayer3;
    bankerPointsNum = (bankerPointsNum + tempBanker3) >= 10 ? bankerPointsNum + tempBanker3 - 10 : bankerPointsNum + tempBanker3;
    
    NSMutableDictionary *dict =  [NSMutableDictionary dictionary];
    // 判断庄闲 输赢
    NSString *win;
    if (playerPointsNum < bankerPointsNum) {
        if (bankerPointsNum == 6) {  // super 6 幸运6
            win = @"🔴🔸";
            self.superSixCount++;
            [dict setObject:@(YES) forKey:@"isSuperSix"];
        } else {
            win = @"🔴";
        }
        [dict setObject:@(0) forKey:@"WinType"];
        self.bankerCount++;
    } else if (playerPointsNum > bankerPointsNum) {
        win = @"🅿️";
        self.playerCount++;
        [dict setObject:@(1) forKey:@"WinType"];
    } else {
        win = @"✅";
        self.tieCount++;
        [dict setObject:@(2) forKey:@"WinType"];
    }
    
    // 对子
    if (player1 == player2) {
        win = [NSString stringWithFormat:@"%@🔹", win];
        self.playerPairCount++;
        [dict setObject:@(YES) forKey:@"isPlayerPair"];
    }
    if (banker1 == banker2) {
        win = [NSString stringWithFormat:@"%@🔺", win];
        self.bankerPairCount++;
        [dict setObject:@(YES) forKey:@"isBankerPair"];
    }
    
    [dict setObject: [NSString stringWithFormat:@"%ld", player1] forKey:@"player1"];
    [dict setObject: [NSString stringWithFormat:@"%ld", player2] forKey:@"player2"];
    
    [dict setObject: player3 == nil ? @"" : player3 forKey:@"player3"];
    [dict setObject: [NSString stringWithFormat:@"%ld", banker1] forKey:@"banker1"];
    [dict setObject: [NSString stringWithFormat:@"%ld", banker2] forKey:@"banker2"];
    [dict setObject: banker3  == nil ? @"" : banker3 forKey:@"banker3"];
    [dict setObject: [NSString stringWithFormat:@"%ld", playerPointsNum] forKey:@"playerPointsNum"];
    [dict setObject: [NSString stringWithFormat:@"%ld", bankerPointsNum] forKey:@"bankerPointsNum"];
    [dict setObject: [NSString stringWithFormat:@"%ld", self.pokerCount] forKey:@"index"];
    
    
    [self.resultDataArray addObject:dict];
    
    NSLog(@"Player: %ld点 %ld  %ld  %@  - Banker: %ld点 %d  %ld  %@ =%@",playerPointsNum, player1, player2, player3.length > 0 ? player3 : @"",   bankerPointsNum, banker1, banker2, banker3.length > 0 ? banker3 : @"", win);
}


#pragma mark -  UITableView 初始化
- (UITableView *)tableView {
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kMarginHeight + 30 +5 + kTrendViewHeight +2 + 126, [[UIScreen mainScreen] bounds].size.width , [UIScreen mainScreen].bounds.size.height - (kMarginHeight + 30 +5 + kTrendViewHeight +2 + 126 +64)) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor yellowColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.rowHeight=100;   //设置每一行的高度
    }
    
    return _tableView;
}


#pragma mark - UITableViewDataSource
// //返回列表每个分组section拥有cell行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.resultDataArray.count;
}

// //配置每个cell，随着用户拖拽列表，cell将要出现在屏幕上时此方法会不断调用返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BaccaratCell *cell = [BaccaratCell cellWithTableView:tableView reusableId:@"BaccaratCell"];
    // 倒序
    cell.model = self.resultDataArray[self.resultDataArray.count - indexPath.row -1];
    return cell;
    
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 35;
}


@end
