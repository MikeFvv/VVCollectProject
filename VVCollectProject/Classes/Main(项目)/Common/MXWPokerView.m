//
//  MXWPokerView.m
//  VVCollectProject
//
//  Created by Admin on 2021/12/9.
//  Copyright © 2021 Mike. All rights reserved.
//

#import "MXWPokerView.h"


@interface MXWPokerView ()

/// 点数
@property (nonatomic, strong) UILabel *pointsNumLabel;
/// 花色
@property (nonatomic, strong) UILabel *pokerColorLabel;
/// 花色类型
@property (nonatomic, assign) PokerColorType colorTyp;

@end

@implementation MXWPokerView


- (void)dealloc
{
    DLog(@"1");
}


-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]){
        
        [self createUI];
    }
    return self;
}

/// 数据清空
- (void)dataClear {
    self.pointsNumLabel.text = @"";
    self.pokerColorLabel.text = @"";
}

- (void)setModel:(PlayCardModel *)model {
    _model = model;
    
    
    self.pointsNumLabel.text = model.cardStr;
    self.pokerColorLabel.text = model.suitSymbol;
    self.colorTyp = self.model.colorTyp;
}

- (void)setColorTyp:(PokerColorType)colorTyp {
    _colorTyp = colorTyp;
    
    switch (colorTyp) {
        case PokerColorType_Diamonds:
        case PokerColorType_Hearts:
            self.pointsNumLabel.textColor = [UIColor redColor];
            self.pokerColorLabel.textColor = [UIColor redColor];
            break;
        case PokerColorType_Clubs:
        case PokerColorType_Spades:
            self.pointsNumLabel.textColor = [UIColor blackColor];
            self.pokerColorLabel.textColor = [UIColor blackColor];
            break;
        default:
            break;
    }
}


- (void)createUI {
//    self.clipsToBounds = true;
//    self.backgroundColor = [UIColor whiteColor];
    
    
    UIView *backView = [[UIView alloc] init];
    backView.backgroundColor = [UIColor whiteColor];
    backView.layer.cornerRadius = 3;
    backView.layer.masksToBounds = YES;
    [self addSubview:backView];
    
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self);
    }];
    
    UILabel *pointsNumLabel = [[UILabel alloc] init];
    pointsNumLabel.text = @"--";
    pointsNumLabel.font = [UIFont boldSystemFontOfSize:20];
    pointsNumLabel.textColor = [UIColor blackColor];
    pointsNumLabel.textAlignment = NSTextAlignmentCenter;
    [backView addSubview:pointsNumLabel];
    _pointsNumLabel = pointsNumLabel;
    
    [pointsNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView.mas_top).offset(0);
        make.centerX.equalTo(backView.mas_centerX);
    }];
    
    
    UILabel *pokerColorLabel = [[UILabel alloc] init];
    pokerColorLabel.text = @"--";
    pokerColorLabel.font = [UIFont systemFontOfSize:20];
    pokerColorLabel.textColor = [UIColor blackColor];
    pokerColorLabel.textAlignment = NSTextAlignmentCenter;
    [backView addSubview:pokerColorLabel];
    _pokerColorLabel = pokerColorLabel;
    
    [pokerColorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(backView.mas_bottom).offset(0);
        make.centerX.equalTo(backView.mas_centerX);
    }];
    
}



- (void)layoutSubviews {
    [super layoutSubviews];
    self.layer.masksToBounds = true;
}


@end


