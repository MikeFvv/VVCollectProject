//
//  BPockerPBView.m
//  VVCollectProject
//
//  Created by Admin on 2022/1/2.
//  Copyright © 2022 Mike. All rights reserved.
//

#import "BPockerPBView.h"
#import "BJSendPokerCollectionViewCell.h"
#import "UIView+Extension.h"
#import "BaccaratResultModel.h"


static NSString *const kBJSendPokerCollectionViewCellId = @"BJSendPokerCollectionViewCell";

// 需要实现三个协议 UICollectionViewDelegateFlowLayout 继承自 UICollectionViewDelegate
@interface BPockerPBView ()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) UICollectionView *collectionView;


@end

@implementation BPockerPBView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}


- (void)setSendCardDataArray:(NSArray<PokerCardModel *> *)sendCardDataArray {
    _sendCardDataArray = sendCardDataArray;
    
    [self.collectionView reloadData];
}


#pragma mark -- UICollectionViewDataSource 数据源

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
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
    PokerCardModel *model = (PokerCardModel *)self.sendCardDataArray[indexPath.row];
    cell.model = model;
    
    return cell;
}

#pragma mark --UICollectionViewDelegateFlowLayout  视图布局

#pragma mark - 首先创建一个collectionView
- (UICollectionView *)collectionView {
    
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        
        // 设置每个item的大小
        layout.itemSize = CGSizeMake(20, 30);
        
        // 设置列间距
        layout.minimumInteritemSpacing = 1;
        
        // 设置行间距
        layout.minimumLineSpacing = 0;
        
        //每个分区的四边间距UIEdgeInsetsMake
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        // 设置布局方向(滚动方向)
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:layout];
        
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
        
        [_collectionView registerClass:[BJSendPokerCollectionViewCell class] forCellWithReuseIdentifier:kBJSendPokerCollectionViewCellId];
        
    }
    return _collectionView;
}
- (void)createUI {
    self.backgroundColor = [UIColor clearColor];
    
//    UILabel *titleLabel = [[UILabel alloc] init];
//    titleLabel.text = @"--";
//    titleLabel.font = [UIFont boldSystemFontOfSize:20];
//    titleLabel.textColor = [UIColor whiteColor];
//    titleLabel.textAlignment = NSTextAlignmentCenter;
//    [self addSubview:titleLabel];
//    _nameLabel = titleLabel;
//
//    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(titleLabel.mas_bottom).offset(5);
//        make.left.equalTo(self.mas_left);
//        make.right.equalTo(self.mas_right);
//        make.height.mas_equalTo(20);
//    }];
//
//    UILabel *pTotalLabel = [[UILabel alloc] init];
//    pTotalLabel.text = @"--";
//    pTotalLabel.font = [UIFont boldSystemFontOfSize:20];
//    pTotalLabel.textColor = [UIColor whiteColor];
//    pTotalLabel.textAlignment = NSTextAlignmentCenter;
//    [self addSubview:pTotalLabel];
//    _totalPointsLabel = pTotalLabel;
//
//    [pTotalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(self.mas_bottom);
//        make.left.equalTo(self.mas_left);
//        make.right.equalTo(self.mas_right);
//        make.height.mas_equalTo(20);
//    }];
    
    
    [self addSubview:self.collectionView];
}
@end


