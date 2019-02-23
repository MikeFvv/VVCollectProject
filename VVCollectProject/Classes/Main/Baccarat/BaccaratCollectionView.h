//
//  BaccaratCollectionView.h
//  VVCollectProject
//
//  Created by 罗耀生 on 2019/2/24.
//  Copyright © 2019 Mike. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^HeadClick)(NSInteger index);

@interface BaccaratCollectionView : UIView

@property (nonatomic, copy) HeadClick click;

+ (BaccaratCollectionView *)headViewWithModel:(id)model;

@property (nonatomic,strong) id model;

@end

NS_ASSUME_NONNULL_END
