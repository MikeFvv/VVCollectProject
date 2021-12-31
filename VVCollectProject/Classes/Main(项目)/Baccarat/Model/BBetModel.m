//
//  BBetModel.m
//  VVCollectProject
//
//  Created by Admin on 2021/12/26.
//  Copyright © 2021 Mike. All rights reserved.
//

#import "BBetModel.h"

@implementation BBetModel

- (NSInteger)total_bet_money {
    _total_bet_money = self.playerPair_money + self.tie_money + self.superSix_money + self.bankerPair_money + self.player_money + self.banker_money;
    return _total_bet_money;
}


- (NSInteger)winLose_money {
    _winLose_money = self.total_winLose_money - self.total_bet_money;
    return _winLose_money;
}
@end
