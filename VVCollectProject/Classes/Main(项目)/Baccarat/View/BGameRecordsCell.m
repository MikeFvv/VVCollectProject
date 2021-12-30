//
//  BGameRecordsCell.m
//  VVCollectProject
//
//  Created by Admin on 2021/12/19.
//  Copyright © 2021 Mike. All rights reserved.
//

#import "BGameRecordsCell.h"
#import "BaccaratResultModel.h"
#import "VVFunctionManager.h"

@interface BGameRecordsCell()

@end

@implementation BGameRecordsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (instancetype)cellWithTableView:(UITableView *)tableView reusableId:(NSString *)ID
{
    BGameRecordsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[BGameRecordsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}


- (void)setupUI {
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    _nameMLabel = [UILabel new];
    _nameMLabel.text = @"B";
    _nameMLabel.layer.cornerRadius = 14/2;
    _nameMLabel.layer.masksToBounds = YES;
    _nameMLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_nameMLabel];
    _nameMLabel.font = [UIFont boldSystemFontOfSize:12];
    _nameMLabel.textColor = [UIColor whiteColor];
    _nameMLabel.backgroundColor =[UIColor redColor];
    
    [_nameMLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(5);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.size.mas_equalTo(14);
    }];
    
    _titleLabel = [UILabel new];
    _titleLabel.text = @"Banker";
    _titleLabel.font = [UIFont systemFontOfSize:8];
    _titleLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:_titleLabel];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameMLabel.mas_right).offset(0);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    
    _countLabel = [UILabel new];
    _countLabel.text = @"10";
    _countLabel.font = [UIFont boldSystemFontOfSize:12];
    _countLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:_countLabel];
    
    [_countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-5);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self);
        make.height.equalTo(@(1));
    }];
    
}




- (void)layoutSubviews
{
    [super layoutSubviews];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}



@end


