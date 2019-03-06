//
//  BaccaratCollectionView.h
//  VVCollectProject
//
//  Created by Mike on 2019/2/24.
//  Copyright © 2019 Mike. All rights reserved.
//


// https://www.jianshu.com/p/99b364222b9a  单选 多选
// 附上GitHub地址：github.com/Cool-plume-HL/UICollectionView.git

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^HeadClickBlock)(NSInteger index);

@interface BaccaratCollectionView : UIView

@property (nonatomic, copy) HeadClickBlock headClickBlock;

+ (BaccaratCollectionView *)headViewWithModel:(id)model;

@property (nonatomic,strong) id model;

@end

NS_ASSUME_NONNULL_END
