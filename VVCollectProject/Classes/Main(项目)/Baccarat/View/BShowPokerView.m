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
@property (nonatomic, strong) UIView *playerBackView;
@property (nonatomic, strong) UIView *player3BackView;
@property (nonatomic, strong) UIStackView *playerStackView;


@property (nonatomic, strong) BPockerView *player_pk1;
@property (nonatomic, strong) BPockerView *player_pk2;
@property (nonatomic, strong) BPockerView *player_pk3;

// *** 庄 ***
@property (nonatomic, strong) UIView *bankerBackView;
@property (nonatomic, strong) UIView *banker3BackView;
@property (nonatomic, strong) UIStackView *bankerStackView;

@property (nonatomic, strong) BPockerView *banker_pk1;
@property (nonatomic, strong) BPockerView *banker_pk2;
@property (nonatomic, strong) BPockerView *banker_pk3;

// *** 其它 ***
/// 定时器
@property (nonatomic, strong) NSTimer *dealerTimer;


@property (nonatomic, strong) UILabel *playerTotalPointsLabel;
@property (nonatomic, strong) UILabel *bankerTotalPointsLabel;
@property (nonatomic, strong) UILabel *winTypeLabel;

// 记录翻第几张牌
@property(nonatomic,assign)NSInteger index;
// 记录翻第几张牌
@property(nonatomic,assign)NSInteger bankerIndex;
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
    _index = 0;
    _bankerIndex = 0;
    
}

- (void)setResultModel:(BaccaratResultModel *)resultModel {
    _resultModel = resultModel;
    
    // 移除全部子视图
//    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    _index = 0;
    _bankerIndex = 0;
    
    BOOL isPlayerHave3 = NO;
    for (NSInteger index = 0; index < resultModel.playerArray.count; index++) {
        PokerCardModel *model = resultModel.playerArray[index];
        
//        if (index == 2) {
//            isPlayerHave3 = YES;
//            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//            dict[@"model"] = model;
//            [self performSelector:@selector(repeatDelayPlayer:) withObject:dict afterDelay:1.0f];
//
//        } else {
//            [self playerDealerDisplayView:model];
//        }
        if (index == 0) {
            self.player_pk1.imgview2.image = [UIImage imageNamed:model.pokerImg];
        } else if (index == 1) {
            self.player_pk2.imgview2.image = [UIImage imageNamed:model.pokerImg];
        } else {
            self.player_pk3.imgview2.image = [UIImage imageNamed:model.pokerImg];
        }
    }
    
    for (NSInteger index = 0; index < resultModel.bankerArray.count; index++) {
        PokerCardModel *model = resultModel.bankerArray[index];
//        if (index == 2) {
//            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//            dict[@"model"] = model;
//            [self performSelector:@selector(repeatDelayBanker:) withObject:dict afterDelay: isPlayerHave3 ? 2.0 : 1.0f];
//
//        } else {
//            [self bankerDealerDisplayView:model];
//        }
        
        if (index == 0) {
            self.banker_pk1.imgview2.image = [UIImage imageNamed:model.pokerImg];
        } else if (index == 1) {
            self.banker_pk2.imgview2.image = [UIImage imageNamed:model.pokerImg];
        } else {
            self.banker_pk3.imgview2.image = [UIImage imageNamed:model.pokerImg];
        }
    }
    
    // 延时执行翻牌
    [self performSelector:@selector(delayedExecutionFlop) withObject:nil afterDelay:1.0f];
    
    // 延时执行
    [self performSelector:@selector(repeatDelay) withObject:nil afterDelay:isPlayerHave3 ? 3.0 : 1.5f];
    
    
//    _dealerTimer=[NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(removeStackView) userInfo:nil repeats:YES];
}

- (void)delayedExecutionFlop {
    // 执行动画
    [self executeAnimation];
}

// 执行动画
- (void)executeAnimation {
    // 根据tag值取到扑克牌
    BPockerView *pocker = [self viewWithTag:2001+ _index];
    // 方法二
    [self rotateWithView:pocker];
}

// 延时方法
- (void)delayAction:(UIView *)view {
    [self bringSubviewToFront:view];
}

- (void)delayAction2 {
    _index++;
    if (_index < 4) {
        [self executeAnimation];
    }
}

// 方法二
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





- (void)repeatDelay {
    self.playerTotalPointsLabel.text = [NSString stringWithFormat:@"%ld",self.resultModel.playerTotalPoints];
    self.bankerTotalPointsLabel.text = [NSString stringWithFormat:@"%ld",self.resultModel.bankerTotalPoints];
    self.winTypeLabel.text = [self getWinType:self.resultModel.winType];
}























- (void)repeatDelayPlayer:(NSDictionary *)parDict {
    PokerCardModel *model = (PokerCardModel *)parDict[@"model"];
    [self player3DealerDisplayView:model];
}
- (void)repeatDelayBanker:(NSDictionary *)parDict {
    PokerCardModel *model = (PokerCardModel *)parDict[@"model"];
    [self banker3DealerDisplayView:model];
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
    
    BPockerView *player_pk1 = [[BPockerView alloc] initWithFrame:CGRectMake(60, 0, 55, 70)];
    player_pk1.tag = 2000 + 1;
    [self addSubview:player_pk1];
    _player_pk1 = player_pk1;
    
    BPockerView *player_pk2 = [[BPockerView alloc] initWithFrame:CGRectMake(120, 0, 55, 70)];
    player_pk2.tag = 2000 + 2;
    [self addSubview:player_pk2];
    _player_pk2 = player_pk2;
    
    BPockerView *player_pk3 = [[BPockerView alloc] initWithFrame:CGRectMake(0, 0, 55, 70)];
    player_pk3.tag = 2000 + 5;
    [self addSubview:player_pk3];
    _player_pk3 = player_pk3;
    
    BPockerView *banker_pk1 = [[BPockerView alloc] initWithFrame:CGRectMake(200+0, 0, 55, 70)];
    banker_pk1.tag = 2000 + 3;
    [self addSubview:banker_pk1];
    _banker_pk1 = banker_pk1;
    
    BPockerView *banker_pk2 = [[BPockerView alloc] initWithFrame:CGRectMake(200+60, 0, 55, 70)];
    banker_pk2.tag = 2000 + 4;
    [self addSubview:banker_pk2];
    _banker_pk2 = banker_pk2;
    
    BPockerView *banker_pk3 = [[BPockerView alloc] initWithFrame:CGRectMake(200+120, 0, 55, 70)];
    banker_pk3.tag = 2000 + 6;
    [self addSubview:banker_pk3];
    _banker_pk3 = banker_pk3;
    
    
    
    
    
    
    UIView *backView = [[UIView alloc] init];
    backView.backgroundColor = [UIColor clearColor];
    [self addSubview:backView];
    
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self);
    }];
    
    UIView *playerBackView = [[UIView alloc] init];
    playerBackView.backgroundColor = [UIColor clearColor];
    [backView addSubview:playerBackView];
    _playerBackView = playerBackView;
    
    [playerBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView.mas_top);
        make.left.equalTo(backView.mas_left).offset(50);
        make.size.mas_equalTo(CGSizeMake(120, 70));
    }];
    
    UIView *player3BackView = [[UIView alloc] init];
    player3BackView.backgroundColor = [UIColor clearColor];
    [backView addSubview:player3BackView];
    _player3BackView = player3BackView;
    
    [player3BackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(playerBackView.mas_bottom).offset(5);
        make.centerX.equalTo(playerBackView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(55, 70));
    }];
    
    _playerStackView = [[UIStackView alloc] init];
    //子控件的布局方向
    _playerStackView.axis = UILayoutConstraintAxisHorizontal;
    _playerStackView.distribution = UIStackViewDistributionFillEqually;
    _playerStackView.spacing = 10;
    _playerStackView.alignment = UIStackViewAlignmentFill;
    [playerBackView addSubview:_playerStackView];
    [_playerStackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(playerBackView);
    }];
    
    
    
    UIView *bankerBackView = [[UIView alloc] init];
    bankerBackView.backgroundColor = [UIColor clearColor];
    [backView addSubview:bankerBackView];
    _bankerBackView = bankerBackView;
    
    [bankerBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(playerBackView.mas_centerY);
        make.right.equalTo(backView.mas_right).offset(-50);
        make.size.mas_equalTo(CGSizeMake(120, 70));
    }];
    
    UIView *banker3BackView = [[UIView alloc] init];
    banker3BackView.backgroundColor = [UIColor clearColor];
    [backView addSubview:banker3BackView];
    _banker3BackView = banker3BackView;
    
    [banker3BackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bankerBackView.mas_bottom).offset(5);
        make.centerX.equalTo(bankerBackView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(55, 70));
    }];
    
    _bankerStackView = [[UIStackView alloc] init];
    //子控件的布局方向
    _bankerStackView.axis = UILayoutConstraintAxisHorizontal;
    _bankerStackView.distribution = UIStackViewDistributionFillEqually;
    _bankerStackView.spacing = 10;
    _bankerStackView.alignment = UIStackViewAlignmentFill;
    [bankerBackView addSubview:_bankerStackView];
    [_bankerStackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(bankerBackView);
    }];
    
    
    UILabel *playerTotalPointsLabel = [[UILabel alloc] init];
    playerTotalPointsLabel.text = @"";
    playerTotalPointsLabel.font = [UIFont boldSystemFontOfSize:50];
    playerTotalPointsLabel.textColor = [UIColor blueColor];
    playerTotalPointsLabel.alpha = 0.5;
    playerTotalPointsLabel.textAlignment = NSTextAlignmentCenter;
    [backView addSubview:playerTotalPointsLabel];
    _playerTotalPointsLabel = playerTotalPointsLabel;
    
    [playerTotalPointsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(backView.mas_centerY).offset(0);
        make.centerX.equalTo(playerBackView.mas_centerX).offset(-20);
    }];
    
    UILabel *bankerTotalPointsLabel = [[UILabel alloc] init];
    bankerTotalPointsLabel.text = @"";
    bankerTotalPointsLabel.font = [UIFont boldSystemFontOfSize:50];
    bankerTotalPointsLabel.textColor = [UIColor redColor];
    bankerTotalPointsLabel.alpha = 0.5;
    bankerTotalPointsLabel.textAlignment = NSTextAlignmentCenter;
    [backView addSubview:bankerTotalPointsLabel];
    _bankerTotalPointsLabel = bankerTotalPointsLabel;
    
    [bankerTotalPointsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(backView.mas_centerY).offset(0);
        make.centerX.equalTo(bankerBackView.mas_centerX).offset(30);
    }];
    
    
    UILabel *winTypeLabel = [[UILabel alloc] init];
    winTypeLabel.text = @"";
    winTypeLabel.font = [UIFont boldSystemFontOfSize:26];
    winTypeLabel.textColor = [UIColor blueColor];
    winTypeLabel.alpha = 0.7;
    winTypeLabel.textAlignment = NSTextAlignmentCenter;
    [backView addSubview:winTypeLabel];
    _winTypeLabel = winTypeLabel;
    
    [winTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(backView.mas_centerY).offset(0);
        make.centerX.equalTo(backView.mas_centerX);
    }];
    
}


#pragma mark -  发牌显示视图
- (void)playerDealerDisplayView:(PokerCardModel *)carModel {
    
    MXWPokerView *view = [[MXWPokerView alloc] init];
    view.fromType = 1;
    view.model = carModel;
    
    [self.playerStackView addArrangedSubview:view];
    [UIView animateWithDuration:0.5 animations:^{
        [self.playerStackView layoutIfNeeded];
    }];
}
- (void)player3DealerDisplayView:(PokerCardModel *)carModel {
    
    MXWPokerView *view = [[MXWPokerView alloc] init];
    view.fromType = 1;
    view.model = carModel;
    
    [self.player3BackView addSubview:view];
    [UIView animateWithDuration:0.8 animations:^{
        view.frame = CGRectMake(0, 0, 55, 70);
    }];
}
- (void)bankerDealerDisplayView:(PokerCardModel *)carModel {
    
    MXWPokerView *view = [[MXWPokerView alloc] init];
    view.fromType = 1;
    view.model = carModel;
    
    [self.bankerStackView addArrangedSubview:view];
    [UIView animateWithDuration:0.5 animations:^{
        [self.bankerStackView layoutIfNeeded];
    }];
}

- (void)banker3DealerDisplayView:(PokerCardModel *)carModel {
    
    MXWPokerView *view = [[MXWPokerView alloc] init];
    view.fromType = 1;
    view.model = carModel;
    
    [self.banker3BackView addSubview:view];
    [UIView animateWithDuration:0.8 animations:^{
        view.frame = CGRectMake(0, 0, 55, 70);
    }];
}


/// 移除视图
- (void)removeStackView {
    
    for (NSInteger i = 0; i < [self.playerStackView subviews].count; i++) {
        MXWPokerView *viewLabel = [self.playerStackView subviews][i];
        [viewLabel dataClear];
        [self.playerStackView removeArrangedSubview:viewLabel];
    }
    while (self.player3BackView.subviews.count) {
        [self.player3BackView.subviews.lastObject removeFromSuperview];
    }
    
    
    for (NSInteger j = 0; j < [self.bankerStackView subviews].count; j++) {
        MXWPokerView *viewLabel = [self.bankerStackView subviews][j];
        [viewLabel dataClear];
        [self.bankerStackView removeArrangedSubview:viewLabel];
    }
    while (self.banker3BackView.subviews.count) {
        [self.banker3BackView.subviews.lastObject removeFromSuperview];
    }
    
    self.playerTotalPointsLabel.text = @"";
    self.bankerTotalPointsLabel.text = @"";
    self.winTypeLabel.text = @"";
//    [self stopTimer];
}


-(void)stopTimer {
    if (_dealerTimer != nil) {
        //停止计时器
        [_dealerTimer invalidate];
    }
    
    [self removeStackView];
    
}

@end



