//
//  BaccaratChipsView.m
//  VVCollectProject
//
//  Created by Admin on 2021/12/19.
//  Copyright © 2021 Mike. All rights reserved.
//

#import "ChipsView.h"
#import "ChipsCollectionViewCell.h"
#import "UIView+Extension.h"




static NSString *const kCellBaccaratCollectionViewId = @"ChipsCollectionViewCell";

// 需要实现三个协议 UICollectionViewDelegateFlowLayout 继承自 UICollectionViewDelegate
@interface ChipsView ()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) UICollectionView *collectionView;
//


@end

@implementation ChipsView



- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initData];
        [self createUI];
        [self initSubviews];
        
    }
    return self;
}


- (void)showView:(UIView *)view {
    [UIView transitionWithView:view
                      duration:0.4
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                         self.hidden = NO;
                    }
                    completion:NULL];
}


- (void)onCancelBtn:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(cancelBetChipsBtnClick)]) {
        [self.delegate cancelBetChipsBtnClick];
    }
}

- (void)onSureButton:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(sureBetBtnClick)]) {
        [self.delegate sureBetBtnClick];
    }
}

- (void)createUI {
    
    self.backgroundColor = [UIColor redColor];
    
    // 。还有越过本局
    
    UIButton *cancelBtn = [[UIButton alloc] init];
    [cancelBtn setTitle:@"取消注码" forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    cancelBtn.backgroundColor = [UIColor colorWithHex:@"259225" alpha:0.7];
    cancelBtn.layer.cornerRadius = 5;
    cancelBtn.layer.borderWidth = 2;
    cancelBtn.layer.borderColor = [UIColor greenColor].CGColor;
    [cancelBtn addTarget:self action:@selector(onCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancelBtn];
    
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).offset(10);
        make.size.mas_equalTo(CGSizeMake(100, 45));
    }];
    
    
    UIButton *sureButton = [[UIButton alloc] init];
    [sureButton setTitle:@"确定下注" forState:UIControlStateNormal];
    sureButton.titleLabel.font = [UIFont systemFontOfSize:20];
    [sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sureButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    sureButton.backgroundColor = [UIColor colorWithHex:@"259225" alpha:0.7];
    sureButton.layer.cornerRadius = 5;
    sureButton.layer.borderWidth = 2;
    sureButton.layer.borderColor = [UIColor greenColor].CGColor;
    [sureButton addTarget:self action:@selector(onSureButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:sureButton];
    
    [sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-10);
        make.size.mas_equalTo(CGSizeMake(100, 45));
    }];
    
    
    
}


- (void)setDelegate:(id<ChipsViewDelegate>)delegate {
    _delegate = delegate;
    
    // 设置默认选中第一个
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.collectionView selectItemAtIndexPath:indexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
    [self collectionView:self.collectionView didSelectItemAtIndexPath:indexPath];
}

- (NSArray *)dataArray {
    if (!_dataArray) {
        
        //        @{@"money": @(100), @"moneyStr": @"100", @"normal_chipsImg": @"game_bet_normal", @"selected_chipsImg": @"game_bet_selected"},
        //        @{@"money": @(500), @"moneyStr": @"500", @"normal_chipsImg": @"game_bet_normal", @"selected_chipsImg": @"game_bet_selected"},
        
        NSArray *tempArray = @[
            @{@"money": @(1000), @"moneyStr": @"1000", @"normal_chipsImg": @"game_bet_normal", @"selected_chipsImg": @"game_bet_selected"},
            @{@"money": @(5000), @"moneyStr": @"5000", @"normal_chipsImg": @"game_bet_normal", @"selected_chipsImg": @"game_bet_selected"},
            @{@"money": @(10000), @"moneyStr": @"1万", @"normal_chipsImg": @"game_bet_normal", @"selected_chipsImg": @"game_bet_selected"},
            @{@"money": @(50000), @"moneyStr": @"5万", @"normal_chipsImg": @"game_bet_normal", @"selected_chipsImg": @"game_bet_selected"},
            @{@"money": @(100000), @"moneyStr": @"10万", @"normal_chipsImg": @"game_bet_normal", @"selected_chipsImg": @"game_bet_selected"},
            @{@"money": @(500000), @"moneyStr": @"50万", @"normal_chipsImg": @"game_bet_normal", @"selected_chipsImg": @"game_bet_selected"},
            @{@"money": @(1000000), @"moneyStr": @"100万", @"normal_chipsImg": @"game_bet_normal", @"selected_chipsImg": @"game_bet_selected"},
        ];
        
        _dataArray = [ChipsModel mj_objectArrayWithKeyValuesArray:tempArray];
        
    }
    return _dataArray;
}

- (void)initData {
    
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
    layout.itemSize = CGSizeMake(50, 50);
    
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
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(100+10*2, 0, self.frame.size.width-100*2-10*4, height) collectionViewLayout:layout];
    
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
    
    _collectionView.allowsMultipleSelection = NO;
    /**
     四./注册cell
     在重用池中没有新的cell就注册一个新的cell
     相当于懒加载新的cell
     定义重用标识符(在页面最上定义全局)
     用自定义的cell类,防止内容重叠
     注册时填写的重用标识符 是给整个类添加的 所以类里有的所有属性都有重用标识符
     */
    [_collectionView registerClass:[ChipsCollectionViewCell class] forCellWithReuseIdentifier:kCellBaccaratCollectionViewId];
    
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
    return self.dataArray.count;
}

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ChipsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellBaccaratCollectionViewId forIndexPath:indexPath];
    ChipsModel *model = (ChipsModel *)self.dataArray[indexPath.row];
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
    if ([self.delegate respondsToSelector:@selector(chipsSelectedModel:)]) {
        [self.delegate chipsSelectedModel:self.dataArray[indexPath.row]];
    }
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

@end

