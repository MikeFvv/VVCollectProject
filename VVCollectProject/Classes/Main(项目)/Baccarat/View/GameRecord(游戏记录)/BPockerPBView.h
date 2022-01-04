//
//  BPockerPBView.h
//  VVCollectProject
//
//  Created by Admin on 2022/1/2.
//  Copyright © 2022 Mike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PokerCardModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BPockerPBView : UIView
@property (nonatomic, strong) NSArray<PokerCardModel *> *sendCardDataArray;
@end

NS_ASSUME_NONNULL_END
