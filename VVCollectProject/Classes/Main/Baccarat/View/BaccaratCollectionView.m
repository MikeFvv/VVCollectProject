//
//  BaccaratCollectionView.m
//  VVCollectProject
//
//  Created by Mike on 2019/2/24.
//  Copyright © 2019 Mike. All rights reserved.
//

#import "BaccaratCollectionView.h"
#import "BaccaratCollectionViewCell.h"
#import "UIView+Extension.h"
#import "BaccaratModel.h"


static NSString * const kCellBaccaratCollectionViewId = @"BaccaratCollectionViewCell";

// 需要实现三个协议 UICollectionViewDelegateFlowLayout 继承自 UICollectionViewDelegate
@interface BaccaratCollectionView ()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) UICollectionView *collectionView;
//
@property (nonatomic,strong) NSMutableArray *resultDataArray;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UILabel *lastLbl;
/// 记录长龙个数
@property (nonatomic, assign)int longNum;
/// 记录长龙的最小 X
@property (nonatomic, assign)CGFloat longMinX;
/// 记录"和"前面的一个结果
@property (nonatomic, strong) NSDictionary *preTieDict;
/// 记录最大的 x 值
@property (nonatomic, assign)CGFloat maxXValue;
/// 记录上一个长龙所有 label
@property (nonatomic, strong)NSMutableArray *lastChangLongLblArray;
@property (nonatomic, strong)NSMutableArray *currentChangLongLblArray;

@property (nonatomic, assign)CGFloat twoChangLongPoint;
/// 记录当前长龙最低下第一个 label
@property (nonatomic, strong)UILabel *changLongBottomLbl;
/// 连续和的数量
@property (nonatomic, assign) NSInteger tieNum;

@property (nonatomic, strong) BaccaratModel *lastModel;

/// 记录一条路
@property (nonatomic, strong) NSMutableArray *yiluArray;
/// 记录所有大路路子
@property (nonatomic, strong) NSMutableArray<NSArray *> *daluResultDataArray;

@end

@implementation BaccaratCollectionView



+ (BaccaratCollectionView *)headViewWithModel:(id)model {
    
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
        _scrollView.hidden = YES;
    } else if (roadType == 1) {
        self.collectionView.hidden = YES;
        self.scrollView.hidden = NO;
        [self addSubview:self.scrollView];
    }
}


- (void)setModel:(id)model {
    self.resultDataArray = [NSMutableArray arrayWithArray:(NSArray *)model];
    if (self.roadType == 0) {
        [self.collectionView reloadData];
    } else if (self.roadType == 1) {
//        self.maxXValue = 0;
//        self.longNum = 0;
//        [self creatItems];
        
        
        
        [self newCreatItems];
    } else {
        NSLog(@"1");
    }
}


- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _scrollView.delegate = self;
        _scrollView.backgroundColor = [UIColor yellowColor];
        _scrollView.contentSize = CGSizeMake(1000, 0);
        _maxXValue = 0;
        _longNum = 0;
    }
    return _scrollView;
}


- (void)newCreatItems {
    
        BaccaratModel *model = (BaccaratModel *)self.resultDataArray.lastObject;
        
        if (model.WinType == 0 && self.resultDataArray.count != 1) {
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
            return;
        }
        
        self.tieNum = 0;
        UILabel *label = [[UILabel alloc] init];
        label.layer.masksToBounds = YES;
        label.font = [UIFont boldSystemFontOfSize:14];
        label.textAlignment = NSTextAlignmentCenter;
        
        CGFloat itemWidth = 16;
        label.layer.cornerRadius = itemWidth/2;
        [self.scrollView addSubview:label];
        
    
        BaccaratModel *lastModel;
        if (self.resultDataArray.count >= 2) {
            lastModel = (BaccaratModel *)self.resultDataArray[self.resultDataArray.count-2];
        }
        BaccaratModel *lastTwoModel;
        if (self.resultDataArray.count >= 3) {
            lastTwoModel = (BaccaratModel *)self.resultDataArray[self.resultDataArray.count-3];
        }
        
        if (model.WinType == 1) {
            if (model.isSuperSix) {
                label.text = @"6";
                label.textColor = [UIColor whiteColor];
            }
            label.backgroundColor = [UIColor redColor];
        } else if (model.WinType == 2) {
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
            [self.scrollView addSubview:bankerPairView];
            
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
            [self.scrollView addSubview:playerPairView];
            
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
        if (self.resultDataArray.count == 1) {
            label.frame = CGRectMake(x, y, w, h);
            if (model.WinType != 0) {
                self.longNum = 1;
                [self.yiluArray addObject:model];
            }
        }else{
            
            BOOL continueBool = model.WinType == self.lastModel.WinType ? YES : NO;
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
                    //将长龙底下部分加入到数组
                    [self.currentChangLongLblArray addObject:label];
                    x = CGRectGetMaxX(self.lastLbl.frame) + margin;
                    label.frame = CGRectMake(x, self.lastLbl.y, w, h);
                }
                if (x > self.maxXValue) {
                    self.maxXValue = x;
                }
                [self.yiluArray addObject:model];
            }else{
                [self.daluResultDataArray addObject:self.yiluArray];
                self.yiluArray = nil;
                
                if (self.longNum >= 6) {
                    if (self.lastChangLongLblArray.count != 0) {
                        for (int a = 0; a < self.lastChangLongLblArray.count; a++) {
                            UILabel *lbl = self.lastChangLongLblArray[a];
                            if (lbl.x >= self.changLongBottomLbl.x) {
                                [lbl removeFromSuperview];
                            }
                        }
                    }
                    
                    [self.lastChangLongLblArray removeAllObjects];
                    [self.lastChangLongLblArray addObjectsFromArray:self.currentChangLongLblArray];
                    [self.currentChangLongLblArray removeAllObjects];
                }
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
                [self.yiluArray addObject:model];
            }
            
        }
        
        
        
        
        [UIView animateWithDuration:0.1 animations:^{
            if (self.maxXValue + w + margin > (self.bounds.size.width - 60)){
                if ((self.maxXValue + w + margin) != CGRectGetMinX(self.lastLbl.frame)) {
                    
                    [self.scrollView setContentOffset:CGPointMake(self.maxXValue + w + margin - (kSCREEN_WIDTH - 60), 0) animated:YES];
                }
            } else {
                [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
            }
        }];
        
        
        self.lastLbl = label;
        self.lastModel = model;
        
    
}


- (NSString *)winTypeDict:(BaccaratModel *)model {
    NSString *text;
    if (model.WinType == 1) {
        text = @"B";
    } else if (model.WinType == 2) {
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
    return self.resultDataArray.count;
}

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BaccaratCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellBaccaratCollectionViewId forIndexPath:indexPath];
    BaccaratModel *model = (BaccaratModel *)self.resultDataArray[indexPath.row];
    cell.model = model;
    return cell;
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
    for (UIView *view in self.scrollView.subviews) {
        [view removeFromSuperview];
    }
    
    self.scrollView.contentSize = CGSizeMake(1000, 0);
    for (int i = 0; i < self.resultDataArray.count; i++) {
        BaccaratModel *model = (BaccaratModel *)self.resultDataArray[i];
        
        if (model.WinType == 0 && i != 0) {
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
        [self.scrollView addSubview:label];
        
        
        
        BaccaratModel *lastModel;
        if (i >= 1) {
            lastModel = (BaccaratModel *)self.resultDataArray[i-1];
        }
        BaccaratModel *lastTwoModel;
        if (i >= 2) {
            lastTwoModel = (BaccaratModel *)self.resultDataArray[i-2];
        }
        
        if (model.WinType == 1) {
            if (model.isSuperSix) {
                label.text = @"6";
                label.textColor = [UIColor whiteColor];
            }
            label.backgroundColor = [UIColor redColor];
        } else if (model.WinType == 2) {
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
            [self.scrollView addSubview:bankerPairView];
            
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
            [self.scrollView addSubview:playerPairView];
            
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
            if (model.WinType != 0) {
                self.longNum = 1;
            }
        }else{
            
            BOOL continueBool = model.WinType == self.lastModel.WinType ? YES : NO;
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
                    //将长龙底下部分加入到数组
                    [self.currentChangLongLblArray addObject:label];
                    x = CGRectGetMaxX(self.lastLbl.frame) + margin;
                    label.frame = CGRectMake(x, self.lastLbl.y, w, h);
                }
                if (x > self.maxXValue) {
                    self.maxXValue = x;
                }
            } else {
                if (self.longNum >= 6) {
                    if (self.lastChangLongLblArray.count != 0) {
                        for (int a = 0; a < self.lastChangLongLblArray.count; a++) {
                            UILabel *lbl = self.lastChangLongLblArray[a];
                            if (lbl.x >= self.changLongBottomLbl.x) {
                                [lbl removeFromSuperview];
                            }
                        }
                    }
                    
                    [self.lastChangLongLblArray removeAllObjects];
                    [self.lastChangLongLblArray addObjectsFromArray:self.currentChangLongLblArray];
                    [self.currentChangLongLblArray removeAllObjects];
                }
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
                    
                    [self.scrollView setContentOffset:CGPointMake(self.maxXValue + w + margin - (kSCREEN_WIDTH - 60), 0) animated:YES];
                }
            } else {
                [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
            }
        }];
        
        
        self.lastLbl = label;
        self.lastLbl.tag = i;
        self.lastModel = model;
        
    }
}



- (NSMutableArray *)lastChangLongLblArray{
    if (!_lastChangLongLblArray) {
        _lastChangLongLblArray = [NSMutableArray arrayWithCapacity:2];
    }
    return _lastChangLongLblArray;
}

- (NSMutableArray *)currentChangLongLblArray{
    if (!_currentChangLongLblArray) {
        _currentChangLongLblArray = [NSMutableArray arrayWithCapacity:2];
    }
    return _currentChangLongLblArray;
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
