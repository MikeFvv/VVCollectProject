/************************************************************
  *  * EaseMob CONFIDENTIAL 
  * __________________ 
  * Copyright (C) 2013-2014 EaseMob Technologies. All rights reserved. 
  *  
  * NOTICE: All information contained herein is, and remains 
  * the property of EaseMob Technologies.
  * Dissemination of this information or reproduction of this material 
  * is strictly forbidden unless prior written permission is obtained
  * from EaseMob Technologies.
  */

#import "UIResponder+Router.h"

@implementation UIResponder (Router)

- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo
{
    [[self nextResponder] routerEventWithName:eventName userInfo:userInfo];
}

@end


// 使用方法

//  Cell
//- (void)followButtonClick:(UIButton *)button
//{
//    [self routerEventWithName:@"cancelFollow" userInfo:self.userInfo];
//}
//
//// Controller
//- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo
//{
//    if ([eventName isEqualToString:@"cancelFollow"]) {
//        NSString *userId = userInfo[@"userId"];
//        [self cancelFollowWithUserId:userId];
//        return;
//    }
//    [super routerEventWithName:eventName userInfo:userInfo];
//}
//
//// Controller  另外
//- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo
//{
//    if ([eventName isEqualToString:@"favButtonClick"]) {
//        NSLog(@"favButtonClick  userInfo = %@",userInfo);
//        currentSelectRecommend = [[NSDictionary alloc] initWithDictionary:userInfo];
//        NSString *recommendUser = userInfo[@"recommendUser"];
//        [self followUser:recommendUser];
//    }
//    else if ([eventName isEqualToString:@"commentButtonClick"]){
//        currentSelectRecommend = [[NSDictionary alloc] initWithDictionary:userInfo];
//        NSString *recommendUser = userInfo[@"recommendUser"];
//        [self commentWithUserId:recommendUser];
//        NSLog(@"commentButtonClick userInfo = %@",userInfo);
//    }
//    else{
//        [super routerEventWithName:eventName userInfo:userInfo];
//    }
//}
