//
//  BaccaratController.m
//  VVCollectProject
//
//  Created by 罗耀生 on 2019/2/20.
//  Copyright © 2019 Mike. All rights reserved.
//

#import "BaccaratController.h"

@interface BaccaratController ()

//
@property (nonatomic,strong) NSMutableArray *dataArray;
// 牌总张数
@property (nonatomic,assign) NSInteger pokerTotal;


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
    NSDictionary *dict = @{
                           @"PokerColor":@"spade",
                           @"heart":@"",
                           };
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
//      int pokerNum = (arc4random() % 7) + 0;
    
    
    
    
    
    
    self.pokerTotal = 415;

    
    
    for (NSInteger i = 0; i < 100; i++) {
        [self oncePoker];
    }
    
    
    
    
}

- (void)oncePoker {
    
    NSInteger player1 = 0;
    NSInteger player2 = 0;
    NSInteger player3 = 0;
    
    NSInteger banker1 = 0;
    NSInteger banker2 = 0;
    NSInteger banker3 = 0;
    
    NSInteger playerNum = 0;
    NSInteger bankerNum = 0;
    
    for (NSInteger i = 1; i <= 4; i++) {
        
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
        
        playerNum = tempPlayer1 + tempPlayer2 >= 10 ? 0 : tempPlayer1 + tempPlayer2;
        bankerNum = tempBanker1 + tempBanker2 >= 10 ? 0 : tempBanker1 + tempBanker2;
        
        if (playerNum >= 8 ||  bankerNum >= 8) {
//            break;
        }
        
        
        
//        if (i == 5) {
//
//        } else if (i == 6) {
//            break;
//        }
    }
    
    NSString *win;
    if (playerNum < bankerNum) {
        if (bankerNum == 6) {
            win = @"🔴🌕";
        } else {
            win = @"🔴";
        }
        
    } else if (playerNum > bankerNum) {
        win = @"🅿️";
    } else {
        win = @"✅";
    }
    
    NSLog(@"Player: %d点 %d  %d  - Banker: %d点 %d  %d =%@",playerNum, player1, player2,bankerNum, banker1, banker2, win);
}


@end
