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
#import "BaccaratResultModel.h"
#import "BaccaratCom.h"


// https://wgm8.com/szh-fate-in-the-cards-understanding-baccarat-trends-part-2/
// *** 珠盘路 ***
//同样，红色代表庄家，蓝色代表闲家，绿色代表和局。
//第一个标记出现在珠盘的左上角，然后开始竖直向下排，六格填满后就转到第二列，第二列填满后转到第三列，以此类推。
//与大路不同，和局单独占据一格。



static NSString *const kCellBaccaratCollectionViewId = @"BaccaratCollectionViewCell";

// 需要实现三个协议 UICollectionViewDelegateFlowLayout 继承自 UICollectionViewDelegate
@interface BBigRoadMapView ()
//
@property (nonatomic, strong) NSMutableArray *daLu_DataArray;

/// 大路
@property (nonatomic, strong) UIScrollView *daLu_ScrollView;


// ****** 大路 ******

/// 记录最后一个数据
@property (nonatomic, strong) BaccaratResultModel *daLu_lastModel;
/// 大路 最后一个Label
@property (nonatomic, strong) UILabel *daLu_lastLabel;
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
/// 连续和的数量
@property (nonatomic, assign) NSInteger tieNum;

/// 记录一条路
@property (nonatomic, strong) NSMutableArray<BaccaratResultModel *> *oneColArray;
/// 记录所有大路「列」数据
@property (nonatomic, strong) NSMutableArray<NSArray *> *daLu_ColDataArray;


@property (nonatomic, strong) NSMutableArray *dyl_DataArray;
@property (nonatomic, strong) NSMutableArray *xl_DataArray;
@property (nonatomic, strong) NSMutableArray *xql_DataArray;

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
    _allColMaxLabelX = 0;
    _currentLongNum = 0;
    _tieNum = 0;
}

- (void)createUI {
    [self addSubview:self.daLu_ScrollView];
}



- (void)setModel:(id)model {
    _model = model;
    self.daLu_DataArray = [NSMutableArray arrayWithArray:(NSArray *)model];
    [self daLu_createItems];
    
    NSLog(@"1");
}




#pragma mark -  大路
- (void)daLu_createItems {
    
    BaccaratResultModel *model = (BaccaratResultModel *)self.daLu_DataArray.lastObject;
    
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
    [self.daLu_ScrollView addSubview:label];
    
    
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
    
    if (self.daLu_DataArray.count == 1) {
        label.frame = CGRectMake(x, y, w, h);
        self.currentLongNum = 1;
        [self.oneColArray addObject:model];
        [self.daLu_ColDataArray addObject:self.oneColArray];
    } else {
        
        BOOL isLong = NO;
        if (model.winType == self.daLu_lastModel.winType || self.daLu_lastModel.winType == WinType_TIE) {
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
            
            
            if (lastLabelX > 0 && lastLabelX >= CGRectGetMaxX(self.daLu_lastLabel.frame)) {
                maxBlankColumns = lastLabelY/(w +margin);
            }
            
            // 记录连续相同的结果个数
            self.currentLongNum += 1;
            if (self.currentLongNum <= maxBlankColumns) {  // 长龙向下
                self.currentColMinX = self.daLu_lastLabel.x;
                x = self.daLu_lastLabel.x;
                label.frame = CGRectMake(x, CGRectGetMaxY(self.daLu_lastLabel.frame) + margin, w, h);
                
            } else {
                // 长龙拐弯
                x = CGRectGetMaxX(self.daLu_lastLabel.frame) + margin;
                label.frame = CGRectMake(x, self.daLu_lastLabel.y, w, h);
                
                
                if (CGRectGetMinY(label.frame) == 0) {  // 极端特殊情况下，第一行长龙，需要把初始值矫正
                    self.currentColMinX = CGRectGetMinX(label.frame);
                }
            }
            
            if (x > self.allColMaxLabelX) {
                self.allColMaxLabelX = x;
            }
            [self.oneColArray addObject:model];
        } else {
            
            // *** 开头第一个 ***
            
            self.oneColArray = nil;
            // 前一列最后一个 Label
            self.frontColLastLabel = self.daLu_lastLabel;
            
            
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
            [self.oneColArray addObject:model];
            [self.daLu_ColDataArray addObject:self.oneColArray];
            self.currentColMinX = CGRectGetMinX(label.frame);
            
            // 把前一列大于等于当前X值的最后一个Label 记录
            if (CGRectGetMaxX(self.daLu_lastLabel.frame) >= CGRectGetMaxX(label.frame)) {
                [self.allBigColLastLabelArray addObject:self.daLu_lastLabel];
            }
            
        }
    }
    
    if (self.allColMaxLabelX + w + margin > (self.bounds.size.width - 50)){ // 大路闲庄路X大于整个屏幕时往后自动移动位置，好观看
        if ((self.allColMaxLabelX + w + margin) != (CGRectGetMaxX(self.daLu_lastLabel.frame) + margin)) {
            // 移动位置
            [UIView animateWithDuration:0.1 animations:^{
                [self.daLu_ScrollView setContentOffset:CGPointMake(self.allColMaxLabelX + w + margin - (self.bounds.size.width - 50), 0) animated:YES];
            }];
        }
    }
    
    self.daLu_lastLabel = label;
    self.daLu_lastModel = model;
    
    
    MapColorType dyl_colorType = [self xsl_ComputerData:self.daLu_ColDataArray roadMapType:RoadMapType_DYL];
    if (dyl_colorType != ColorType_Undefined) {
        [self.dyl_DataArray addObject:@(dyl_colorType)];
    }
    
    
    MapColorType xl_colorType = [self xsl_ComputerData:self.daLu_ColDataArray roadMapType:RoadMapType_XL];
    if (xl_colorType != ColorType_Undefined) {
        [self.xl_DataArray addObject:@(xl_colorType)];
    }
    MapColorType xql_colorType = [self xsl_ComputerData:self.daLu_ColDataArray roadMapType:RoadMapType_XQL];
    if (xql_colorType != ColorType_Undefined) {
        [self.xql_DataArray addObject:@(xql_colorType)];
    }
    
    
    if ([self.delegate respondsToSelector:@selector(getXSLData:xlDataArray:xqlDataArray:)]) {
        
        [self.delegate getXSLData:self.dyl_DataArray xlDataArray:self.xl_DataArray xqlDataArray:self.xql_DataArray];
    }
    
}


/// 获得最小的Y 值 Label
/// @param currentColX 当前X值
- (UILabel *)getMinYLabelColX:(CGFloat)currentColX {
    
    UILabel *tempLabel = nil;
    CGFloat minY = (16 +1) * 6;
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


#pragma mark -  算法数据
/// 获得下三路 数据
/// @param daLu_ColDataArray 大路列数据
/// @param roadMapType 下三路 类型
- (MapColorType)xsl_ComputerData:(NSMutableArray *)daLu_ColDataArray roadMapType:(RoadMapType)roadMapType {
    // *** 大眼路规则 ***
    // 大眼仔开始及对应位：第二列对第一列.第三列对第二列.第四列对第三列.第五列对第四列.如此类推。
    // 大眼仔：是从大路第二列(第一口不计)第二口开始向第一列第二口对(第一列不管开几多口庄或闲，是不写红蓝笔，只供大眼仔对应写红或蓝)。
    // (大眼仔开始的第一口)大路第二列.向下开闲，向左望第一列有对，写红。
    
    
    //    小路开始及对应位：第三列对第一列.第四列对第二列.第五列对第三列.第六列对第四列.如此类推。
    //    曱甴路开始及对应位：第四列对第一列.第五列对第二列.第六列对第三列.第七列对第四列.如此类推。
    
    
    NSInteger spacingColumn = 0;  // 间距列数量
    if (roadMapType == RoadMapType_DYL) {
        spacingColumn = 2;
    } else if (roadMapType == RoadMapType_XL) {
        spacingColumn = 3;
    } else if (roadMapType == RoadMapType_XQL) {
        spacingColumn = 4;
    }
    
    if (daLu_ColDataArray.count < spacingColumn) {
        return ColorType_Undefined;
    }
    
    // 当前列
    NSArray *currentColArray = (NSArray *)daLu_ColDataArray.lastObject;
    
    if (daLu_ColDataArray.count == spacingColumn && currentColArray.count == 1) {
        return ColorType_Undefined;
    }
    
    // 比较列
    NSArray *frontColArray = (NSArray *)daLu_ColDataArray[daLu_ColDataArray.count-spacingColumn];
    
    
    MapColorType colorType = 0;
    if (currentColArray.count == 1) { // 路头牌 第一个
        // 比较列 前一列
        NSArray *frontTwoColArray = (NSArray *)daLu_ColDataArray[daLu_ColDataArray.count-(spacingColumn+1)];
        // 🅰️
        colorType = [self getDaYanLuColorCurrentColumnNum:frontColArray.count frontColumnNum:frontTwoColArray.count isFirst:YES];
        
        // 🅱️假设  路头牌”之后在大眼仔上添加的颜色应该是假设大路中上一列继续的情况下我们本应在大眼仔上添加的颜色的相反颜色
//        colorType = [self getDaYanLuColorCurrentColumnNum:frontColArray.count+1 frontColumnNum:frontTwoColArray.count isFirst:NO];
//        colorType = colorType == ColorType_Red ? ColorType_Blue : ColorType_Red;
        
    } else {
        // 路中牌
        colorType = [self getDaYanLuColorCurrentColumnNum:currentColArray.count frontColumnNum:frontColArray.count isFirst:NO];
    }
    
    return colorType;
}



/// 判断是 红蓝
/// @param currentColumnNum 当前列数量
/// @param frontColumnNum 前一列列数量
- (MapColorType)getDaYanLuColorCurrentColumnNum:(NSInteger)currentColumnNum frontColumnNum:(NSInteger)frontColumnNum isFirst:(BOOL)isFirst {
    
    // ❗️❗️❗️🅰️-(按照这个方法) 下三路口决：有对写红，无对写蓝，齐脚跳写红，突脚跳写蓝，突脚连写红。(突脚连-是指长庄或长闲)❗️❗️❗️
    
    MapColorType mapColorType = ColorType_Undefined;
    if (isFirst) {
        if (currentColumnNum == frontColumnNum) {  // 🅰️齐脚跳写红  🅱️「路头牌」「标红」
            mapColorType = ColorType_Red;
        } else if (currentColumnNum < frontColumnNum || currentColumnNum > frontColumnNum) {  // 🅰️突脚跳写蓝  🅱️「路头牌」「标蓝」
            mapColorType = ColorType_Blue;
        } else {
            NSLog(@"🔴🔴🔴未知 MapColorType 1🔴🔴🔴");
        }
    } else {
        if (currentColumnNum <= frontColumnNum) {   // 🅰️有对写红 🅱️「路中牌」当前列小于等于前一列 「标红」
            mapColorType = ColorType_Red;
        } else if (currentColumnNum - frontColumnNum == 1) {  // 🅰️无对写蓝 🅱️「路中牌」 当前列大于前一列 1个 「标蓝」
            mapColorType = ColorType_Blue;
        } else if (currentColumnNum - frontColumnNum >= 2) {  // 🅰️突脚连-是指长庄或长闲  🅱️「路中牌」 当前列大于前一列 2个及以上 长闲长庄 「标红」
            mapColorType = ColorType_Red;
        } else {
            NSLog(@"🔴🔴🔴未知 MapColorType 2🔴🔴🔴");
        }
    }
      
    return mapColorType;
}




- (UIScrollView *)daLu_ScrollView {
    if (!_daLu_ScrollView) {
        _daLu_ScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 100)];
        _daLu_ScrollView.delegate = self;
        _daLu_ScrollView.backgroundColor = [UIColor whiteColor];
        _daLu_ScrollView.contentSize = CGSizeMake(1000, 0);
        _daLu_ScrollView.layer.borderWidth = 1;
        _daLu_ScrollView.layer.borderColor = [UIColor redColor].CGColor;
    }
    return _daLu_ScrollView;
}

/**
 和的处理
 */
- (void)tieBezierPath:(BaccaratResultModel *)model {
    if (self.daLu_DataArray.count == 1) {
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
        [self.daLu_ScrollView addSubview:label];
        
        label.backgroundColor = [UIColor clearColor];
        label.frame = CGRectMake(x, y, w, h);
        self.currentLongNum = 1;
        [self.oneColArray addObject:model];
        self.daLu_lastLabel = label;
        self.daLu_lastModel = model;
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
    [self.daLu_lastLabel.layer addSublayer:lineLayer];
    
    self.tieNum++;
    if (self.tieNum != 1) {
        for (UILabel *view in self.daLu_lastLabel.subviews) {
            if (view.tag == 5577) {
                [view removeFromSuperview];
            }
        }
        UILabel *tieNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 7, 7)];
        tieNumLabel.font = [UIFont systemFontOfSize:11];
        tieNumLabel.textAlignment = NSTextAlignmentCenter;
        tieNumLabel.textColor = [UIColor redColor];
        tieNumLabel.tag = 5577;
        [self.daLu_lastLabel addSubview:tieNumLabel];
        tieNumLabel.text = [NSString stringWithFormat:@"%ld",self.tieNum];
    }
    
    // 对子
    if (model.isPlayerPair || model.isBankerPair) {
        [self pairView:model label:self.daLu_lastLabel];
    }
}

// 对子
- (void)pairView:(BaccaratResultModel *)model label:(UILabel *)label {
    CGFloat circleViewWidht = 7;
    if (model.isBankerPair) {
        UIView *bankerPairView = [[UIView alloc] init];
        bankerPairView.backgroundColor = [UIColor colorWithRed:1.000 green:0.251 blue:0.251 alpha:1.000];
        bankerPairView.layer.cornerRadius = circleViewWidht/2;
        bankerPairView.layer.masksToBounds = YES;
        [self.daLu_ScrollView addSubview:bankerPairView];
        
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
        [self.daLu_ScrollView addSubview:playerPairView];
        
        [playerPairView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(label.mas_bottom);
            make.right.equalTo(label.mas_right);
            make.size.mas_equalTo(@(circleViewWidht));
        }];
    }
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

- (NSMutableArray *)oneColArray {
    if (!_oneColArray) {
        _oneColArray = [NSMutableArray array];
    }
    return _oneColArray;
}

- (NSMutableArray *)daLu_ColDataArray {
    if (!_daLu_ColDataArray) {
        _daLu_ColDataArray = [NSMutableArray array];
    }
    return _daLu_ColDataArray;
}
- (NSMutableArray *)allBigColLastLabelArray {
    if (!_allBigColLastLabelArray) {
        _allBigColLastLabelArray = [NSMutableArray array];
    }
    return _allBigColLastLabelArray;
}


@end

