//
//  HXQMarqueeModel.m
//  hxquan
//
//  Created by Tiny on 2018/3/15.
//  Copyright © 2018年 Tiny. All rights reserved.
//

#import "HXQMarqueeModel.h"

@implementation HXQMarqueeModel

-(void)setTitle:(NSString *)title{
    
    //拿到icon 计算宽度
    self.width = 103;
}

-(BOOL)isEqual:(id)object{
    if (self == object) {
        return YES;
    }
    if ([object isKindOfClass:[self class]]) {
        HXQMarqueeModel *obj = (HXQMarqueeModel *)object;
        
        return self.width == obj.width &&
        [self.userImg isEqualToString:obj.userImg];
    }else{
        return NO;
    }
}

-(instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end
