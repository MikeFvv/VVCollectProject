//
//  BaccaratXiaSanLuView.m
//  VVCollectProject
//
//  Created by Admin on 2021/12/19.
//  Copyright © 2021 Mike. All rights reserved.
//

#import "BaccaratXiaSanLuView.h"
#import "UIView+Extension.h"



@interface BaccaratXiaSanLuView ()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

/// 空白网格视图
@property (nonatomic, strong) UICollectionView *blankGridCollectionView;
/// 下三路
@property (nonatomic, strong) UIScrollView *xsl_ScrollView;

// ****** 下三路 ******

/// 记录最后一个数据
@property (nonatomic, assign) MapColorType xsl_lastModel;
/// 下三路 最后一个Label
@property (nonatomic, strong) UILabel *xsl_lastLabel;
/// 记录当前长龙个数
@property (nonatomic, assign) NSInteger currentLongNum;
/// 记录当前列的最小 X
@property (nonatomic, assign) CGFloat currentColMinX;
/// 记录所有列 最大Label的 x 值(取值是minX)
@property (nonatomic, assign) CGFloat allColMaxLabelX;
/// 把前一列大于等于当前X值的最后一个Label 记录,  用来判断长龙拐弯的的最后一个，动态移除X 小于当前的Label
@property (nonatomic, strong) NSMutableArray<UILabel *> *allBigColLastLabelArray;
/// 记录前一列最后一个Label
@property (nonatomic, strong) UILabel *frontColLastLabel;
/// 记录一条路
@property (nonatomic, strong) NSMutableArray *oneColArray;

@property (nonatomic, strong) NSMutableArray *xsl_DataArray;

@end

@implementation BaccaratXiaSanLuView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createBlankGridView];
        [self initData];
        [self createUI];
    }
    return self;
}

- (void)initData {
    _allColMaxLabelX = 0;
    _currentLongNum = 0;
}

- (void)createUI {
    [self addSubview:self.xsl_ScrollView];
}

- (void)setDataArray:(NSArray *)dataArray {
    _dataArray = dataArray;
    
    if (!dataArray || dataArray.count == 0) {
        return;
    }
    self.xsl_DataArray = [NSMutableArray arrayWithArray:dataArray];
    [self xsl_createItems];
    
    NSLog(@"1");
}


#pragma mark -  下三路
- (void)xsl_createItems {
    
    CGFloat margin = 1;
    CGFloat w = kItemSizeWidth;
    CGFloat h = w;
    CGFloat x = 0;
    CGFloat y = 0;
    
    
    UILabel *label = [[UILabel alloc] init];
    CAShapeLayer *lineLayer = nil;
    if (self.roadMapType == RoadMapType_DYL) {
        label.layer.cornerRadius = w/2;
        label.layer.masksToBounds = YES;
        label.layer.borderWidth = 3.0;
        
    } else if (self.roadMapType == RoadMapType_XL) {
        label.layer.cornerRadius = w/2;
        label.layer.masksToBounds = YES;
        
    } else if (self.roadMapType == RoadMapType_XQL) {
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
    
    [self.xsl_ScrollView addSubview:label];
    
    
    
    MapColorType colorType = [self.xsl_DataArray.lastObject integerValue];
    
    if (colorType == ColorType_Red) {
        
        if (self.roadMapType == RoadMapType_DYL) {
            label.layer.borderColor = [UIColor redColor].CGColor;
        } else if (self.roadMapType == RoadMapType_XL) {
            label.backgroundColor = [UIColor redColor];
        } else if (self.roadMapType == RoadMapType_XQL) {
            lineLayer.strokeColor = [UIColor redColor].CGColor;
        }
    } else if (colorType == ColorType_Blue) {
        if (self.roadMapType == RoadMapType_DYL) {
            label.layer.borderColor = [UIColor blueColor].CGColor;
        } else if (self.roadMapType == RoadMapType_XL) {
            label.backgroundColor = [UIColor blueColor];
        } else if (self.roadMapType == RoadMapType_XQL) {
            lineLayer.strokeColor = [UIColor blueColor].CGColor;
        }
    } else {
        NSLog(@"🔴🔴🔴未知🔴🔴🔴");
    }
    
    
    
    BOOL isLong = NO;
    if (colorType == self.xsl_lastModel) {
        isLong = YES;
    }
    if (isLong) {
        // 计算最大可使用空白格数
        NSInteger maxBlankColumns = 6;
        
        //            CGFloat lastLabelX = CGRectGetMaxX(self.frontColLastLabel.frame);
        //            CGFloat lastLabelY = CGRectGetMinY(self.frontColLastLabel.frame);
        
        UILabel *tailLabel = [self getMinYLabelColX:self.currentColMinX];
        tailLabel = tailLabel ? tailLabel : self.frontColLastLabel;
        CGFloat lastLabelX = CGRectGetMaxX(tailLabel.frame);
        CGFloat lastLabelY = CGRectGetMinY(tailLabel.frame);
        
        
        if (lastLabelX > 0 && lastLabelX >= CGRectGetMaxX(self.xsl_lastLabel.frame)) {
            maxBlankColumns = lastLabelY/(w +margin);
        }
        
        // 记录连续相同的结果个数
        self.currentLongNum += 1;
        if (self.currentLongNum <= maxBlankColumns) {  // 长龙向下
            self.currentColMinX = self.xsl_lastLabel.x;
            x = self.xsl_lastLabel.x;
            label.frame = CGRectMake(x, CGRectGetMaxY(self.xsl_lastLabel.frame) + margin, w, h);
            
        } else {
            // 长龙拐弯
            x = CGRectGetMaxX(self.xsl_lastLabel.frame) + margin;
            label.frame = CGRectMake(x, self.xsl_lastLabel.y, w, h);
            
            
            if (CGRectGetMinY(label.frame) == 0) {  // 极端特殊情况下，第一行长龙，需要把初始值矫正
                self.currentColMinX = CGRectGetMinX(label.frame);
            }
        }
        
        if (x > self.allColMaxLabelX) {
            self.allColMaxLabelX = x;
        }
        [self.oneColArray addObject:@(colorType)];
    } else {
        
        // *** 开头第一个 ***
        
        self.oneColArray = nil;
        // 前一列最后一个 Label
        self.frontColLastLabel = self.xsl_lastLabel;
        
        
        y = 0;
        // 最顶上的长龙时处理 极端情况
        CGFloat lastLabelY = CGRectGetMinY(self.frontColLastLabel.frame);
        if (lastLabelY == 0) {
            CGFloat lastLabelX = CGRectGetMaxX(self.frontColLastLabel.frame);
            x = lastLabelX + margin;
        } else {
            x = self.currentColMinX + w + margin;
        }
        
        if (x > self.allColMaxLabelX) {
            self.allColMaxLabelX = x;
        }
        label.frame = CGRectMake(x, y, w, h);
        // 相同开奖结果清空
        self.currentLongNum = 1;
        [self.oneColArray addObject:@(colorType)];
        self.currentColMinX = CGRectGetMinX(label.frame);
        
        // 把前一列大于等于当前X值的最后一个Label 记录
        if (CGRectGetMaxX(self.xsl_lastLabel.frame) >= CGRectGetMaxX(label.frame)) {
            [self.allBigColLastLabelArray addObject:self.xsl_lastLabel];
        }
        
    }
    
    
    if (self.allColMaxLabelX + w + margin > (self.bounds.size.width - 50)){ // 下三路闲庄路X大于整个屏幕时往后自动移动位置，好观看
        if ((self.allColMaxLabelX + w + margin) != (CGRectGetMaxX(self.xsl_lastLabel.frame) + margin)) {
            // 移动位置
            [UIView animateWithDuration:0.1 animations:^{
                [self.xsl_ScrollView setContentOffset:CGPointMake(self.allColMaxLabelX + w + margin - (self.bounds.size.width - 50), 0) animated:YES];
                [self.blankGridCollectionView setContentOffset:CGPointMake(self.allColMaxLabelX + w + margin - (self.bounds.size.width - 50), 0) animated:YES];
            }];
        }
    }
    
    self.xsl_lastLabel = label;
    self.xsl_lastModel = colorType;
}




/// 获得最小的Y 值 Label
/// @param currentColX 当前X值
- (UILabel *)getMinYLabelColX:(CGFloat)currentColX {
    
    UILabel *tempLabel = nil;
    CGFloat minY = (kItemSizeWidth +1) * 6;
    for (UILabel *label in self.allBigColLastLabelArray.reverseObjectEnumerator) {  //  对数组逆序遍历，然后再删除元素就没有问题了。
        CGFloat oldX = CGRectGetMaxX(label.frame);
        CGFloat oldY = CGRectGetMaxY(label.frame);
        if (oldX >= currentColX) {  // 大于等于当前 X
            if (oldY < minY) {
                minY = oldY;
                tempLabel = label;  // 记录这个Label
            }
        } else {  // 否则移除小于当前的X 值Label
            [self.allBigColLastLabelArray removeObject:label];
        }
    }
    return tempLabel;
}






#pragma mark - 首先创建一个collectionView
- (void)createBlankGridView {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    // 设置每个item的大小
    layout.itemSize = CGSizeMake(kItemSizeWidth+1, kItemSizeWidth+1);
    
    // 设置列间距
    layout.minimumInteritemSpacing = 0;
    
    // 设置行间距
    layout.minimumLineSpacing = 0;
    
    //每个分区的四边间距UIEdgeInsetsMake
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    // 设置布局方向(滚动方向)
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    CGFloat height = (kItemSizeWidth+1) * 6;
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
    return kTotalGridsNum+12;
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




- (UIScrollView *)xsl_ScrollView {
    if (!_xsl_ScrollView) {
        _xsl_ScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _xsl_ScrollView.delegate = self;
        _xsl_ScrollView.backgroundColor = [UIColor clearColor];
        _xsl_ScrollView.contentSize = CGSizeMake((kItemSizeWidth+1)*(kTotalGridsNum/6), 0);
        _xsl_ScrollView.layer.borderWidth = 1;
        _xsl_ScrollView.layer.borderColor = [UIColor redColor].CGColor;
        // 禁止弹簧效果
        _xsl_ScrollView.bounces = NO;
        // 滚动条
        _xsl_ScrollView.showsVerticalScrollIndicator = NO;
        _xsl_ScrollView.showsHorizontalScrollIndicator = NO;
    }
    return _xsl_ScrollView;
}


- (NSMutableArray *)xsl_DataArray {
    if (!_xsl_DataArray) {
        _xsl_DataArray = [NSMutableArray array];
    }
    return _xsl_DataArray;
}

- (NSMutableArray *)oneColArray {
    if (!_oneColArray) {
        _oneColArray = [NSMutableArray array];
    }
    return _oneColArray;
}

- (NSMutableArray *)allBigColLastLabelArray {
    if (!_allBigColLastLabelArray) {
        _allBigColLastLabelArray = [NSMutableArray array];
    }
    return _allBigColLastLabelArray;
}


@end




