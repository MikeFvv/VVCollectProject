//
//  BlackJackCell.m
//  VVCollectProject
//
//  Created by Mike on 2019/3/12.
//  Copyright © 2019 Mike. All rights reserved.
//

#import "BlackJackCell.h"
#import "PlayCardModel.h"

#define kFontSizeLabel 12
#define kFontName  @"Futura"
//#define kFontName  @"Futuraaaae"

@interface BlackJackCell ()

@property (nonatomic, strong) UILabel *playerLabel;
@property (nonatomic, strong) UILabel *bankerLabel;
@property (nonatomic, strong) UILabel *playerOrbankerOrTieLabel;
@property (nonatomic, strong) UILabel *bustLabel;
@property (nonatomic, strong) UIView *playerPairView;
@property (nonatomic, strong) UILabel *pointsNumLabel;
@property (nonatomic, strong) UILabel *ALabel;
@property (nonatomic, strong) UILabel *doubleLabel;

@end

@implementation BlackJackCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



+ (instancetype)cellWithTableView:(UITableView *)tableView reusableId:(NSString *)ID
{
    BlackJackCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[BlackJackCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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
    
    
    UILabel *indexLabel = [[UILabel alloc] init];
    indexLabel.text = @"0";
    indexLabel.font = [UIFont systemFontOfSize:12];
    indexLabel.textColor = [UIColor darkGrayColor];
    [self addSubview:indexLabel];
    _indexLabel = indexLabel;
    
    [indexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(self.mas_left).offset(3);
    }];
    
    UILabel *playerLabel = [[UILabel alloc] init];
    playerLabel.text = @"player";
    playerLabel.font = [UIFont fontWithName:kFontName size:kFontSizeLabel];
    playerLabel.textColor = [UIColor darkGrayColor];
    playerLabel.numberOfLines = 0;
    playerLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:playerLabel];
    _playerLabel = playerLabel;
    
    [playerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(3);
        make.left.mas_equalTo(self.mas_left).offset(30);
    }];
   
    UILabel *bankerLabel = [[UILabel alloc] init];
    bankerLabel.text = @"banker";
    bankerLabel.font = [UIFont fontWithName:kFontName size:kFontSizeLabel];
    bankerLabel.textColor = [UIColor darkGrayColor];
    bankerLabel.numberOfLines = 0;
    bankerLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:bankerLabel];
    _bankerLabel = bankerLabel;
    
    [bankerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(playerLabel.mas_bottom).offset(2);
        make.left.mas_equalTo(playerLabel.mas_left);
    }];
    
    
    CGFloat yWidth = 22;
    
    UILabel *playerOrbankerOrTieLabel = [[UILabel alloc] init];
    playerOrbankerOrTieLabel.text = @"banker";
    playerOrbankerOrTieLabel.font = [UIFont boldSystemFontOfSize:18];
    playerOrbankerOrTieLabel.textColor = [UIColor whiteColor];
    playerOrbankerOrTieLabel.numberOfLines = 0;
    playerOrbankerOrTieLabel.textAlignment = NSTextAlignmentCenter;
    playerOrbankerOrTieLabel.layer.cornerRadius = yWidth/2;
    playerOrbankerOrTieLabel.layer.masksToBounds = YES;
    [self addSubview:playerOrbankerOrTieLabel];
    _playerOrbankerOrTieLabel = playerOrbankerOrTieLabel;
    
    [playerOrbankerOrTieLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-12);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(yWidth, yWidth));
    }];
    
    UIView *playerPairView = [[UIView alloc] init];
    playerPairView.backgroundColor = [UIColor colorWithRed:0.118 green:0.565 blue:1.000 alpha:1.000];
    playerPairView.layer.cornerRadius = 8/2;
    playerPairView.layer.masksToBounds = YES;
    _playerPairView = playerPairView;
    [self addSubview:playerPairView];
    
    [playerPairView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(playerOrbankerOrTieLabel.mas_bottom);
        make.right.mas_equalTo(playerOrbankerOrTieLabel.mas_right);
        make.size.mas_equalTo(@(8));
    }];
    
    
    UILabel *bustLabel = [[UILabel alloc] init];
    bustLabel.text = @"爆";
    bustLabel.font = [UIFont systemFontOfSize:15];
    bustLabel.textColor = [UIColor whiteColor];
    bustLabel.numberOfLines = 0;
    bustLabel.textAlignment = NSTextAlignmentCenter;
    bustLabel.layer.cornerRadius = yWidth/2;
    bustLabel.layer.masksToBounds = YES;
    [self addSubview:bustLabel];
    _bustLabel = bustLabel;
    
    [bustLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(playerOrbankerOrTieLabel.mas_left).offset(-2);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.size.mas_equalTo(@(yWidth));
    }];
    
    UILabel *pointsNumLabel = [[UILabel alloc] init];
    pointsNumLabel.text = @"-";
    pointsNumLabel.font = [UIFont systemFontOfSize:16];
    pointsNumLabel.textColor = [UIColor darkGrayColor];
    [self addSubview:pointsNumLabel];
    _pointsNumLabel = pointsNumLabel;
    
    [pointsNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(bustLabel.mas_left).offset(-5);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    
    UILabel *ALabel = [[UILabel alloc] init];
    ALabel.text = @"A";
    ALabel.font = [UIFont systemFontOfSize:16];
    ALabel.textColor = [UIColor whiteColor];
    ALabel.layer.cornerRadius = yWidth/2;
    ALabel.layer.masksToBounds = YES;
    ALabel.textAlignment = NSTextAlignmentCenter;
    ALabel.backgroundColor = [UIColor grayColor];
    [self addSubview:ALabel];
    _ALabel = ALabel;
    
    [ALabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(pointsNumLabel.mas_left).offset(-5);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.size.mas_equalTo(@(yWidth));
    }];
    
    UILabel *doubleLabel = [[UILabel alloc] init];
    doubleLabel.text = @"D";
    doubleLabel.font = [UIFont systemFontOfSize:16];
    doubleLabel.textColor = [UIColor whiteColor];
    doubleLabel.layer.cornerRadius = yWidth/2;
    doubleLabel.layer.masksToBounds = YES;
    doubleLabel.textAlignment = NSTextAlignmentCenter;
    doubleLabel.backgroundColor = [UIColor grayColor];
    [self addSubview:doubleLabel];
    _doubleLabel = doubleLabel;
    
    [doubleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(ALabel.mas_left).offset(-5);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.size.mas_equalTo(@(yWidth));
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
    NSArray *playerArray       = (NSArray *)[dict objectForKey:@"PlayerArray"];
    NSArray *bankerArray       = (NSArray *)[dict objectForKey:@"BankerArray"];
    NSString *winType       = [[dict objectForKey:@"WinType"] stringValue];
    
    NSInteger playerNum = 0;
    BOOL isPlayerA = NO;
    NSMutableString *playerStr = [NSMutableString string];
    for (NSInteger i = 0; i < playerArray.count; i++) {
        PlayCardModel *model = playerArray[i];
        [playerStr appendString:model.cardText];
        playerNum = playerNum + model.cardValue.integerValue;
        if (model.cardValue.integerValue == 1) {
            isPlayerA = YES;
        }
    }
    
    if (isPlayerA && (playerNum + 10 <= 21)) {
        playerNum = playerNum + 10;
    }
    
    NSInteger bankerNum = 0;
    BOOL isBankerA = NO;
    NSMutableString *bankerStr = [NSMutableString string];
    for (NSInteger j = 0; j < bankerArray.count; j++) {
        PlayCardModel *model = bankerArray[j];
        [bankerStr appendString:model.cardText];
        bankerNum = bankerNum + model.cardValue.integerValue;
        if (model.cardValue.integerValue == 1) {
            isBankerA = YES;
        }
    }
    
    if (isBankerA && (bankerNum + 10 <= 21)) {
        bankerNum = bankerNum + 10;
    }
    
    self.playerLabel.text = playerStr;
    self.bankerLabel.text = bankerStr;
    self.playerOrbankerOrTieLabel.text = [self bankerOrPlayerOrTie:winType];

    
    if ([winType integerValue] == 1) {
        self.playerOrbankerOrTieLabel.backgroundColor = [UIColor redColor];
    } else if ([winType integerValue] == 2) {
        self.playerOrbankerOrTieLabel.backgroundColor = [UIColor blueColor];
    } else {
        self.playerOrbankerOrTieLabel.backgroundColor = [UIColor greenColor];
    }
    
    
    // 爆牌
    if ([[dict objectForKey:@"PlayerBust"] boolValue]) {
        self.bustLabel.hidden = NO;
        self.bustLabel.backgroundColor = [UIColor blueColor];
    } else if ([[dict objectForKey:@"BankerBust"] boolValue]) {
        self.bustLabel.hidden = NO;
        self.bustLabel.backgroundColor = [UIColor redColor];
    } else {
        self.bustLabel.hidden = YES;
    }
    
    if ([[dict objectForKey:@"isPlayerPair"] boolValue]) {
        self.playerPairView.hidden = NO;
    } else {
        self.playerPairView.hidden = YES;
    }

    self.pointsNumLabel.text = [NSString stringWithFormat:@"%zd - %zd", playerNum, bankerNum];
    if (isPlayerA || isBankerA) {
        self.ALabel.hidden = NO;
    } else {
       self.ALabel.hidden = YES;
    }
    
    // 加倍标示
    if ([[dict objectForKey:@"isDoubleOne"] boolValue]) {
        self.doubleLabel.hidden = NO;
    } else {
        self.doubleLabel.hidden = YES;
    }
}


- (NSString *)bankerOrPlayerOrTie:(NSString *)string {
    
    switch ([string integerValue]) {
        case 0:
            return @"T";
            break;
        case 1:
            return @"B";
            break;
        case 2:
            return @"P";
            break;
        default:
            break;
    }
    return nil;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
