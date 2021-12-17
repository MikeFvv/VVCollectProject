//
//  BaccaratRoadMapView.m
//  VVCollectProject
//
//  Created by lvan Lewis on 2019/9/19.
//  Copyright © 2019 Mike. All rights reserved.
//

#import "BaccaratRoadMapView.h"
#import "BaccaratCollectionViewCell.h"
#import "UIView+Extension.h"
#import "BaccaratResultModel.h"



// 下三路颜色类型
typedef NS_ENUM(NSInteger, MapColorType) {
    ColorType_Red = 0,   // 红色
    ColorType_Blue = 1,   // 蓝色
};



// https://wgm8.com/szh-fate-in-the-cards-understanding-baccarat-trends-part-2/
// *** 珠盘路 ***
//同样，红色代表庄家，蓝色代表闲家，绿色代表和局。
//第一个标记出现在珠盘的左上角，然后开始竖直向下排，六格填满后就转到第二列，第二列填满后转到第三列，以此类推。
//与大路不同，和局单独占据一格。



static NSString *const kCellBaccaratCollectionViewId = @"BaccaratCollectionViewCell";

// 需要实现三个协议 UICollectionViewDelegateFlowLayout 继承自 UICollectionViewDelegate
@interface BaccaratRoadMapView ()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) UICollectionView *collectionView2;
@property (strong, nonatomic) UICollectionView *collectionView3;
@property (strong, nonatomic) UICollectionView *collectionView4;
//
@property (nonatomic,strong) NSMutableArray *dalu_DataArray;
@property (nonatomic,strong) NSMutableArray *dyzl_DataArray;
@property (nonatomic,strong) NSMutableArray *xl_DataArray;
@property (nonatomic,strong) NSMutableArray *yyl_DataArray;




/// 大路
@property (nonatomic, strong) UIScrollView *dalu_ScrollView;
/// 大眼路
@property (nonatomic, strong) UIScrollView *dyzl_ScrollView;
/// 小路
@property (nonatomic, strong) UIScrollView *xl_ScrollView;
/// 曱甴路(小强路)
@property (nonatomic, strong) UIScrollView *yyl_ScrollView;


@property (nonatomic, strong) UILabel *lastLbl;
/// 记录长龙个数
@property (nonatomic, assign) NSInteger longNum;
/// 记录长龙的最小 X
@property (nonatomic, assign) CGFloat longMinX;
/// 记录"和"前面的一个结果
@property (nonatomic, strong) NSDictionary *preTieDict;
/// 记录最大的 x 值
@property (nonatomic, assign)CGFloat maxXValue;

/// 记录当前长龙最低下第一个 label
@property (nonatomic, strong) UILabel *changLongBottomLbl;
/// 记录最后一个转折长龙 最后一个Label
@property (nonatomic, strong) UILabel *turnLongLongBottomLabel;
/// 记录前一路最后一个Label
@property (nonatomic, strong) UILabel *frontLastLabel;

/// 第一个长龙
@property (nonatomic, assign) BOOL isFirstLongLong;
/// 连续和的数量
@property (nonatomic, assign) NSInteger tieNum;

@property (nonatomic, strong) BaccaratResultModel *lastModel;

/// 记录一条路
@property (nonatomic, strong) NSMutableArray<BaccaratResultModel *> *yiluArray;
/// 记录所有大路路子
@property (nonatomic, strong) NSMutableArray<NSArray *> *daluResultDataArray;

@end

@implementation BaccaratRoadMapView



+ (BaccaratRoadMapView *)headViewWithModel:(id)model {
    
    //    NSInteger lorow = 0;
    //    if (isGroupLord) {
    //        lorow = (model.dataList.count + 2 == 0)?0: (model.dataList.count + 2)/5 + ((model.dataList.count + 2) % 5 > 0 ? 1: 0);
    //    } else {
    //        lorow = (model.dataList.count == 0)?0: model.dataList.count/5 + (model.dataList.count % 5 > 0 ? 1: 0);
    //    }
    //
    //    CGFloat height = lorow*CD_Scal(82, 667)+50;
    //    //    lorow = (lorow>5)?5:lorow;
    //    BaccaratCollectionView *view = [[BaccaratCollectionView alloc]initWithFrame:CGRectMake(0, 0, CDScreenWidth, height)];
    //    view.dataList = model.dataList;
    //    view.isGroupLord = isGroupLord;
    //    [view updateList:model];
    //    return view;
    
    return nil;
}


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //        [self initData];
        [self initSubviews];
        //        [self initLayout];
    }
    return self;
}

- (void)setRoadType:(NSInteger)roadType {
    _roadType = roadType;
    if (roadType == 0) {
        self.collectionView.hidden = NO;
        _dalu_ScrollView.hidden = YES;
    } else if (roadType == 1) {
        self.collectionView.hidden = YES;
        self.dalu_ScrollView.hidden = NO;
        [self addSubview:self.dalu_ScrollView];
    }
}


- (void)setModel:(id)model {
    self.dalu_DataArray = [NSMutableArray arrayWithArray:(NSArray *)model];
    if (self.roadType == 0) {
        [self.collectionView reloadData];
    } else if (self.roadType == 1) {
        //        self.maxXValue = 0;
        //        self.longNum = 0;
        //        [self creatItems];
        
        [self daLu_createItems];
    } else {
        NSLog(@"1");
    }
}


- (UIScrollView *)dalu_ScrollView {
    if (!_dalu_ScrollView) {
        _dalu_ScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 100)];
        _dalu_ScrollView.delegate = self;
        _dalu_ScrollView.backgroundColor = [UIColor whiteColor];
        _dalu_ScrollView.contentSize = CGSizeMake(1000, 0);
        _dalu_ScrollView.layer.borderWidth = 1;
        _dalu_ScrollView.layer.borderColor = [UIColor redColor].CGColor;
        _maxXValue = 0;
        _longNum = 0;
        _isFirstLongLong = YES;
    }
    return _dalu_ScrollView;
}
- (UIScrollView *)dyzl_ScrollView {
    if (!_dyzl_ScrollView) {
        _dyzl_ScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 100+10, self.frame.size.width, 100)];
        _dyzl_ScrollView.delegate = self;
        _dyzl_ScrollView.backgroundColor = [UIColor whiteColor];
        _dyzl_ScrollView.contentSize = CGSizeMake(1000, 0);
        _dyzl_ScrollView.layer.borderWidth = 1;
        _dyzl_ScrollView.layer.borderColor = [UIColor redColor].CGColor;
        _maxXValue = 0;
        _longNum = 0;
        _isFirstLongLong = YES;
    }
    return _dyzl_ScrollView;
}
- (UIScrollView *)xl_ScrollView {
    if (!_xl_ScrollView) {
        _xl_ScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 100*2+10*2, self.frame.size.width, 100)];
        _xl_ScrollView.delegate = self;
        _xl_ScrollView.backgroundColor = [UIColor whiteColor];
        _xl_ScrollView.contentSize = CGSizeMake(1000, 0);
        _xl_ScrollView.layer.borderWidth = 1;
        _xl_ScrollView.layer.borderColor = [UIColor redColor].CGColor;
        _maxXValue = 0;
        _longNum = 0;
        _isFirstLongLong = YES;
    }
    return _xl_ScrollView;
}
- (UIScrollView *)yyl_ScrollView {
    if (!_yyl_ScrollView) {
        _yyl_ScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 100*3+10*3, self.frame.size.width, 100)];
        _yyl_ScrollView.delegate = self;
        _yyl_ScrollView.backgroundColor = [UIColor whiteColor];
        _yyl_ScrollView.contentSize = CGSizeMake(1000, 0);
        _yyl_ScrollView.layer.borderWidth = 1;
        _yyl_ScrollView.layer.borderColor = [UIColor redColor].CGColor;
        _maxXValue = 0;
        _longNum = 0;
        _isFirstLongLong = YES;
    }
    return _yyl_ScrollView;
}


/**
 和的处理
 */
- (void)tieBezierPath:(BaccaratResultModel *)model {
    if (self.dalu_DataArray.count == 1) {
        //        CGFloat margin = 1;
        CGFloat w = 16;
        CGFloat h = w;
        CGFloat x = 0;
        CGFloat y = 0;
        
        UILabel *label = [[UILabel alloc] init];
        label.layer.masksToBounds = YES;
        label.font = [UIFont boldSystemFontOfSize:14];
        label.textAlignment = NSTextAlignmentCenter;
        label.layer.cornerRadius = w/2;
        [self.dalu_ScrollView addSubview:label];
        
        label.backgroundColor = [UIColor clearColor];
        label.frame = CGRectMake(x, y, w, h);
        self.longNum = 1;
        [self.yiluArray addObject:model];
        self.lastLbl = label;
        self.lastModel = model;
    }
    
    
    // 线的路径
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    // 起点
    [linePath moveToPoint:CGPointMake(16, 0)];
    // 其他点
    [linePath addLineToPoint:CGPointMake(0, 16)];
    
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    lineLayer.lineWidth = 1.5;
    lineLayer.strokeColor = [UIColor greenColor].CGColor;
    lineLayer.path = linePath.CGPath;
    lineLayer.fillColor = nil;
    [self.lastLbl.layer addSublayer:lineLayer];
    
    self.tieNum++;
    if (self.tieNum != 1) {
        for (UILabel *view in self.lastLbl.subviews) {
            if (view.tag == 5577) {
                [view removeFromSuperview];
            }
        }
        UILabel *tieNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 7, 7)];
        tieNumLabel.font = [UIFont systemFontOfSize:11];
        tieNumLabel.textAlignment = NSTextAlignmentCenter;
        tieNumLabel.textColor = [UIColor redColor];
        tieNumLabel.tag = 5577;
        [self.lastLbl addSubview:tieNumLabel];
        tieNumLabel.text = [NSString stringWithFormat:@"%ld",self.tieNum];
    }
    
    // 对子
    if (model.isPlayerPair || model.isBankerPair) {
        [self pairView:model label:self.lastLbl];
    }
}

#pragma mark -  大路
- (void)daLu_createItems {
    
    BaccaratResultModel *model = (BaccaratResultModel *)self.dalu_DataArray.lastObject;
    
    if (model.winType == WinType_TIE) {
            [self tieBezierPath:model];
            return;
    }
    
    CGFloat margin = 1;
    CGFloat w = 16;
    CGFloat h = 16;
    CGFloat x = 0;
    CGFloat y = 0;
    
    UILabel *label = [[UILabel alloc] init];
    label.layer.masksToBounds = YES;
    label.font = [UIFont boldSystemFontOfSize:14];
    label.textAlignment = NSTextAlignmentCenter;
    label.layer.cornerRadius = w/2;
    [self.dalu_ScrollView addSubview:label];
    
    
    BaccaratResultModel *lastModel;
    if (self.dalu_DataArray.count >= 2) {
        lastModel = (BaccaratResultModel *)self.dalu_DataArray[self.dalu_DataArray.count-2];
    }
    
    if (model.winType == WinType_Banker) {
        if (model.isSuperSix) {
            label.text = @"6";
            label.textColor = [UIColor whiteColor];
        }
        label.backgroundColor = [UIColor redColor];
    } else if (model.winType == WinType_Player) {
        label.backgroundColor = [UIColor blueColor];
    } else {
        label.backgroundColor = [UIColor greenColor];
    }
    
    // 对子
    if (model.isPlayerPair || model.isBankerPair) {
        [self pairView:model label:label];
    }
   
    if (self.dalu_DataArray.count == 1) {
        label.frame = CGRectMake(x, y, w, h);
        self.longNum = 1;
        [self.yiluArray addObject:model];
        [self.daluResultDataArray addObject:self.yiluArray];
    } else {
        
        BOOL isLong = NO;
        if (model.winType == self.lastModel.winType || self.lastModel.winType == WinType_TIE) {
            isLong = YES;
        }
        if (isLong) {
            // 计算最大可使用空白格数
            NSInteger maxBlankColumns = 6;
            CGFloat lastLabelX = CGRectGetMaxX(self.frontLastLabel.frame);
            CGFloat lastLabelY = CGRectGetMinY(self.frontLastLabel.frame);
            if (lastLabelX > 0 && lastLabelX >= CGRectGetMaxX(self.lastLbl.frame)) {
                maxBlankColumns = lastLabelY/(w +margin);
            }
            
            // 记录连续相同的结果个数
            self.longNum += 1;
            if (self.longNum <= maxBlankColumns) {
                self.longMinX = self.lastLbl.x;
                x = self.lastLbl.x;
                label.frame = CGRectMake(x, CGRectGetMaxY(self.lastLbl.frame) + margin, w, h);
            } else {
                x = CGRectGetMaxX(self.lastLbl.frame) + margin;
                label.frame = CGRectMake(x, self.lastLbl.y, w, h);
            }
            
            if (x > self.maxXValue) {
                self.maxXValue = x;
            }
            [self.yiluArray addObject:model];
        } else {
            
            // 开头第一个
            if (self.yiluArray.count > 0) {
                
                self.yiluArray = nil;
                self.frontLastLabel = self.lastLbl;
            }
            
            y = 0;
            // 最顶上的长龙时处理 极端情况
            CGFloat lastLabelY = CGRectGetMinY(self.frontLastLabel.frame);
            if (lastLabelY == 0) {
                CGFloat lastLabelX = CGRectGetMaxX(self.frontLastLabel.frame);
                x = lastLabelX + margin;
            } else {
                x = self.longMinX + w + margin;
            }
            
            if (x > self.maxXValue) {
                self.maxXValue = x;
            }
            label.frame = CGRectMake(x, y, w, h);
            // 相同开奖结果清空
            self.longNum = 1;
            [self.yiluArray addObject:model];
            [self.daluResultDataArray addObject:self.yiluArray];
            self.longMinX = CGRectGetMinX(label.frame);
        }
    }
    
    if (self.maxXValue + w + margin > (self.bounds.size.width - 50)){
        if ((self.maxXValue + w + margin) != (CGRectGetMaxX(self.lastLbl.frame) + margin)) {
            // 移动位置
            [UIView animateWithDuration:0.1 animations:^{
                [self.dalu_ScrollView setContentOffset:CGPointMake(self.maxXValue + w + margin - (self.bounds.size.width - 50), 0) animated:YES];
            }];
        }
    }
    
    
    self.lastLbl = label;
    self.lastModel = model;
    
    
//    [self daYanLu_createItems];
}


#pragma mark -  大眼路
/// 大眼路
- (void)daYanLu_createItems {
    
    // *** 大眼路规则 ***
    // 大眼仔开始及对应位：第二列对第一列.第三列对第二列.第四列对第三列.第五列对第四列.如此类推。
    // 大眼仔：是从大路第二列(第一口不计)第二口开始向第一列第二口对(第一列不管开几多口庄或闲，是不写红蓝笔，只供大眼仔对应写红或蓝)。
    // (大眼仔开始的第一口)大路第二列.向下开闲，向左望第一列有对，写红。
    
    
//    小路开始及对应位：第三列对第一列.第四列对第二列.第五列对第三列.第六列对第四列.如此类推。
//    曱甴路开始及对应位：第四列对第一列.第五列对第二列.第六列对第三列.第七列对第四列.如此类推。

    
    
    
    if (self.daluResultDataArray.count < 2) {
        return;
    }
    
    NSArray<BaccaratResultModel *> *currentColArray = (NSArray *)self.daluResultDataArray.lastObject;
    
    if (self.daluResultDataArray.count == 2 && currentColArray.count == 1) {
        return;
    }
    
    BaccaratResultModel *model = currentColArray.lastObject;   // 当前的
    
    CGFloat margin = 1;
    CGFloat w = 16;
    CGFloat h = 16;
    CGFloat x = 0;
    CGFloat y = 0;
    
    
    UILabel *label = [[UILabel alloc] init];
    label.layer.masksToBounds = YES;
    label.font = [UIFont boldSystemFontOfSize:14];
    label.textAlignment = NSTextAlignmentCenter;
    label.layer.cornerRadius = w/2;
    [self.dyzl_ScrollView addSubview:label];
    
    // 前一列
    NSArray *frontColArray = (NSArray *)self.daluResultDataArray[self.daluResultDataArray.count-2];
   
    
    MapColorType colorType = 0;
    if (currentColArray.count == 1) {
        // 路头牌
        
        // 前2列
        NSArray *frontTwoColArray = (NSArray *)self.daluResultDataArray[self.daluResultDataArray.count-3];
        // 假设  路头牌”之后在大眼仔上添加的颜色应该是假设大路中上一列继续的情况下我们本应在大眼仔上添加的颜色的相反颜色
        colorType = [self getDaYanLuColorCurrentColumnNum:frontColArray.count+1 frontColumnNum:frontTwoColArray.count];
        colorType = colorType == ColorType_Red ? ColorType_Blue : ColorType_Red;
    } else {
        // 路中牌
        colorType = [self getDaYanLuColorCurrentColumnNum:currentColArray.count frontColumnNum:frontColArray.count];
    }
    
    
    
    if (self.daluResultDataArray.count == 1) {
        label.frame = CGRectMake(x, y, w, h);
        self.longNum = 1;
        [self.yiluArray addObject:model];
    } else {
        
        BOOL isLong = NO;
        if (model.winType == self.lastModel.winType) {
            isLong = YES;
        }
        if (isLong) {
            // 计算最大可使用空白格数
            NSInteger maxBlankColumns = 6;
            CGFloat lastLabelX = CGRectGetMaxX(self.frontLastLabel.frame);
            CGFloat lastLabelY = CGRectGetMinY(self.frontLastLabel.frame);
            if (lastLabelX > 0 && lastLabelX >= CGRectGetMaxX(self.lastLbl.frame)) {
                maxBlankColumns = lastLabelY/(w +margin);
            }
            
            // 记录连续相同的结果个数
            self.longNum += 1;
            if (self.longNum <= maxBlankColumns) {
                self.longMinX = self.lastLbl.x;
                x = self.lastLbl.x;
                label.frame = CGRectMake(x, CGRectGetMaxY(self.lastLbl.frame) + margin, w, h);
            } else {
                x = CGRectGetMaxX(self.lastLbl.frame) + margin;
                label.frame = CGRectMake(x, self.lastLbl.y, w, h);
            }
            
            if (x > self.maxXValue) {
                self.maxXValue = x;
            }
            [self.yiluArray addObject:model];
        } else {
            
            // 开头第一个
            if (self.yiluArray.count > 0) {
                self.yiluArray = nil;
                self.frontLastLabel = self.lastLbl;
            }
            
            y = 0;
            // 最顶上的长龙时处理 极端情况
            CGFloat lastLabelY = CGRectGetMinY(self.frontLastLabel.frame);
            if (lastLabelY == 0) {
                CGFloat lastLabelX = CGRectGetMaxX(self.frontLastLabel.frame);
                x = lastLabelX + margin;
            } else {
                x = self.longMinX + w + margin;
            }
            
            if (x > self.maxXValue) {
                self.maxXValue = x;
            }
            label.frame = CGRectMake(x, y, w, h);
            // 相同开奖结果清空
            self.longNum = 1;
            [self.yiluArray addObject:model];
            self.longMinX = CGRectGetMinX(label.frame);
        }
    }
    
    if (self.maxXValue + w + margin > (self.bounds.size.width - 50)){
        if ((self.maxXValue + w + margin) != (CGRectGetMaxX(self.lastLbl.frame) + margin)) {
            // 移动位置
            [UIView animateWithDuration:0.1 animations:^{
                [self.dyzl_ScrollView setContentOffset:CGPointMake(self.maxXValue + w + margin - (self.bounds.size.width - 50), 0) animated:YES];
            }];
        }
    }
    
    
    self.lastLbl = label;
    self.lastModel = model;
    
}


- (MapColorType)getDaYanLuColorCurrentColumnNum:(NSInteger)currentColumnNum frontColumnNum:(NSInteger)frontColumnNum {
    MapColorType mapColorType = 0;
    if (currentColumnNum <= frontColumnNum) {   // 当前列小于等于前一列 「标红」  // -路中牌
        mapColorType = ColorType_Red;
    } else if (currentColumnNum -1 == frontColumnNum) {  // 当前列大于前一列 1个 「标蓝」  // -路中牌
        mapColorType = ColorType_Blue;
    } else if (currentColumnNum -1 > frontColumnNum) {  // 当前列大于前一列 2个及以上 「标红」  长闲长庄  // -路中牌
        mapColorType = ColorType_Red;
    } else {
        NSLog(@"🔴🔴🔴未知🔴🔴🔴");
    }
    return mapColorType;
}


// 对子
- (void)pairView:(BaccaratResultModel *)model label:(UILabel *)label {
    CGFloat circleViewWidht = 7;
    if (model.isBankerPair) {
        UIView *bankerPairView = [[UIView alloc] init];
        bankerPairView.backgroundColor = [UIColor colorWithRed:1.000 green:0.251 blue:0.251 alpha:1.000];
        bankerPairView.layer.cornerRadius = circleViewWidht/2;
        bankerPairView.layer.masksToBounds = YES;
        [self.dalu_ScrollView addSubview:bankerPairView];
        
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
        [self.dalu_ScrollView addSubview:playerPairView];
        
        [playerPairView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(label.mas_bottom);
            make.right.equalTo(label.mas_right);
            make.size.mas_equalTo(@(circleViewWidht));
        }];
    }
}


- (NSString *)winTypeDict:(BaccaratResultModel *)model {
    NSString *text;
    if (model.winType == WinType_Banker) {
        text = @"B";
    } else if (model.winType == WinType_Player) {
        text = @"P";
    } else {
        text = @"T";
    }
    return text;
}




#pragma mark - 首先创建一个collectionView
- (void)initSubviews {
    
    //    首先创建一个collectionView
    //    创建的时候UICollectionViewFlowLayout必须创建
    //    layout.itemSize必须设置
    //    必须注册一个collectionView的自定义cell
    /**
     创建layout(布局)
     UICollectionViewFlowLayout 继承与UICollectionLayout
     对比其父类 好处是 可以设置每个item的边距 大小 头部和尾部的大小
     */
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    CGFloat itemWidth = ([UIScreen mainScreen].bounds.size.width - 10*2 - 10*2) / (90/6+1);
    // 设置每个item的大小
    layout.itemSize = CGSizeMake(itemWidth, itemWidth);
    
    // 设置列间距
    layout.minimumInteritemSpacing = 1;
    
    // 设置行间距
    layout.minimumLineSpacing = 1;
    
    //每个分区的四边间距UIEdgeInsetsMake
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
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
    // 设置分区(组)的EdgeInset（四边距）
    //layout.sectionInset = UIEdgeInsetsMake(<#CGFloat top#>, <#CGFloat left#>, <#CGFloat bottom#>, <#CGFloat right#>);
    //
    // 设置分区的头视图和尾视图是否始终固定在屏幕上边和下边
    //        layout.sectionFootersPinToVisibleBounds = YES;
    //        layout.sectionHeadersPinToVisibleBounds = YES;
    
    /**
     初始化mainCollectionView
     设置collectionView的位置
     */
    CGFloat height = self.frame.size.height;
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, height) collectionViewLayout:layout];
    
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
    
    /**
     四./注册cell
     在重用池中没有新的cell就注册一个新的cell
     相当于懒加载新的cell
     定义重用标识符(在页面最上定义全局)
     用自定义的cell类,防止内容重叠
     注册时填写的重用标识符 是给整个类添加的 所以类里有的所有属性都有重用标识符
     */
    [_collectionView registerClass:[BaccaratCollectionViewCell class] forCellWithReuseIdentifier:kCellBaccaratCollectionViewId];
    [_collectionView registerClass:[BaccaratCollectionViewCell class] forCellWithReuseIdentifier:kCellBaccaratCollectionViewId];
    [_collectionView registerClass:[BaccaratCollectionViewCell class] forCellWithReuseIdentifier:kCellBaccaratCollectionViewId];
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
    if (collectionView == self.collectionView) {
        return self.dalu_DataArray.count;
    } else if (collectionView == self.collectionView2) {
        return self.dyzl_DataArray.count;
    } else if (collectionView == self.collectionView3) {
        return self.xl_DataArray.count;
    } else {
        return self.yyl_DataArray.count;
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
    if (collectionView == self.collectionView) {
        BaccaratCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellBaccaratCollectionViewId forIndexPath:indexPath];
        BaccaratResultModel *model = (BaccaratResultModel *)self.dalu_DataArray[indexPath.row];
        cell.model = model;
        return cell;
    } else if (collectionView == self.collectionView2) {
        BaccaratCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellBaccaratCollectionViewId forIndexPath:indexPath];
        BaccaratResultModel *model = (BaccaratResultModel *)self.dalu_DataArray[indexPath.row];
        cell.model = model;
        return cell;
    } else if (collectionView == self.collectionView3) {
        BaccaratCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellBaccaratCollectionViewId forIndexPath:indexPath];
        BaccaratResultModel *model = (BaccaratResultModel *)self.dalu_DataArray[indexPath.row];
        cell.model = model;
        return cell;
    } else {
        BaccaratCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellBaccaratCollectionViewId forIndexPath:indexPath];
        BaccaratResultModel *model = (BaccaratResultModel *)self.dalu_DataArray[indexPath.row];
        cell.model = model;
        return cell;
    }
    
}

#pragma mark --UICollectionViewDelegateFlowLayout  视图布局

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(1, 1, 1, 1);
}

#pragma mark --UICollectionViewDelegate 代理

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}










// 画线
// https://www.cnblogs.com/lulushen/p/11163965.html
// https://www.cnblogs.com/jaesun/p/iOS-CAShapeLayerUIBezierPath-hua-xian.html 这个
- (void)creatItems {
    for (UIView *view in self.dalu_ScrollView.subviews) {
        [view removeFromSuperview];
    }
    
    self.dalu_ScrollView.contentSize = CGSizeMake(1000, 0);
    for (int i = 0; i < self.dalu_DataArray.count; i++) {
        BaccaratResultModel *model = (BaccaratResultModel *)self.dalu_DataArray[i];
        
        if (model.winType == WinType_TIE && i != 0) {
            // 线的路径
            UIBezierPath *linePath = [UIBezierPath bezierPath];
            // 起点
            [linePath moveToPoint:CGPointMake(16, 0)];
            // 其他点
            [linePath addLineToPoint:CGPointMake(0, 16)];
            
            CAShapeLayer *lineLayer = [CAShapeLayer layer];
            lineLayer.lineWidth = 1.5;
            lineLayer.strokeColor = [UIColor greenColor].CGColor;
            lineLayer.path = linePath.CGPath;
            lineLayer.fillColor = nil;
            [self.lastLbl.layer addSublayer:lineLayer];
            
            self.tieNum++;
            if (self.tieNum != 1) {
                UILabel *tieNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 7, 7)];
                tieNumLabel.font = [UIFont boldSystemFontOfSize:11];
                tieNumLabel.textAlignment = NSTextAlignmentCenter;
                tieNumLabel.textColor = [UIColor greenColor];
                [self.lastLbl addSubview:tieNumLabel];
                tieNumLabel.text = [NSString stringWithFormat:@"%ld",self.tieNum];
            }
            continue;
        }
        
        self.tieNum = 0;
        UILabel *label = [[UILabel alloc] init];
        label.layer.masksToBounds = YES;
        label.font = [UIFont boldSystemFontOfSize:14];
        label.textAlignment = NSTextAlignmentCenter;
        
        CGFloat itemWidth = 16;
        label.layer.cornerRadius = itemWidth/2;
        [self.dalu_ScrollView addSubview:label];
        
        
        
        BaccaratResultModel *lastModel;
        if (i >= 1) {
            lastModel = (BaccaratResultModel *)self.dalu_DataArray[i-1];
        }
        
        if (model.winType == WinType_Banker) {
            if (model.isSuperSix) {
                label.text = @"6";
                label.textColor = [UIColor whiteColor];
            }
            label.backgroundColor = [UIColor redColor];
        } else if (model.winType == WinType_Player) {
            label.backgroundColor = [UIColor blueColor];
        } else {
            label.backgroundColor = [UIColor greenColor];
        }
        
        // 对子
        CGFloat circleViewWidht = 7;
        if (model.isBankerPair) {
            UIView *bankerPairView = [[UIView alloc] init];
            bankerPairView.backgroundColor = [UIColor colorWithRed:1.000 green:0.251 blue:0.251 alpha:1.000];
            bankerPairView.layer.cornerRadius = circleViewWidht/2;
            bankerPairView.layer.masksToBounds = YES;
            [self.dalu_ScrollView addSubview:bankerPairView];
            
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
            [self.dalu_ScrollView addSubview:playerPairView];
            
            [playerPairView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(label.mas_bottom);
                make.right.equalTo(label.mas_right);
                make.size.mas_equalTo(@(circleViewWidht));
            }];
        }
        
        CGFloat margin = 1;
        CGFloat w = itemWidth;
        CGFloat h = w;
        CGFloat x = 0;
        CGFloat y = 0;
        if (i == 0) {
            label.frame = CGRectMake(x, y, w, h);
            if (model.winType != WinType_TIE) {
                self.longNum = 1;
            }
        }else{
            
            BOOL continueBool = model.winType == self.lastModel.winType ? YES : NO;
            if (continueBool) {
                //记录连续相同的结果个数
                self.longNum += 1;
                if (self.longNum <= 6) {
                    self.longMinX = self.lastLbl.x;
                    x = self.lastLbl.x;
                    label.frame = CGRectMake(x, CGRectGetMaxY(self.lastLbl.frame) + margin, w, h);
                    if (self.longNum == 6) {//记录长龙最底下的第一个 label,用于之后进行 x 值的比较
                        self.changLongBottomLbl = label;
                    }
                }else{
                    x = CGRectGetMaxX(self.lastLbl.frame) + margin;
                    label.frame = CGRectMake(x, self.lastLbl.y, w, h);
                }
                if (x > self.maxXValue) {
                    self.maxXValue = x;
                }
            } else {
                
                y = 0;
                if (self.longNum > 6) {
                    x = self.longMinX + w + margin;
                }else{
                    x = CGRectGetMaxX(self.lastLbl.frame) + margin;
                }
                if (x > self.maxXValue) {
                    self.maxXValue = x;
                }
                label.frame = CGRectMake(x, y, w, h);
                //相同开奖结果清空
                self.longNum = 1;
            }
            
        }
        
        
        
        
        [UIView animateWithDuration:0.1 animations:^{
            if (self.maxXValue + w + margin > (self.bounds.size.width - 60)){
                if ((self.maxXValue + w + margin) != CGRectGetMinX(self.lastLbl.frame)) {
                    
                    [self.dalu_ScrollView setContentOffset:CGPointMake(self.maxXValue + w + margin - (kSCREEN_WIDTH - 60), 0) animated:YES];
                }
            } else {
                [self.dalu_ScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
            }
        }];
        
        
        self.lastLbl = label;
        self.lastLbl.tag = i;
        self.lastModel = model;
        
    }
}


- (NSMutableArray *)yiluArray {
    if (!_yiluArray) {
        _yiluArray = [NSMutableArray array];
    }
    return _yiluArray;
}

- (NSMutableArray *)daluResultDataArray{
    if (!_daluResultDataArray) {
        _daluResultDataArray = [NSMutableArray array];
    }
    return _daluResultDataArray;
}


@end

