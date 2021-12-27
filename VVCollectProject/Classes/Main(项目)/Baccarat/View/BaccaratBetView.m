//
//  BaccaratBetView.m
//  VVCollectProject
//
//  Created by Admin on 2021/12/19.
//  Copyright © 2021 Mike. All rights reserved.
//

#import "BaccaratBetView.h"
#import "UIView+Extension.h"
#import "BaccaratCom.h"


@interface BaccaratBetView ()

///
@property (nonatomic, strong) UILabel *playerPairLabel;
///
@property (nonatomic, strong) UILabel *tieLabel;
///
@property (nonatomic, strong) UILabel *superSixLabel;
///
@property (nonatomic, strong) UILabel *bankerPairLabel;
///
@property (nonatomic, strong) UILabel *playerLabel;
///
@property (nonatomic, strong) UILabel *bankerLabel;

@property (nonatomic, strong) BBetModel *betModel;
@end

@implementation BaccaratBetView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initData];
        [self createUI];
        
    }
    return self;
}

- (void)initData {
    BBetModel *betModel = [[BBetModel alloc] init];
    _betModel = betModel;
}


- (void)cancelBetChips {
    
    self.playerPairLabel.text = @"";
    self.tieLabel.text = @"";
    self.superSixLabel.text = @"";
    self.bankerPairLabel.text = @"";
    self.playerLabel.text = @"";
    self.bankerLabel.text = @"";
    
    self.betModel = nil;
}


- (void)betClickBtn:(UIButton *)sender {
    
    if (sender.tag == 3001) { // 闲对
        if (self.betModel.playerPair_money + self.selectedModel.money <= kMaxBetChipsNum) {
            self.playerPairLabel.text = [NSString stringWithFormat:@"%ld",[self.playerPairLabel.text integerValue] + self.selectedModel.money];
            self.betModel.playerPair_money = self.betModel.playerPair_money + self.selectedModel.money;
        }
    } else if (sender.tag == 3002) { // 和
        if (self.betModel.tie_money + self.selectedModel.money <= kMaxBetChipsNum) {
            self.tieLabel.text = [NSString stringWithFormat:@"%ld",[self.tieLabel.text integerValue] + self.selectedModel.money];
            self.betModel.tie_money = self.betModel.tie_money + self.selectedModel.money;
        }
    } else if (sender.tag == 3003) { // 超级6
        if (self.betModel.superSix_money + self.selectedModel.money <= kMaxBetChipsNum) {
            self.superSixLabel.text = [NSString stringWithFormat:@"%ld",[self.superSixLabel.text integerValue] + self.selectedModel.money];
            self.betModel.superSix_money = self.betModel.superSix_money + self.selectedModel.money;
        }
    } else if (sender.tag == 3004) { // 庄对
        if (self.betModel.bankerPair_money + self.selectedModel.money <= kMaxBetChipsNum) {
            self.bankerPairLabel.text = [NSString stringWithFormat:@"%ld",[self.bankerPairLabel.text integerValue] + self.selectedModel.money];
            self.betModel.bankerPair_money = self.betModel.bankerPair_money + self.selectedModel.money;
        }
    } else if (sender.tag == 3005) { // 闲
        if (self.betModel.player_money + self.selectedModel.money <= kMaxBetChipsNum) {
            self.playerLabel.text = [NSString stringWithFormat:@"%ld",[self.playerLabel.text integerValue] + self.selectedModel.money];
            self.betModel.player_money = self.betModel.player_money + self.selectedModel.money;
        }
    } else if (sender.tag == 3006) { // 庄
        if (self.betModel.banker_money + self.selectedModel.money <= kMaxBetChipsNum) {
            self.bankerLabel.text = [NSString stringWithFormat:@"%ld",[self.bankerLabel.text integerValue] + self.selectedModel.money];
            self.betModel.banker_money = self.betModel.banker_money + self.selectedModel.money;
        }
    }
    
    NSLog(@"11");
}



- (void)createUI {
    
    UILabel *ttLabel = [[UILabel alloc] init];
    ttLabel.text = @"请下注";
    ttLabel.font = [UIFont boldSystemFontOfSize:20];
    ttLabel.textColor = [UIColor whiteColor];
    ttLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:ttLabel];
    
    [ttLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(0);
        make.centerX.equalTo(self.mas_centerX);
        make.height.mas_equalTo(30);
    }];
    
   
    CGFloat widhtBtn = self.frame.size.width/4;
    CGFloat btnHeight = 50;
    NSInteger fontSize = 20;
    
    UIView *backView = [[UIView alloc] init];
    backView.backgroundColor = [UIColor greenColor];
    backView.layer.borderWidth = 1.0;
    backView.layer.masksToBounds = YES;
    backView.layer.cornerRadius = 10;
    backView.layer.borderColor = [UIColor colorWithHex:@"D1CC68"].CGColor;
    [self addSubview:backView];
    
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(btnHeight*2+10);
        make.left.bottom.right.equalTo(self);
    }];
    
    
    UIButton *playerPairBtn = [[UIButton alloc] init];
    [playerPairBtn setTitle:@"闲对\n1:11" forState:UIControlStateNormal];
    [playerPairBtn addTarget:self action:@selector(betClickBtn:) forControlEvents:UIControlEventTouchUpInside];
    playerPairBtn.titleLabel.font = [UIFont boldSystemFontOfSize:fontSize];
    [playerPairBtn setTitleColor:[UIColor colorWithHex:@"D1CC68"] forState:UIControlStateNormal];
    playerPairBtn.backgroundColor = [UIColor colorWithHex:@"003D14"];
    playerPairBtn.layer.borderWidth = 1.0;
    playerPairBtn.layer.borderColor = [UIColor colorWithHex:@"D1CC68"].CGColor;
    //    playerPairBtn.layer.cornerRadius = 10;
    playerPairBtn.tag = 3001;
    playerPairBtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [backView addSubview:playerPairBtn];
    
    [playerPairBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView.mas_top).offset(0);
        make.left.equalTo(backView.mas_left).offset(0);
        make.width.mas_equalTo(widhtBtn);
        make.height.mas_equalTo(btnHeight);
    }];
    
    
    
    UIButton *tieBtn = [[UIButton alloc] init];
    [tieBtn setTitle:@"和\n1:8" forState:UIControlStateNormal];
    [tieBtn addTarget:self action:@selector(betClickBtn:) forControlEvents:UIControlEventTouchUpInside];
    tieBtn.titleLabel.font = [UIFont boldSystemFontOfSize:fontSize];
    [tieBtn setTitleColor:[UIColor colorWithHex:@"D1CC68"] forState:UIControlStateNormal];
    tieBtn.backgroundColor = [UIColor colorWithHex:@"003D14"];
    tieBtn.layer.borderWidth = 1.0;
    tieBtn.layer.borderColor = [UIColor colorWithHex:@"D1CC68"].CGColor;
    //    tieBtn.layer.cornerRadius = 10;
    tieBtn.tag = 3002;
    tieBtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [backView addSubview:tieBtn];
    
    [tieBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView.mas_top).offset(0);
        make.left.equalTo(playerPairBtn.mas_right).offset(0);
        make.width.mas_equalTo(widhtBtn);
        make.height.mas_equalTo(btnHeight);
    }];
    
    UIButton *superSixBtn = [[UIButton alloc] init];
    [superSixBtn setTitle:@"S-Six\n1:12" forState:UIControlStateNormal];
    [superSixBtn addTarget:self action:@selector(betClickBtn:) forControlEvents:UIControlEventTouchUpInside];
    superSixBtn.titleLabel.font = [UIFont boldSystemFontOfSize:fontSize];
    [superSixBtn setTitleColor:[UIColor colorWithHex:@"D1CC68"] forState:UIControlStateNormal];
    superSixBtn.backgroundColor = [UIColor colorWithHex:@"003D14"];
    superSixBtn.layer.borderWidth = 1.0;
    superSixBtn.layer.borderColor = [UIColor colorWithHex:@"D1CC68"].CGColor;
    //    superSixBtn.layer.cornerRadius = 10;
    superSixBtn.tag = 3003;
    superSixBtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    superSixBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    superSixBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [backView addSubview:superSixBtn];
    
    [superSixBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView.mas_top).offset(0);
        make.left.equalTo(tieBtn.mas_right).offset(0);
        make.width.mas_equalTo(widhtBtn);
        make.height.mas_equalTo(btnHeight);
    }];
    
    UIButton *bankerPairBtn = [[UIButton alloc] init];
    [bankerPairBtn setTitle:@"庄对\n1:11" forState:UIControlStateNormal];
    [bankerPairBtn addTarget:self action:@selector(betClickBtn:) forControlEvents:UIControlEventTouchUpInside];
    bankerPairBtn.titleLabel.font = [UIFont boldSystemFontOfSize:fontSize];
    [bankerPairBtn setTitleColor:[UIColor colorWithHex:@"D1CC68"] forState:UIControlStateNormal];
    bankerPairBtn.backgroundColor = [UIColor colorWithHex:@"003D14"];
    bankerPairBtn.layer.borderWidth = 1.0;
    bankerPairBtn.layer.borderColor = [UIColor colorWithHex:@"D1CC68"].CGColor;
    //    bankerPairBtn.layer.cornerRadius = 10;
    bankerPairBtn.tag = 3004;
    bankerPairBtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [backView addSubview:bankerPairBtn];
    
    [bankerPairBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView.mas_top).offset(0);
        make.right.equalTo(backView.mas_right).offset(0);
        make.width.mas_equalTo(widhtBtn);
        make.height.mas_equalTo(btnHeight);
    }];
    
    
    
    UIButton *playerBtn = [[UIButton alloc] init];
    [playerBtn setTitle:@"闲\n1:1" forState:UIControlStateNormal];
    [playerBtn addTarget:self action:@selector(betClickBtn:) forControlEvents:UIControlEventTouchUpInside];
    playerBtn.titleLabel.font = [UIFont boldSystemFontOfSize:fontSize];
    [playerBtn setTitleColor:[UIColor colorWithHex:@"D1CC68"] forState:UIControlStateNormal];
    playerBtn.backgroundColor = [UIColor colorWithHex:@"003D14"];
    playerBtn.layer.borderWidth = 1.0;
    playerBtn.layer.borderColor = [UIColor colorWithHex:@"D1CC68"].CGColor;
    //    playerBtn.layer.cornerRadius = 10;
    playerBtn.tag = 3005;
    playerBtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [backView addSubview:playerBtn];
    
    [playerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(playerPairBtn.mas_bottom).offset(0);
        make.left.equalTo(backView.mas_left).offset(0);
        make.width.mas_equalTo(widhtBtn*2);
        make.height.mas_equalTo(btnHeight+10);
    }];
    
    
    UIButton *bankerBtn = [[UIButton alloc] init];
    [bankerBtn setTitle:@"庄\n1:1" forState:UIControlStateNormal];
    [bankerBtn addTarget:self action:@selector(betClickBtn:) forControlEvents:UIControlEventTouchUpInside];
    bankerBtn.titleLabel.font = [UIFont boldSystemFontOfSize:fontSize];
    [bankerBtn setTitleColor:[UIColor colorWithHex:@"D1CC68"] forState:UIControlStateNormal];
    bankerBtn.backgroundColor = [UIColor colorWithHex:@"003D14"];
    bankerBtn.layer.borderWidth = 1.0;
    bankerBtn.layer.borderColor = [UIColor colorWithHex:@"D1CC68"].CGColor;
    //    bankerBtn.layer.cornerRadius = 10;
    bankerBtn.tag = 3006;
    bankerBtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [backView addSubview:bankerBtn];
    
    [bankerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(playerPairBtn.mas_bottom).offset(0);
        make.right.equalTo(backView.mas_right).offset(0);
        make.width.mas_equalTo(widhtBtn*2);
        make.height.mas_equalTo(btnHeight+10);
    }];
    
    
    NSInteger betNumFontSize = 15;
    
    
    UILabel *playerPairLabel = [[UILabel alloc] init];
    playerPairLabel.text = @"";
    playerPairLabel.font = [UIFont boldSystemFontOfSize:betNumFontSize];
    playerPairLabel.textColor = [UIColor redColor];
    playerPairLabel.textAlignment = NSTextAlignmentCenter;
    [playerPairBtn addSubview:playerPairLabel];
    _playerPairLabel = playerPairLabel;
    
    [playerPairLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(playerPairBtn.mas_centerX);
        make.centerY.equalTo(playerPairBtn.mas_centerY);
    }];
    
    UILabel *tieLabel = [[UILabel alloc] init];
    tieLabel.text = @"";
    tieLabel.font = [UIFont boldSystemFontOfSize:betNumFontSize];
    tieLabel.textColor = [UIColor redColor];
    tieLabel.textAlignment = NSTextAlignmentCenter;
    [tieBtn addSubview:tieLabel];
    _tieLabel = tieLabel;
    
    [tieLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(tieBtn.mas_centerX);
        make.centerY.equalTo(tieBtn.mas_centerY);
    }];
    
    UILabel *superSixLabel = [[UILabel alloc] init];
    superSixLabel.text = @"";
    superSixLabel.font = [UIFont boldSystemFontOfSize:betNumFontSize];
    superSixLabel.textColor = [UIColor redColor];
    superSixLabel.textAlignment = NSTextAlignmentCenter;
    [superSixBtn addSubview:superSixLabel];
    _superSixLabel = superSixLabel;
    
    [superSixLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(superSixBtn.mas_centerX);
        make.centerY.equalTo(superSixBtn.mas_centerY);
    }];
    
    UILabel *bankerPairLabel = [[UILabel alloc] init];
    bankerPairLabel.text = @"";
    bankerPairLabel.font = [UIFont boldSystemFontOfSize:betNumFontSize];
    bankerPairLabel.textColor = [UIColor redColor];
    bankerPairLabel.textAlignment = NSTextAlignmentCenter;
    [bankerPairBtn addSubview:bankerPairLabel];
    _bankerPairLabel = bankerPairLabel;
    
    [bankerPairLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bankerPairBtn.mas_centerX);
        make.centerY.equalTo(bankerPairBtn.mas_centerY);
    }];
    
    
    UILabel *playerLabel = [[UILabel alloc] init];
    playerLabel.text = @"";
    playerLabel.font = [UIFont boldSystemFontOfSize:betNumFontSize];
    playerLabel.textColor = [UIColor redColor];
    playerLabel.textAlignment = NSTextAlignmentCenter;
    [playerBtn addSubview:playerLabel];
    _playerLabel = playerLabel;
    
    [playerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(playerBtn.mas_centerX);
        make.centerY.equalTo(playerBtn.mas_centerY);
    }];
    
    UILabel *bankerLabel = [[UILabel alloc] init];
    bankerLabel.text = @"";
    bankerLabel.font = [UIFont boldSystemFontOfSize:betNumFontSize];
    bankerLabel.textColor = [UIColor redColor];
    bankerLabel.textAlignment = NSTextAlignmentCenter;
    [bankerBtn addSubview:bankerLabel];
    _bankerLabel = bankerLabel;
    
    [bankerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bankerBtn.mas_centerX);
        make.centerY.equalTo(bankerBtn.mas_centerY);
    }];
}


@end





