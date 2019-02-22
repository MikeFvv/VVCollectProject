//
//  BaccaratCell.m
//  VVCollectProject
//
//  Created by 罗耀生 on 2019/2/22.
//  Copyright © 2019 Mike. All rights reserved.
//

#import "BaccaratCell.h"

@interface BaccaratCell()

@property (nonatomic, strong) UILabel *indexLabel;

@property (nonatomic, strong) UILabel *playerLabel;

@property (nonatomic, strong) UILabel *bankerLabel;
@property (nonatomic, strong) UILabel *resultLabel;



@end

@implementation BaccaratCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (instancetype)cellWithTableView:(UITableView *)tableView reusableId:(NSString *)ID
{
    BaccaratCell *cell = [[BaccaratCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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
    
    
    _indexLabel = [UILabel new];
    [self.contentView addSubview:_indexLabel];
    _indexLabel.font = [UIFont systemFontOfSize:15];
    _indexLabel.textColor = [UIColor darkGrayColor];
    
    [_indexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(8);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    _playerLabel = [UILabel new];
    [self.contentView addSubview:_playerLabel];
    _playerLabel.font = [UIFont systemFontOfSize:14];
    _playerLabel.textColor = [UIColor blueColor];
    
    [_playerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(40);
        make.right.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    _bankerLabel = [UILabel new];
    [self.contentView addSubview:_bankerLabel];
    _bankerLabel.font = [UIFont systemFontOfSize:14];
    _bankerLabel.textColor = [UIColor redColor];
    
    [_bankerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_centerX).offset(-20);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    _resultLabel = [UILabel new];
    //    _resultLabel.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:_resultLabel];
    _resultLabel.font = [UIFont systemFontOfSize:14];
    _resultLabel.textColor = [UIColor redColor];
    
    [_resultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right);
        make.left.equalTo(self.mas_right).offset(-70);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self);
        make.height.equalTo(@(0.5));
    }];
    
}

- (void)setModel:(id)model {
    NSDictionary *dict = (NSDictionary *)model;
    NSString *player3 = [dict objectForKey:@"player3"];
    NSString *banker3 = [dict objectForKey:@"banker3"];
    
    _indexLabel.text =  [dict objectForKey:@"index"];
    NSString *playerStr = [NSString stringWithFormat:@"Player: %@点 %@  %@  %@", [dict objectForKey:@"playerPointsNum"], [dict objectForKey:@"player1"], [dict objectForKey:@"player2"], player3.length > 0 ? player3 : @""];
    
    NSString *bankerStr = [NSString stringWithFormat:@"Banker: %@点 %@  %@  %@", [dict objectForKey:@"bankerPointsNum"], [dict objectForKey:@"banker1"], [dict objectForKey:@"banker2"], banker3.length > 0 ? banker3 : @""];
    
    self.playerLabel.text = playerStr;
    self.bankerLabel.text = bankerStr;
    
    NSString *resultStr;
    if ([[dict objectForKey:@"WinType"] integerValue] == 0) {
        resultStr = @"🔴";
    } else if ([[dict objectForKey:@"WinType"] integerValue] == 1) {
        resultStr = @"🅿️";
    } else {
        resultStr = @"✅";
    }
    
    if ([[dict objectForKey:@"isSuperSix"] boolValue]) {
        resultStr = [NSString stringWithFormat:@"%@🔸", resultStr];
    }
    if ([[dict objectForKey:@"isPlayerPair"] boolValue]) {
        resultStr = [NSString stringWithFormat:@"%@🔹", resultStr];
    }
    if ([[dict objectForKey:@"isBankerPair"] boolValue]) {
        resultStr = [NSString stringWithFormat:@"%@🔺", resultStr];
    }
    
    self.resultLabel.text = resultStr;
    
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

@end
