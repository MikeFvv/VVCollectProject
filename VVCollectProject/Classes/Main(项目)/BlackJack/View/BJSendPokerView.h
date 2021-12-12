//
//  BJSendPokerView.h
//  VVCollectProject
//
//  Created by Admin on 2021/12/11.
//  Copyright © 2021 Mike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayCardModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BJSendPokerView : UIView
/// 玩家名称
@property (nonatomic,strong) UILabel *nameLabel;
/// 点数 or Other 字符显示
@property (nonatomic,strong) UILabel *totalPointsLabel;
/// 总点数
@property (nonatomic,assign) NSInteger totalPoints;
//@property (nonatomic,assign) NSInteger emptyDataIndex;
//
@property (nonatomic,strong) NSMutableArray<PlayCardModel *> *resultDataArray;

@end

NS_ASSUME_NONNULL_END
