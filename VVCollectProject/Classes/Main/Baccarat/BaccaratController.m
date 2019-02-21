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
// 牌总张数
@property (nonatomic,assign) NSInteger pokerTotal;
// 牌局数
@property (nonatomic,assign) NSInteger pokerCount;

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

//    4种
//    1 2 3 4 5 6 7 8 9 10 11 12 13
//    A 2 3 4 5 6 7 8 9 10 L Q K

    NSArray *array = @[ @(1),@(2),@(3),@(4),@(5),@(6),@(7),@(8),@(9),@(10),@(11),@(12),@(13),
                       @(1),@(2),@(3),@(4),@(5),@(6),@(7),@(8),@(9),@(10),@(11),@(12),@(13),
                       @(1),@(2),@(3),@(4),@(5),@(6),@(7),@(8),@(9),@(10),@(11),@(12),@(13),
                       @(1),@(2),@(3),@(4),@(5),@(6),@(7),@(8),@(9),@(10),@(11),@(12),@(13),
                        
                       @(1),@(2),@(3),@(4),@(5),@(6),@(7),@(8),@(9),@(10),@(11),@(12),@(13),
                       @(1),@(2),@(3),@(4),@(5),@(6),@(7),@(8),@(9),@(10),@(11),@(12),@(13),
                       @(1),@(2),@(3),@(4),@(5),@(6),@(7),@(8),@(9),@(10),@(11),@(12),@(13),
                       @(1),@(2),@(3),@(4),@(5),@(6),@(7),@(8),@(9),@(10),@(11),@(12),@(13),
                        
                        @(1),@(2),@(3),@(4),@(5),@(6),@(7),@(8),@(9),@(10),@(11),@(12),@(13),
                        @(1),@(2),@(3),@(4),@(5),@(6),@(7),@(8),@(9),@(10),@(11),@(12),@(13),
                        @(1),@(2),@(3),@(4),@(5),@(6),@(7),@(8),@(9),@(10),@(11),@(12),@(13),
                        @(1),@(2),@(3),@(4),@(5),@(6),@(7),@(8),@(9),@(10),@(11),@(12),@(13),
                        
                        @(1),@(2),@(3),@(4),@(5),@(6),@(7),@(8),@(9),@(10),@(11),@(12),@(13),
                        @(1),@(2),@(3),@(4),@(5),@(6),@(7),@(8),@(9),@(10),@(11),@(12),@(13),
                        @(1),@(2),@(3),@(4),@(5),@(6),@(7),@(8),@(9),@(10),@(11),@(12),@(13),
                        @(1),@(2),@(3),@(4),@(5),@(6),@(7),@(8),@(9),@(10),@(11),@(12),@(13),
                        
                        @(1),@(2),@(3),@(4),@(5),@(6),@(7),@(8),@(9),@(10),@(11),@(12),@(13),
                        @(1),@(2),@(3),@(4),@(5),@(6),@(7),@(8),@(9),@(10),@(11),@(12),@(13),
                        @(1),@(2),@(3),@(4),@(5),@(6),@(7),@(8),@(9),@(10),@(11),@(12),@(13),
                        @(1),@(2),@(3),@(4),@(5),@(6),@(7),@(8),@(9),@(10),@(11),@(12),@(13),
                        
                        @(1),@(2),@(3),@(4),@(5),@(6),@(7),@(8),@(9),@(10),@(11),@(12),@(13),
                        @(1),@(2),@(3),@(4),@(5),@(6),@(7),@(8),@(9),@(10),@(11),@(12),@(13),
                        @(1),@(2),@(3),@(4),@(5),@(6),@(7),@(8),@(9),@(10),@(11),@(12),@(13),
                        @(1),@(2),@(3),@(4),@(5),@(6),@(7),@(8),@(9),@(10),@(11),@(12),@(13),
                        
                        @(1),@(2),@(3),@(4),@(5),@(6),@(7),@(8),@(9),@(10),@(11),@(12),@(13),
                        @(1),@(2),@(3),@(4),@(5),@(6),@(7),@(8),@(9),@(10),@(11),@(12),@(13),
                        @(1),@(2),@(3),@(4),@(5),@(6),@(7),@(8),@(9),@(10),@(11),@(12),@(13),
                        @(1),@(2),@(3),@(4),@(5),@(6),@(7),@(8),@(9),@(10),@(11),@(12),@(13),
                        
                        @(1),@(2),@(3),@(4),@(5),@(6),@(7),@(8),@(9),@(10),@(11),@(12),@(13),
                        @(1),@(2),@(3),@(4),@(5),@(6),@(7),@(8),@(9),@(10),@(11),@(12),@(13),
                        @(1),@(2),@(3),@(4),@(5),@(6),@(7),@(8),@(9),@(10),@(11),@(12),@(13),
                        @(1),@(2),@(3),@(4),@(5),@(6),@(7),@(8),@(9),@(10),@(11),@(12),@(13) ];
    
    
    self.dataArray = [NSMutableArray arrayWithArray:array];
    self.pokerTotal = 416;
    self.pokerCount = 0;
    
    
    for (NSInteger i = 1; i <= 100; i++) {
        if (self.pokerTotal < 6) {
            break;
        }
        self.pokerCount++;
        [self oncePoker];
    }
    
    NSLog(@"发了%ld局 / 剩余 %ld 张牌", self.pokerCount, self.pokerTotal);
}

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
    NSInteger playerNum = 0;
    NSInteger bankerNum = 0;
    
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
        
        playerNum = tempPlayer1 + tempPlayer2 >= 10 ? tempPlayer1 + tempPlayer2 - 10 : tempPlayer1 + tempPlayer2;
        bankerNum = tempBanker1 + tempBanker2 >= 10 ? tempBanker1 + tempBanker2 - 10 : tempBanker1 + tempBanker2;
        
        if (i == 4) {
            if (playerNum >= 8 ||  bankerNum >= 8) {
                break;
            }
            if (playerNum >= 6 && bankerNum > 6) {
                break;
            }
        } else if (i == 5) {
            if (playerNum < 6) {
                player3 = num.stringValue;
            } else {
                if (bankerNum < 6) {
                    banker3 = num.stringValue;
                    break;
                }
            }
            
            NSInteger tempPlayer3 = player3.integerValue >= 10 ? 0 : player3.integerValue;
            if (bankerNum == 3 && tempPlayer3 == 8) {
                break;
            } else if (bankerNum == 4 && (tempPlayer3 == 8 || tempPlayer3 == 9 || tempPlayer3 == 0 || tempPlayer3 == 1)) {
                break;
            } else if (bankerNum == 5 && (tempPlayer3 == 8 || tempPlayer3 == 9 || tempPlayer3 == 0 || tempPlayer3 == 1 || tempPlayer3 == 2 || tempPlayer3 == 3)) {
                break;
            } else if (bankerNum == 6 && (tempPlayer3 != 6 || tempPlayer3 != 7)) {
                break;
            }
        } else if (i == 6) {
            if (bankerNum <= 6) {
                banker3 = num.stringValue;
            }
        }
    }
    
    
    NSInteger tempPlayer3 = player3.integerValue >= 10 ? 0 : player3.integerValue;
    NSInteger tempBanker3 = banker3.integerValue >= 10 ? 0 : banker3.integerValue;
    playerNum = (playerNum + tempPlayer3) >= 10 ? playerNum + tempPlayer3 - 10 : playerNum + tempPlayer3;
    bankerNum = (bankerNum + tempBanker3) >= 10 ? bankerNum + tempBanker3 - 10 : bankerNum + tempBanker3;
    
    // 判断庄闲 输赢
    NSString *win;
    if (playerNum < bankerNum) {
        if (bankerNum == 6) {  // Lucky 6 幸运6
            win = @"🔴🔸";
        } else {
            win = @"🔴";
        }
        
    } else if (playerNum > bankerNum) {
        win = @"🅿️";
    } else {
        win = @"✅";
    }
//    🔵 💚
    // 对子
    if (player1 == player2) {
        win = [NSString stringWithFormat:@"%@🔹", win];
    }
    if (banker1 == banker2) {
        win = [NSString stringWithFormat:@"%@🔺", win];
    }
    
    NSLog(@"Player: %d点 %d  %d  %@  - Banker: %d点 %d  %d  %@ =%@",playerNum, player1, player2, player3.length > 0 ? player3 : @"",   bankerNum, banker1, banker2, banker3.length > 0 ? banker3 : @"", win);
}


@end
