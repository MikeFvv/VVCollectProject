//
//  BaccaratCell.m
//  VVCollectProject
//
//  Created by Mike on 2019/2/22.
//  Copyright © 2019 Mike. All rights reserved.
//

#import "BaccaratCell.h"
#import "BaccaratModel.h"

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
    BaccaratCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[BaccaratCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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
        make.left.equalTo(self.mas_left).offset(36);
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

- (NSString *)pokerCharacter:(NSInteger)num {
    switch (num) {
        case 1:
            return @"A";
            break;
        case 2:
            case 3:
            case 4:
            case 5:
            case 6:
            case 7:
            case 8:
            case 9:
        case 10:
            return [NSString stringWithFormat:@"%ld", num];
        case 11:
            return @"L";
            break;
        case 12:
            return @"Q";
            break;
        case 13:
            return @"K";
            break;
        default:
            break;
    }
    return nil;
}


- (void)setModel:(id)model {
    BaccaratModel *bModel;
    if ([model isKindOfClass:[BaccaratModel class]]) {
        bModel = model;
    } else {
        return;
    }
    
    _indexLabel.text =  [NSString stringWithFormat:@"%ld", bModel.pokerCount];
    NSString *playerStr = [NSString stringWithFormat:@"Player: %ld点 %@  %@  %@", bModel.playerPointsNum,  [self pokerCharacter: bModel.player1], [self pokerCharacter: bModel.player2], bModel.player3.length > 0 ? [self pokerCharacter: [bModel.player3 integerValue]] : @""];
    
    
    NSString *bankerStr = [NSString stringWithFormat:@"Banker: %ld点 %@  %@  %@", bModel.bankerPointsNum, [self pokerCharacter: bModel.banker1], [self pokerCharacter: bModel.banker2], bModel.banker3.length > 0 ? [self pokerCharacter: [bModel.banker3 integerValue]] : @""];
    
    self.playerLabel.text = playerStr;
    self.bankerLabel.text = bankerStr;
    
    NSString *resultStr;
    if (bModel.winType == WinType_Banker) {
        resultStr = @"🔴";
    } else if (bModel.winType == WinType_Player) {
        resultStr = @"🅿️";
    } else {
        resultStr = @"✅";
    }
    
    if (bModel.isSuperSix) {
        resultStr = [NSString stringWithFormat:@"%@🔸", resultStr];
    }
    if (bModel.isPlayerPair) {
        resultStr = [NSString stringWithFormat:@"%@🔹", resultStr];
    }
    if (bModel.isBankerPair) {
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

