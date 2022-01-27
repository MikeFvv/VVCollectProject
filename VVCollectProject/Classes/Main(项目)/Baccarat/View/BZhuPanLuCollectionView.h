//
//  BaccaratCollectionView.h
//  VVCollectProject
//
//  Created by blom on 2019/2/24.
//  Copyright © 2019 Mike. All rights reserved.
//


// https://www.jianshu.com/p/99b364222b9a  单选 多选
// 附上GitHub地址：github.com/Cool-plume-HL/UICollectionView.git

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^HeadClickBlock)(NSInteger index);

@interface BZhuPanLuCollectionView : UIView

@property (nonatomic, copy) HeadClickBlock headClickBlock;

@property (nonatomic, strong) id model;
// 路类型  0 庄闲路
@property (nonatomic, assign) NSInteger roadType;


@end

NS_ASSUME_NONNULL_END
