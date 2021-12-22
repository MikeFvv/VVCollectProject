//
//  BaccaratCollectionViewCell.m
//  VVCollectProject
//
//  Created by Mike on 2019/2/25.
//  Copyright © 2019 Mike. All rights reserved.
//

#import "BaccaratCollectionViewCell.h"
#import "BaccaratResultModel.h"

@interface BaccaratCollectionViewCell ()

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UILabel *bankerOrPlayerOrTieLabel;
/// 庄对
@property (nonatomic, strong) UIView *bankerPairView;
/// 闲对
@property (nonatomic, strong) UIView *playerPairView;
/// 幸运6
@property (nonatomic, assign) UIView *superSixView;


@end

@implementation BaccaratCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self createUI];
    }
    return self;
}

- (void)createUI {
    
//    self.backgroundColor = [UIColor yellowColor];
//    self.layer.masksToBounds = YES;
    
    
    
    UIView *backView = [[UIView alloc] init];
//    backView.backgroundColor = [UIColor greenColor];
    backView.layer.cornerRadius = self.frame.size.width/2;
    backView.layer.masksToBounds = YES;
    [self.contentView addSubview:backView];
    _backView = backView;
    
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
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
    _bankerPairView = bankerPairView;
    [backView addSubview:bankerPairView];
    
    [bankerPairView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView.mas_top);
        make.left.equalTo(backView.mas_left);
        make.size.mas_equalTo(@(circleViewWidht));
    }];
    
    UIView *playerPairView = [[UIView alloc] init];
    playerPairView.backgroundColor = [UIColor colorWithRed:0.118 green:0.565 blue:1.000 alpha:1.000];
    playerPairView.layer.cornerRadius = circleViewWidht/2;
    playerPairView.layer.masksToBounds = YES;
    _playerPairView = playerPairView;
    [backView addSubview:playerPairView];
    
    [playerPairView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(backView.mas_bottom);
        make.right.equalTo(backView.mas_right);
        make.size.mas_equalTo(@(circleViewWidht));
    }];
    
    
    UIView *superSixView = [[UIView alloc] init];
    superSixView.backgroundColor = [UIColor yellowColor];
    superSixView.layer.cornerRadius = circleViewWidht/2;
    superSixView.layer.masksToBounds = YES;
    _superSixView = superSixView;
    [backView addSubview:superSixView];
    
    [superSixView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(backView.mas_bottom);
        make.left.equalTo(backView.mas_left);
        make.size.mas_equalTo(@(circleViewWidht));
    }];
}

- (void)setModel:(id)model {
    BaccaratResultModel *bModel;
    if ([model isKindOfClass:[BaccaratResultModel class]]) {
        bModel = model;
    } else {
        return;
    }
    
    if (bModel.winType == WinType_Banker) {
        self.bankerOrPlayerOrTieLabel.text = @"B";
        self.backView.backgroundColor = [UIColor redColor];
    } else if (bModel.winType == WinType_Player) {
        self.bankerOrPlayerOrTieLabel.text = @"P";
        self.backView.backgroundColor = [UIColor blueColor];
    } else {
        self.bankerOrPlayerOrTieLabel.text = @"T";
        self.backView.backgroundColor = [UIColor greenColor];
    }
    
    if (bModel.isSuperSix) {
        self.superSixView.hidden = NO;
    } else {
        self.superSixView.hidden = YES;
    }
    
    
    if (bModel.isBankerPair) {
        self.bankerPairView.hidden = NO;
    } else {
        self.bankerPairView.hidden = YES;
    }
    
    if (bModel.isPlayerPair) {
        self.playerPairView.hidden = NO;
    } else {
        self.playerPairView.hidden = YES;
    }
    
}


@end
