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
    nameLabel.text = @"ID：";
    nameLabel.font = [UIFont systemFontOfSize:14];
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
    imgView.image = [UIImage imageNamed:@"test-11"];
    [self addSubview:imgView];
    _imgView = imgView;
    
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameLabel.mas_bottom).offset(0);
        make.left.equalTo(self.mas_left).offset(5);
        make.right.equalTo(self.mas_right).offset(-5);
        make.height.equalTo(@(45));
    }];
    
    UILabel *userMoneyLabel = [[UILabel alloc] init];
    userMoneyLabel.text = @"0";
    userMoneyLabel.font = [UIFont boldSystemFontOfSize:14];
    userMoneyLabel.textColor = [UIColor redColor];
    userMoneyLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:userMoneyLabel];
    _userMoneyLabel = userMoneyLabel;
    
    [userMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imgView.mas_bottom).offset(0);
        make.left.equalTo(self.mas_left).offset(0);
        make.right.equalTo(self.mas_right).offset(0);
    }];
}

@end
