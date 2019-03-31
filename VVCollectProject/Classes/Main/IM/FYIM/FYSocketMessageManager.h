//
//  FYSocketMessageManager.h
//  VVCollectProject
//
//  Created by Mike on 2019/3/30.
//  Copyright © 2019 Mike. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FYReceiveMessageDelegate.h"


NS_ASSUME_NONNULL_BEGIN

@interface FYSocketMessageManager : NSObject

// 是否连接Socket 
@property (nonatomic,assign) BOOL isConnect;

+ (FYSocketMessageManager *)shareInstance;

// 设置代理
@property (weak, nonatomic)id <FYReceiveMessageDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
