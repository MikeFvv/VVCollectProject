//
//  BPockerTextView.m
//  VVCollectProject
//
//  Created by Admin on 2022/1/2.
//  Copyright © 2022 Mike. All rights reserved.
//

#import "BPockerTextView.h"

@interface BPockerTextView ()
/// 扑克字符(点数)
@property (nonatomic, strong) UILabel *pokerTextLabel;
/// 扑克花色
@property (nonatomic, strong) UILabel *pokerColorLabel;
@end

@implementation BPockerTextView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}


- (void)setModel:(PokerCardModel *)model {
    _model = model;
    
    self.pokerTextLabel.text = model.cardStr;
    self.pokerColorLabel.text = model.suitSymbol;

    [self setLabelColorTypp:self.model.colorTyp];

    self.backgroundColor = [UIColor whiteColor];
    self.layer.borderWidth = 1;
}

- (void)setLabelColorTypp:(CardColorType)colorTyp {
    
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

- (void)createUI {
    self.backgroundColor = [UIColor whiteColor];
    
    UILabel *pokerTextLabel = [[UILabel alloc] init];
    pokerTextLabel.text = @"";
    pokerTextLabel.font = [UIFont boldSystemFontOfSize:20];
    pokerTextLabel.textColor = [UIColor blackColor];
    pokerTextLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:pokerTextLabel];
    _pokerTextLabel = pokerTextLabel;

    [pokerTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(0);
        make.centerX.equalTo(self.mas_centerX);
    }];


    UILabel *pokerColorLabel = [[UILabel alloc] init];
    pokerColorLabel.text = @"";
    pokerColorLabel.font = [UIFont systemFontOfSize:20];
    pokerColorLabel.textColor = [UIColor blackColor];
    pokerColorLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:pokerColorLabel];
    _pokerColorLabel = pokerColorLabel;

    [pokerColorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(0);
        make.centerX.equalTo(self.mas_centerX);
    }];
    
}

@end
