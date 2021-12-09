//
//  InitState.h
//  VVCollectProject
//
//  Created by Admin on 2021/12/10.
//  Copyright © 2021 Mike. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface InitState : NSObject
/// 玩家ID
@property (nonatomic, copy) NSString *playerID;
/// 玩家剩余筹码
@property (nonatomic, assign) NSInteger jetton;
@end

NS_ASSUME_NONNULL_END
