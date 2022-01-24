//
//  BTopupCollectionCell.m
//  VVCollectProject
//
//  Created by Admin on 2022/1/25.
//  Copyright © 2022 Mike. All rights reserved.
//

#import "BTopupCollectionCell.h"

@implementation BTopupCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self creactUI];
    }
    return self;
}




- (void)creactUI {
    
    self.backgroundColor = [UIColor blackColor];
    self.layer.cornerRadius = 3;
    self.layer.masksToBounds = YES;
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"充值";
    titleLabel.font = [UIFont boldSystemFontOfSize:14];
    titleLabel.textColor = [UIColor colorWithHex:@"976F70"];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.numberOfLines = 1;
    [self.contentView addSubview:titleLabel];
    _titleLabel = titleLabel;
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(2);
        make.centerX.equalTo(self.contentView.mas_centerX);
    }];
    
    UILabel *numLabel = [[UILabel alloc] init];
    numLabel.text = @"--";
    numLabel.font = [UIFont boldSystemFontOfSize:18];
    numLabel.textColor = [UIColor whiteColor];
    numLabel.textAlignment = NSTextAlignmentLeft;
    numLabel.numberOfLines = 1;
    [self.contentView addSubview:numLabel];
    _numLabel = numLabel;
    
    [numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-2);
        make.centerX.equalTo(self.contentView.mas_centerX);
    }];
}


@end

