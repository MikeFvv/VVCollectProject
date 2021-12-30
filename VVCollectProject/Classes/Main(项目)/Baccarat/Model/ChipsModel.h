//
//  ChipsModel.h
//  VVCollectProject
//
//  Created by Admin on 2021/12/19.
//  Copyright © 2021 Mike. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChipsModel : NSObject
/// 筹码数值
@property (nonatomic, assign) NSInteger money;
/// 筹码字符
@property (nonatomic, copy) NSString *moneyStr;
/// 正常 筹码图标
@property (nonatomic, copy) NSString *normal_chipsImg; 
/// 选中 筹码图标  game_bet_selected
@property (nonatomic, copy) NSString *selected_chipsImg;



/// 是否选中
@property (nonatomic, assign) BOOL isSelected;

@property (nonatomic, assign) BOOL isGrayed;

@end

NS_ASSUME_NONNULL_END
