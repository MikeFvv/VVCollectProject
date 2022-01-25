//
//  BUserChipssView.m
//  VVCollectProject
//
//  Created by Admin on 2021/12/27.
//  Copyright © 2021 Mike. All rights reserved.
//

#import "BUserChipssView.h"

@implementation BUserChipssView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    self.backgroundColor = [UIColor whiteColor];
    
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor colorWithRed:0.643 green:0.000 blue:0.357 alpha:1.000].CGColor;
    
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.text = @"ID：赌神？";
    nameLabel.font = [UIFont systemFontOfSize:10];
    nameLabel.textColor = [UIColor darkGrayColor];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:nameLabel];
    _nameLabel = nameLabel;
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(0);
        make.left.equalTo(self.mas_left).offset(0);
        make.right.equalTo(self.mas_right).offset(0);
    }];
    
    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.layer.cornerRadius = 50/2;
    imgView.layer.masksToBounds = YES;
    imgView.image = [UIImage imageNamed:@"com_ph_avatar_3"];
    [self addSubview:imgView];
    _imgView = imgView;
    
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameLabel.mas_bottom).offset(0);
        make.centerX.equalTo(self.mas_centerX);
        make.size.equalTo(@(50));
    }];
    
    UILabel *userMoneyLabel = [[UILabel alloc] init];
    userMoneyLabel.text = @"0";
    userMoneyLabel.font = [UIFont boldSystemFontOfSize:14];
    userMoneyLabel.textColor = [UIColor redColor];
    userMoneyLabel.textAlignment = NSTextAlignmentCenter;
    userMoneyLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview:userMoneyLabel];
    _userMoneyLabel = userMoneyLabel;
    
    [userMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imgView.mas_bottom).offset(0);
        make.left.equalTo(self.mas_left).offset(0);
        make.right.equalTo(self.mas_right).offset(0);
    }];
}

@end
