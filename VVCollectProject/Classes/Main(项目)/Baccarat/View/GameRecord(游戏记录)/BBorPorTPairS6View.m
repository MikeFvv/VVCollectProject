//
//  BBorPorTPairS6View.m
//  VVCollectProject
//
//  Created by Admin on 2022/1/2.
//  Copyright © 2022 Mike. All rights reserved.
//

#import "BBorPorTPairS6View.h"


@interface BBorPorTPairS6View ()

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UILabel *bankerOrPlayerOrTieLabel;
/// 庄对
@property (nonatomic, strong) UIView *bankerPairView;
/// 闲对
@property (nonatomic, strong) UIView *playerPairView;
/// 幸运6
@property (nonatomic, assign) UIView *superSixView;
@end



@implementation BBorPorTPairS6View

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)setModel:(BaccaratResultModel *)model {
    _model = model;
    if (model.winType == WinType_Banker) {
        self.bankerOrPlayerOrTieLabel.text = @"B";
        self.backView.backgroundColor = [UIColor redColor];
    } else if (model.winType == WinType_Player) {
        self.bankerOrPlayerOrTieLabel.text = @"P";
        self.backView.backgroundColor = [UIColor blueColor];
    } else {
        self.bankerOrPlayerOrTieLabel.text = @"T";
        self.backView.backgroundColor = [UIColor greenColor];
    }
    
    if (model.isBankerPair) {
        self.bankerPairView.hidden = NO;
    } else {
        self.bankerPairView.hidden = YES;
    }
    
    if (model.isPlayerPair) {
        self.playerPairView.hidden = NO;
    } else {
        self.playerPairView.hidden = YES;
    }
    
    
    if (model.isSuperSix) {
        self.superSixView.hidden = NO;
    } else {
        self.superSixView.hidden = YES;
    }
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.backView.layer.cornerRadius = self.frame.size.width/2;
    self.backView.layer.masksToBounds = YES;
}

- (void)createUI {
    self.backgroundColor = [UIColor clearColor];

    UIView *backView = [[UIView alloc] init];
    [self addSubview:backView];
    _backView = backView;
    
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    UILabel *bankerOrPlayerOrTieLabel = [[UILabel alloc] init];
    //    bankerOrPlayerOrTieLabel.layer.masksToBounds = YES;
    //    bankerOrPlayerOrTieLabel.layer.cornerRadius = self.frame.size.width/2;
    bankerOrPlayerOrTieLabel.textAlignment = NSTextAlignmentCenter;
    bankerOrPlayerOrTieLabel.font = [UIFont boldSystemFontOfSize:16];
    bankerOrPlayerOrTieLabel.textColor = [UIColor whiteColor];
    [backView addSubview:bankerOrPlayerOrTieLabel];
    _bankerOrPlayerOrTieLabel = bankerOrPlayerOrTieLabel;
    
    [bankerOrPlayerOrTieLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(backView);
    }];
    
    
    
    CGFloat circleViewWidht = 8;
    
    UIView *bankerPairView = [[UIView alloc] init];
    bankerPairView.backgroundColor = [UIColor colorWithRed:1.000 green:0.251 blue:0.251 alpha:1.000];
    bankerPairView.layer.cornerRadius = circleViewWidht/2;
    bankerPairView.layer.masksToBounds = YES;
    bankerPairView.hidden = YES;
    [self addSubview:bankerPairView];
    _bankerPairView = bankerPairView;
    
    [bankerPairView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView.mas_top);
        make.left.equalTo(backView.mas_left);
        make.size.mas_equalTo(@(circleViewWidht));
    }];
    
    UIView *playerPairView = [[UIView alloc] init];
    playerPairView.backgroundColor = [UIColor colorWithRed:0.118 green:0.565 blue:1.000 alpha:1.000];
    playerPairView.layer.cornerRadius = circleViewWidht/2;
    playerPairView.layer.masksToBounds = YES;
    playerPairView.hidden = YES;
    [self addSubview:playerPairView];
    _playerPairView = playerPairView;
    
    [playerPairView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(backView.mas_bottom);
        make.right.equalTo(backView.mas_right);
        make.size.mas_equalTo(@(circleViewWidht));
    }];
    
    
    UIView *superSixView = [[UIView alloc] init];
    superSixView.backgroundColor = [UIColor yellowColor];
    superSixView.layer.cornerRadius = circleViewWidht/2;
    superSixView.layer.masksToBounds = YES;
    superSixView.hidden = YES;
    [self addSubview:superSixView];
    _superSixView = superSixView;
    
    [superSixView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(backView.mas_bottom);
        make.left.equalTo(backView.mas_left);
        make.size.mas_equalTo(@(circleViewWidht));
    }];
}

@end
