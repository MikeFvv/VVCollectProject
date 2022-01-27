//
//  BJDetailsController.h
//  VVCollectProject
//
//  Created by blom on 2019/3/11.
//  Copyright © 2019 Mike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BJWinOrLoseResultModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BJDetailsController : UIViewController

@property (strong, nonatomic) NSMutableArray<BJWinOrLoseResultModel *> *dataArray;
@end

NS_ASSUME_NONNULL_END
