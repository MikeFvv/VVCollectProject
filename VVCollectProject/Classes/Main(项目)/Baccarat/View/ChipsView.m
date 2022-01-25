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
/// 筹码数据
@property (nonatomic, strong) NSMutableArray<ChipsModel *> *dataArray;

@property (strong, nonatomic) UIButton *sureButton;
@property (strong, nonatomic) UIButton *cancelBtn;

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


- (void)setCurrentBalance:(NSInteger)currentBalance {
    _currentBalance = currentBalance;
    [self.collectionView reloadData];
}

- (void)setIsShowSureButton:(BOOL)isShowSureButton {
    _isShowSureButton = isShowSureButton;
    if (isShowSureButton) {
        self.sureButton.hidden = YES;
    } else {
        self.sureButton.hidden = NO;
    }
}

- (void)setIsShowCancelBtn:(BOOL)isShowCancelBtn {
    _isShowCancelBtn = isShowCancelBtn;
    
    if (isShowCancelBtn) {
        self.sureButton.hidden = NO;
        [self.cancelBtn setTitle:@"取消注码" forState:UIControlStateNormal];
        self.cancelBtn.tag = 6000;
    } else {
//        self.sureButton.hidden = YES;
        [self.cancelBtn setTitle:@"越过本局" forState:UIControlStateNormal];
        self.cancelBtn.tag = 6001;
    }
    
}

- (void)setIsRepeatBetBtn:(BOOL)isRepeatBetBtn {
    _isRepeatBetBtn = isRepeatBetBtn;
    
    if (isRepeatBetBtn) {
        [self.sureButton setTitle:@"重复下注" forState:UIControlStateNormal];
        self.sureButton.tag = 5001;
    } else {
        [self.sureButton setTitle:@"确定下注" forState:UIControlStateNormal];
        self.sureButton.tag = 5000;
    }
}


- (void)setIsAllInBetBtn:(BOOL)isAllInBetBtn {
    _isAllInBetBtn = isAllInBetBtn;
    if (isAllInBetBtn) {
        [self.sureButton setTitle:@"全押" forState:UIControlStateNormal];
        self.sureButton.tag = 5002;
    } else {
        [self.sureButton setTitle:@"确定下注" forState:UIControlStateNormal];
        self.sureButton.tag = 5000;
    }
}

//- (void)setIsAllInBetBtn:(BOOL)isAllInBetBtn {
//    _isAllInBetBtn = isAllInBetBtn;
//    if (isAllInBetBtn) {
//        [self.cancelBtn setTitle:@"越过本局" forState:UIControlStateNormal];
//    } else {
//        [self.cancelBtn setTitle:@"取消注码" forState:UIControlStateNormal];
//    }
//}



- (void)onCancelBtn:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(cancelBetChipsBtnClick:)]) {
        [self.delegate cancelBetChipsBtnClick:sender];
    }
}

- (void)onSureButton:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(sureBetBtnClick:)]) {
        [self.delegate sureBetBtnClick:sender];
    }
}

- (void)createUI {
    
//    self.backgroundColor = [UIColor redColor];
    
    // 。还有越过本局
    
    UIButton *cancelBtn = [[UIButton alloc] init];
    [cancelBtn setTitle:@"越过本局" forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    cancelBtn.backgroundColor = [UIColor colorWithHex:@"259225" alpha:0.7];
    cancelBtn.layer.cornerRadius = 5;
    cancelBtn.layer.borderWidth = 2;
    cancelBtn.layer.borderColor = [UIColor greenColor].CGColor;
    [cancelBtn addTarget:self action:@selector(onCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    cancelBtn.tag = 6001;
//    cancelBtn.hidden = YES;
    [self addSubview:cancelBtn];
    _cancelBtn = cancelBtn;
    
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
    sureButton.tag = 5000;
    sureButton.hidden = YES;
    [self addSubview:sureButton];
    _sureButton = sureButton;
    
    [sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-10);
        make.size.mas_equalTo(CGSizeMake(100, 45));
    }];
    
    
    
}


- (void)setDelegate:(id<ChipsViewDelegate>)delegate {
    _delegate = delegate;
    
    // 设置默认选中第一个
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:2 inSection:0];
    [self.collectionView selectItemAtIndexPath:indexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
    [self collectionView:self.collectionView didSelectItemAtIndexPath:indexPath];
    
//    ChipsModel *model = self.dataArray[2];
//    model.isSelected = YES;
    
}

- (NSArray *)dataArray {
    if (!_dataArray) {
        
        NSArray *tempArray = @[
            @{@"money": @(100), @"moneyStr": @"100", @"normal_chipsImg": @"chip_100", @"selected_chipsImg": @"chip_100"},
            @{@"money": @(500), @"moneyStr": @"500", @"normal_chipsImg": @"chip_500", @"selected_chipsImg": @"chip_500"},
            @{@"money": @(1000), @"moneyStr": @"1000", @"normal_chipsImg": @"chip_1000", @"selected_chipsImg": @"chip_1000"},
            @{@"money": @(5000), @"moneyStr": @"5000", @"normal_chipsImg": @"chip_5000", @"selected_chipsImg": @"chip_5000"},
            @{@"money": @(10000), @"moneyStr": @"1万", @"normal_chipsImg": @"chip_10000", @"selected_chipsImg": @"chip_10000"},
            @{@"money": @(100000), @"moneyStr": @"10万", @"normal_chipsImg": @"game_bet_selected", @"selected_chipsImg": @"game_bet_selected"},
            
//            @{@"money": @(50000), @"moneyStr": @"5万", @"normal_chipsImg": @"game_bet_selected", @"selected_chipsImg": @"game_bet_selected"},
//            @{@"money": @(500000), @"moneyStr": @"50万", @"normal_chipsImg": @"game_bet_selected", @"selected_chipsImg": @"game_bet_selected"},
//            @{@"money": @(1000000), @"moneyStr": @"100万", @"normal_chipsImg": @"game_bet_selected", @"selected_chipsImg": @"game_bet_selected"},
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
    
    // 设置布局方向(滚动方向)
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
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
    if (model.money > self.currentBalance) {
        model.isGrayed = YES;
    } else {
        model.isGrayed = NO;
    }
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
    for (ChipsModel *model in self.dataArray) {
        model.isSelected = NO;
    }
    ChipsModel *model = self.dataArray[indexPath.row];
    model.isSelected = YES;
    if ([self.delegate respondsToSelector:@selector(chipsSelectedModel:)]) {
        [self.delegate chipsSelectedModel:model];
    }
    [self.collectionView reloadData];
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ChipsModel *model = (ChipsModel *)self.dataArray[indexPath.row];
    if (model.money > self.currentBalance) {
        return NO;
    }
    return YES;
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

@end

