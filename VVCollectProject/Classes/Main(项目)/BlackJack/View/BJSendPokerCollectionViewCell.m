//
//  BJSendPokerCollectionViewCell.m
//  VVCollectProject
//
//  Created by Admin on 2021/12/11.
//  Copyright © 2021 Mike. All rights reserved.
//

#import "BJSendPokerCollectionViewCell.h"
#import "BaccaratResultModel.h"

@interface BJSendPokerCollectionViewCell ()
@property (nonatomic, strong) UIView *backView;
/// 扑克字符(点数)
@property (nonatomic, strong) UILabel *pokerTextLabel;
/// 扑克花色
@property (nonatomic, strong) UILabel *pokerColorLabel;


@end

@implementation BJSendPokerCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self createUI];
    }
    return self;
}

- (void)clearDataContent {
    self.backView.backgroundColor = [UIColor clearColor];
    self.backView.layer.borderWidth = 0;
    self.pokerTextLabel.text = @"";
    self.pokerColorLabel.text = @"";
    
}

- (void)setModel:(PokerCardModel *)model {
    _model = model;
    
    self.pokerTextLabel.text = model.cardStr;
    self.pokerColorLabel.text = model.suitSymbol;
    
    [self setLabelColorTypp:self.model.colorTyp];
    
    
    
    self.backView.backgroundColor = [UIColor whiteColor];
    self.backView.layer.borderWidth = 1;
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
//    self.backgroundColor = [UIColor whiteColor];
    
    
    UIView *backView = [[UIView alloc] init];
    backView.backgroundColor = [UIColor whiteColor];
    backView.layer.cornerRadius = 3;
    backView.layer.masksToBounds = YES;
    backView.layer.borderWidth = 1;
    backView.layer.borderColor = [UIColor blackColor].CGColor;
    [self addSubview:backView];
    _backView = backView;
    
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self);
    }];
    
    UILabel *pokerTextLabel = [[UILabel alloc] init];
    pokerTextLabel.text = @"";
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
    pokerColorLabel.text = @"";
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


@end

