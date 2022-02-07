//
//  BAtuoRunModel.h
//  VVCollectProject
//
//  Created by Admin on 2022/2/6.
//  Copyright © 2022 Mike. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BAutoRunModel : NSObject
/// 充值
@property (nonatomic, copy) NSString *title;
/// 运行次数
@property (nonatomic, assign) NSInteger runsNum;

@end

NS_ASSUME_NONNULL_END
