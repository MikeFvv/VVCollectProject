//
//  BaccaratBetView.m
//  VVCollectProject
//
//  Created by Admin on 2021/12/19.
//  Copyright © 2021 Mike. All rights reserved.
//

#import "BaccaratBetView.h"
#import "UIView+Extension.h"

@interface BaccaratBetView ()


@end

@implementation BaccaratBetView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}


- (void)createUI {
    
    UILabel *ttLabel = [[UILabel alloc] init];
    ttLabel.text = @"请下注";
    ttLabel.font = [UIFont boldSystemFontOfSize:26];
    ttLabel.textColor = [UIColor whiteColor];
    ttLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:ttLabel];
    
    [ttLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(0);
        make.centerX.equalTo(self.mas_centerX);
        make.height.mas_equalTo(30);
    }];
    
    
    UIView *backView = [[UIView alloc] init];
    backView.backgroundColor = [UIColor greenColor];
    backView.layer.borderWidth = 1.0;
    backView.layer.masksToBounds = YES;
    backView.layer.cornerRadius = 20;
    backView.layer.borderColor = [UIColor colorWithHex:@"D1CC68"].CGColor;
    [self addSubview:backView];
    
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ttLabel.mas_bottom).offset(0);
        make.left.bottom.right.equalTo(self);
    }];
    
    
    CGFloat widhtBtn = self.frame.size.width/4;
    NSInteger fontSize = 22;
    
    
    UIButton *playerPairBtn = [[UIButton alloc] init];
    [playerPairBtn setTitle:@"闲对\n1:11" forState:UIControlStateNormal];
    [playerPairBtn addTarget:self action:@selector(confirmBtn:) forControlEvents:UIControlEventTouchUpInside];
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
        make.height.mas_equalTo(50);
    }];
    
    UIButton *tieBtn = [[UIButton alloc] init];
    [tieBtn setTitle:@"和\n1:8" forState:UIControlStateNormal];
    [tieBtn addTarget:self action:@selector(confirmBtn:) forControlEvents:UIControlEventTouchUpInside];
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
        make.height.mas_equalTo(50);
    }];
    
    UIButton *superSixBtn = [[UIButton alloc] init];
    [superSixBtn setTitle:@"SuperSix\n1:12" forState:UIControlStateNormal];
    [superSixBtn addTarget:self action:@selector(confirmBtn:) forControlEvents:UIControlEventTouchUpInside];
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
        make.height.mas_equalTo(50);
    }];
    
    UIButton *bankerPairBtn = [[UIButton alloc] init];
    [bankerPairBtn setTitle:@"庄对\n1:11" forState:UIControlStateNormal];
    [bankerPairBtn addTarget:self action:@selector(confirmBtn:) forControlEvents:UIControlEventTouchUpInside];
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
        make.height.mas_equalTo(50);
    }];
    
    
    
    UIButton *playerBtn = [[UIButton alloc] init];
    [playerBtn setTitle:@"闲\n1:1" forState:UIControlStateNormal];
    [playerBtn addTarget:self action:@selector(confirmBtn:) forControlEvents:UIControlEventTouchUpInside];
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
        make.height.mas_equalTo(60);
    }];
    
    
    UIButton *bankerBtn = [[UIButton alloc] init];
    [bankerBtn setTitle:@"庄\n1:0.95" forState:UIControlStateNormal];
    [bankerBtn addTarget:self action:@selector(confirmBtn:) forControlEvents:UIControlEventTouchUpInside];
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
        make.height.mas_equalTo(60);
    }];
}

- (void)confirmBtn:(UIButton *)sender {
    NSLog(@"111");
}

@end





