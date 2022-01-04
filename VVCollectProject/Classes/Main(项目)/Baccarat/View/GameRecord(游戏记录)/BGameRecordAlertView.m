//
//  BGameRecordAlertView.m
//  VVCollectProject
//
//  Created by Admin on 2022/1/2.
//  Copyright © 2022 Mike. All rights reserved.
//

#import "BGameRecordAlertView.h"
#import "BStatisticsCollectionCell.h"
#import "BStatisticssReusableView.h"
#import "BGameRecordCell.h"


@interface BGameRecordAlertView () <UITableViewDataSource, UITableViewDelegate>
///
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation BGameRecordAlertView


- (instancetype)initWithFrame:(CGRect)frame {
   self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        [self createUI];
        
        [[[UIApplication sharedApplication].windows objectAtIndex:0] endEditing:YES];
        [[[UIApplication sharedApplication].windows objectAtIndex:0] addSubview:self];
    }
    return self;
}


- (void)setZhuPanLuResultDataArray:(NSMutableArray *)zhuPanLuResultDataArray {
    _zhuPanLuResultDataArray = zhuPanLuResultDataArray;
    [self.tableView reloadData];
}


- (void)showAlertAnimation
{
    self.alpha = 1;
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue         = [NSNumber numberWithFloat:0];
    animation.toValue           = [NSNumber numberWithFloat:1];
    animation.duration          = 0.25;
    animation.timingFunction    = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [self.layer addAnimation:animation forKey:@"opacity"];
}

-(void)removeFromCurrentView:(UIGestureRecognizer *)gesture
{
    UIView * subView    = (UIView *)[self viewWithTag:99];
    UIView * shadowView = self;
    if (CGRectContainsPoint(subView.frame, [gesture locationInView:shadowView])){
        
    } else {
        [self removeSelfFromSuperview];
    }
}
- (void)removeSelfFromSuperview
{
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
//        [self removeFromSuperview];
    }];
}

- (void)createUI {
    self.backgroundColor    = [UIColor colorWithWhite:0.2 alpha:0.5];
    
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(mxwScreenWidth()/2-(mxwScreenWidth()/2+100)/2, 60/2, mxwScreenWidth()/2+100, mxwScreenHeight()-60)];
    backView.backgroundColor = [UIColor colorWithHex:@"3C0C0E"];
    backView.layer.cornerRadius = 5;
    backView.layer.masksToBounds = YES;
    [self addSubview:backView];
    
    [backView addSubview:self.tableView];
    
    
    UIButton *cancelBtn = [[UIButton alloc] init];
    [cancelBtn setImage:[UIImage imageNamed:@"com_close"] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(removeSelfFromSuperview) forControlEvents:UIControlEventTouchUpInside];
    cancelBtn.tag = 3001;
    [self addSubview:cancelBtn];

    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(backView.mas_right);
        make.centerY.equalTo(backView.mas_top);
        make.size.mas_equalTo(40);
    }];
}

#pragma mark -  UITableView 初始化
- (UITableView *)tableView {
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, mxwScreenWidth()/2+100, mxwScreenHeight()-60) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.rowHeight = 40;   //设置每一行的高度
        [_tableView registerClass:[BGameRecordCell class] forCellReuseIdentifier:@"BGameRecordCell"];
    }
    
    return _tableView;
}


#pragma mark - UITableViewDataSource
// //返回列表每个分组section拥有cell行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.zhuPanLuResultDataArray.count;
}

// //配置每个cell，随着用户拖拽列表，cell将要出现在屏幕上时此方法会不断调用返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BGameRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BGameRecordCell"];
    if(cell == nil) {
        cell = [BGameRecordCell cellWithTableView:tableView reusableId:@"BGameRecordCell"];
    }
    
    cell.index = self.zhuPanLuResultDataArray.count - indexPath.row;
    // 倒序
    cell.model = self.zhuPanLuResultDataArray[self.zhuPanLuResultDataArray.count - indexPath.row -1];
    
    return cell;
    
}

@end

