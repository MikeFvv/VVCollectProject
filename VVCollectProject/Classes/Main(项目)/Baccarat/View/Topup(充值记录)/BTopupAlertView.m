//
//  BTopupAlertView.m
//  VVCollectProject
//
//  Created by Admin on 2022/1/25.
//  Copyright © 2022 Mike. All rights reserved.
//

#import "BTopupAlertView.h"
#import "BTopupCollectionCell.h"
#import "BStatisticssReusableView.h"

#import "BaccaratCom.h"
#import "WHC_ModelSqlite.h"

@interface BTopupAlertView () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,UICollectionViewDelegate>
///
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation BTopupAlertView


- (instancetype)initWithFrame:(CGRect)frame {
   self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        [self createUI];
        [self initData];
        
        [[[UIApplication sharedApplication].windows objectAtIndex:0] endEditing:YES];
        [[[UIApplication sharedApplication].windows objectAtIndex:0] addSubview:self];
        
//        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeFromCurrentView:)];
//        [self addGestureRecognizer:tapGesture];
    }
    return self;
}


//- (void)setBUserData:(BUserData *)bUserData {
//    _bUserData = bUserData;
//    [self.collectionView reloadData];
//}


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

- (void)initData {
    
    BalanceRecordModel *model1 = [[BalanceRecordModel alloc] init];
    model1.userId = kUserIdStr;
    model1.title = @"充值1万";
    model1.topupId = @"1";
    model1.money = 10000;
    model1.rechargeType = @"充值";
    
    BalanceRecordModel *model2 = [[BalanceRecordModel alloc] init];
    model2.userId = kUserIdStr;
    model2.title = @"充值3万";
    model2.topupId = @"3";
    model2.money = 30000;
    model2.rechargeType = @"充值";
    
    BalanceRecordModel *model3 = [[BalanceRecordModel alloc] init];
    model3.userId = kUserIdStr;
    model3.title = @"充值5万";
    model3.topupId = @"5";
    model3.money = 50000;
    model3.rechargeType = @"充值";
    
    BalanceRecordModel *model4 = [[BalanceRecordModel alloc] init];
    model4.userId = kUserIdStr;
    model4.title = @"充值10万";
    model4.topupId = @"10";
    model4.money = 100000;
    model4.rechargeType = @"充值";
    
//    BalanceRecordModel *model5 = [[BalanceRecordModel alloc] init];
//    model5.userId = kUserIdStr;
//    model5.title = @"充值100万";
//    model5.topupId = @"100";
//    model5.money = 1000000;
//    model5.rechargeType = @"充值";
    
    self.dataArray = @[model1,model2,model3,model4];
    
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
        
        [_collectionView registerClass:[BTopupCollectionCell class] forCellWithReuseIdentifier:@"BTopupCollectionCell"];
        //这里的HeaderCRView 是自定义的header类型
        [_collectionView registerClass:[BStatisticssReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"BStatisticssReusableView"];
    }
    return _collectionView;
}


#pragma mark -- UICollectionViewDataSource 数据源

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BTopupCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BTopupCollectionCell" forIndexPath:indexPath];
    cell.numLabel.textColor = [UIColor whiteColor];
//    cell.model = self.dataArray[indexPath.row];
    
    BalanceRecordModel *model = self.dataArray[indexPath.row];
    cell.titleLabel.text = model.title;
    cell.numLabel.text = [NSString stringWithFormat:@"%ld",model.money];
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
            cell.titleLabel.text = @"充值";
        }
        return cell;
    } else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        return nil;
    }
    return nil;
}


//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    BalanceRecordModel *model = self.dataArray[indexPath.row];
    
    if ([self.delegate respondsToSelector:@selector(didTopup:)]) {
        [self.delegate didTopup:model];
    }
    
    [self removeSelfFromSuperview];
}




@end

