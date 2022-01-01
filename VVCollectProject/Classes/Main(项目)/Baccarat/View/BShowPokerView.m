//
//  BShowPokerView.m
//  VVCollectProject
//
//  Created by Admin on 2021/12/17.
//  Copyright © 2021 Mike. All rights reserved.
//

#import "BShowPokerView.h"
#import "BPockerView.h"

@interface BShowPokerView ()

// *** 闲 ***
@property (nonatomic, strong) BPockerView *player_pk1;
@property (nonatomic, strong) BPockerView *player_pk2;
@property (nonatomic, strong) BPockerView *player_pk3;

@property(nonatomic,assign) BOOL isPlayer3;
@property (nonatomic, strong) UILabel *playerTotalPointsLabel;


/// player 2张牌点数
@property (nonatomic, assign) NSInteger player2TotalPoints;

// *** 庄 ***
@property (nonatomic, strong) BPockerView *banker_pk1;
@property (nonatomic, strong) BPockerView *banker_pk2;
@property (nonatomic, strong) BPockerView *banker_pk3;

@property(nonatomic,assign) BOOL isBanker3;
@property (nonatomic, strong) UILabel *bankerTotalPointsLabel;

/// banker 2张牌点数
@property (nonatomic, assign) NSInteger banker2TotalPoints;

@property (nonatomic, strong) UILabel *winTypeLabel;
// *** 其它 ***

// 记录翻第几张牌
@property(nonatomic,assign)NSInteger index;
// 动画时间
@property(nonatomic,assign)CGFloat duration;

@end

@implementation BShowPokerView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initData];
        [self createUI];
    }
    return self;
}
- (void)initData {
    _duration = 0.5;
    self.index = 1;
    
}

- (void)setResultModel:(BaccaratResultModel *)resultModel {
    _resultModel = resultModel;
    
    // 移除全部子视图
    //    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    self.index = 1;
    
    self.player2TotalPoints = 0;
    self.banker2TotalPoints = 0;
    
    for (NSInteger index = 0; index < resultModel.playerArray.count; index++) {
        PokerCardModel *model = resultModel.playerArray[index];
        if (index == 0) {
            self.player_pk1.hidden = NO;
            self.player_pk1.imgview2.image = [UIImage imageNamed:model.pokerImg];
            self.player2TotalPoints = (self.player2TotalPoints + model.bCardValue) % 10;
        } else if (index == 1) {
            self.player_pk2.hidden = NO;
            self.player_pk2.imgview2.image = [UIImage imageNamed:model.pokerImg];
            self.player2TotalPoints = (self.player2TotalPoints + model.bCardValue) % 10;
        } else {
            self.isPlayer3 = YES;
            self.player_pk3.imgview2.image = [UIImage imageNamed:model.pokerImg];
        }
    }
    
    for (NSInteger index = 0; index < resultModel.bankerArray.count; index++) {
        PokerCardModel *model = resultModel.bankerArray[index];
        if (index == 0) {
            self.banker_pk1.hidden = NO;
            self.banker_pk1.imgview2.image = [UIImage imageNamed:model.pokerImg];
            self.banker2TotalPoints = (self.banker2TotalPoints + model.bCardValue) % 10;
        } else if (index == 1) {
            self.banker_pk2.hidden = NO;
            self.banker_pk2.imgview2.image = [UIImage imageNamed:model.pokerImg];
            self.banker2TotalPoints = (self.banker2TotalPoints + model.bCardValue) % 10;
        } else {
            self.isBanker3 = YES;
            self.banker_pk3.imgview2.image = [UIImage imageNamed:model.pokerImg];
        }
    }
    
    [self performSelector:@selector(delayedExecutionFlop) withObject:nil afterDelay:.5f];
    
}

- (void)delayedExecutionFlop {
    // 执行翻牌动画
    [self executeAnimation];
}

// 执行动画
- (void)executeAnimation {
    // 根据tag值取到扑克牌
    BPockerView *pocker = [self viewWithTag:2000+ self.index];
    
    if (pocker) {
        [self rotateWithView:pocker];
    }
    
    if (self.index >= 4) {
        // 延时执行显示点数
        //        [self performSelector:@selector(showPointsMethod) withObject:nil afterDelay:0.1f];
        [self showPointsMethod];
    }
}



- (void)delayAction2 {
    
    if (self.index <= 4) {
        self.index++;
    }
    
    if (self.index < 5) {
        [self executeAnimation];
    }
    
    if (self.index == 4) {
        
        if (self.isPlayer3) {
            // 延时执行翻牌
            [self performSelector:@selector(delayedExecutionPlayer3Flop) withObject:nil afterDelay:1.0f];
        }
        
        if (!self.isPlayer3 && self.isBanker3) {
            // 延时执行翻牌
            [self performSelector:@selector(delayedExecutionBanker3Flop) withObject:nil afterDelay:1.0f];
        }
    }
}


- (void)delayedExecutionPlayer3Flop {
    self.player_pk3.hidden = NO;
    self.index = 5;
    [self performSelector:@selector(delayedExecutionFlop) withObject:nil afterDelay:.5f];
    
    if (self.isBanker3) {
        // 延时执行翻牌
        [self performSelector:@selector(delayedExecutionBanker3Flop) withObject:nil afterDelay:1.0f];
    }
}
- (void)delayedExecutionBanker3Flop {
    self.banker_pk3.hidden = NO;
    self.index = 6;
    [self performSelector:@selector(delayedExecutionFlop) withObject:nil afterDelay:.5f];
}

/// 显示点数发方法
- (void)showPointsMethod {
    if (self.index == 4 && self.resultModel.pokerTotalNum > 4) {
        self.playerTotalPointsLabel.text = [NSString stringWithFormat:@"%ld",self.player2TotalPoints];
        self.bankerTotalPointsLabel.text = [NSString stringWithFormat:@"%ld",self.banker2TotalPoints];
        return;
    }
    
    if (self.isPlayer3 && self.isBanker3 && self.index == 5) {
        // 有6张牌 第5张牌 先进入这里
        // 优化 这里先显示闲的点数
        [self performSelector:@selector(setPlayer5Points) withObject:nil afterDelay:1.5f];
        
    } else if (!self.isPlayer3 && self.isBanker3 && self.index-1 == self.resultModel.pokerTotalNum) {
        // 庄5 庄是最后一张牌
        [self performSelector:@selector(setResultPoints) withObject:nil afterDelay:1.0f];
    } else if (self.index == self.resultModel.pokerTotalNum) {
        // 4张牌或者6张牌 结束 最后一张牌
        [self performSelector:@selector(setResultPoints) withObject:nil afterDelay:1.0f];
    }
}

- (void)setPlayer5Points {
    self.playerTotalPointsLabel.text = [NSString stringWithFormat:@"%ld",self.resultModel.playerTotalPoints];
}


#pragma mark -  设置点数
- (void)setResultPoints {
    self.playerTotalPointsLabel.text = [NSString stringWithFormat:@"%ld",self.resultModel.playerTotalPoints];
    self.bankerTotalPointsLabel.text = [NSString stringWithFormat:@"%ld",self.resultModel.bankerTotalPoints];
    self.winTypeLabel.text = [self getWinType:self.resultModel.winType];
    
    if ([self.delegate respondsToSelector:@selector(endFlop)]) {
        [self.delegate endFlop];
    }
}


// 延时方法
- (void)delayAction:(UIView *)view {
    [self bringSubviewToFront:view];
}
// 翻牌方法
- (void)rotateWithView:(BPockerView *)view {
    
    [self performSelector:@selector(delayAction:) withObject:view afterDelay:_duration / 2];
    [self performSelector:@selector(delayAction2) withObject:nil afterDelay:_duration];
    [UIView beginAnimations:@"aa" context:nil];
    [UIView setAnimationDuration:_duration];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [view.imgview1 removeFromSuperview];
    [view addSubview:view.imgview2];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:view cache:NO];
    [UIView commitAnimations];
}










/// 移除视图
- (void)removeStackView {
    
    self.index = 1;
    self.isPlayer3 = NO;
    self.isBanker3 = NO;
    
    // 移除全部子视图
    [self.player_pk1.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.player_pk2.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.player_pk3.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    [self.banker_pk1.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.banker_pk2.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.banker_pk3.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    [self.player_pk1 addSubview:self.player_pk1.imgview1];
    [self.player_pk2 addSubview:self.player_pk2.imgview1];
    [self.player_pk3 addSubview:self.player_pk3.imgview1];
    
    [self.banker_pk1 addSubview:self.banker_pk1.imgview1];
    [self.banker_pk2 addSubview:self.banker_pk2.imgview1];
    [self.banker_pk3 addSubview:self.banker_pk3.imgview1];
    
    self.player_pk1.hidden = YES;
    self.player_pk2.hidden = YES;
    self.player_pk3.hidden = YES;
    
    self.banker_pk1.hidden = YES;
    self.banker_pk2.hidden = YES;
    self.banker_pk3.hidden = YES;
    
    //    //依次遍历self.view中的所有子视图
    //    for (id tmpView in self.player_pk1.subviews) {
    //        //找到要删除的子视图的对象
    //        if([tmpView isKindOfClass:[UIImageView class]]) {
    //            UIImageView *imgView = (UIImageView *)tmpView;
    //            if(imgView.tag == 1)   //判断是否满足自己要删除的子视图的条件
    //            {
    //                [imgView removeFromSuperview]; //删除子视图
    //                break;  //跳出for循环，因为子视图已经找到，无须往下遍历
    //            }
    //        }
    //    }
    
    self.playerTotalPointsLabel.text = @"";
    self.bankerTotalPointsLabel.text = @"";
    self.winTypeLabel.text = @"";
    //    [self stopTimer];
}








- (NSString *)getWinType:(WinType)winType {
    NSString *str = nil;
    switch (winType) {
        case WinType_Banker: {
            str = @"Banker Win";
            self.winTypeLabel.textColor = [UIColor redColor];
        }
            
            break;
        case WinType_Player: {
            str = @"Player Win";
            self.winTypeLabel.textColor = [UIColor blueColor];
        }
            
            break;
        default: {
            str = @"TIE";
            self.winTypeLabel.textColor = [UIColor greenColor];
        }
            
            break;
    }
    return str;
}



- (void)createUI {
    
    BPockerView *player_pk1 = [[BPockerView alloc] initWithFrame:CGRectMake(120, 0, 55, 70)];
    player_pk1.tag = 2000 + 1;
    player_pk1.hidden = YES;
    [self addSubview:player_pk1];
    _player_pk1 = player_pk1;
    
    BPockerView *player_pk2 = [[BPockerView alloc] initWithFrame:CGRectMake(60, 0, 55, 70)];
    player_pk2.tag = 2000 + 3;
    player_pk2.hidden = YES;
    [self addSubview:player_pk2];
    _player_pk2 = player_pk2;
    
    BPockerView *player_pk3 = [[BPockerView alloc] initWithFrame:CGRectMake(0, 0, 55, 70)];
    player_pk3.tag = 2000 + 5;
    player_pk3.hidden = YES;
    [self addSubview:player_pk3];
    _player_pk3 = player_pk3;
    
    BPockerView *banker_pk1 = [[BPockerView alloc] initWithFrame:CGRectMake(200+0, 0, 55, 70)];
    banker_pk1.tag = 2000 + 2;
    banker_pk1.hidden = YES;
    [self addSubview:banker_pk1];
    _banker_pk1 = banker_pk1;
    
    BPockerView *banker_pk2 = [[BPockerView alloc] initWithFrame:CGRectMake(200+60, 0, 55, 70)];
    banker_pk2.tag = 2000 + 4;
    banker_pk2.hidden = YES;
    [self addSubview:banker_pk2];
    _banker_pk2 = banker_pk2;
    
    BPockerView *banker_pk3 = [[BPockerView alloc] initWithFrame:CGRectMake(200+120, 0, 55, 70)];
    banker_pk3.tag = 2000 + 6;
    banker_pk3.hidden = YES;
    [self addSubview:banker_pk3];
    _banker_pk3 = banker_pk3;
    
    
    UILabel *playerTotalPointsLabel = [[UILabel alloc] init];
    playerTotalPointsLabel.text = @"";
    playerTotalPointsLabel.font = [UIFont boldSystemFontOfSize:36];
    playerTotalPointsLabel.textColor = [UIColor blueColor];
    playerTotalPointsLabel.alpha = 0.5;
    playerTotalPointsLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:playerTotalPointsLabel];
    _playerTotalPointsLabel = playerTotalPointsLabel;
    
    [playerTotalPointsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.player_pk1.mas_bottom).offset(0);
        make.centerX.equalTo(self.player_pk2.mas_centerX).offset(0);
    }];
    
    UILabel *bankerTotalPointsLabel = [[UILabel alloc] init];
    bankerTotalPointsLabel.text = @"";
    bankerTotalPointsLabel.font = [UIFont boldSystemFontOfSize:36];
    bankerTotalPointsLabel.textColor = [UIColor redColor];
    bankerTotalPointsLabel.alpha = 0.5;
    bankerTotalPointsLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:bankerTotalPointsLabel];
    _bankerTotalPointsLabel = bankerTotalPointsLabel;
    
    [bankerTotalPointsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.banker_pk1.mas_bottom).offset(0);
        make.centerX.equalTo(self.banker_pk2.mas_centerX).offset(0);
    }];
    
    
    UILabel *winTypeLabel = [[UILabel alloc] init];
    winTypeLabel.text = @"";
    winTypeLabel.font = [UIFont boldSystemFontOfSize:20];
    winTypeLabel.textColor = [UIColor blueColor];
    winTypeLabel.alpha = 0.7;
    winTypeLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:winTypeLabel];
    _winTypeLabel = winTypeLabel;
    
    [winTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.playerTotalPointsLabel.mas_centerY).offset(0);
        make.centerX.equalTo(self.mas_centerX);
    }];
}


@end



