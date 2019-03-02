//
//  BlackJackController.m
//  VVCollectProject
//
//  Created by 罗耀生 on 2019/2/27.
//  Copyright © 2019 Mike. All rights reserved.
//

#import "BlackJackController.h"


#define kLabelFontSize 12
#define kBtnFontSize 16
#define kBuyBtnHeight 38

@interface BlackJackController ()

// 数据
@property (nonatomic,strong) NSMutableArray *dataArray;
// 牌副数
@property (nonatomic,assign) NSInteger pokerNum;
// 牌张数
@property (nonatomic,assign) NSInteger perDeckNum;

// 牌的总张数
@property (nonatomic,assign) NSInteger pokerTotalNum;


@property (nonatomic,strong) UILabel *resultLabel;
// 闲家要牌爆率
@property (nonatomic,assign) CGFloat playerBurstRate;
// 庄家要牌爆率
@property (nonatomic,assign) CGFloat bankerBurstRate;

// 计算的爆率
@property (nonatomic, strong) UITextField *pokerPointsTextField;
// 牌张数
@property (nonatomic, strong) UITextField *perDeckNumTextField;


@property (nonatomic,assign) BOOL isBanker;

@end

@implementation BlackJackController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pokerNum = 8;
    [self initData];
    [self initUI];
    
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
    
}



#pragma mark - 算法
- (void)blackJackAlgorithm {
    //    NSInteger tempPlayer1 = player1 >= 10 ? 0 : player1;
    //    NSInteger tempPlayer2 = player2 >= 10 ? 0 : player2;
    
    //    1/13
    //
    //
    //    13
    //    12 +
    //
    //    1 2 3 4 5 6 7 8 9 10 11 12 13 > 10
    //
    //    13 - 9 = 4
    //
    //
    //    13/4
    //
    //    12 + x > 21
    //
    //    21 - 12 = 9
    //
    //    4/13 = 30.7%    爆率
    
}

- (void)bankerBurstRate:(NSInteger)num {

    NSInteger indexAA;
    for (NSInteger index = 0; index < 10000; index++) {
        indexAA = (arc4random() % self.perDeckNumTextField.text.integerValue) + 0;
    }
    
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    if (self.perDeckNumTextField.text.integerValue == 13) {
        [array addObjectsFromArray:@[@(1), @(2),@(3),@(4),@(5),@(6),@(7),@(8),@(9),@(10),@(10),@(10),@(10)]];
    } else {
        [array addObjectsFromArray:@[@(1), @(2),@(3),@(4),@(5),@(6),@(7),@(8),@(9),@(10),@(10),@(10)]];
    }
    
    
    // 洗牌
    for (NSInteger index = 1; index <= 10; index++) {
        int pokerIndexA = (arc4random() % self.perDeckNumTextField.text.integerValue) + 0;
        int pokerIndexB = (arc4random() % self.perDeckNumTextField.text.integerValue) + 0;
        
        [array exchangeObjectAtIndex:pokerIndexA withObjectAtIndex:pokerIndexB];
    }
    
    NSInteger xxNum  = num + [array[indexAA] integerValue];
    [self burstRate:xxNum];
}

- (void)burstRate:(NSInteger)num {
    CGFloat xx = 21 - num;
    // 爆率
    CGFloat rate = (self.perDeckNumTextField.text.integerValue -xx)/self.perDeckNumTextField.text.integerValue;
    self.playerBurstRate = rate;
}

#pragma mark - Player计算看看
- (void)onPlayerBtn {
    self.isBanker = NO;
    
    NSMutableArray *jjArray = [[NSMutableArray alloc] init];
    for (NSInteger j = 0; j < 1000; j++) {
        [self bankerBurstRate:self.pokerPointsTextField.text.integerValue];
        [jjArray addObject:[NSNumber numberWithFloat:self.playerBurstRate]];
    }

    CGFloat aaa;
    for (NSInteger index = 0; index < 1000; index++) {
        NSNumber *number = jjArray[index];
        aaa = aaa + number.floatValue;
    }
    self.playerBurstRate = aaa/1000;
    
    [self resultText];
}

#pragma mark - Banker计算看看
- (void)onBankerBtn {
    self.isBanker = YES;
    [self bankerBurstRate:self.pokerPointsTextField.text.integerValue];
    [self resultText];
}

- (void)resultText {
    
    self.resultLabel.text =  [NSString stringWithFormat:@"Player爆率 %0.2f", self.playerBurstRate];
}


//- (void)


#pragma mark - 计算打牌小牌
- (NSString *)xbxbxb:(NSInteger)card {
    
    NSString *result;
    NSInteger count = 0;
    
    if(card < 7 ){
        count++ ;
    } else if (card > 9){
        count--;
    }
    
    
    if(count <= 0){
        return [NSString stringWithFormat:@"%ld Hold", count];
    } else {
        return [NSString stringWithFormat:@"%ld Bet", count];
    }
    
    result = [NSString stringWithFormat:@"%ld", count];
    
    return result;
    
}







#pragma mark - 拿牌
- (void)hitMeth {
    
}


#pragma mark - 停牌
- (void)standMeth {
    
}

#pragma mark - 双倍下注
- (void)doubleMeth {
    
}





- (void)initUI {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITextField *perDeckNumTextField = [[UITextField alloc] init];
    perDeckNumTextField.text = @"13";
    perDeckNumTextField.keyboardType = UIKeyboardTypeNumberPad;
    perDeckNumTextField.textColor = [UIColor grayColor];
    perDeckNumTextField.layer.cornerRadius = 5;
    perDeckNumTextField.layer.borderColor = [UIColor grayColor].CGColor;
    perDeckNumTextField.layer.borderWidth = 1;
    _perDeckNumTextField = perDeckNumTextField;
    [self.view addSubview:perDeckNumTextField];
    
    [perDeckNumTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.top.mas_equalTo(self.view.mas_top).offset(60);
        make.size.mas_equalTo(CGSizeMake(60, 40));
    }];
    
    UITextField *pokerPointsTextField = [[UITextField alloc] init];
    pokerPointsTextField.text = @"15";
    pokerPointsTextField.keyboardType = UIKeyboardTypeNumberPad;
    pokerPointsTextField.textColor = [UIColor grayColor];
    pokerPointsTextField.layer.cornerRadius = 5;
    pokerPointsTextField.layer.borderColor = [UIColor grayColor].CGColor;
    pokerPointsTextField.layer.borderWidth = 1;
    _pokerPointsTextField = pokerPointsTextField;
    [self.view addSubview:pokerPointsTextField];
    
    [pokerPointsTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(perDeckNumTextField.mas_right).offset(20);
        make.top.mas_equalTo(self.view.mas_top).offset(60);
        make.size.mas_equalTo(CGSizeMake(60, 40));
    }];
    
    
    UIButton *playerBtn = [[UIButton alloc] init];
    [playerBtn setTitle:@"PLAYER" forState:UIControlStateNormal];
    playerBtn.titleLabel.font = [UIFont systemFontOfSize:kBtnFontSize];
    [playerBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [playerBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    playerBtn.backgroundColor = [UIColor colorWithRed:0.027 green:0.757 blue:0.376 alpha:1.000];
    playerBtn.layer.cornerRadius = 5;
    [playerBtn addTarget:self action:@selector(onPlayerBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:playerBtn];
    
    [playerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(pokerPointsTextField.mas_right).offset(10);
        make.centerY.mas_equalTo(pokerPointsTextField.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(70, kBuyBtnHeight));
    }];
    
    UIButton *bankerBtn = [[UIButton alloc] init];
    [bankerBtn setTitle:@"BANKER" forState:UIControlStateNormal];
    bankerBtn.titleLabel.font = [UIFont systemFontOfSize:kBtnFontSize];
    [bankerBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [bankerBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    bankerBtn.backgroundColor = [UIColor colorWithRed:0.027 green:0.757 blue:0.376 alpha:1.000];
    bankerBtn.layer.cornerRadius = 5;
    [bankerBtn addTarget:self action:@selector(onBankerBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bankerBtn];
    
    [bankerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(playerBtn.mas_right).offset(10);
        make.centerY.mas_equalTo(pokerPointsTextField.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(70, kBuyBtnHeight));
    }];
    
    UILabel *resultLabel = [[UILabel alloc] init];
    resultLabel.font = [UIFont systemFontOfSize:kLabelFontSize];
    //    pokerCountLabel.layer.borderWidth = 1;
    //    pokerCountLabel.layer.borderColor = [UIColor blueColor].CGColor;
    resultLabel.numberOfLines = 0;
    //    pokerCountLabel.text = @"结果";S
    resultLabel.textColor = [UIColor darkGrayColor];
    [self.view addSubview:resultLabel];
    _resultLabel = resultLabel;
    
    [resultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.top.mas_equalTo(pokerPointsTextField.mas_bottom).offset(10);
    }];
}

@end
