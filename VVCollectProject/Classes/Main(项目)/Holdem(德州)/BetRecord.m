//
//  BetRecord.m
//  VVCollectProject
//
//  Created by Admin on 2021/12/10.
//  Copyright © 2021 Mike. All rights reserved.
//

#import "BetRecord.h"

@implementation BetRecord

- (void)BetRecord:(NSString *)playerID position:(NSInteger)position jetton:(CGFloat)jetton {
    self.playerID = playerID;
    self.position = position;
    self.jetton = jetton;
}

- (void)setHoldState:(NSString *)holdType holdStrategy:(CGFloat)holdStrategy {
    self.holdType = holdType;
    self.holdStrategy = holdStrategy;
}

- (void)setFlopState:(NSString *)flopType flopStrategy:(CGFloat)flopStrategy {
    self.flopType = flopType;
    self.flopStrategy = flopStrategy;
}

- (void)setTurnState:(NSString *)turnType turnStrategy:(CGFloat)turnStrategy {
    self.turnType = turnType;
    self.turnStrategy = turnStrategy;
}

- (void)setRiverState:(NSString *)riverType riverStrategy:(CGFloat)riverStrategy {
    self.riverType = riverType;
    self.riverStrategy = riverStrategy;
}
    
    


@end
