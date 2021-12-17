//
//  BJSendPokerView.m
//  VVCollectProject
//
//  Created by Admin on 2021/12/11.
//  Copyright © 2021 Mike. All rights reserved.
//

#import "BJSendPokerView.h"
#import "BJSendPokerCollectionViewCell.h"
#import "UIView+Extension.h"
#import "BaccaratResultModel.h"


static NSString *const kBJSendPokerCollectionViewCellId = @"BJSendPokerCollectionViewCell";

// 需要实现三个协议 UICollectionViewDelegateFlowLayout 继承自 UICollectionViewDelegate
@interface BJSendPokerView ()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) UICollectionView *collectionView;


@end

@implementation BJSendPokerView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)setSendCardDataArray:(NSMutableArray<PokerCardModel *> *)sendCardDataArray {
    _sendCardDataArray = sendCardDataArray;
    
    [self.collectionView reloadData];
    
    // 计算点数
    [self calculateNumberPoints];
}


/// 计算点数
- (void)calculateNumberPoints {
    NSInteger totalPoints = 0;
    NSInteger totalAlterValue = 0;
    BOOL isfirstA = NO;
    for (PokerCardModel *model in self.sendCardDataArray) {
        BOOL isCurrent = YES;
        if (model.alterValue == 11 && !isfirstA) {
            isfirstA = YES;
            isCurrent = NO;
            totalAlterValue = totalPoints + model.alterValue;
        }
        totalPoints = totalPoints + model.cardValue;
        
        if (isfirstA && isCurrent) {
            totalAlterValue = totalAlterValue + model.cardValue;
        }
    }
    
    if (totalPoints > 21) {
        self.totalPointsLabel.text = @"Bust!";
        self.totalPointsLabel.backgroundColor = [UIColor redColor];
    } else {
        NSString *str = nil;
        if (totalAlterValue > 0 && totalAlterValue <= 21) {
            str = [NSString stringWithFormat:@"%ld or %ld", totalPoints,totalAlterValue];;
        } else {
            str = [NSString stringWithFormat:@"%ld", totalPoints];;
        }
        self.totalPointsLabel.text = str;
        self.totalPointsLabel.backgroundColor = [UIColor clearColor];
    }
}



#pragma mark -- UICollectionViewDataSource 数据源

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    //    return 10;
    if (self.sendCardDataArray.count > 2) {
        return self.sendCardDataArray.count + 1;
    }
    return self.sendCardDataArray.count;
}

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BJSendPokerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kBJSendPokerCollectionViewCellId forIndexPath:indexPath];
    
    if (indexPath.row == 2) {
        [cell clearDataContent];
        return cell;
    }
    NSInteger index = indexPath.row > 2 ? indexPath.row-1 : indexPath.row;
    PokerCardModel *model = (PokerCardModel *)self.sendCardDataArray[index];
    cell.model = model;
    
    return cell;
}

#pragma mark --UICollectionViewDelegateFlowLayout  视图布局

//定义每个UICollectionView 的 margin
//-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    return UIEdgeInsetsMake(1, 1, 1, 1);
//}

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






#pragma mark -  懒加载
//- (NSMutableArray *)dalusendCardDataArray{
//    if (!_dalusendCardDataArray) {
//        _dalusendCardDataArray = [NSMutableArray array];
//    }
//    return _dalusendCardDataArray;
//}



#pragma mark - 首先创建一个collectionView
- (UICollectionView *)collectionView {
    
    if (!_collectionView) {
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
        
    //    CGFloat itemWidth = ([UIScreen mainScreen].bounds.size.width - 10*2 - 10*2) / (90/6+1);
        
       CGFloat spacingWidth = (self.frame.size.width - 40 *3) / 4 -0.1;
        // 设置每个item的大小
        layout.itemSize = CGSizeMake(40, 50);
        
        // 设置列间距
        layout.minimumInteritemSpacing = spacingWidth;
        
        // 设置行间距
        layout.minimumLineSpacing = 5;
        
        //每个分区的四边间距UIEdgeInsetsMake
        layout.sectionInset = UIEdgeInsetsMake(0, spacingWidth, 0, spacingWidth);
        
        // 设置布局方向(滚动方向)
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        //
        // 设置分区的头视图和尾视图是否始终固定在屏幕上边和下边
        //        layout.sectionFootersPinToVisibleBounds = YES;
        //        layout.sectionHeadersPinToVisibleBounds = YES;
        
        /**
         初始化mainCollectionView
         设置collectionView的位置
         */
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 20, self.frame.size.width, self.frame.size.height-20-20) collectionViewLayout:layout];
        
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
        [_collectionView registerClass:[BJSendPokerCollectionViewCell class] forCellWithReuseIdentifier:kBJSendPokerCollectionViewCellId];
        
    }
    return _collectionView;
}
- (void)createUI {
    self.backgroundColor = [UIColor clearColor];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"--";
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titleLabel];
    _nameLabel = titleLabel;
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).offset(5);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(20);
    }];
    
//    titleLabel.backgroundColor = [UIColor redColor];
    
    
    
    UILabel *pTotalLabel = [[UILabel alloc] init];
    pTotalLabel.text = @"--";
    pTotalLabel.font = [UIFont boldSystemFontOfSize:20];
    pTotalLabel.textColor = [UIColor whiteColor];
    pTotalLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:pTotalLabel];
    _totalPointsLabel = pTotalLabel;
    
    [pTotalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(20);
    }];
    
    
    [self addSubview:self.collectionView];
//    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(titleLabel.mas_bottom);
//        make.left.equalTo(self.mas_left);
//        make.right.equalTo(self.mas_right);
//        make.bottom.equalTo(pTotalLabel.mas_top);
//    }];
}
@end

