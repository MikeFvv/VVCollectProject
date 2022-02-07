//
//  BaccaratCollectionView.m
//  VVCollectProject
//
//  Created by blom on 2019/2/24.
//  Copyright © 2019 Mike. All rights reserved.
//

#import "BZhuPanLuCollectionView.h"
#import "BaccaratCollectionViewCell.h"
#import "UIView+Extension.h"
#import "BaccaratResultModel.h"



static NSString *const kCellBaccaratCollectionViewId = @"BaccaratCollectionViewCell";

// 需要实现三个协议 UICollectionViewDelegateFlowLayout 继承自 UICollectionViewDelegate
@interface BZhuPanLuCollectionView ()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
/// 空白网格视图
@property (nonatomic, strong) UICollectionView *blankGridCollectionView;
@property (strong, nonatomic) UICollectionView *collectionView;
//
@property (nonatomic, strong) NSMutableArray *resultDataArray;

@end

@implementation BZhuPanLuCollectionView



- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self createBlankGridView];
        [self initSubviews];
    }
    return self;
}

- (void)setRoadType:(NSInteger)roadType {
    _roadType = roadType;
    if (roadType == 0) {
        self.collectionView.hidden = NO;
    }
}


- (void)setModel:(id)model {
    self.resultDataArray = [NSMutableArray arrayWithArray:(NSArray *)model];
    if (self.roadType == 0) {
        [self.collectionView reloadData];
    } else {
        NSLog(@"1");
    }
}


#pragma mark - 首先创建一个collectionView
- (void)initSubviews {

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    CGFloat itemWidth = ([UIScreen mainScreen].bounds.size.width - 10*2 - 10*2) / (90/6+1);
    // 设置每个item的大小
    layout.itemSize = CGSizeMake(kBZPLItemSizeWidth, kBZPLItemSizeWidth);
    
    // 设置列间距
    layout.minimumInteritemSpacing = 1;
    
    // 设置行间距
    layout.minimumLineSpacing = 1;
    
    //每个分区的四边间距UIEdgeInsetsMake
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    //
    // 设置Item的估计大小,用于动态设置item的大小，结合自动布局（self-sizing-cell）
    //layout.estimatedItemSize = CGSizeMake(<#CGFloat width#>, <#CGFloat height#>);
    
    // 设置布局方向(滚动方向)
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    // 设置头视图尺寸大小
    //layout.headerReferenceSize = CGSizeMake(<#CGFloat width#>, <#CGFloat height#>);
    
    // 设置尾视图尺寸大小
    //layout.footerReferenceSize = CGSizeMake(<#CGFloat width#>, <#CGFloat height#>);
    
    //
    // 设置分区的头视图和尾视图是否始终固定在屏幕上边和下边
    //        layout.sectionFootersPinToVisibleBounds = YES;
    //        layout.sectionHeadersPinToVisibleBounds = YES;
    
    
    /**
     初始化mainCollectionView
     设置collectionView的位置
     */
    CGFloat height = (kBZPLItemSizeWidth+1) * 6;
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, height) collectionViewLayout:layout];
    
    /** mainCollectionView 的布局(必须实现的) */
    _collectionView.collectionViewLayout = layout;
    
    //mainCollectionView 的背景色
    _collectionView.backgroundColor = [UIColor clearColor];
    
    //禁止滚动
    //_collectionView.scrollEnabled = NO;
    
    //设置代理协议
    _collectionView.delegate = self;
    
    //设置数据源协议
    _collectionView.dataSource = self;
    // 禁止弹簧效果
    _collectionView.bounces = NO;
    // 滚动条
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    
    if (@available(iOS 11.0, *)) {  //ooo<<< 有偏移距离  去掉
        _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    /**
     四./注册cell
     在重用池中没有新的cell就注册一个新的cell
     相当于懒加载新的cell
     定义重用标识符(在页面最上定义全局)
     用自定义的cell类,防止内容重叠
     注册时填写的重用标识符 是给整个类添加的 所以类里有的所有属性都有重用标识符
     */
    [_collectionView registerClass:[BaccaratCollectionViewCell class] forCellWithReuseIdentifier:kCellBaccaratCollectionViewId];
    
    //注册头部(初始化头部)
    //[_collectionView registerClass:<#(nullable Class)#> forSupplementaryViewOfKind:<#(nonnull NSString *)#> withReuseIdentifier:<#(nonnull NSString *)#>];
    
    //注册尾部
    //[_collectionView registerClass:<#(nullable Class)#> forSupplementaryViewOfKind:<#(nonnull NSString *)#> withReuseIdentifier:<#(nonnull NSString *)#>];
    
    [self addSubview:self.collectionView];
}

#pragma mark -- UICollectionViewDataSource 数据源

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView == self.blankGridCollectionView) {
        return kBTotalGridsNum+12;
    } else {
        return self.resultDataArray.count;
    }
}

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == self.blankGridCollectionView) {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
        
        UIColor *color = [UIColor colorWithHex:@"880A1E" alpha:0.2];
        cell.layer.borderWidth = 0.2;
        cell.layer.borderColor = color.CGColor;
        
        return cell;
    } else {
        BaccaratCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellBaccaratCollectionViewId forIndexPath:indexPath];
        
    //    UIColor *color = indexPath.section % 2 == 0 ? [UIColor greenColor] : [UIColor redColor];
    //    cell.layer.borderWidth = 1;
    //    cell.layer.borderColor = color.CGColor;
        
        BaccaratResultModel *model = (BaccaratResultModel *)self.resultDataArray[indexPath.row];
        cell.model = model;
        return cell;
    }
}

#pragma mark --UICollectionViewDelegateFlowLayout  视图布局

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

#pragma mark --UICollectionViewDelegate 代理

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
//    cell.backgroundColor = [UIColor whiteColor];
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

#pragma mark - 首先创建一个collectionView
- (void)createBlankGridView {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    // 设置每个item的大小
    layout.itemSize = CGSizeMake(kBZPLItemSizeWidth+1, kBZPLItemSizeWidth+1);
    
    // 设置列间距
    layout.minimumInteritemSpacing = 0;
    
    // 设置行间距
    layout.minimumLineSpacing = 0;
    
    //每个分区的四边间距UIEdgeInsetsMake
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    // 设置布局方向(滚动方向)
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    CGFloat height = (kBZPLItemSizeWidth+1) * 6;
    _blankGridCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, height) collectionViewLayout:layout];
    
    /** mainCollectionView 的布局(必须实现的) */
    _blankGridCollectionView.collectionViewLayout = layout;
    
    //mainCollectionView 的背景色
    _blankGridCollectionView.backgroundColor = [UIColor whiteColor];
    
    //禁止滚动
    //_collectionView.scrollEnabled = NO;
    
    //设置代理协议
    _blankGridCollectionView.delegate = self;
    
    //设置数据源协议
    _blankGridCollectionView.dataSource = self;
    // 滚动条
    _blankGridCollectionView.showsVerticalScrollIndicator = NO;
    _blankGridCollectionView.showsHorizontalScrollIndicator = NO;
    
    if (@available(iOS 11.0, *)) {  //ooo<<< 有偏移距离  去掉
        _blankGridCollectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    [_blankGridCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    [self addSubview:_blankGridCollectionView];
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//
//    CGFloat contentOffsetX = scrollView.contentOffset.x;
//     if (contentOffsetX > 0) {
//         [self.blankGridCollectionView setContentOffset:CGPointMake(contentOffsetX, 0) animated:NO];
//    }
//}




@end
