//
//  BaccaratCollectionViewCell.m
//  VVCollectProject
//
//  Created by 罗耀生 on 2019/2/25.
//  Copyright © 2019 Mike. All rights reserved.
//

#import "BaccaratCollectionViewCell.h"


@interface BaccaratCollectionViewCell ()


@property (nonatomic,strong) UILabel *bankerOrPlayerOrTieLabel;
// 庄对
@property (nonatomic,strong) UIView *bankerPairView;
// 闲对
@property (nonatomic,strong) UIView *playerPairView;
// 幸运6
@property (nonatomic,assign) UIView *superSixView;


@end

@implementation BaccaratCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI {
    
//    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = self.frame.size.width/2;
    
    UILabel *bankerOrPlayerOrTieLabel = [[UILabel alloc] init];
    //    bankerOrPlayerOrTieLabel.layer.masksToBounds = YES;
    //    bankerOrPlayerOrTieLabel.layer.cornerRadius = self.frame.size.width/2;
    bankerOrPlayerOrTieLabel.textAlignment = NSTextAlignmentCenter;
    bankerOrPlayerOrTieLabel.font = [UIFont boldSystemFontOfSize:16];
    bankerOrPlayerOrTieLabel.textColor = [UIColor whiteColor];
    [self addSubview:bankerOrPlayerOrTieLabel];
    _bankerOrPlayerOrTieLabel = bankerOrPlayerOrTieLabel;
    
    [bankerOrPlayerOrTieLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    
    
    CGFloat circleViewWidht = 8;
    
    UIView *bankerPairView = [[UIView alloc] init];
    bankerPairView.backgroundColor = [UIColor colorWithRed:1.000 green:0.251 blue:0.251 alpha:1.000];
    bankerPairView.layer.cornerRadius = circleViewWidht/2;
    bankerPairView.layer.masksToBounds = YES;
    _bankerPairView = bankerPairView;
    [self addSubview:bankerPairView];
    
    [bankerPairView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top);
        make.left.mas_equalTo(self.mas_left);
        make.size.mas_equalTo(@(circleViewWidht));
    }];
    
    UIView *playerPairView = [[UIView alloc] init];
    playerPairView.backgroundColor = [UIColor colorWithRed:0.118 green:0.565 blue:1.000 alpha:1.000];
    playerPairView.layer.cornerRadius = circleViewWidht/2;
    playerPairView.layer.masksToBounds = YES;
    _playerPairView = playerPairView;
    [self addSubview:playerPairView];
    
    [playerPairView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom);
        make.right.mas_equalTo(self.mas_right);
        make.size.mas_equalTo(@(circleViewWidht));
    }];
    
    
    UIView *superSixView = [[UIView alloc] init];
    superSixView.backgroundColor = [UIColor yellowColor];
    superSixView.layer.cornerRadius = circleViewWidht/2;
    superSixView.layer.masksToBounds = YES;
    _superSixView = superSixView;
    [self addSubview:superSixView];
    
    [superSixView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom);
        make.left.mas_equalTo(self.mas_left);
        make.size.mas_equalTo(@(circleViewWidht));
    }];
}

- (void)setModel:(id)model {
    
    NSDictionary *dict = (NSDictionary *)model;
    
    if ([[dict objectForKey:@"WinType"] integerValue] == 0) {
        self.bankerOrPlayerOrTieLabel.text = @"B";
        self.backgroundColor = [UIColor redColor];
    } else if ([[dict objectForKey:@"WinType"] integerValue] == 1) {
        self.bankerOrPlayerOrTieLabel.text = @"P";
        self.backgroundColor = [UIColor blueColor];
    } else {
        self.bankerOrPlayerOrTieLabel.text = @"T";
        self.backgroundColor = [UIColor greenColor];
    }
    
    if ([[dict objectForKey:@"isSuperSix"] boolValue]) {
        self.superSixView.hidden = NO;
    } else {
        self.superSixView.hidden = YES;
    }
    
    
    if ([[dict objectForKey:@"isBankerPair"] boolValue]) {
        self.bankerPairView.hidden = NO;
    } else {
        self.bankerPairView.hidden = YES;
    }
    
    if ([[dict objectForKey:@"isPlayerPair"] boolValue]) {
        self.playerPairView.hidden = NO;
    } else {
        self.playerPairView.hidden = YES;
    }
    
}


@end