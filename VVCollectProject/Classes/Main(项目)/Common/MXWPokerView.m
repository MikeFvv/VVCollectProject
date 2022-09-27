//
//  MXWPokerView.m
//  VVCollectProject
//
//  Created by Admin on 2021/12/9.
//  Copyright © 2021 Mike. All rights reserved.
//

#import "MXWPokerView.h"


@interface MXWPokerView ()

/// 扑克字符(点数)
@property (nonatomic, strong) UILabel *pokerTextLabel;
/// 扑克花色
@property (nonatomic, strong) UILabel *pokerColorLabel;
/// 花色类型
@property (nonatomic, assign) CardColorType colorTyp;

@end

@implementation MXWPokerView


- (void)dealloc
{
    BMLog(@"1");
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
    self.pokerTextLabel.text = @"";
    self.pokerColorLabel.text = @"";
}

- (void)setModel:(PokerCardModel *)model {
    _model = model;
    
    
    self.pokerTextLabel.text = model.cardStr;
    self.pokerColorLabel.text = model.suitSymbol;
    self.colorTyp = self.model.colorTyp;
}

- (void)setColorTyp:(CardColorType)colorTyp {
    _colorTyp = colorTyp;
    
    switch (colorTyp) {
        case DIAMONDS:
        case HEARTS:
            self.pokerTextLabel.textColor = [UIColor redColor];
            self.pokerColorLabel.textColor = [UIColor redColor];
            break;
        case CLUBS:
        case SPADES:
            self.pokerTextLabel.textColor = [UIColor blackColor];
            self.pokerColorLabel.textColor = [UIColor blackColor];
            break;
        default:
            break;
    }
}

- (void)setFromType:(NSInteger)fromType {
    _fromType = fromType;
    
    if (fromType == 1) {
        self.pokerTextLabel.font = [UIFont boldSystemFontOfSize:30];
        self.pokerColorLabel.font = [UIFont systemFontOfSize:30];
    }
}

- (void)createUI {
//    self.clipsToBounds = true;
//    self.backgroundColor = [UIColor whiteColor];
    
    
    UIView *backView = [[UIView alloc] init];
    backView.backgroundColor = [UIColor whiteColor];
    backView.layer.cornerRadius = 3;
    backView.layer.masksToBounds = YES;
    backView.layer.borderWidth = 1;
    backView.layer.borderColor = [UIColor blackColor].CGColor;
    
    [self addSubview:backView];
    
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self);
    }];
    
    UILabel *pokerTextLabel = [[UILabel alloc] init];
    pokerTextLabel.text = @"--";
    pokerTextLabel.font = [UIFont boldSystemFontOfSize:20];
    pokerTextLabel.textColor = [UIColor blackColor];
    pokerTextLabel.textAlignment = NSTextAlignmentCenter;
    [backView addSubview:pokerTextLabel];
    _pokerTextLabel = pokerTextLabel;
    
    [pokerTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
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


