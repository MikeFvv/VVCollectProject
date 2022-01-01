//
//  BStatisticsView.m
//  VVCollectProject
//
//  Created by Admin on 2021/12/31.
//  Copyright © 2021 Mike. All rights reserved.
//

#import "BStatisticsAlertView.h"
#import "BStatisticsCollectionCell.h"
#import "BStatisticssReusableView.h"


@interface BStatisticsAlertView () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,UICollectionViewDelegate>
///
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation BStatisticsAlertView


- (instancetype)initWithFrame:(CGRect)frame {
   self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        [self createUI];
        
        [[[UIApplication sharedApplication].windows objectAtIndex:0] endEditing:YES];
        [[[UIApplication sharedApplication].windows objectAtIndex:0] addSubview:self];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeFromCurrentView:)];
        [self addGestureRecognizer:tapGesture];
    }
    return self;
}


- (void)setBUserData:(BUserData *)bUserData {
    _bUserData = bUserData;
    [self.collectionView reloadData];
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
    
    
    [backView addSubview:self.collectionView];
    
    
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

#pragma mark - 创建一个UICollectionView
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        
        CGFloat itemWidth = (mxwScreenWidth()/2+100 -5*3 -10*2) / 4- 0.1;
        // 设置每个item的大小
        layout.itemSize = CGSizeMake(itemWidth, 60);
        
        // 设置列间距
        layout.minimumInteritemSpacing = 5;
        
        // 设置行间距
        layout.minimumLineSpacing = 5;
        
        //每个分区的四边间距UIEdgeInsetsMake
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        
        // 设置布局方向(滚动方向)r
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        // +0 = +52
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, mxwScreenWidth()/2+100, mxwScreenHeight()-60) collectionViewLayout:layout];
        
        /** mainCollectionView 的布局(必须实现的) */
        _collectionView.collectionViewLayout = layout;
        
        //mainCollectionView 的背景色
        _collectionView.backgroundColor = [UIColor clearColor];
        
        //设置代理协议
        _collectionView.delegate = self;
        
        //设置数据源协议
        _collectionView.dataSource = self;
        // 禁止滚动
//        _collectionView.scrollEnabled = NO;
        
        [_collectionView registerClass:[BStatisticsCollectionCell class] forCellWithReuseIdentifier:@"BStatisticsCollectionCell"];
        //这里的HeaderCRView 是自定义的header类型
        [_collectionView registerClass:[BStatisticssReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"BStatisticssReusableView"];
    }
    return _collectionView;
}


#pragma mark -- UICollectionViewDataSource 数据源

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 16;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BStatisticsCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BStatisticsCollectionCell" forIndexPath:indexPath];
    cell.numLabel.textColor = [UIColor whiteColor];
//    cell.model = self.dataArray[indexPath.row];
    if (indexPath.row == 0) {
        cell.titleLabel.text = @"最高余额记录";
        cell.numLabel.text = [NSString stringWithFormat:@"%ld",self.bUserData.today_maxTotalMoney];
    } else if (indexPath.row == 1) {
        cell.titleLabel.text = @"最低余额记录";
        cell.numLabel.text = [NSString stringWithFormat:@"%ld",self.bUserData.today_MinTotalMoney];
    } else if (indexPath.row == 2) {
        cell.titleLabel.text = @"最高获胜记录";
        cell.numLabel.text = [NSString stringWithFormat:@"%ld",self.bUserData.today_maxWinTotalMoney];
    } else if (indexPath.row == 3) {
        cell.titleLabel.text = @"最高失败记录";
        cell.numLabel.text = [NSString stringWithFormat:@"%ld",self.bUserData.today_maxLoseTotalMoney];
    } else if (indexPath.row == 4) {
        cell.titleLabel.text = @"游戏总局数";
        cell.numLabel.text = [NSString stringWithFormat:@"%ld",self.bUserData.today_gameTotalNum];
    } else if (indexPath.row == 5) {
        cell.titleLabel.text = @"闲总局数";
        cell.numLabel.text = [NSString stringWithFormat:@"%ld",self.bUserData.today_playerTotalNum];
    } else if (indexPath.row == 6) {
        cell.titleLabel.text = @"庄总局数";
        cell.numLabel.text = [NSString stringWithFormat:@"%ld",self.bUserData.today_bankerTotalNum];
    } else if (indexPath.row == 7) {
        cell.titleLabel.text = @"和总局数";
        cell.numLabel.text = [NSString stringWithFormat:@"%ld",self.bUserData.today_tieTotalNum];
    } else if (indexPath.row == 8) {
        cell.titleLabel.text = @"获胜总局数";
        cell.numLabel.text = [NSString stringWithFormat:@"%ld",self.bUserData.today_winTotalNum];
    } else if (indexPath.row == 9) {
        cell.titleLabel.text = @"获胜概率";
        cell.numLabel.text = [NSString stringWithFormat:@"%0.2f%%",self.bUserData.today_winTotalProbability];
    } else if (indexPath.row == 10) {
        cell.titleLabel.text = @"最高连胜记录";
        cell.numLabel.text = [NSString stringWithFormat:@"%ld",self.bUserData.today_continuoustoday_winTotalNum];
    } else if (indexPath.row == 11) {
        cell.titleLabel.text = @"最高连输记录";
        cell.numLabel.text = [NSString stringWithFormat:@"%ld",self.bUserData.today_continuousLoseTotalNum];
    } else if (indexPath.row == 12) {
        cell.titleLabel.text = @"今日盈利";
        if (self.bUserData.today_ProfitMoney >= 0) {
            cell.numLabel.textColor = [UIColor greenColor];
            cell.numLabel.text = [NSString stringWithFormat:@"+%ld",self.bUserData.today_ProfitMoney];
        } else {
            cell.numLabel.textColor = [UIColor redColor];
            cell.numLabel.text = [NSString stringWithFormat:@"%ld",self.bUserData.today_ProfitMoney];
        }
    } else {
        cell.titleLabel.text = @"--";
        cell.numLabel.text = @"--";
    }
    
    
    return cell;
}

//头部视图的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(self.width, 30);
}
//这个也是最重要的方法 获取Header的 方法。
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        NSString *CellIdentifier = @"BStatisticssReusableView";
        //从缓存中获取 Headercell
        BStatisticssReusableView *cell = (BStatisticssReusableView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:CellIdentifier forIndexPath:indexPath];
        cell.tag = 3000+indexPath.section;
        
        if (indexPath.section == 0) {
            cell.titleLabel.text = @"今日统计";
        } else if (indexPath.section == 1) {
            cell.titleLabel.text = @"全部统计";
        }
       
        return cell;
    } else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        return nil;
    }
    return nil;
}

@end
