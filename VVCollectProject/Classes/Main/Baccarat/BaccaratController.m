//
//  BaccaratController.m
//  VVCollectProject
//
//  Created by Mike on 2019/2/20.
//  Copyright © 2019 Mike. All rights reserved.
//

#import "BaccaratController.h"

@interface BaccaratController ()

//
@property (nonatomic,strong) NSMutableArray *dataArray;
// 牌副数
@property (nonatomic,assign) NSInteger pokerNum;
// 牌总张数
@property (nonatomic,assign) NSInteger pokerTotal;
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
    
    self.pokerNum = 8 * 100000;
    
    [self opening];
}

#pragma mark -  开局
- (void)opening {
    [self initData];
    // 发牌局数
    for (NSInteger i = 1; i <= (self.pokerNum * 52 * 4); i++) {
        if (self.pokerTotal < 6) {
            break;
        }
        self.pokerCount++;
        [self oncePoker];
    }

    NSLog(@"\n发了%ld局\n剩余 %ld张牌\n闲赢%ld\n庄赢%ld\n闲对共%ld\n庄对共%ld\n幸运6共%ld\n和局共%ld", self.pokerCount, self.pokerTotal, self.playerCount, self.bankerCount, self.playerPairCount, self.bankerPairCount, self.superSixCount, self.tieCount);
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
    
    self.pokerTotal = self.dataArray.count;
    self.pokerCount = 0;
    self.playerCount = 0;
    self.bankerCount = 0;
    self.playerPairCount = 0;
    self.bankerPairCount = 0;
    self.superSixCount = 0;
    self.tieCount = 0;
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
        
        int pokerPoints = (arc4random() % self.pokerTotal) + 0;
        self.pokerTotal--;
        
        NSNumber *num = (NSNumber *)self.dataArray[pokerPoints];
        [self.dataArray removeObjectAtIndex:pokerPoints];
        //        NSLog(@"🔴= %@", num.stringValue);
        
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
    
    // 判断庄闲 输赢
    NSString *win;
    if (playerPointsNum < bankerPointsNum) {
        if (bankerPointsNum == 6) {  // super 6 幸运6
            win = @"🔴🔸";
            self.superSixCount++;
        } else {
            win = @"🔴";
        }
        self.bankerCount++;
    } else if (playerPointsNum > bankerPointsNum) {
        win = @"🅿️";
        self.playerCount++;
    } else {
        win = @"✅";
        self.tieCount++;
    }
    
    // 对子
    if (player1 == player2) {
        win = [NSString stringWithFormat:@"%@🔹", win];
        self.playerPairCount++;
    }
    if (banker1 == banker2) {
        win = [NSString stringWithFormat:@"%@🔺", win];
        self.bankerPairCount++;
    }
    
    NSLog(@"Player: %ld点 %ld  %ld  %@  - Banker: %ld点 %d  %ld  %@ =%@",playerPointsNum, player1, player2, player3.length > 0 ? player3 : @"",   bankerPointsNum, banker1, banker2, banker3.length > 0 ? banker3 : @"", win);
}


@end
