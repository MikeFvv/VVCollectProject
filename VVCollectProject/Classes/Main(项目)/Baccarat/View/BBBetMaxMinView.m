//
//  BBBetMaxMinView.m
//  VVCollectProject
//
//  Created by Admin on 2021/12/26.
//  Copyright © 2021 Mike. All rights reserved.
//

#import "BBBetMaxMinView.h"

@interface BBBetMaxMinView ()
///
@property (nonatomic, strong) UILabel *minLabel;
@property (nonatomic, strong) UILabel *maxLabel;

@end

@implementation BBBetMaxMinView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    self.backgroundColor = [UIColor colorWithHex:@"6A0222"];
    
    UILabel *minTtLabel = [[UILabel alloc] init];
    minTtLabel.text = @"MIN";
    minTtLabel.font = [UIFont boldSystemFontOfSize:14];
    minTtLabel.textColor = [UIColor colorWithHex:@"BCAF94"];
    minTtLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:minTtLabel];
    
    [minTtLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(1);
        make.left.equalTo(self.mas_left).offset(10);
        make.width.mas_equalTo(80);
    }];
    
    UILabel *minLabel = [[UILabel alloc] init];
    minLabel.text = @"1,000";
    minLabel.font = [UIFont boldSystemFontOfSize:14];
    minLabel.textColor = [UIColor colorWithHex:@"BCAF94"];
    minLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:minLabel];
    
    [minLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(minTtLabel.mas_bottom);
        make.left.equalTo(self.mas_left).offset(10);
        make.width.mas_equalTo(80);
    }];
    
    
    UILabel *maxTtLabel = [[UILabel alloc] init];
    maxTtLabel.text = @"MIN";
    maxTtLabel.font = [UIFont boldSystemFontOfSize:14];
    maxTtLabel.textColor = [UIColor colorWithHex:@"BCAF94"];
    maxTtLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:maxTtLabel];
    
    [maxTtLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(1);
        make.left.equalTo(minTtLabel.mas_right).offset(10);
        make.width.mas_equalTo(80);
    }];
    
    UILabel *maxLabel = [[UILabel alloc] init];
    maxLabel.text = @"2,000,000";
    maxLabel.font = [UIFont boldSystemFontOfSize:14];
    maxLabel.textColor = [UIColor colorWithHex:@"BCAF94"];
    maxLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:maxLabel];
    
    [maxLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(maxTtLabel.mas_bottom);
        make.left.equalTo(minTtLabel.mas_right).offset(10);
        make.width.mas_equalTo(120);
    }];
}


@end
