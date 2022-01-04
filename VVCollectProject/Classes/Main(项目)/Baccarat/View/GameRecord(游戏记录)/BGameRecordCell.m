//
//  BaccaratCell.m
//  VVCollectProject
//
//  Created by Mike on 2019/2/22.
//  Copyright © 2019 Mike. All rights reserved.
//

#import "BGameRecordCell.h"
#import "BaccaratResultModel.h"
#import "VVFunctionManager.h"
#import "BBorPorTPairS6View.h"
#import "BPockerPBView.h"

@interface BGameRecordCell()


@property (nonatomic, strong) UILabel *indexLabel;
@property (nonatomic, strong) BBorPorTPairS6View *winResultView;

@property (nonatomic, strong) BPockerPBView *playerPockerPBView;
@property (nonatomic, strong) BPockerPBView *bankerPockerPBView;

@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *playerPointsLabel;
@property (nonatomic, strong) UILabel *bankerPointsLabel;

@property (nonatomic, strong) UILabel *winLoseMoneyLabel;

@end

@implementation BGameRecordCell


+ (instancetype)cellWithTableView:(UITableView *)tableView reusableId:(NSString *)ID
{
    BGameRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[BGameRecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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


- (void)setModel:(id)model {
    BaccaratResultModel *bModel;
    if ([model isKindOfClass:[BaccaratResultModel class]]) {
        bModel = model;
    } else {
        return;
    }
    
    _indexLabel.text =  [NSString stringWithFormat:@"%ld", self.index];
    self.winResultView.model = bModel;
    
    self.playerPointsLabel.text = [NSString stringWithFormat:@"%ld", bModel.playerTotalPoints];
    self.bankerPointsLabel.text = [NSString stringWithFormat:@"%ld", bModel.bankerTotalPoints];
    
    self.playerPockerPBView.sendCardDataArray = bModel.playerArray;
    self.bankerPockerPBView.sendCardDataArray = bModel.bankerArray;
    
    self.timeLabel.text = bModel.createTime;
    
    if (bModel.betMoney > 0) {
        if (1) {
            self.winLoseMoneyLabel.textColor = [UIColor greenColor];
            self.winLoseMoneyLabel.text = [NSString stringWithFormat:@"+%ld",bModel.betMoney];
        } else {
            self.winLoseMoneyLabel.textColor = [UIColor redColor];
            self.winLoseMoneyLabel.text = [NSString stringWithFormat:@"%ld",bModel.betMoney];
        }
    } else {
        self.winLoseMoneyLabel.textColor = [UIColor whiteColor];
        self.winLoseMoneyLabel.text = @"越过本局";
    }
    
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
    
    BBorPorTPairS6View *winResultView = [[BBorPorTPairS6View alloc] init];
    [backView addSubview: winResultView];
    _winResultView = winResultView;
    [winResultView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView.mas_left).offset(25);
        make.centerY.equalTo(backView.mas_centerY);
        make.size.mas_equalTo(25);
    }];
    
    
    UILabel *pppLabel = [UILabel new];
    [backView addSubview:pppLabel];
    pppLabel.font = [UIFont boldSystemFontOfSize:20];
    pppLabel.textColor = [UIColor blueColor];
    _playerPointsLabel = pppLabel;
    
    [pppLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(winResultView.mas_right).offset(10);
        make.centerY.equalTo(backView.mas_centerY);
    }];
    
    UILabel *bbbLabel = [UILabel new];
    [backView addSubview:bbbLabel];
    bbbLabel.font = [UIFont boldSystemFontOfSize:20];
    bbbLabel.textColor = [UIColor redColor];
    _bankerPointsLabel = bbbLabel;
    
    [bbbLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(winResultView.mas_right).offset(180);
        make.centerY.equalTo(backView.mas_centerY);
    }];
    
    
    CGFloat pWidth = 63;
    CGFloat pHeight = 30;
    BPockerPBView *playerPockerPBView = [[BPockerPBView alloc] initWithFrame:CGRectMake(0, 5, pWidth, pHeight)];
    [backView addSubview:playerPockerPBView];
    _playerPockerPBView = playerPockerPBView;
    [playerPockerPBView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(pppLabel.mas_right).offset(10);
        make.centerY.equalTo(backView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(pWidth, pHeight));
    }];
    
    BPockerPBView *bankerPockerPBView = [[BPockerPBView alloc] initWithFrame:CGRectMake(0, 5, pWidth, pHeight)];
    [backView addSubview:bankerPockerPBView];
    _bankerPockerPBView = bankerPockerPBView;
    [bankerPockerPBView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(playerPockerPBView.mas_right).offset(10);
        make.centerY.equalTo(backView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(pWidth, pHeight));
    }];
    
    _timeLabel = [UILabel new];
    [backView addSubview:_timeLabel];
    _timeLabel.font = [UIFont systemFontOfSize:10];
    _timeLabel.textColor = [UIColor whiteColor];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bbbLabel.mas_right).offset(15);
        make.centerY.equalTo(backView.mas_centerY);
    }];
    
    
    _winLoseMoneyLabel = [UILabel new];
    [backView addSubview:_winLoseMoneyLabel];
    _winLoseMoneyLabel.font = [UIFont systemFontOfSize:14];
//    _winLoseMoneyLabel.textColor = [UIColor purpleColor];
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

