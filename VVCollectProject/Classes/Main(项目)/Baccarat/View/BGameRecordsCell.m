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

@property (nonatomic, strong) UILabel *nameMLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *countLabel;

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
    
    _nameMLabel = [UILabel new];
    _nameMLabel.text = @"B";
    _nameMLabel.layer.cornerRadius = 16/2;
    _nameMLabel.layer.masksToBounds = YES;
    _nameMLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_nameMLabel];
    _nameMLabel.font = [UIFont boldSystemFontOfSize:14];
    _nameMLabel.textColor = [UIColor whiteColor];
    _nameMLabel.backgroundColor =[UIColor redColor];
    
    [_nameMLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(5);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.size.mas_equalTo(16);
    }];
    
    _titleLabel = [UILabel new];
    _titleLabel.text = @"B";
    _titleLabel.font = [UIFont systemFontOfSize:14];
    _titleLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:_titleLabel];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameMLabel.mas_right).offset(5);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    
    _countLabel = [UILabel new];
    _countLabel.text = @"10";
    _countLabel.font = [UIFont boldSystemFontOfSize:14];
    _countLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:_countLabel];
    
    [_countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor darkGrayColor];
    [self addSubview:lineView];
    
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


