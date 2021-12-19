//
//  BAnalyzeRoadMapView.m
//  VVCollectProject
//
//  Created by Admin on 2021/12/17.
//  Copyright © 2021 Mike. All rights reserved.
//

#import "BAnalyzeRoadMapView.h"
#import "BGameRecordsCell.h"

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
@property (nonatomic, strong) UILabel *grm_bankerLabel;
@property (nonatomic, strong) UIView *grm_dyzl_bankerView;
@property (nonatomic, strong) UIView *grm_xl_bankerView;
@property (nonatomic, strong) UILabel *grm_yyl_bankerLabel;

// *** 闲 ***
@property (nonatomic, strong) UILabel *grm_playerLabel;
@property (nonatomic, strong) UIView *grm_dyzl_playerView;
@property (nonatomic, strong) UIView *grm_xl_playerView;
@property (nonatomic, strong) UILabel *grm_yyl_playerLabel;

@end

@implementation BAnalyzeRoadMapView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    
    UIView *backView = [[UIView alloc] init];
    backView.backgroundColor = [UIColor redColor];
    backView.layer.borderWidth = 1;
    backView.layer.borderColor = [UIColor greenColor].CGColor;
    [self addSubview:backView];
    
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self);
    }];
    
    UIView *leftView = [[UIView alloc] init];
    leftView.backgroundColor = [UIColor whiteColor];
    [backView addSubview:leftView];
    _leftView = leftView;
    
    [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView.mas_left).offset(0);
        make.top.equalTo(backView.mas_top).offset(0);
        make.width.mas_equalTo(self.frame.size.width-70);
        make.bottom.equalTo(backView.mas_bottom).offset(0);
    }];
    
    UIView *rightView = [[UIView alloc] init];
    rightView.backgroundColor = [UIColor cyanColor];
    [backView addSubview:rightView];
    _rightView = rightView;
    
    [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(backView.mas_right).offset(0);
        make.top.equalTo(backView.mas_top).offset(0);
        make.width.mas_equalTo(70);
        make.bottom.equalTo(backView.mas_bottom).offset(0);
    }];
    
    [self gameRecordsView];
    [self analyzeRoadMapView];
}


#pragma mark - xxUITableView
- (UITableView *)leftTableView {
    if (!_leftTableView) {
        _leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width-70, self.frame.size.height-20) style:UITableViewStylePlain];
        _leftTableView.backgroundColor = [UIColor whiteColor];
        _leftTableView.dataSource = self;
        _leftTableView.delegate = self;
        //        _leftTableView.tableHeaderView = self.headView;
        //        _leftTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        
        _leftTableView.rowHeight = 23;   // 行高
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
    
    return 6;
}

//配置每个cell，随着用户拖拽列表，cell将要出现在屏幕上时此方法会不断调用返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BGameRecordsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BGameRecordsCell"];
    if(cell == nil) {
        cell = [BGameRecordsCell cellWithTableView:tableView reusableId:@"BGameRecordsCell"];
    }
    
    return cell;
}


/// 统计庄闲图  游戏记录
- (void)gameRecordsView {
    [self.leftView addSubview:self.leftTableView];
}




/// 分析问路图
- (void)analyzeRoadMapView {
    UIView *guideRoadMapBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 70, 135)];
    guideRoadMapBackView.backgroundColor = [UIColor whiteColor];
    guideRoadMapBackView.layer.cornerRadius = 5;
    guideRoadMapBackView.layer.masksToBounds = YES;
    guideRoadMapBackView.layer.borderWidth = 1;
    guideRoadMapBackView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.rightView addSubview:guideRoadMapBackView];
    
    
    CGFloat lineSpacing = 30;
    CGFloat widht = 18;
    
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
    UILabel *grm_bankerLabel = [UILabel new];
    grm_bankerLabel.layer.cornerRadius = widht/2;
    grm_bankerLabel.layer.masksToBounds = YES;
    grm_bankerLabel.backgroundColor = [UIColor redColor];
    [guideRoadMapBackView addSubview:grm_bankerLabel];
    grm_bankerLabel.text = @"B";
    grm_bankerLabel.textAlignment = NSTextAlignmentCenter;
    grm_bankerLabel.font = [UIFont boldSystemFontOfSize:16];
    grm_bankerLabel.textColor = [UIColor whiteColor];
    _grm_bankerLabel = grm_bankerLabel;
    
    [grm_bankerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(guideRoadMapBackView.mas_left).offset(10);
        make.bottom.equalTo(line1View.mas_top).offset(-3);
        make.size.mas_equalTo(widht);
    }];
    
    UILabel *grm_playerLabel = [UILabel new];
    grm_playerLabel.layer.cornerRadius = widht/2;
    grm_playerLabel.layer.masksToBounds = YES;
    grm_playerLabel.backgroundColor = [UIColor blueColor];
    [guideRoadMapBackView addSubview:grm_playerLabel];
    grm_playerLabel.text = @"P";
    grm_playerLabel.textAlignment = NSTextAlignmentCenter;
    grm_playerLabel.font = [UIFont boldSystemFontOfSize:16];
    grm_playerLabel.textColor = [UIColor whiteColor];
    _grm_playerLabel = grm_playerLabel;
    
    [grm_playerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(guideRoadMapBackView.mas_right).offset(-10);
        make.centerY.equalTo(grm_bankerLabel.mas_centerY);
        make.size.mas_equalTo(widht);
    }];
    
    /// *** 2 ***
    UIView *grm_dyzl_bankerView = [UIView new];
    grm_dyzl_bankerView.layer.cornerRadius = widht/2;
    grm_dyzl_bankerView.layer.masksToBounds = YES;
    grm_dyzl_bankerView.layer.borderWidth = 3.6;
    grm_dyzl_bankerView.layer.borderColor = [UIColor redColor].CGColor;
    [guideRoadMapBackView addSubview:grm_dyzl_bankerView];
    _grm_dyzl_bankerView = grm_dyzl_bankerView;
    
    [grm_dyzl_bankerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(grm_bankerLabel.mas_left);
        make.bottom.equalTo(line2View.mas_top).offset(-3);
        make.size.mas_equalTo(widht);
    }];
    
    UIView *grm_dyzl_playerView = [UIView new];
    grm_dyzl_playerView.layer.cornerRadius = widht/2;
    grm_dyzl_playerView.layer.masksToBounds = YES;
    grm_dyzl_playerView.layer.borderWidth = 4;
    grm_dyzl_playerView.layer.borderColor = [UIColor blueColor].CGColor;
    [guideRoadMapBackView addSubview:grm_dyzl_playerView];
    _grm_dyzl_playerView = grm_dyzl_playerView;
    
    [grm_dyzl_playerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(grm_playerLabel.mas_right);
        make.centerY.equalTo(grm_dyzl_bankerView.mas_centerY);
        make.size.mas_equalTo(widht);
    }];
    
    /// *** 3 ***
    UIView *grm_xl_bankerView = [UIView new];
    grm_xl_bankerView.layer.cornerRadius = widht/2;
    grm_xl_bankerView.layer.masksToBounds = YES;
    grm_xl_bankerView.backgroundColor = [UIColor redColor];
    [guideRoadMapBackView addSubview:grm_xl_bankerView];
    _grm_xl_bankerView = grm_xl_bankerView;
    
    [grm_xl_bankerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(grm_bankerLabel.mas_left);
        make.bottom.equalTo(line3View.mas_top).offset(-3);
        make.size.mas_equalTo(widht);
    }];
    
    UIView *grm_xl_playerView = [UIView new];
    grm_xl_playerView.layer.cornerRadius = widht/2;
    grm_xl_playerView.layer.masksToBounds = YES;
    grm_xl_playerView.backgroundColor = [UIColor blueColor];
    [guideRoadMapBackView addSubview:grm_xl_playerView];
    _grm_xl_playerView = grm_xl_playerView;
    
    [grm_xl_playerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(grm_playerLabel.mas_right);
        make.centerY.equalTo(grm_xl_bankerView.mas_centerY);
        make.size.mas_equalTo(widht);
    }];
    
    /// *** 4 ***
    UIView *grm_yyl_bankerView = [UIView new];
    grm_yyl_bankerView.backgroundColor = [UIColor clearColor];
    [guideRoadMapBackView addSubview:grm_yyl_bankerView];
    
    [grm_yyl_bankerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(grm_bankerLabel.mas_left);
        make.bottom.equalTo(line4View.mas_top).offset(-3);
        make.size.mas_equalTo(widht);
    }];
    
    UIView *grm_yyl_playerView = [UIView new];
    grm_yyl_playerView.backgroundColor = [UIColor clearColor];
    [guideRoadMapBackView addSubview:grm_yyl_playerView];
    
    [grm_yyl_playerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(grm_playerLabel.mas_right);
        make.centerY.equalTo(grm_yyl_bankerView.mas_centerY);
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
    [grm_yyl_bankerView.layer addSublayer:lineLayer];
    
    
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
    [grm_yyl_playerView.layer addSublayer:lineLayer2];
}

@end


