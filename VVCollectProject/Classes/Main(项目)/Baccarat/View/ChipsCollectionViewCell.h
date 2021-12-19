//
//  ChipsCollectionViewCell.h
//  VVCollectProject
//
//  Created by Admin on 2021/12/19.
//  Copyright © 2021 Mike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChipsModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface ChipsCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) ChipsModel *model;
@end

NS_ASSUME_NONNULL_END
