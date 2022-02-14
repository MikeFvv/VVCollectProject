//
//  BaccaratXiaSanLuView.m
//  VVCollectProject
//
//  Created by Admin on 2021/12/19.
//  Copyright © 2021 Mike. All rights reserved.
//

#import "BaccaratXiaSanLuView.h"
#import "UIView+Extension.h"
#import "BaccaratComputer.h"


@interface BaccaratXiaSanLuView ()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

/// 空白网格视图
@property (nonatomic, strong) UICollectionView *blankGridCollectionView;
/// 下三路
@property (nonatomic, strong) UIScrollView *roadListScrollView;
/// 数据
@property (nonatomic, strong) NSMutableArray *xsl_DataArray;


// ****** 下三路 ******

/// 下三路 最后一个Label
@property (nonatomic, strong) UILabel *roadListLastLabel;
/// 记录当前列的最小 X
@property (nonatomic, assign) CGFloat currentColMinX;
/// 把前一列大于等于当前X值的最后一个Label 记录,  用来判断长龙拐弯的的最后一个，动态移除X 小于当前的Label
@property (nonatomic, strong) NSMutableArray<UILabel *> *allColLastLabelArray;
/// 记录当前一条路
@property (nonatomic, strong) NSMutableArray *newOneColArray;
/// 记录所有大路「列」数据
@property (nonatomic, strong) NSMutableArray<NSArray *> *columnDataArray;


/// 最后一个模型数据
@property (nonatomic, assign) MapColorType xsl_lastModel;

@end

@implementation BaccaratXiaSanLuView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initData];
        [self createUI];
    }
    return self;
}

- (void)initData {
    
    _roadListLastLabel = nil;
    _currentColMinX = 0;
    _allColLastLabelArray = nil;
    _newOneColArray = nil;
    _columnDataArray = nil;
    
}

- (void)createUI {
    [self createBlankGridView];
    [self addSubview:self.roadListScrollView];
}

- (void)setDataArray:(NSArray *)dataArray {
    _dataArray = dataArray;
    
    if (!dataArray || dataArray.count == 0) {
        return;
    }
    self.xsl_DataArray = [NSMutableArray arrayWithArray:dataArray];
    
    MapColorType model = [self.xsl_DataArray.lastObject integerValue];
    [self createItemModel:model];
    
}


/// 移除最后一个
- (void)removeLastSubview {
    
    UILabel *lastLabel = self.roadListScrollView.subviews.lastObject;
    if (!lastLabel) {
        return;
    }
    [lastLabel removeFromSuperview];
    
    // 最后拐弯的列 大X列
    UILabel *lastMaxXLabel = self.allColLastLabelArray.lastObject;
    if(CGRectEqualToRect(lastLabel.frame, lastMaxXLabel.frame)) {
        [self.allColLastLabelArray removeLastObject];
    }
    
    NSMutableArray *tempMArraay = (NSMutableArray *)self.columnDataArray.lastObject;
    
    // 长龙的个数减1
    if (tempMArraay.count == 1) {
        self.newOneColArray = nil;
        [self.columnDataArray removeLastObject];
        
        NSMutableArray *newMArraay = (NSMutableArray *)self.columnDataArray.lastObject;
        self.newOneColArray = newMArraay;
        
    } else {
        [self.newOneColArray removeLastObject];
    }
    
    // 最后的Label 数据，重新赋值
    UILabel *lastLabel2 = self.roadListScrollView.subviews.lastObject;
    self.roadListLastLabel = lastLabel2;
    
    //    MapColorType model = [self.xsl_DataArray.lastObject integerValue];
    MapColorType lastMapColorType = [self.newOneColArray.lastObject integerValue];
    self.xsl_lastModel = lastMapColorType;
    
    if (CGRectGetMinY(lastLabel.frame) == 0) {  // Y= 0时，需要把初始值矫正
        CGFloat margin = kBMarginWidth;
        CGFloat w = kBXSLItemSizeWidth;
        self.currentColMinX = CGRectGetMinX(lastLabel.frame)-w-margin;
    }
    
}

#pragma mark -  下三路
- (void)createItemModel:(MapColorType)model {
    
    CGFloat margin = kBMarginWidth;
    CGFloat w = kBXSLItemSizeWidth;
    CGFloat h = w;
    CGFloat x = 0;
    CGFloat y = 0;
    
    UILabel *label = [self createLabelModel:model roadMapType:self.roadMapType];
    [self.roadListScrollView addSubview:label];
    
    
    // 长龙判断
    BOOL isLong = NO;
    if (model == self.xsl_lastModel) {
        isLong = YES;
    }
    
    if (isLong) {
        
        [self.newOneColArray addObject:@(model)];
        
        // 计算最多可使用空白格数
        NSInteger maxBlankColumns = [BaccaratComputer getMaxBlankColumnsCurrentColX:self.currentColMinX allColLastLabelArray:self.allColLastLabelArray width:w];
        
        if (self.newOneColArray.count <= maxBlankColumns) {  // 长龙向下
            x = self.roadListLastLabel.x;
            label.frame = CGRectMake(x, CGRectGetMaxY(self.roadListLastLabel.frame) + margin, w, h);
            
        } else {
            // 长龙拐弯
            x = CGRectGetMaxX(self.roadListLastLabel.frame) + margin;
            label.frame = CGRectMake(x, self.roadListLastLabel.y, w, h);
            
            
            if (CGRectGetMinY(label.frame) == 0) {  // 极端特殊情况下，第一行长龙，需要把初始值矫正
                self.currentColMinX = CGRectGetMinX(label.frame);
            }
        }
    } else {
        
        // *** 开头第一个 ***
        self.newOneColArray = nil;
        [self.newOneColArray addObject:@(model)];
        [self.columnDataArray addObject:self.newOneColArray];
        
        y = 0;
        // 最顶上的长龙时处理 极端情况
        CGFloat lastLabelY = CGRectGetMinY(self.roadListLastLabel.frame);
        if (lastLabelY == 0) {
            CGFloat lastLabelX = CGRectGetMaxX(self.roadListLastLabel.frame);
            x = lastLabelX + margin;
        } else {
            x = self.currentColMinX + w + margin;
        }
        label.frame = CGRectMake(x, y, w, h);
        
        self.currentColMinX = CGRectGetMinX(label.frame);
        
        // 把前一列大于等于当前X值的最后一个Label 记录
        if (CGRectGetMaxX(self.roadListLastLabel.frame) >= CGRectGetMaxX(label.frame)) {
            [self.allColLastLabelArray addObject:self.roadListLastLabel];
        }
        
    }
    
    self.roadListLastLabel = label;
    self.xsl_lastModel = model;
    
    CGFloat maxLabelX = self.roadListLastLabel.x + margin + w;
    [self moveViewPosition:maxLabelX];
}

- (void)moveViewPosition:(CGFloat)maxLabelX {
    if (maxLabelX > (self.bounds.size.width - 50)){ // 大路闲庄路X大于整个屏幕时往后自动移动位置，好观看
        // 移动位置
        [UIView animateWithDuration:0.1 animations:^{
            [self.roadListScrollView setContentOffset:CGPointMake(maxLabelX - (self.bounds.size.width - 50), 0) animated:YES];
            [self.blankGridCollectionView setContentOffset:CGPointMake(maxLabelX - (self.bounds.size.width - 50), 0) animated:YES];
        }];
    }
}




#pragma mark - 首先创建一个collectionView
- (void)createBlankGridView {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    // 设置每个item的大小
    layout.itemSize = CGSizeMake(kBXSLItemSizeWidth+1, kBXSLItemSizeWidth+1);
    
    // 设置列间距
    layout.minimumInteritemSpacing = 0;
    
    // 设置行间距
    layout.minimumLineSpacing = 0;
    
    //每个分区的四边间距UIEdgeInsetsMake
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    // 设置布局方向(滚动方向)
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    CGFloat height = (kBXSLItemSizeWidth+1) * 6;
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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat contentOffsetX = scrollView.contentOffset.x;
    if (contentOffsetX > 0) {
        [self.blankGridCollectionView setContentOffset:CGPointMake(contentOffsetX, 0) animated:NO];
    }
}

#pragma mark -- UICollectionViewDataSource 数据源

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return kBTotalGridsNum+12;
}
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    
    UIColor *color = [UIColor colorWithHex:@"880A1E" alpha:0.2];
    cell.layer.borderWidth = 0.2;
    cell.layer.borderColor = color.CGColor;
    
    return cell;
}

- (UILabel *)createLabelModel:(MapColorType)colorType roadMapType:(RoadMapType)roadMapType {
    
    CGFloat w = kBXSLItemSizeWidth;
    
    UILabel *label = [[UILabel alloc] init];
    
    CAShapeLayer *lineLayer = nil;
    if (roadMapType == RoadMapType_DYL) {
        label.layer.cornerRadius = w/2;
        label.layer.masksToBounds = YES;
        label.layer.borderWidth = 2.0;
        
    } else if (roadMapType == RoadMapType_XL) {
        label.layer.cornerRadius = w/2;
        label.layer.masksToBounds = YES;
        
    } else if (roadMapType == RoadMapType_XQL) {
        // 线的路径
        UIBezierPath *linePath = [UIBezierPath bezierPath];
        // 起点
        [linePath moveToPoint:CGPointMake(w, 1.0)];
        // 其他点
        [linePath addLineToPoint:CGPointMake(1.0, w)];
        
        CAShapeLayer *templineLayer = [CAShapeLayer layer];
        templineLayer.lineWidth = 3;
        templineLayer.path = linePath.CGPath;
        templineLayer.fillColor = nil;
        [label.layer addSublayer:templineLayer];
        lineLayer = templineLayer;
    }
    
    if (colorType == ColorType_Red) {
        
        if (roadMapType == RoadMapType_DYL) {
            label.layer.borderColor = [UIColor redColor].CGColor;
        } else if (roadMapType == RoadMapType_XL) {
            label.backgroundColor = [UIColor redColor];
        } else if (roadMapType == RoadMapType_XQL) {
            lineLayer.strokeColor = [UIColor redColor].CGColor;
        }
    } else if (colorType == ColorType_Blue) {
        if (roadMapType == RoadMapType_DYL) {
            label.layer.borderColor = [UIColor blueColor].CGColor;
        } else if (roadMapType == RoadMapType_XL) {
            label.backgroundColor = [UIColor blueColor];
        } else if (roadMapType == RoadMapType_XQL) {
            lineLayer.strokeColor = [UIColor blueColor].CGColor;
        }
    } else {
        label.backgroundColor = [UIColor grayColor];
        NSLog(@"🔴🔴🔴未知🔴🔴🔴");
    }
    
    return label;
}


- (UIScrollView *)roadListScrollView {
    if (!_roadListScrollView) {
        _roadListScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _roadListScrollView.delegate = self;
        _roadListScrollView.backgroundColor = [UIColor clearColor];
        _roadListScrollView.contentSize = CGSizeMake((kBXSLItemSizeWidth+1)*(kBTotalGridsNum/6), 0);
        _roadListScrollView.layer.borderWidth = 1;
        _roadListScrollView.layer.borderColor = [UIColor redColor].CGColor;
        // 禁止弹簧效果
        _roadListScrollView.bounces = NO;
        // 滚动条
        _roadListScrollView.showsVerticalScrollIndicator = NO;
        _roadListScrollView.showsHorizontalScrollIndicator = NO;
    }
    return _roadListScrollView;
}


- (NSMutableArray *)xsl_DataArray {
    if (!_xsl_DataArray) {
        _xsl_DataArray = [NSMutableArray array];
    }
    return _xsl_DataArray;
}

- (NSMutableArray *)newOneColArray {
    if (!_newOneColArray) {
        _newOneColArray = [NSMutableArray array];
    }
    return _newOneColArray;
}
- (NSMutableArray *)allColLastLabelArray {
    if (!_allColLastLabelArray) {
        _allColLastLabelArray = [NSMutableArray array];
    }
    return _allColLastLabelArray;
}
- (NSMutableArray *)columnDataArray {
    if (!_columnDataArray) {
        _columnDataArray = [NSMutableArray array];
    }
    return _columnDataArray;
}

@end




