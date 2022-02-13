//
//  BaccaratRoadMapView.m
//  VVCollectProject
//
//  Created by lvan Lewis on 2019/9/19.
//  Copyright © 2019 Mike. All rights reserved.
//

#import "BBigRoadMapView.h"
#import "BaccaratCollectionViewCell.h"
#import "UIView+Extension.h"

#import "BaccaratCom.h"
#import "BaccaratComputer.h"


// https://wgm8.com/szh-fate-in-the-cards-understanding-baccarat-trends-part-2/
// *** 珠盘路 ***
//同样，红色代表庄家，蓝色代表闲家，绿色代表和局。
//第一个标记出现在珠盘的左上角，然后开始竖直向下排，六格填满后就转到第二列，第二列填满后转到第三列，以此类推。
//与大路不同，和局单独占据一格。




static NSString *const kCellBaccaratCollectionViewId = @"BaccaratCollectionViewCell";

// 需要实现三个协议 UICollectionViewDelegateFlowLayout 继承自 UICollectionViewDelegate
@interface BBigRoadMapView () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

/// 大路视图
@property (nonatomic, strong) UIScrollView *roadListScrollView;
/// 空白网格视图
@property (nonatomic, strong) UICollectionView *blankGridCollectionView;



// ****** 大路 ******

/// 大路 最后一个Label
@property (nonatomic, strong) UILabel *roadListLastLabel;
/// 记录当前列的最小 X
@property (nonatomic, assign) CGFloat currentColMinX;
/// 把前一列大于等于当前X值的最后一个Label 记录,  用来判断长龙拐弯的的最后一个，动态移除X 小于当前的Label
@property (nonatomic, strong) NSMutableArray<UILabel *> *allColLastLabelArray;
/// 记录当前一条路
@property (nonatomic, strong) NSMutableArray<BaccaratResultModel *> *newOneColArray;
/// 记录所有大路「列」数据
@property (nonatomic, strong) NSMutableArray<NSArray *> *columnDataArray;


/// 连续和的数量
@property (nonatomic, assign) NSInteger tieNum;


/// 大眼路
@property (nonatomic, strong) NSMutableArray *dyl_DataArray;
/// 小路
@property (nonatomic, strong) NSMutableArray *xl_DataArray;
/// 小强路
@property (nonatomic, strong) NSMutableArray *xql_DataArray;
/// 问路
@property (nonatomic, strong) NSMutableArray *wenLu_DataArray;

@end

@implementation BBigRoadMapView



- (instancetype)initWithFrame:(CGRect)frame{
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
    
    _tieNum = 0;
}

- (void)createUI {
    [self createBlankGridView];
    [self addSubview:self.roadListScrollView];
}

- (void)setIsShowTie:(BOOL)isShowTie {
    _isShowTie = isShowTie;
    
    // 移除全部子视图
    [self.roadListScrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self initData];
    
    for (NSInteger index = 0; index < self.zhuPanLuResultDataArray.count; index++) {
        BaccaratResultModel *model = self.zhuPanLuResultDataArray[index];
        [self createItemModel:model isFirst:index == 0 ? YES : NO];
    }
}



- (void)setZhuPanLuResultDataArray:(NSMutableArray<BaccaratResultModel *> *)zhuPanLuResultDataArray {
    _zhuPanLuResultDataArray = zhuPanLuResultDataArray;
    
    if (!zhuPanLuResultDataArray) {
        NSLog(@"🔴🔴🔴大路112🔴🔴🔴");
    }
    self.wenLu_DataArray = [NSMutableArray array];
    
    BaccaratResultModel *model = (BaccaratResultModel *)self.zhuPanLuResultDataArray.lastObject;
    
    [self createItemModel:model isFirst:zhuPanLuResultDataArray.count == 1 ? YES : NO];
    
    if (model.winType != WinType_TIE) {
        [self getXiaSanLuData:self.columnDataArray];
    }
}

#pragma mark -  大路
- (void)createItemModel:(BaccaratResultModel *)model isFirst:(BOOL)isFirst {
    
    CGFloat margin = kBMarginWidth;
    CGFloat w = kBDLItemSizeWidth;
    CGFloat h = w;
    CGFloat x = 0;
    CGFloat y = 0;
    
    if (!self.isShowTie && model.winType == WinType_TIE) {
        self.tieNum++;
        [self tieBezierPath:model isFirst:isFirst];
        return;
    }
    
    UILabel *label = [self createLabelModel:model];;
    [self.roadListScrollView addSubview:label];

    BOOL isLong = [BaccaratComputer isLongResultModel:model colDataArray:self.columnDataArray];

    if (isLong) {
        
        [self.newOneColArray addObject:model];
        if (isFirst) {
            [self.columnDataArray addObject:self.newOneColArray];
        }
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
        [self.newOneColArray addObject:model];
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


/// 获取下三路数据
- (void)getXiaSanLuData:(NSArray *)columnDataArray {
    MapColorType dyl_colorType = [self xsl_ComputerData:columnDataArray roadMapType:RoadMapType_DYL];
    if (dyl_colorType != ColorType_None) {
        [self.dyl_DataArray addObject:@(dyl_colorType)];
    }
    
    MapColorType xl_colorType = [self xsl_ComputerData:columnDataArray roadMapType:RoadMapType_XL];
    if (xl_colorType != ColorType_None) {
        [self.xl_DataArray addObject:@(xl_colorType)];
    }
    
    MapColorType xql_colorType = [self xsl_ComputerData:columnDataArray roadMapType:RoadMapType_XQL];
    if (xql_colorType != ColorType_None) {
        [self.xql_DataArray addObject:@(xql_colorType)];
    }
    
    
    if ([self.delegate respondsToSelector:@selector(getXSLDataWithCurrentModel:wenLuDataArray:dylDataArray:xlDataArray:xqlDataArray:)]) {
        NSArray *oneArray = (NSArray *)columnDataArray.lastObject;
        BaccaratResultModel *lastModel = oneArray.lastObject;
        // 下三路和问题 数据代理
        [self.delegate getXSLDataWithCurrentModel:lastModel wenLuDataArray:self.wenLu_DataArray dylDataArray:self.dyl_DataArray xlDataArray:self.xl_DataArray xqlDataArray:self.xql_DataArray];
    }
}



#pragma mark -  算法数据
/// 获得下三路 数据
/// @param columnDataArray 大路列数据
/// @param roadMapType 下三路 类型
- (MapColorType)xsl_ComputerData:(NSArray *)columnDataArray roadMapType:(RoadMapType)roadMapType {
    // *** 大眼路规则 ***
    // 大眼仔开始及对应位：第二列对第一列.第三列对第二列.第四列对第三列.第五列对第四列.如此类推。
    // 大眼仔：是从大路第二列(第一口不计)第二口开始向第一列第二口对(第一列不管开几多口庄或闲，是不写红蓝笔，只供大眼仔对应写红或蓝)。
    // (大眼仔开始的第一口)大路第二列.向下开闲，向左望第一列有对，写红。
    
    
    //    小路开始及对应位：第三列对第一列.第四列对第二列.第五列对第三列.第六列对第四列.如此类推。
    //    曱甴路开始及对应位：第四列对第一列.第五列对第二列.第六列对第三列.第七列对第四列.如此类推。
    
    
    NSInteger spacingColumn = 0;  // 列开始数量
    if (roadMapType == RoadMapType_DYL) {
        spacingColumn = 2;
    } else if (roadMapType == RoadMapType_XL) {
        spacingColumn = 3;
    } else if (roadMapType == RoadMapType_XQL) {
        spacingColumn = 4;
    }
    
    if (columnDataArray.count < spacingColumn) {
        return ColorType_None;
    }
    // 当前列
    NSArray *currentColArray = (NSArray *)columnDataArray.lastObject;
    
    
    // 比较列
    NSInteger compareIndex = columnDataArray.count-spacingColumn;
    NSArray *compareColArray = (NSArray *)columnDataArray[compareIndex];
    NSInteger compareCount = compareColArray.count;
    //    if (compareIndex == 0) {
    //        compareCount = compareCount -1;
    //    }
    
    // ****** 庄问路（指路图） 预计下一把的功能******
    MapColorType wenLuColorType = [self getDaYanLuColorCurrentColumnNum:currentColArray.count+1 compareColumnNum:compareCount isFirst:NO];
    [self.wenLu_DataArray addObject:@(wenLuColorType)];
    
    
    if (columnDataArray.count == spacingColumn && currentColArray.count == 1) {
        return ColorType_None;
    }
    
    
    MapColorType colorType = 0;
    if (currentColArray.count == 1) { // 路头牌 第一个
        // 比较列 前一列
        NSArray *frontTwoColArray = (NSArray *)columnDataArray[columnDataArray.count-(spacingColumn+1)];
        
        // 路头牌 当前列 的 前一列
        NSArray *lastColTwoColArray = (NSArray *)columnDataArray[columnDataArray.count-(1+1)];
        // 🅰️
        colorType = [self getDaYanLuColorCurrentColumnNum:lastColTwoColArray.count compareColumnNum:frontTwoColArray.count isFirst:YES];
        
        // 🅱️假设  路头牌”之后在大眼仔上添加的颜色应该是假设大路中上一列继续的情况下我们本应在大眼仔上添加的颜色的相反颜色
        //        colorType = [self getDaYanLuColorCurrentColumnNum:frontColArray.count+1 frontColumnNum:frontTwoColArray.count isFirst:NO];
        //        colorType = colorType == ColorType_Red ? ColorType_Blue : ColorType_Red;
        
    } else {
        // 路中牌
        colorType = [self getDaYanLuColorCurrentColumnNum:currentColArray.count compareColumnNum:compareCount isFirst:NO];
    }
    
    return colorType;
}



/// 判断是 红蓝
/// @param currentColumnNum 当前列数量
/// @param compareColumnNum  比较列 列数量
- (MapColorType)getDaYanLuColorCurrentColumnNum:(NSInteger)currentColumnNum compareColumnNum:(NSInteger)compareColumnNum isFirst:(BOOL)isFirst {
    
    // ❗️❗️❗️🅰️-(按照这个方法) 下三路口决：有对写红，无对写蓝，齐脚跳写红，突脚跳写蓝，突脚连写红。(突脚连-是指长庄或长闲)❗️❗️❗️
    // 下三路共有五句口诀：
    // 有对画红、无对画蓝、齐脚跳画红、突脚跳画蓝、突脚连画红。
    
    MapColorType mapColorType = ColorType_None;
    if (isFirst) {
        if (currentColumnNum == compareColumnNum) {  // 🅰️齐脚跳写红  🅱️「路头牌」「标红」
            mapColorType = ColorType_Red;
        } else if (currentColumnNum < compareColumnNum || currentColumnNum > compareColumnNum) {  // 🅰️突脚跳写蓝  🅱️「路头牌」「标蓝」
            mapColorType = ColorType_Blue;
        } else {
            NSLog(@"🔴🔴🔴未知 MapColorType 1🔴🔴🔴");
        }
    } else {
        if (currentColumnNum <= compareColumnNum) {   // 🅰️有对写红 🅱️「路中牌」当前列小于等于比较列 「标红」
            mapColorType = ColorType_Red;
        } else if (currentColumnNum - compareColumnNum == 1) {  // 🅰️无对写蓝 🅱️「路中牌」 当前列大于比较列 1个 「标蓝」
            mapColorType = ColorType_Blue;
        } else if (currentColumnNum - compareColumnNum >= 2) {  // 🅰️突脚连-是指长庄或长闲  🅱️「路中牌」 当前列大于比较列 2个及以上 长闲长庄 「标红」
            mapColorType = ColorType_Red;
        } else {
            NSLog(@"🔴🔴🔴未知 MapColorType 2🔴🔴🔴");
        }
    }
    
    return mapColorType;
}








/// 移除最后一个
- (void)removeLastSubview {
    
    //    [self.zhuPanLuResultDataArray removeLastObject];
    
    BaccaratResultModel *lastModel = self.zhuPanLuResultDataArray.lastObject;
    
    if (self.isShowTie || (!self.isShowTie && lastModel.winType != WinType_TIE)) {
        
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
        
        if (CGRectGetMinY(lastLabel.frame) == 0) {  // Y= 0时，需要把初始值矫正
            CGFloat margin = kBMarginWidth;
            CGFloat w = kBDLItemSizeWidth;
            self.currentColMinX = CGRectGetMinX(lastLabel.frame)-w-margin;
        }
        
        [self.dyl_DataArray removeLastObject];
        [self.xl_DataArray removeLastObject];
        [self.xql_DataArray removeLastObject];
        [self.wenLu_DataArray removeLastObject];
        
        /// 连续和的数量
        //    self.tieNum = self.tieNum - 1;
        
    }
}

- (UILabel *)createLabelModel:(BaccaratResultModel *)model {
    UILabel *label = [[UILabel alloc] init];
    label.layer.masksToBounds = YES;
    label.font = [UIFont boldSystemFontOfSize:12];
    label.textAlignment = NSTextAlignmentCenter;
    label.layer.cornerRadius = kBDLItemSizeWidth/2;
    [self.roadListScrollView addSubview:label];
    
    
    if (model.winType == WinType_Banker) {
        self.tieNum = 0;
        if (model.isSuperSix) {
            label.text = @"6";
            label.textColor = [UIColor whiteColor];
        }
        label.backgroundColor = [UIColor redColor];
    } else if (model.winType == WinType_Player) {
        self.tieNum = 0;
        label.backgroundColor = [UIColor blueColor];
    } else {
        self.tieNum++;
        label.backgroundColor = [UIColor greenColor];
    }
    
    
    // 对子
    if (model.isPlayerPair || model.isBankerPair) {
        [self pairView:model label:label];
    }
    
    return label;
}


- (UIScrollView *)roadListScrollView {
    if (!_roadListScrollView) {
        _roadListScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _roadListScrollView.delegate = self;
        _roadListScrollView.backgroundColor = [UIColor clearColor];
        _roadListScrollView.contentSize = CGSizeMake((kBDLItemSizeWidth+1)*(kBTotalGridsNum/6), 0);
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

/**
 和的处理
 */
- (void)tieBezierPath:(BaccaratResultModel *)model isFirst:(BOOL)isFirst {
    if (isFirst == 1) {  // 第一个和特殊处理
       
        CGFloat w = kBDLItemSizeWidth;
        CGFloat h = w;
        CGFloat x = 0;
        CGFloat y = 0;
        
        UILabel *label = [[UILabel alloc] init];
        label.layer.masksToBounds = YES;
        label.font = [UIFont boldSystemFontOfSize:14];
        label.textAlignment = NSTextAlignmentCenter;
        label.layer.cornerRadius = w/2;
        label.backgroundColor = [UIColor clearColor];
        label.frame = CGRectMake(x, y, w, h);
        
        [self.roadListScrollView addSubview:label];
        [self.newOneColArray addObject:model];
        [self.columnDataArray addObject:self.newOneColArray];
        self.roadListLastLabel = label;
    }
    
    
    // 线的路径
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    // 起点
    [linePath moveToPoint:CGPointMake(kBDLItemSizeWidth, 0)];
    // 其他点
    [linePath addLineToPoint:CGPointMake(0, kBDLItemSizeWidth)];
    
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    lineLayer.lineWidth = 2.0;
    lineLayer.strokeColor = [UIColor greenColor].CGColor;
    lineLayer.path = linePath.CGPath;
    lineLayer.fillColor = nil;
    [self.roadListLastLabel.layer addSublayer:lineLayer];
    
    
    if (self.tieNum != 1) {
        for (UILabel *view in self.roadListLastLabel.subviews) {
            if (view.tag == 5577) {
                [view removeFromSuperview];
            }
        }
        UILabel *tieNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 7, 7)];
        tieNumLabel.font = [UIFont systemFontOfSize:11];
        tieNumLabel.textAlignment = NSTextAlignmentCenter;
        tieNumLabel.textColor = [UIColor redColor];
        tieNumLabel.tag = 5577;
        [self.roadListLastLabel addSubview:tieNumLabel];
        tieNumLabel.text = [NSString stringWithFormat:@"%ld",self.tieNum];
    }
    
    // 对子
    if (model.isPlayerPair || model.isBankerPair) {
        [self pairView:model label:self.roadListLastLabel];
    }
}

// 对子
- (void)pairView:(BaccaratResultModel *)model label:(UILabel *)label {
    CGFloat circleViewWidht = 6;
    if (model.isBankerPair) {
        UIView *bankerPairView = [[UIView alloc] init];
        bankerPairView.backgroundColor = [UIColor colorWithRed:1.000 green:0.251 blue:0.251 alpha:1.000];
        bankerPairView.layer.cornerRadius = circleViewWidht/2;
        bankerPairView.layer.masksToBounds = YES;
        [self.roadListScrollView addSubview:bankerPairView];
        
        [bankerPairView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(label.mas_top);
            make.left.equalTo(label.mas_left);
            make.size.mas_equalTo(@(circleViewWidht));
        }];
    }
    
    if (model.isPlayerPair) {
        UIView *playerPairView = [[UIView alloc] init];
        playerPairView.backgroundColor = [UIColor colorWithRed:0.118 green:0.565 blue:1.000 alpha:1.000];
        playerPairView.layer.cornerRadius = circleViewWidht/2;
        playerPairView.layer.masksToBounds = YES;
        [self.roadListScrollView addSubview:playerPairView];
        
        [playerPairView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(label.mas_bottom);
            make.right.equalTo(label.mas_right);
            make.size.mas_equalTo(@(circleViewWidht));
        }];
    }
}







#pragma mark - 首先创建一个collectionView
- (void)createBlankGridView {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    // 设置每个item的大小
    layout.itemSize = CGSizeMake(kBDLItemSizeWidth+1, kBDLItemSizeWidth+1);
    
    // 设置列间距
    layout.minimumInteritemSpacing = 0;
    
    // 设置行间距
    layout.minimumLineSpacing = 0;
    
    //每个分区的四边间距UIEdgeInsetsMake
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    // 设置布局方向(滚动方向)
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    CGFloat height = (kBDLItemSizeWidth+1) * 6;
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


- (NSMutableArray *)dyl_DataArray {
    if (!_dyl_DataArray) {
        _dyl_DataArray = [NSMutableArray array];
    }
    return _dyl_DataArray;
}
- (NSMutableArray *)xl_DataArray {
    if (!_xl_DataArray) {
        _xl_DataArray = [NSMutableArray array];
    }
    return _xl_DataArray;
}

- (NSMutableArray *)xql_DataArray {
    if (!_xql_DataArray) {
        _xql_DataArray = [NSMutableArray array];
    }
    return _xql_DataArray;
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

