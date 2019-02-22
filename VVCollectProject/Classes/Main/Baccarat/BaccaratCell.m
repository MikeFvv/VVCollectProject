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
    _indexLabel.font = [UIFont systemFontOfSize:16];
    _indexLabel.textColor = [UIColor darkGrayColor];
    
    [_indexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(8);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    _playerLabel = [UILabel new];
    [self.contentView addSubview:_playerLabel];
    _playerLabel.font = [UIFont systemFontOfSize:16];
    _playerLabel.textColor = [UIColor blueColor];
    
    [_playerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(40);
        make.right.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    _bankerLabel = [UILabel new];
    [self.contentView addSubview:_bankerLabel];
    _bankerLabel.font = [UIFont systemFontOfSize:16];
    _bankerLabel.textColor = [UIColor redColor];
    
    [_bankerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_centerX).offset(10);
        make.right.equalTo(self.mas_right).offset(-20);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self);
        make.height.equalTo(@(1));
    }];
   
}

- (void)setModel:(id)model {
   NSDictionary *dict = (NSDictionary *)model;
    NSString *player3 = [dict objectForKey:@"player3"];
    NSString *banker3 = [dict objectForKey:@"banker3"];
    
 _indexLabel.text =  [dict objectForKey:@"index"];
   NSString *playerStr = [NSString stringWithFormat:@"Player: %@点 %@  %@  %@", [dict objectForKey:@"playerPointsNum"], [dict objectForKey:@"player1"], [dict objectForKey:@"player2"], player3.length > 0 ? player3 : @""];
    
   NSString *bankerStr = [NSString stringWithFormat:@"Banker: %@点 %@  %@  %@", [dict objectForKey:@"bankerPointsNum"], [dict objectForKey:@"banker1"], [dict objectForKey:@"banker2"], banker3.length > 0 ? banker3 : @""];
    
    _playerLabel.text = playerStr;
    _bankerLabel.text = bankerStr;
    
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

