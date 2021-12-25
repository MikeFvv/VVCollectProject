//
//  BAnalyzeRoadMapView.m
//  VVCollectProject
//
//  Created by Admin on 2021/12/17.
//  Copyright © 2021 Mike. All rights reserved.
//

#import "BAnalyzeRoadMapView.h"
#import "BGameRecordsCell.h"


//static const int kAnalyzeRoadMapView_Width = 70;


@interface BAnalyzeRoadMapView ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UIView *leftView;
@property (nonatomic, strong) UIView *rightView;
@property (nonatomic, strong) UITableView *leftTableView;

// ******* 左边统计图 *******
@property (nonatomic, strong) UILabel *pokerCountLabel;
@property (nonatomic, strong) UILabel *bankerTotalCountLabel;
@property (nonatomic, strong) UILabel *playerTotalCountLabel;
@property (nonatomic, strong) UILabel *tieCountLabel;
@property (nonatomic, strong) UILabel *bankerPairCountLabel;
@property (nonatomic, strong) UILabel *playerPairCountLabel;
@property (nonatomic, strong) UILabel *superSixCountLabel;


// ******* grm 指路图 *******
// *** 庄 ***
@property (nonatomic, strong) UILabel *wlt_bankerLabel;
@property (nonatomic, strong) UIView *wlt_dyl_bankerView;
@property (nonatomic, strong) UIView *wlt_xl_bankerView;
@property (nonatomic, strong) UILabel *wlt_xql_bankerLabel;
@property (nonatomic, strong) CAShapeLayer *playerLineLayer;

// *** 闲 ***
@property (nonatomic, strong) UILabel *wlt_playerLabel;
@property (nonatomic, strong) UIView *wlt_dyl_playerView;
@property (nonatomic, strong) UIView *wlt_xl_playerView;
@property (nonatomic, strong) UILabel *wlt_xql_playerLabel;
@property (nonatomic, strong) CAShapeLayer *bankerLineLayer;

   
@end

@implementation BAnalyzeRoadMapView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)setWenLuDataArray:(NSArray *)wenLuDataArray {
    _wenLuDataArray = wenLuDataArray;
    if (!wenLuDataArray || wenLuDataArray.count == 0) {
        return;
    }
    
    NSLog(@"11");
    
    for (NSInteger index = 0; index < wenLuDataArray.count; index++) {
        MapColorType colorType = [wenLuDataArray[index] integerValue];
        
        UIColor *bankerColor = nil;
        UIColor *playerColor = nil;
        if (self.currentModel.winType == WinType_Banker) {  // 需要判断当前的庄或闲 如果是闲取反
             bankerColor = colorType == ColorType_Red ? [UIColor redColor] : [UIColor blueColor];
             playerColor = colorType == ColorType_Red ? [UIColor blueColor] : [UIColor redColor];
        } else {
            bankerColor = colorType == ColorType_Red ? [UIColor blueColor] : [UIColor redColor];
            playerColor = colorType == ColorType_Red ? [UIColor redColor] : [UIColor blueColor];
        }
        
        if (index == 0) {
            self.wlt_dyl_bankerView.hidden = NO;
            self.wlt_dyl_playerView.hidden = NO;
            self.wlt_dyl_bankerView.layer.borderColor = bankerColor.CGColor;
            self.wlt_dyl_playerView.layer.borderColor = playerColor.CGColor;
        } else if (index == 1) {
            self.wlt_xl_bankerView.hidden = NO;
            self.wlt_xl_playerView.hidden = NO;
            self.wlt_xl_bankerView.backgroundColor = bankerColor;
            self.wlt_xl_playerView.backgroundColor = playerColor;
        } else if (index == 2) {
            self.bankerLineLayer.hidden = NO;
            self.playerLineLayer.hidden = NO;
            self.bankerLineLayer.strokeColor = bankerColor.CGColor;
            self.playerLineLayer.strokeColor = playerColor.CGColor;
        } else {
            NSLog(@"🔴🔴🔴未知 BAnalyzeRoadMapView setWenLuDataArray 🔴🔴🔴");
        }
    }
    
}

- (void)createUI {
    
    UIView *backView = [[UIView alloc] init];
    backView.backgroundColor = [UIColor cyanColor];
    backView.layer.borderWidth = 1;
    backView.layer.borderColor = [UIColor greenColor].CGColor;
    [self addSubview:backView];
    
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self);
    }];
    
    UIView *leftView = [[UIView alloc] init];
    leftView.backgroundColor = [UIColor clearColor];
    [backView addSubview:leftView];
    _leftView = leftView;
    
    [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView.mas_left).offset(0);
        make.top.equalTo(backView.mas_top).offset(0);
        make.width.mas_equalTo(self.frame.size.width-75);
        make.bottom.equalTo(backView.mas_bottom).offset(0);
    }];
    
    UIView *rightView = [[UIView alloc] init];
    rightView.backgroundColor = [UIColor clearColor];
    [backView addSubview:rightView];
    _rightView = rightView;
    
    [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(backView.mas_right).offset(0);
        make.top.equalTo(backView.mas_top).offset(0);
        make.width.mas_equalTo(71); // +1
        make.bottom.equalTo(backView.mas_bottom).offset(0);
    }];
    
    [self gameRecordsView];
    [self analyzeRoadMapView];
}


#pragma mark - xxUITableView
- (UITableView *)leftTableView {
    if (!_leftTableView) {
        _leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width-76, self.frame.size.height-1) style:UITableViewStylePlain];
        _leftTableView.backgroundColor = [UIColor whiteColor];
        _leftTableView.dataSource = self;
        _leftTableView.delegate = self;
        //        _leftTableView.tableHeaderView = self.headView;
        //        _leftTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        
        _leftTableView.rowHeight = 18;   // 行高
        _leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;  // 去掉分割线
        _leftTableView.estimatedRowHeight = 0;
        _leftTableView.estimatedSectionHeaderHeight = 0;
        _leftTableView.estimatedSectionFooterHeight = 0;
    }
    return _leftTableView;
}


#pragma mark - UITableViewDataSource
//返回列表每个分组section拥有cell行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 7;
}

//配置每个cell，随着用户拖拽列表，cell将要出现在屏幕上时此方法会不断调用返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BGameRecordsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BGameRecordsCell"];
    if(cell == nil) {
        cell = [BGameRecordsCell cellWithTableView:tableView reusableId:@"BGameRecordsCell"];
    }
    
    
    if (indexPath.row == 0) {
        cell.nameMLabel.backgroundColor = [UIColor redColor];
        cell.nameMLabel.text = @"B";
        cell.titleLabel.text = @"BANKER";
        cell.countLabel.text = [NSString stringWithFormat:@"%ld",self.gameStatisticsModel.bankerNum];
    } else if (indexPath.row == 1) {
        cell.nameMLabel.backgroundColor = [UIColor blueColor];
        cell.nameMLabel.text = @"P";
        cell.titleLabel.text = @"PLAYER";
        cell.countLabel.text = [NSString stringWithFormat:@"%ld",self.gameStatisticsModel.playerNum];
    } else if (indexPath.row == 2) {
        cell.nameMLabel.backgroundColor = [UIColor greenColor];
        cell.nameMLabel.text = @"T";
        cell.titleLabel.text = @"TIE";
        cell.countLabel.text = [NSString stringWithFormat:@"%ld",self.gameStatisticsModel.tieNum];
    } else if (indexPath.row == 3) {
        cell.nameMLabel.backgroundColor = [UIColor yellowColor];
        cell.nameMLabel.text = @"B";
        cell.titleLabel.text = @"B PAIR";
        cell.countLabel.text = [NSString stringWithFormat:@"%ld",self.gameStatisticsModel.bankerPairNum];
    } else if (indexPath.row == 4) {
        cell.nameMLabel.backgroundColor = [UIColor yellowColor];
        cell.nameMLabel.text = @"P";
        cell.titleLabel.text = @"P PAIR";
        cell.countLabel.text = [NSString stringWithFormat:@"%ld",self.gameStatisticsModel.playerPairNum];
    } else if (indexPath.row == 5) {
        cell.nameMLabel.backgroundColor = [UIColor yellowColor];
        cell.nameMLabel.text = @"6";
        cell.titleLabel.text = @"SUPER";
        cell.countLabel.text = [NSString stringWithFormat:@"%ld",self.gameStatisticsModel.superNum];
    } else if (indexPath.row == 6) {
        cell.nameMLabel.backgroundColor = [UIColor colorWithHex:@"6A0222"]; //深红色
        cell.nameMLabel.text = @"G";
        cell.titleLabel.text = @"GAME";
        cell.countLabel.text = [NSString stringWithFormat:@"%ld",self.gameStatisticsModel.gameNum];
    }
    
    return cell;
}


/// 统计庄闲图  游戏记录
- (void)gameRecordsView {
    [self.leftView addSubview:self.leftTableView];
}




/// 分析问路图
- (void)analyzeRoadMapView {
    UIView *guideRoadMapBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 70, kTrendViewHeight-1)];
    guideRoadMapBackView.backgroundColor = [UIColor whiteColor];
    guideRoadMapBackView.layer.cornerRadius = 5;
    guideRoadMapBackView.layer.masksToBounds = YES;
    guideRoadMapBackView.layer.borderWidth = 1;
    guideRoadMapBackView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.rightView addSubview:guideRoadMapBackView];
    
    
    CGFloat lineSpacing = 26;
    CGFloat widht = kZPLItemSizeWidth;
    
    UIView *line1View = [[UIView alloc] init];
    line1View.backgroundColor = [UIColor purpleColor];
    [guideRoadMapBackView addSubview:line1View];
    
    [line1View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(guideRoadMapBackView.mas_top).offset(lineSpacing);
        make.left.equalTo(guideRoadMapBackView.mas_left).offset(7);
        make.right.equalTo(guideRoadMapBackView.mas_right).offset(-7);
        make.height.mas_equalTo(2);
    }];
    
    UIView *line2View = [[UIView alloc] init];
    line2View.backgroundColor = [UIColor grayColor];
    [guideRoadMapBackView addSubview:line2View];
    
    [line2View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line1View.mas_bottom).offset(lineSpacing);
        make.left.equalTo(line1View.mas_left);
        make.right.equalTo(line1View.mas_right);
        make.height.mas_equalTo(1);
    }];
    
    UIView *line3View = [[UIView alloc] init];
    line3View.backgroundColor = [UIColor grayColor];
    [guideRoadMapBackView addSubview:line3View];
    
    [line3View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line2View.mas_bottom).offset(lineSpacing);
        make.left.equalTo(line1View.mas_left);
        make.right.equalTo(line1View.mas_right);
        make.height.mas_equalTo(1);
    }];
    
    UIView *line4View = [[UIView alloc] init];
    line4View.backgroundColor = [UIColor grayColor];
    [guideRoadMapBackView addSubview:line4View];
    
    [line4View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line3View.mas_bottom).offset(lineSpacing);
        make.left.equalTo(line1View.mas_left);
        make.right.equalTo(line1View.mas_right);
        make.height.mas_equalTo(1);
    }];
    
    /// *** 1 ***
    UILabel *wlt_bankerLabel = [UILabel new];
    wlt_bankerLabel.layer.cornerRadius = widht/2;
    wlt_bankerLabel.layer.masksToBounds = YES;
    wlt_bankerLabel.backgroundColor = [UIColor redColor];
    [guideRoadMapBackView addSubview:wlt_bankerLabel];
    wlt_bankerLabel.text = @"B";
    wlt_bankerLabel.textAlignment = NSTextAlignmentCenter;
    wlt_bankerLabel.font = [UIFont boldSystemFontOfSize:16];
    wlt_bankerLabel.textColor = [UIColor whiteColor];
    _wlt_bankerLabel = wlt_bankerLabel;
    
    [wlt_bankerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(guideRoadMapBackView.mas_left).offset(10);
        make.bottom.equalTo(line1View.mas_top).offset(-3);
        make.size.mas_equalTo(widht);
    }];
    
    UILabel *wlt_playerLabel = [UILabel new];
    wlt_playerLabel.layer.cornerRadius = widht/2;
    wlt_playerLabel.layer.masksToBounds = YES;
    wlt_playerLabel.backgroundColor = [UIColor blueColor];
    [guideRoadMapBackView addSubview:wlt_playerLabel];
    wlt_playerLabel.text = @"P";
    wlt_playerLabel.textAlignment = NSTextAlignmentCenter;
    wlt_playerLabel.font = [UIFont boldSystemFontOfSize:16];
    wlt_playerLabel.textColor = [UIColor whiteColor];
    _wlt_playerLabel = wlt_playerLabel;
    
    [wlt_playerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(guideRoadMapBackView.mas_right).offset(-10);
        make.centerY.equalTo(wlt_bankerLabel.mas_centerY);
        make.size.mas_equalTo(widht);
    }];
    
    /// *** 2 ***
    UIView *wlt_dyl_bankerView = [UIView new];
    wlt_dyl_bankerView.layer.cornerRadius = widht/2;
    wlt_dyl_bankerView.layer.masksToBounds = YES;
    wlt_dyl_bankerView.layer.borderWidth = 3.6;
    wlt_dyl_bankerView.layer.borderColor = [UIColor redColor].CGColor;
    wlt_dyl_bankerView.hidden = YES;
    [guideRoadMapBackView addSubview:wlt_dyl_bankerView];
    _wlt_dyl_bankerView = wlt_dyl_bankerView;
    
    [wlt_dyl_bankerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wlt_bankerLabel.mas_left);
        make.bottom.equalTo(line2View.mas_top).offset(-3);
        make.size.mas_equalTo(widht);
    }];
    
    UIView *wlt_dyl_playerView = [UIView new];
    wlt_dyl_playerView.layer.cornerRadius = widht/2;
    wlt_dyl_playerView.layer.masksToBounds = YES;
    wlt_dyl_playerView.layer.borderWidth = 4;
    wlt_dyl_playerView.layer.borderColor = [UIColor blueColor].CGColor;
    wlt_dyl_playerView.hidden = YES;
    [guideRoadMapBackView addSubview:wlt_dyl_playerView];
    _wlt_dyl_playerView = wlt_dyl_playerView;
    
    [wlt_dyl_playerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(wlt_playerLabel.mas_right);
        make.centerY.equalTo(wlt_dyl_bankerView.mas_centerY);
        make.size.mas_equalTo(widht);
    }];
    
    /// *** 3 ***
    UIView *wlt_xl_bankerView = [UIView new];
    wlt_xl_bankerView.layer.cornerRadius = widht/2;
    wlt_xl_bankerView.layer.masksToBounds = YES;
    wlt_xl_bankerView.backgroundColor = [UIColor redColor];
    wlt_xl_bankerView.hidden = YES;
    [guideRoadMapBackView addSubview:wlt_xl_bankerView];
    _wlt_xl_bankerView = wlt_xl_bankerView;
    
    [wlt_xl_bankerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wlt_bankerLabel.mas_left);
        make.bottom.equalTo(line3View.mas_top).offset(-3);
        make.size.mas_equalTo(widht);
    }];
    
    UIView *wlt_xl_playerView = [UIView new];
    wlt_xl_playerView.layer.cornerRadius = widht/2;
    wlt_xl_playerView.layer.masksToBounds = YES;
    wlt_xl_playerView.backgroundColor = [UIColor blueColor];
    wlt_xl_playerView.hidden = YES;
    [guideRoadMapBackView addSubview:wlt_xl_playerView];
    _wlt_xl_playerView = wlt_xl_playerView;
    
    [wlt_xl_playerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(wlt_playerLabel.mas_right);
        make.centerY.equalTo(wlt_xl_bankerView.mas_centerY);
        make.size.mas_equalTo(widht);
    }];
    
    /// *** 4 ***
    UIView *wlt_xql_bankerView = [UIView new];
    wlt_xql_bankerView.backgroundColor = [UIColor clearColor];
    [guideRoadMapBackView addSubview:wlt_xql_bankerView];
    
    [wlt_xql_bankerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wlt_bankerLabel.mas_left);
        make.bottom.equalTo(line4View.mas_top).offset(-3);
        make.size.mas_equalTo(widht);
    }];
    
    UIView *wlt_xql_playerView = [UIView new];
    wlt_xql_playerView.backgroundColor = [UIColor clearColor];
    [guideRoadMapBackView addSubview:wlt_xql_playerView];
    
    [wlt_xql_playerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(wlt_playerLabel.mas_right);
        make.centerY.equalTo(wlt_xql_bankerView.mas_centerY);
        make.size.mas_equalTo(widht);
    }];
    
    
    // 线的路径
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    // 起点
    [linePath moveToPoint:CGPointMake(widht, 0)];
    // 其他点
    [linePath addLineToPoint:CGPointMake(0, widht)];
    
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    lineLayer.lineWidth = 3;
    lineLayer.strokeColor = [UIColor redColor].CGColor;
    lineLayer.path = linePath.CGPath;
    lineLayer.fillColor = nil;
    lineLayer.hidden = YES;
    [wlt_xql_bankerView.layer addSublayer:lineLayer];
    _bankerLineLayer = lineLayer;
    
    
    // 线的路径
    UIBezierPath *linePath2 = [UIBezierPath bezierPath];
    // 起点
    [linePath2 moveToPoint:CGPointMake(widht, 0)];
    // 其他点
    [linePath2 addLineToPoint:CGPointMake(0, widht)];
    
    CAShapeLayer *lineLayer2 = [CAShapeLayer layer];
    lineLayer2.lineWidth = 3;
    lineLayer2.strokeColor = [UIColor blueColor].CGColor;
    lineLayer2.path = linePath.CGPath;
    lineLayer2.fillColor = nil;
    lineLayer2.hidden = YES;
    [wlt_xql_playerView.layer addSublayer:lineLayer2];
    _playerLineLayer = lineLayer2;
}

@end


