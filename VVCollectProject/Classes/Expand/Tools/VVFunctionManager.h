//
//  VVFunctionManager.h
//  VVCollectProject
//
//  Created by 罗耀生 on 2019/3/11.
//  Copyright © 2019 Mike. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface VVFunctionManager : NSObject

#pragma mark - 洗牌方法
+ (NSMutableArray *)shuffleArray:(NSArray *)dataArray pokerPairsNum:(NSInteger)pokerPairsNum;
    
@end


