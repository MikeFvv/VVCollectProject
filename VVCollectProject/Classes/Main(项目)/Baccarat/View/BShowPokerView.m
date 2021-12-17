//
//  BShowPokerView.m
//  VVCollectProject
//
//  Created by Admin on 2021/12/17.
//  Copyright © 2021 Mike. All rights reserved.
//

#import "BShowPokerView.h"

@interface BShowPokerView ()

// *** 闲 ***
@property (nonatomic, strong) UIView *playerBackView;
@property (nonatomic, strong) UIView *player3BackView;
@property (nonatomic, strong) UIStackView *playerStackView;
// *** 庄 ***
@property (nonatomic, strong) UIView *bankerBackView;
@property (nonatomic, strong) UIView *banker3BackView;
@property (nonatomic, strong) UIStackView *bankerStackView;

// *** 其它 ***
/// 定时器
@property (nonatomic, strong) NSTimer *dealerTimer;


@property (nonatomic, strong) UILabel *playerTotalPointsLabel;
@property (nonatomic, strong) UILabel *bankerTotalPointsLabel;
@property (nonatomic, strong) UILabel *winTypeLabel;


@end

@implementation BShowPokerView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}


- (void)setResultModel:(BaccaratResultModel *)resultModel {
    _resultModel = resultModel;
    
    BOOL isPlayerHave3 = NO;
    for (NSInteger index = 0; index < resultModel.playerArray.count; index++) {
        PokerCardModel *model = resultModel.playerArray[index];
        if (index == 2) {
            isPlayerHave3 = YES;
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            dict[@"model"] = model;
            [self performSelector:@selector(repeatDelayPlayer:) withObject:dict afterDelay:1.0f];
            
        } else {
            [self playerDealerDisplayView:model];
        }
    }
    
    for (NSInteger index = 0; index < resultModel.bankerArray.count; index++) {
        PokerCardModel *model = resultModel.bankerArray[index];
        if (index == 2) {
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            dict[@"model"] = model;
            [self performSelector:@selector(repeatDelayBanker:) withObject:dict afterDelay: isPlayerHave3 ? 2.0 : 1.0f];
            
        } else {
            [self bankerDealerDisplayView:model];
        }
    }
    
    // 延时执行
    [self performSelector:@selector(repeatDelay) withObject:nil afterDelay:isPlayerHave3 ? 3.0 : 1.5f];
    
    
//    _dealerTimer=[NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(removeStackView) userInfo:nil repeats:YES];
}

- (void)repeatDelayPlayer:(NSDictionary *)parDict {
    PokerCardModel *model = (PokerCardModel *)parDict[@"model"];
    [self player3DealerDisplayView:model];
}
- (void)repeatDelayBanker:(NSDictionary *)parDict {
    PokerCardModel *model = (PokerCardModel *)parDict[@"model"];
    [self banker3DealerDisplayView:model];
}
- (void)repeatDelay {
    self.playerTotalPointsLabel.text = [NSString stringWithFormat:@"%ld",self.resultModel.playerTotalPoints];
    self.bankerTotalPointsLabel.text = [NSString stringWithFormat:@"%ld",self.resultModel.bankerTotalPoints];
    self.winTypeLabel.text = [self getWinType:self.resultModel.winType];
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



