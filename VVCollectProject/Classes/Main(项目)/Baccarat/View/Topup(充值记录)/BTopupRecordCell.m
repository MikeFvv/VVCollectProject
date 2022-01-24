//
//  BTopupRecordCell.m
//  VVCollectProject
//
//  Created by Admin on 2022/1/25.
//  Copyright © 2022 Mike. All rights reserved.
//

#import "BTopupRecordCell.h"
#import "BaccaratResultModel.h"
#import "VVFunctionManager.h"
#import "BBorPorTPairS6View.h"
#import "BPockerPBView.h"
#import "BalanceRecordModel.h"



@interface BTopupRecordCell ()

@property (nonatomic, strong) UILabel *indexLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *typeLabel;
@property (nonatomic, strong) UILabel *winLoseMoneyLabel;

@end

@implementation BTopupRecordCell


+ (instancetype)cellWithTableView:(UITableView *)tableView reusableId:(NSString *)ID
{
    BTopupRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[BTopupRecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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


- (void)setModel:(BalanceRecordModel *)model {
    _model = model;
    
    _indexLabel.text =  [NSString stringWithFormat:@"%ld", self.index];
    self.timeLabel.text = model.update_time;
    self.typeLabel.text = model.rechargeType;
    self.winLoseMoneyLabel.text = [NSString stringWithFormat:@"%ld", model.money];
    
}


- (void)setupUI {
    
    self.contentView.backgroundColor = [UIColor colorWithHex:@"3C0C0E"];
    
    UIView *backView = [[UIView alloc] init];
    backView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    _indexLabel = [UILabel new];
    [backView addSubview:_indexLabel];
    _indexLabel.font = [UIFont systemFontOfSize:12];
    _indexLabel.textColor = [UIColor whiteColor];
    
    [_indexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView.mas_left).offset(5);
        make.centerY.equalTo(backView.mas_centerY);
    }];
    
    UIView *verLine1 = [[UIView alloc] init];
    verLine1.backgroundColor = [UIColor lightGrayColor];
    [backView addSubview:verLine1];
    
    [verLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(backView);
        make.left.equalTo(backView.mas_left).offset(30);
        make.width.equalTo(@(0.5));
    }];
    
    
    _timeLabel = [UILabel new];
    [backView addSubview:_timeLabel];
    _timeLabel.font = [UIFont systemFontOfSize:13];
    _timeLabel.textColor = [UIColor whiteColor];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(verLine1.mas_right).offset(5);
        make.centerY.equalTo(backView.mas_centerY);
    }];
    
    
    UIView *verLine2 = [[UIView alloc] init];
    verLine2.backgroundColor = [UIColor lightGrayColor];
    [backView addSubview:verLine2];
    
    [verLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(backView);
        make.left.equalTo(backView.mas_left).offset(220);
        make.width.equalTo(@(0.5));
    }];
    
    
    
    UILabel *typeLabel = [UILabel new];
    [backView addSubview:typeLabel];
    typeLabel.font = [UIFont systemFontOfSize:14];
    typeLabel.textColor = [UIColor whiteColor];
    _typeLabel = typeLabel;
    
    [typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(verLine2.mas_right).offset(20);
        make.centerY.equalTo(backView.mas_centerY);
    }];
    
    UIView *verLine3 = [[UIView alloc] init];
    verLine3.backgroundColor = [UIColor lightGrayColor];
    [backView addSubview:verLine3];
    
    [verLine3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(backView);
        make.left.equalTo(backView.mas_left).offset(360);
        make.width.equalTo(@(0.5));
    }];
    
    
    _winLoseMoneyLabel = [UILabel new];
    [backView addSubview:_winLoseMoneyLabel];
    _winLoseMoneyLabel.font = [UIFont systemFontOfSize:20];
    _winLoseMoneyLabel.textColor = [UIColor greenColor];
    _winLoseMoneyLabel.textAlignment = NSTextAlignmentRight;
    [_winLoseMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(backView.mas_right).offset(-40);
        make.centerY.equalTo(backView.mas_centerY);
    }];
    
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [backView addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(backView);
        make.height.equalTo(@(0.5));
    }];
    
}





- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //    _headImageView.frame = CGRectMake(15, 30, 20, 20);
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}




////添加手势事件
//UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onShadowViewDisappear)];
////将手势添加到需要相应的view中去
//[self.shadowView addGestureRecognizer:tapGesture];
////选择触发事件的方式（默认单机触发）
//[tapGesture setNumberOfTapsRequired:1];


@end


