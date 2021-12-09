//
//  SuperAI.m
//  VVCollectProject
//
//  Created by Admin on 2021/12/10.
//  Copyright © 2021 Mike. All rights reserved.
//

#import "SuperAI.h"

@implementation SuperAI



- (CGFloat)getWinAllPlayerProb {
    float res = 1;
    for (int i = 0; i < self.activePlayers.count - 1; i++)
        res *= self.winProb;
    return res;
}


/*
 
 
 
 
 
 * 设置剩余筹码，剩余金币，玩家人数，自己的位置，当前局数
 * @param jetton
 * @param money
 
 public void setInitInfo(int jetton, int money, int playerNum,
 int position, int handNum, ArrayList<InitState> states) {
 self.totalJetton = jetton;
 self.totalMoney = money;
 if (self.playerNum != playerNum) {
 self.playerNum = playerNum;
 self.hasAllIn = false;
 }
 //        self.position = position;
 self.handNum = handNum;
 if (self.handNum == 1)
 self.initJetton = self.totalJetton + self.totalMoney;
 self.winProb = 0;
 self.holdPokers.clear();
 self.publicPokers.clear();
 self.activePlayers.clear();
 self.ainitStates = states;
 for (InitState state: self.ainitStates) {
 self.activePlayers.add(state.getPlayerID());
 }
 self.buttonID = self.activePlayers.get(0);
 if (self.buttonID.equals(self.playerID)) {
 self.isTheLastOne = true;
 }
 else {
 self.isTheLastOne = false;
 }
 self.isLastHalf = false;
 
 self.folded = false;
 
 self.betStates = null;
 }
 
 
 public void computeLastHalf() {
 if (self.isTheLastOne) {
 self.isLastHalf =  true;
 return ;
 }
 
 int count = 1;
 for (String player: self.activePlayers) {
 if (player.equals(self.playerID))
 break;
 if (!player.equals(self.buttonID))
 count ++;
 }
 if (count > self.activePlayers.size() / 2) {
 self.isLastHalf = true;
 return ;
 }
 self.isLastHalf = false;
 }
 
 
 
 
 
 public void setBetStates(ArrayList<BetState> states) {
 self.betStates = states;
 
 for (BetState state: states) {
 if (state.getAction().equals("fold"))
 self.activePlayers.remove(state.getPlayerID());
 }
 
 if (self.buttonID.equals(self.playerID)) {
 self.isTheLastOne = true;
 }
 else if (!self.activePlayers.get(0).equals(self.buttonID) &&
 self.activePlayers.get(self.activePlayers.size() - 1)
 .equals(self.playerID)) {
 self.isTheLastOne = true;
 }
 
 self.computeLastHalf();
 
 if (!self.hasAllIn && self.publicPokers.size() == 0) {
 for (BetState state: states) {
 if (state.getAction().equals("all_in")) {
 self.hasAllIn = true;
 break;
 }
 }
 }
 }
 
 
 
 */


-(int)getTotalMoneyAndJetton {
    return self.totalMoney + self.totalJetton;
}


#pragma mark -  玩家playerID需要下筹码为jet的盲注

/**
 * 玩家playerID需要下筹码为jet的盲注
 */
- (void)postBlind:(NSString *)playerID jet:(int)jet {
    if (self.playerID == playerID) {
        self.totalJetton -= jet;
    }
}

/**
 * 在发送下注策略之前必须通过该方法获得策略
 * @param diff
 * @param jetton
 * @return
 */
-(NSString *)getResponse:(int)diff jetton:(int)jetton {
    if (self.activePlayers.count == 1) {
        return @"check";
    }
    
    if(self.hasRaised && jetton > diff) {
        jetton = diff;
    }
    
    if (jetton == 0 && diff > 0) {
        return @"fold";
    }
    else if (jetton == 0 && diff == 0) {
        return @"check";
    }
    else if (jetton >= self.totalJetton) {
        self.totalJetton = 0;
        self.hasRaised = true;
        return @"all_in";
    }
    else if (jetton == diff) {
        self.totalJetton -= jetton;
        return @"call";
    }
    else if (jetton > diff) {
        //            Random random = new Random();
        //            int sum = jetton + (random.nextInt(5) + 1);
        //            self.totalJetton -= sum;
        //            self.setHasRaised(true);
        //            return @"raise " + (sum);
        
        return @"";
    } else {
        self.totalJetton -= diff;
        return @"call";
    }
}

/**
 * 添加两张底牌
 */
- (void)addHoldPokers:(Poker *)p1 p2:(Poker *)p2 {
    [self.holdPokers addObject: p1];
    [self.holdPokers addObject: p2];
    
    self.hasRaised = false;
}

/**
 * 发出两张底牌之后思考策略
 * @param betStates 各玩家的当前押注状态
 * @return 押注策略 "check|call|raise num|all_in|fold"
 */
//   public abstract String thinkAfterHold(
//           ArrayList<BetState> betStates);

/**
 * 添加三张公共牌
 */
- (void)addFlopPokers:(Poker *)p1 p2:(Poker *)p2 p3:(Poker *)p3 {
    [self.publicPokers addObject: p1];
    [self.publicPokers addObject: p2];
    [self.publicPokers addObject: p3];
    
    
    //        self.winProb = ProbabilityComputer.computeProbability(
    //                self.holdPokers, self.publicPokers);
    //
    self.hasRaised = false;
}

/**
 * 发出三张公共牌之后思考策略
 * @param betStates 各玩家的当前押注状态
 * @return 押注策略 "check|call|raise num|all_in|fold"
 */
//    public abstract String thinkAfterFlop(
//            ArrayList<BetState> betStates);

/**
 * 添加一张转牌
 */
- (void)addTurnPoker:(Poker *)p {
    [self.publicPokers addObject: p];
    //        self.winProb = ProbabilityComputer.computeProbability(
    //                self.holdPokers, self.publicPokers);
    
    self.hasRaised = false;
}

/**
 * 发出一张转牌之后思考策略
 * @param betStates 各玩家的当前押注状态
 * @return 押注策略 "check|call|raise num|all_in|fold"
 */
//    public abstract String thinkAfterTurn(
//            ArrayList<BetState> betStates);

/**
 * 添加一张河牌
 */
- (void)addRiverPoker:(Poker *)p {
    [self.publicPokers addObject: p];
    
    //        self.winProb = ProbabilityComputer.computeProbability(
    //                self.holdPokers, self.publicPokers);
    
    self.hasRaised = false;
}

/**
 * 发出一张河牌之后思考策略
 * @param betStates 各玩家的当前押注状态
 * @return 押注策略 "check|call|raise num|all_in|fold"
 */
//    public abstract String thinkAfterRiver(
//            ArrayList<BetState> betStates);

/**
 * 跟注
 *
 * @param diff
 * @param maxMultiple 最大可容忍跟注倍数
 * @return
 */
-(NSString *)callByDiff:(int)diff maxMultiple:(int)maxMultiple  {
    if (self.publicPokers.count == 0) {
        NSMutableArray<Poker *> *hp = self.holdPokers;
        if ([self isHoldBigPair:hp]) {
            if (hp[0].value >= 12)
                
                return [self getResponse:diff jetton:diff];
            else {
                if (diff >= self.totalJetton)
                    return [self getResponse:diff jetton:0];
                return [self getResponse:diff jetton:diff];
            }
        }
        
        if (diff > maxMultiple * self.blind)
            return [self getResponse:diff jetton:0];
        
        return [self getResponse:diff jetton:diff];
    }
    
    else if (self.publicPokers.count == 3) {
        float prob = [self getWinAllPlayerProb];
        
        if (prob < 0.10f) {
            return [self getResponse:diff jetton:0];
        }
        else if (prob < 0.50f) {
            if (diff > maxMultiple * self.blind)
                return [self getResponse:diff jetton:0];
            
            if (diff * 4 > self.totalJetton) {
                return [self getResponse:diff jetton:0];
            }
            
            if (diff > 6 * self.blind)
                return [self getResponse:diff jetton:0];
        }
        else if (prob < 0.75f) {
            if (diff > maxMultiple * self.blind)
                return [self getResponse:diff jetton:0];
            
            if (diff * 3 >= self.totalJetton) {
                return [self getResponse:diff jetton:0];
            }
            
            if (diff > 8 * self.blind)
                return [self getResponse:diff jetton:0];
        }
        else if (prob < 0.95f) {
            if (diff > maxMultiple * self.blind)
                return [self getResponse:diff jetton:0];
            
            if (diff * 2 >= self.totalJetton) {
                return [self getResponse:diff jetton:0];
            }
            
            if (diff > 10 * self.blind)
                return [self getResponse:diff jetton:0];
        }
        else if (prob < 0.98f) {
            if (diff > maxMultiple * self.blind)
                return [self getResponse:diff jetton:0];
            
            if (diff >= self.totalJetton) {
                return [self getResponse:diff jetton:0];
            }
            if (diff > 15 * self.blind)
                return [self getResponse:diff jetton:0];
        }
        else if (prob < 0.99f) {
            if (diff > maxMultiple * self.blind)
                return [self getResponse:diff jetton:0];
            
            if (diff >= self.totalJetton) {
                return [self getResponse:diff jetton:0];
            }
            if (diff > 30 * self.blind)
                return [self getResponse:diff jetton:0];
        }
        return [self getResponse:diff jetton:diff];
    }
    else if (self.publicPokers.count == 4) {
        float prob = [self getWinAllPlayerProb];
        
        if (prob < 0.20f) {
            return [self getResponse:diff jetton:0];
        }
        else if (prob < 0.50f) {
            if (diff > maxMultiple * self.blind)
                return [self getResponse:diff jetton:0];
            
            if (diff * 4 >= self.totalJetton) {
                return [self getResponse:diff jetton:0];
            }
            
            if (diff > 8 * self.blind)
                return [self getResponse:diff jetton:0];
        }
        else if (prob < 0.75f) {
            if (diff > maxMultiple * self.blind)
                return [self getResponse:diff jetton:0];
            
            if (diff * 3 >= [self getTotalMoneyAndJetton]) {
                return [self getResponse:diff jetton:0];
            }
            
            if (diff > 10 * self.blind)
                return [self getResponse:diff jetton:0];
        }
        else if (prob < 0.95f) {
            if (diff > maxMultiple * self.blind)
                return [self getResponse:diff jetton:0];
            
            if (diff * 2 >= self.totalJetton) {
                return [self getResponse:diff jetton:0];
            }
            
            if (diff > 15 * self.blind)
                return [self getResponse:diff jetton:0];
        }
        else if (prob < 0.97f) {
            if (diff > maxMultiple * self.blind)
                return [self getResponse:diff jetton:0];
            
            if (diff >= self.totalJetton) {
                return [self getResponse:diff jetton:0];
            }
            
            if (diff > 15 * self.blind)
                return [self getResponse:diff jetton:0];
        }
        else if (prob < 0.985f) {
            if (diff >= self.totalJetton) {
                return [self getResponse:diff jetton:0];
            }
            
            if (diff > 30 * self.blind)
                return [self getResponse:diff jetton:0];
        }
        return [self getResponse:diff jetton:diff];
    }
    else if (self.publicPokers.count == 5) {
        float prob = [self getWinAllPlayerProb];
        
        if (prob < 0.25f) {
            return [self getResponse:diff jetton:0];
        }
        else if (prob < 0.50f) {
            if (diff > maxMultiple * self.blind)
                return [self getResponse:diff jetton:0];
            
            if (diff * 4 >= self.totalJetton) {
                return [self getResponse:diff jetton:0];
            }
            
            if (diff > 5 * self.blind)
                return [self getResponse:diff jetton:0];
        }
        else if (prob < 0.80f) {
            if (diff > maxMultiple * self.blind)
                return [self getResponse:diff jetton:0];
            
            if (diff * 3 >= self.totalJetton) {
                return [self getResponse:diff jetton:0];
            }
            
            if (diff > 6 * self.blind)
                return [self getResponse:diff jetton:0];
        }
        else if (prob < 0.95f) {
            if (diff > maxMultiple * self.blind)
                return [self getResponse:diff jetton:0];
            
            if (diff * 2 > self.totalJetton) {
                return [self getResponse:diff jetton:0];
            }
            
            if (diff > 8 * self.blind)
                return [self getResponse:diff jetton:0];
        }
        else if (prob < 0.97f) {
            if (diff > maxMultiple * self.blind)
                return [self getResponse:diff jetton:0];
            
            if (diff >= self.totalJetton) {
                return [self getResponse:diff jetton:0];
            }
            
            if (diff > 12 * self.blind)
                return [self getResponse:diff jetton:0];
        }
        else if (prob < 0.985f) {
            if (diff >= self.totalJetton) {
                return [self getResponse:diff jetton:0];
            }
            
            if (diff > 50 * self.blind)
                return [self getResponse:diff jetton:0];
        }
        return [self getResponse:diff jetton:diff];
    }
    return [self getResponse:diff jetton:diff];
}

/**
 * 加注：加注金额为mutiple * blind
 *
 * @param diff
 *            根据前面玩家下注，需要跟注的最小数量
 * @param multiple
 * @param maxMultiple 最大可接受倍数
 * @return
 */
-(NSString *)raiseByDiff:(int)diff multiple:(int)multiple maxMultiple:(int)maxMultiple {
    // 本环节已经加过注，则选择跟注
    if (self.hasRaised)
        
        
        return [self callByDiff:diff maxMultiple:maxMultiple];
    
    if (self.publicPokers.count == 0) {
        NSMutableArray<Poker *> *hp = self.holdPokers;
        if ([self isHoldBigPair:hp]) {
            if (hp[0].value >= 12)
                
                return [self getResponse:diff jetton:multiple * self.blind];
            else {
                if (diff >= self.totalJetton)
                    return [self getResponse:diff jetton:0];
                return [self getResponse:diff jetton:multiple * self.blind];
            }
        }
        
        if (diff > maxMultiple * self.blind)
            return [self getResponse:diff jetton:0];
        
        return [self getResponse:diff jetton:multiple * self.blind];
    }
    else if (self.publicPokers.count == 3) {
        float prob = [self getWinAllPlayerProb];
        
        if (prob < 0.10f) {
            
            return [self getResponse:diff jetton:0];
        }
        else if (prob < 0.50f) {
            if (diff > maxMultiple * self.blind)
                return [self getResponse:diff jetton:0];
            
            if (diff * 4 >= self.totalJetton) {
                return [self getResponse:diff jetton:0];
            }
            
            if (diff > 5 * self.blind)
                return [self getResponse:diff jetton:0];
            
            multiple = 1;
        }
        else if (prob < 0.75f) {
            if (diff > maxMultiple * self.blind)
                return [self getResponse:diff jetton:0];
            
            if (diff * 3 >= self.totalJetton) {
                return [self getResponse:diff jetton:0];
            }
            
            if (diff > 6 * self.blind)
                return [self getResponse:diff jetton:0];
            
            multiple = 2;
        }
        else if (prob < 0.95f) {
            if (diff > maxMultiple * self.blind)
                return [self getResponse:diff jetton:0];
            
            if (diff * 2 > self.totalJetton) {
                return [self getResponse:diff jetton:0];
            }
            
            if (diff > 10 * self.blind)
                return [self getResponse:diff jetton:0];
        }
        else if (prob < 0.97f) {
            if (diff > maxMultiple * self.blind)
                return [self getResponse:diff jetton:0];
            
            if (diff >= self.totalJetton) {
                return [self getResponse:diff jetton:0];
            }
            
            if (diff > 25 * self.blind)
                return [self getResponse:diff jetton:0];
        }
        else if (prob < 0.985f) {
            if (diff > 50 * self.blind)
                return [self getResponse:diff jetton:0];
            
            if (diff >= self.totalJetton) {
                return [self getResponse:diff jetton:0];
            }
        }
        else {
            return [self getResponse:diff jetton:2 * multiple * self.blind];
        }
        return [self getResponse:diff jetton:multiple * self.blind];
    }
    else if (self.publicPokers.count == 4) {
        float prob = [self getWinAllPlayerProb];
        
        if (prob < 0.20f) {
            return [self getResponse:diff jetton:0];
        }
        else if (prob < 0.60f) {
            if (diff > maxMultiple * self.blind)
                return [self getResponse:diff jetton:0];
            
            if (diff * 4 > self.totalJetton) {
                return [self getResponse:diff jetton:0];
            }
            
            if (diff > 5 * self.blind)
                return [self getResponse:diff jetton:0];
            
            multiple = 1;
        }
        else if (prob < 0.80f) {
            if (diff > maxMultiple * self.blind)
                return [self getResponse:diff jetton:0];
            
            if (diff * 3 > self.totalJetton) {
                return [self getResponse:diff jetton:0];
            }
            
            if (diff > 6 * self.blind)
                return [self getResponse:diff jetton:0];
            
            multiple = 2;
        }
        else if (prob < 0.96f) {
            if (diff > maxMultiple * self.blind)
                return [self getResponse:diff jetton:0];
            
            if (diff * 3 > self.totalJetton) {
                return [self getResponse:diff jetton:0];
            }
            
            if (diff > 8 * self.blind)
                return [self getResponse:diff jetton:0];
            multiple = 3;
        }
        else if (prob < 0.97f) {
            if (diff > maxMultiple * self.blind)
                return [self getResponse:diff jetton:0];
            
            if (diff * 2 > self.totalJetton) {
                return [self getResponse:diff jetton:0];
            }
            
            if (diff > 20 * self.blind)
                return [self getResponse:diff jetton:0];
        }
        else if (prob < 0.985f) {
            if (diff >= self.totalJetton) {
                return [self getResponse:diff jetton:0];
            }
            
            if (diff > 50 * self.blind)
                return [self getResponse:diff jetton:0];
            
            return [self getResponse:diff jetton:2 * multiple * self.blind];
        }
        else {
            
            return [self getResponse:diff jetton:self.totalJetton];
        }
        return [self getResponse:diff jetton:multiple * self.blind];
    }
    else if (self.publicPokers.count == 5) {
        float prob = [self getWinAllPlayerProb];
        
        if (prob < 0.25f) {
            return [self getResponse:diff jetton:0];
        }
        else if (prob < 0.65f) {
            if (diff > maxMultiple * self.blind)
                return [self getResponse:diff jetton:0];
            
            if (diff * 4 > self.totalJetton) {
                return [self getResponse:diff jetton:0];
            }
            
            if (diff > 5 * self.blind)
                return [self getResponse:diff jetton:0];
            
            multiple = 1;
        }
        else if (prob < 0.85f) {
            if (diff > maxMultiple * self.blind)
                return [self getResponse:diff jetton:0];
            
            if (diff * 3 > self.totalJetton) {
                return [self getResponse:diff jetton:0];
            }
            
            if (diff > 8 * self.blind)
                return [self getResponse:diff jetton:0];
            
            multiple = 2;
        }
        else if (prob < 0.95f) {
            if (diff > maxMultiple * self.blind)
                return [self getResponse:diff jetton:0];
            
            if (diff * 3 > self.totalJetton) {
                return [self getResponse:diff jetton:0];
            }
            
            if (diff > 15 * self.blind)
                return [self getResponse:diff jetton:0];
            multiple = 3;
        }
        else if (prob < 0.97f) {
            if (diff > maxMultiple * self.blind)
                return [self getResponse:diff jetton:0];
            
            if (diff * 2 >= self.totalJetton) {
                return [self getResponse:diff jetton:0];
            }
            
            if (diff > 20 * self.blind)
                return [self getResponse:diff jetton:0];
        }
        else if (prob < 0.985f) {
            if (diff >= 55 * self.blind)
                return [self getResponse:diff jetton:0];
            
            if (diff >= self.totalJetton) {
                return [self getResponse:diff jetton:0];
            }
            
            if (diff > 50 * self.blind)
                return [self getResponse:diff jetton:0];
            
            return [self getResponse:diff jetton:2 * multiple * self.blind];
        }
        else if (prob < 0.99f) {
            
            return [self getResponse:diff jetton:3 * multiple * self.blind];
        }
        else {
            return [self getResponse:diff jetton:self.totalJetton];
        }
    }
    return [self getResponse:diff jetton:multiple * self.blind];
}

/**
 * 判断手牌是否是大对：AA, KK, QQ, JJ, 1010等
 *
 * @param hp
 *            手牌
 * @return 大对返回true, 否则返回false
 */
- (BOOL)isHoldBigPair:(NSArray<Poker *> *)hp {
    // 避免出错
    if (hp == nil || hp.count < 2)
        return false;
    // 手牌是大对：AA, KK, QQ, JJ, 1010等
    else if (hp[0].value == hp[1].value
             && hp[0].value >= MORE_GAP_VALUE)
        return true;
    return false;
}





@end
