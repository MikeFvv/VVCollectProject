//
//  BManualManageRoadView.m
//  VVCollectProject
//
//  Created by Admin on 2022/2/10.
//  Copyright © 2022 Mike. All rights reserved.
//

#import "BManualManageRoadView.h"
#import "BPBTButtonView.h"

@interface BManualManageRoadView ()<BPBTButtonViewDelegate>
/// 闲对
@property (nonatomic, strong) UIButton *playerPairBtn;
/// 庄对
@property (nonatomic, strong) UIButton *bankerPairBtn;
/// 超级6
@property (nonatomic, strong) UIButton *superSixBtn;
/// 赢
@property (nonatomic, strong) UIButton *winBtn;

/// 和 显示隐藏
@property (nonatomic, strong) UIButton *tieShowHidBtn;

/// 闲
@property (nonatomic, strong) BPBTButtonView *playerBtn;
/// 庄
@property (nonatomic, strong) BPBTButtonView *bankerBtn;
/// 和
@property (nonatomic, strong) BPBTButtonView *tieBtn;
/// 后退
@property (nonatomic, strong) UIButton *backBtn;

/// 是否选中闲对
@property (nonatomic, assign) BOOL isSelectedPlayerPair;
/// 是否选中庄对
@property (nonatomic, assign) BOOL isSelectedBankerPair;
/// 是否选中超级6
@property (nonatomic, assign) BOOL isSelectedSuperSix;
/// 是否选中天牌
@property (nonatomic, assign) BOOL isSelectedSkyCard;
/// 是否显示和局
@property (nonatomic, assign) BOOL isShowTie;

@end

@implementation BManualManageRoadView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initData];
        [self createUI];
    }
    return self;
}

- (void)contentBtnClick:(UIButton *)sender {
     NSInteger btnTag = sender.tag - 4000;
     if ([self.delegate respondsToSelector:@selector(didManualManageRoadSelectedClickButtonTag:)]) {
         [self.delegate didManualManageRoadSelectedClickButtonTag:btnTag];
     }
     NSLog(@"1");
}

- (void)onButtonClick:(UIButton *)sender {
    
   NSInteger btnTag = sender.tag - 4000;
    BOOL isSelected = NO;
    
    if (btnTag == 5) {
        if (!self.isSelectedPlayerPair) {
            self.isSelectedPlayerPair = YES;
            sender.backgroundColor = [UIColor blueColor];
            [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        } else {
            self.isSelectedPlayerPair = NO;
            sender.backgroundColor = [UIColor whiteColor];
            [sender setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        }
        isSelected = self.isSelectedPlayerPair;
    } else if (btnTag == 6) {
        if (!self.isSelectedBankerPair) {
            self.isSelectedBankerPair = YES;
            sender.backgroundColor = [UIColor redColor];
            [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        } else {
            self.isSelectedBankerPair = NO;
            sender.backgroundColor = [UIColor whiteColor];
            [sender setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }
        isSelected = self.isSelectedBankerPair;
    } else if (btnTag == 7) {
        if (!self.isSelectedSuperSix) {
            self.isSelectedSuperSix = YES;
            sender.backgroundColor = [UIColor orangeColor];
            [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        } else {
            self.isSelectedSuperSix = NO;
            sender.backgroundColor = [UIColor whiteColor];
            [sender setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        }
        isSelected = self.isSelectedSuperSix;
    } else if (btnTag == 8) {
        if (!self.isSelectedSkyCard) {
            self.isSelectedSkyCard = YES;
            sender.backgroundColor = [UIColor purpleColor];
            [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        } else {
            self.isSelectedSkyCard = NO;
            sender.backgroundColor = [UIColor whiteColor];
            [sender setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
        }
        isSelected = self.isSelectedSkyCard;
    } else if (btnTag == 9) {
        if (!self.isShowTie) {
            self.isShowTie = YES;
            sender.backgroundColor = [UIColor greenColor];
            [sender setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        } else {
            self.isShowTie = NO;
            sender.backgroundColor = [UIColor whiteColor];
            [sender setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        }
        isSelected = self.isShowTie;
    }
    
    if ([self.delegate respondsToSelector:@selector(specialSelectedClickButtonTag:isSelected:)]) {
        [self.delegate specialSelectedClickButtonTag:btnTag isSelected:isSelected];
    }
    NSLog(@"1");
}

- (void)createUI {
//    self.backgroundColor = [UIColor whiteColor];
    
    UIView *backView = [[UIView alloc] init];
    backView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:backView];
    
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    CGFloat smallWidthHeight = 30;
    CGFloat bigWidthHeight = 50;
    CGFloat smallFont = 16;
    CGFloat bigFont = 22;
    
    // *** 1 ***
    UIButton *playerPairBtn = [[UIButton alloc] init];
    //    [autoBtn setBackgroundImage:[UIImage imageNamed:@"com_more_white"] forState:UIControlStateNormal];
    [playerPairBtn addTarget:self action:@selector(onButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    playerPairBtn.titleLabel.font = [UIFont systemFontOfSize:smallFont];
    [playerPairBtn setTitle:@"闲对" forState:UIControlStateNormal];
    [playerPairBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [playerPairBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    playerPairBtn.backgroundColor = [UIColor whiteColor];
    playerPairBtn.layer.borderWidth = 2;
    playerPairBtn.layer.borderColor = [UIColor blueColor].CGColor;
    playerPairBtn.layer.cornerRadius = smallWidthHeight/2;
    playerPairBtn.tag = 4005;
    [backView addSubview:playerPairBtn];
    _playerPairBtn = playerPairBtn;
    
    [playerPairBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView.mas_top).offset(5);
        make.left.equalTo(backView.mas_left).offset(10);
        make.size.mas_equalTo(CGSizeMake(50, smallWidthHeight));
    }];
    
    
    BPBTButtonView *playerBtn = [[BPBTButtonView alloc] init];
    playerBtn.contentBtn.backgroundColor = [UIColor blueColor];
    [playerBtn.contentBtn setTitle:@"闲" forState:UIControlStateNormal];
    playerBtn.contentBtn.tag = 4001;
    playerBtn.tag = 4001;
    playerBtn.delegate = self;
    [backView addSubview:playerBtn];
    _playerBtn = playerBtn;
    
//    playerBtn.bankerPairView.hidden = NO;
//    playerBtn.playerPairView.hidden = NO;
//    playerBtn.superSixView.hidden = NO;
    
    [playerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(playerPairBtn.mas_bottom).offset(5);
        make.centerX.equalTo(playerPairBtn.mas_centerX);
        make.size.mas_equalTo(bigWidthHeight);
    }];
    
    
    // *** 2 ***
    UIButton *bankerPairBtn = [[UIButton alloc] init];
    //    [autoBtn setBackgroundImage:[UIImage imageNamed:@"com_more_white"] forState:UIControlStateNormal];
    [bankerPairBtn addTarget:self action:@selector(onButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    bankerPairBtn.titleLabel.font = [UIFont systemFontOfSize:smallFont];
    [bankerPairBtn setTitle:@"庄对" forState:UIControlStateNormal];
    [bankerPairBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [bankerPairBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    bankerPairBtn.backgroundColor = [UIColor whiteColor];
    bankerPairBtn.layer.borderWidth = 2;
    bankerPairBtn.layer.borderColor = [UIColor redColor].CGColor;
    bankerPairBtn.layer.cornerRadius = smallWidthHeight/2;
    bankerPairBtn.tag = 4006;
    [backView addSubview:bankerPairBtn];
    _bankerPairBtn = bankerPairBtn;
    
    [bankerPairBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView.mas_top).offset(5);
        make.left.equalTo(playerPairBtn.mas_right).offset(20);
        make.size.mas_equalTo(CGSizeMake(50, smallWidthHeight));
    }];
    
    
    BPBTButtonView *bankerBtn = [[BPBTButtonView alloc] init];
    bankerBtn.contentBtn.backgroundColor = [UIColor redColor];
    [bankerBtn.contentBtn setTitle:@"庄" forState:UIControlStateNormal];
    bankerBtn.tag = 4002;
    bankerBtn.contentBtn.tag = 4002;
    bankerBtn.delegate = self;
    [backView addSubview:bankerBtn];
    _bankerBtn = bankerBtn;
    
//    bankerBtn.bankerPairView.hidden = NO;
//    bankerBtn.playerPairView.hidden = NO;
//    bankerBtn.superSixView.hidden = NO;
    
    [bankerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bankerPairBtn.mas_bottom).offset(5);
        make.centerX.equalTo(bankerPairBtn.mas_centerX);
        make.size.mas_equalTo(bigWidthHeight);
    }];
    
    // *** 3 ***
    UIButton *superSixBtn = [[UIButton alloc] init];
    //    [autoBtn setBackgroundImage:[UIImage imageNamed:@"com_more_white"] forState:UIControlStateNormal];
    [superSixBtn addTarget:self action:@selector(onButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    superSixBtn.titleLabel.font = [UIFont systemFontOfSize:smallFont];
    [superSixBtn setTitle:@"超级6" forState:UIControlStateNormal];
    [superSixBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [superSixBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    superSixBtn.backgroundColor = [UIColor whiteColor];
    superSixBtn.layer.borderWidth = 2;
    superSixBtn.layer.borderColor = [UIColor orangeColor].CGColor;
    superSixBtn.layer.cornerRadius = smallWidthHeight/2;
    superSixBtn.tag = 4007;
    [backView addSubview:superSixBtn];
    _superSixBtn = superSixBtn;
    
    [superSixBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView.mas_top).offset(5);
        make.left.equalTo(bankerPairBtn.mas_right).offset(20);
        make.size.mas_equalTo(CGSizeMake(50, smallWidthHeight));
    }];
    
    
    BPBTButtonView *tieBtn = [[BPBTButtonView alloc] init];
    tieBtn.contentBtn.backgroundColor = [UIColor greenColor];
    [tieBtn.contentBtn setTitle:@"和" forState:UIControlStateNormal];
    tieBtn.tag = 4003;
    tieBtn.delegate = self;
    tieBtn.contentBtn.tag = 4003;
    [backView addSubview:tieBtn];
    _tieBtn = tieBtn;
    
//    tieBtn.bankerPairView.hidden = NO;
//    tieBtn.playerPairView.hidden = NO;
//    tieBtn.superSixView.hidden = NO;
    
    [tieBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superSixBtn.mas_bottom).offset(5);
        make.centerX.equalTo(superSixBtn.mas_centerX);
        make.size.mas_equalTo(bigWidthHeight);
    }];
    
    
    // *** 4 *** backBtn; winBtn
    UIButton *winBtn = [[UIButton alloc] init];
    //    [autoBtn setBackgroundImage:[UIImage imageNamed:@"com_more_white"] forState:UIControlStateNormal];
    [winBtn addTarget:self action:@selector(onButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    winBtn.titleLabel.font = [UIFont systemFontOfSize:smallFont];
    [winBtn setTitle:@"赢" forState:UIControlStateNormal];
    [winBtn setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    [winBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    winBtn.backgroundColor = [UIColor whiteColor];
    winBtn.layer.borderWidth = 2;
    winBtn.layer.borderColor = [UIColor purpleColor].CGColor;
    winBtn.layer.cornerRadius = smallWidthHeight/2;
    winBtn.tag = 4008;
    [backView addSubview:winBtn];
    _winBtn = winBtn;

    [winBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView.mas_top).offset(5);
        make.left.equalTo(superSixBtn.mas_right).offset(20);
        make.size.mas_equalTo(CGSizeMake(50, smallWidthHeight));
    }];


    UIButton *backBtn = [[UIButton alloc] init];
    //    [autoBtn setBackgroundImage:[UIImage imageNamed:@"com_more_white"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(contentBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    backBtn.titleLabel.font = [UIFont boldSystemFontOfSize:32];
    [backBtn setTitle:@"←" forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    backBtn.backgroundColor = [UIColor orangeColor];
    backBtn.layer.borderWidth = 4;
    backBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    backBtn.layer.cornerRadius = bigWidthHeight/2;
    backBtn.tag = 4004;
    [backView addSubview:backBtn];

    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(winBtn.mas_bottom).offset(5);
        make.centerX.equalTo(winBtn.mas_centerX);
        make.size.mas_equalTo(bigWidthHeight);
    }];
    
    
    
    // *** 5 *** 和
    UIButton *tieShowHidBtn = [[UIButton alloc] init];
    //    [autoBtn setBackgroundImage:[UIImage imageNamed:@"com_more_white"] forState:UIControlStateNormal];
    [tieShowHidBtn addTarget:self action:@selector(onButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    tieShowHidBtn.titleLabel.font = [UIFont systemFontOfSize:smallFont];
    [tieShowHidBtn setTitle:@"和" forState:UIControlStateNormal];
    [tieShowHidBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [tieShowHidBtn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    tieShowHidBtn.backgroundColor = [UIColor whiteColor];
    tieShowHidBtn.layer.borderWidth = 2;
    tieShowHidBtn.layer.borderColor = [UIColor grayColor].CGColor;
    tieShowHidBtn.layer.cornerRadius = smallWidthHeight/2;
    tieShowHidBtn.tag = 4009;
    [backView addSubview:tieShowHidBtn];
    _tieShowHidBtn = tieShowHidBtn;

    [tieShowHidBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView.mas_top).offset(5);
        make.left.equalTo(winBtn.mas_right).offset(20);
        make.size.mas_equalTo(CGSizeMake(50, smallWidthHeight));
    }];
}


- (void)initData {
    
}

@end
