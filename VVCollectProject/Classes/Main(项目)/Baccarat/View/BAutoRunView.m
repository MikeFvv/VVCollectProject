//
//  BAutoRunView.m
//  VVCollectProject
//
//  Created by Admin on 2022/2/6.
//  Copyright © 2022 Mike. All rights reserved.
//

#import "BAutoRunView.h"
#import "BTopupCollectionCell.h"


@interface BAutoRunView ()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,UICollectionViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation BAutoRunView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initData];
        [self createUI];
    }
    return self;
}

- (void)createUI {
    self.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.collectionView];
}


- (void)initData {
    
    BAutoRunModel *model1 = [[BAutoRunModel alloc] init];
    model1.title = @"运行3次";
    model1.runsNum = 3;
    
    BAutoRunModel *model2 = [[BAutoRunModel alloc] init];
    model2.title = @"运行6次";
    model2.runsNum = 6;
    
    BAutoRunModel *model3 = [[BAutoRunModel alloc] init];
    model3.title = @"运行10次";
    model3.runsNum = 10;
    
    BAutoRunModel *model4 = [[BAutoRunModel alloc] init];
    model4.title = @"运行全部";
    model4.runsNum = 10000;
    
    self.dataArray = @[model1,model2,model3,model4];
    
}



#pragma mark - 创建一个UICollectionView
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        // 设置每个item的大小
        layout.itemSize = CGSizeMake(100, self.frame.size.height-10);
        
        // 设置列间距
        layout.minimumInteritemSpacing = 5;
        
        // 设置行间距
        layout.minimumLineSpacing = 5;
        
        //每个分区的四边间距UIEdgeInsetsMake
        layout.sectionInset = UIEdgeInsetsMake(5, 10, 5, 10);
        
        // 设置布局方向(滚动方向)r
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        // +0 = +52
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:layout];
        
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
    
    BAutoRunModel *model = self.dataArray[indexPath.row];
    cell.titleLabel.text = model.title;
    cell.numLabel.text = [NSString stringWithFormat:@"%ld",model.runsNum];
    return cell;
}


//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    BAutoRunModel *model = self.dataArray[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(didAutoRunModel:)]) {
        [self.delegate didAutoRunModel:model];
    }
    
//    [self removeSelfFromSuperview];
}


@end
