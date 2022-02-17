//
//  BPBTButton.m
//  VVCollectProject
//
//  Created by Admin on 2022/2/10.
//  Copyright © 2022 Mike. All rights reserved.
//

#import "BPBTButtonView.h"

@interface BPBTButtonView ()

@end

@implementation BPBTButtonView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initData];
        [self createUI];
    }
    return self;
}

- (void)onButtonClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(contentBtnClick:)]) {
        [self.delegate contentBtnClick:sender];
    }
}

- (void)createUI {
//    self.backgroundColor = [UIColor whiteColor];
    
    UIView *backView = [[UIView alloc] init];
//    backView.backgroundColor = [UIColor greenColor];
    [self addSubview:backView];
    
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    CGFloat bigWidthHeight = 55;
    CGFloat bigFont = 22;
    
    
    UIButton *contentBtn = [[UIButton alloc] init];
    //    [autoBtn setBackgroundImage:[UIImage imageNamed:@"com_more_white"] forState:UIControlStateNormal];
    [contentBtn addTarget:self action:@selector(onButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    contentBtn.titleLabel.font = [UIFont boldSystemFontOfSize:bigFont];
    [contentBtn setTitle:@"闲" forState:UIControlStateNormal];
    [contentBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [contentBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    contentBtn.backgroundColor = [UIColor blueColor];
    contentBtn.layer.borderWidth = 4;
    contentBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    contentBtn.layer.cornerRadius = bigWidthHeight/2;
//    contentBtn.tag = 3000;
    [backView addSubview:contentBtn];
    _contentBtn = contentBtn;
    
    [contentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(backView.mas_centerY);
        make.centerX.equalTo(backView.mas_centerX);
        make.size.mas_equalTo(bigWidthHeight);
    }];
    
    CGFloat circleViewWidht = 12;
    
    UIView *bankerPairView = [[UIView alloc] init];
    bankerPairView.backgroundColor = [UIColor colorWithRed:1.000 green:0.251 blue:0.251 alpha:1.000];
    bankerPairView.layer.cornerRadius = circleViewWidht/2;
    bankerPairView.layer.masksToBounds = YES;
    bankerPairView.hidden = YES;
    [backView addSubview:bankerPairView];
    _bankerPairView = bankerPairView;
    
    [bankerPairView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView.mas_top).offset(2);
        make.left.equalTo(backView.mas_left).offset(2);
        make.size.mas_equalTo(@(circleViewWidht));
    }];
    
    UIView *playerPairView = [[UIView alloc] init];
    playerPairView.backgroundColor = [UIColor colorWithRed:0.118 green:0.565 blue:1.000 alpha:1.000];
    playerPairView.layer.cornerRadius = circleViewWidht/2;
    playerPairView.layer.masksToBounds = YES;
    playerPairView.hidden = YES;
    [backView addSubview:playerPairView];
    _playerPairView = playerPairView;
    
    [playerPairView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(backView.mas_bottom).offset(-2);
        make.right.equalTo(backView.mas_right).offset(-2);
        make.size.mas_equalTo(@(circleViewWidht));
    }];
    
    
    UIView *superSixView = [[UIView alloc] init];
    superSixView.backgroundColor = [UIColor yellowColor];
    superSixView.layer.cornerRadius = circleViewWidht/2;
    superSixView.layer.masksToBounds = YES;
    superSixView.hidden = YES;
    [backView addSubview:superSixView];
    _superSixView = superSixView;
    
    [superSixView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(backView.mas_bottom).offset(-2);
        make.left.equalTo(backView.mas_left).offset(2);
        make.size.mas_equalTo(@(circleViewWidht));
    }];
    
    
//    *tieCountLabel;
//   @property (nonatomic, strong) UILabel *bankerPairCountLabel;
//   @property (nonatomic, strong) UILabel *playerPairCountLabel;
//   @property (nonatomic, strong) UILabel *superSixCountLabel;
}


- (void)initData {
    
}

@end

