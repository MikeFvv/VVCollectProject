//
//  BStatisticssReusableView.m
//  VVCollectProject
//
//  Created by Admin on 2022/1/2.
//  Copyright © 2022 Mike. All rights reserved.
//

#import "BStatisticssReusableView.h"

@implementation BStatisticssReusableView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    
    self.backgroundColor = [UIColor orangeColor];
 
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"--";
    titleLabel.font = [UIFont fontWithName:@"PingFang SC" size:18];
    titleLabel.textColor = [UIColor redColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.numberOfLines = 1;
    [self addSubview:titleLabel];
    _titleLabel = titleLabel;
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).offset(10);
        make.right.equalTo(self.mas_right).offset(-10);
    }];
}


@end

