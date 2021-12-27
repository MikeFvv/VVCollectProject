//
//  ChipsCollectionViewCell.m
//  VVCollectProject
//
//  Created by Admin on 2021/12/19.
//  Copyright © 2021 Mike. All rights reserved.
//

#import "ChipsCollectionViewCell.h"

@interface ChipsCollectionViewCell ()
/// 背景图
@property (nonatomic, strong) UIImageView *backImageView;
/// 名称
@property (nonatomic, strong) UILabel *nameLabel;

@end

@implementation ChipsCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self createUI];
    }
    return self;
}

- (void)setModel:(ChipsModel *)model {
    _model = model;
    
    self.backImageView.image = [UIImage imageNamed:model.normal_chipsImg];
//    self.nameLabel.text = model.moneyStr;
}
-(void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    
    if (self.selected) {
        self.backImageView.image = [UIImage imageNamed:self.model.selected_chipsImg];
        
        [self.backImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(@(50));
        }];
    } else {
        self.backImageView.image = [UIImage imageNamed:self.model.normal_chipsImg];
        
        [self.backImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(@(40));
        }];
    }
}

- (void)createUI {
    
    UIImageView *backImageView = [[UIImageView alloc] init];
    backImageView.image = [UIImage imageNamed:@"imageName"];
    backImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:backImageView];
    _backImageView = backImageView;
    
    [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.size.equalTo(@(40));
    }];
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.text = @"--";
    nameLabel.font = [UIFont boldSystemFontOfSize:10];
    nameLabel.textColor = [UIColor blackColor];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    [backImageView addSubview:nameLabel];
    _nameLabel = nameLabel;
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(backImageView.mas_centerX);
        make.centerY.equalTo(backImageView.mas_centerY);
    }];
    
}


@end

