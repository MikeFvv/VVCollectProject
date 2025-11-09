

#import "PokerCardModel.h"

@implementation PokerCardModel

MJCodingImplementation


- (instancetype)modelCopy {
    id newObj = [[[self class] alloc] init];
    unsigned int count = 0;
    objc_property_t *props = class_copyPropertyList([self class], &count);
    for (unsigned int i = 0; i < count; i++) {
        const char *propName = property_getName(props[i]);
        if (!propName) continue;
        NSString *key = [NSString stringWithUTF8String:propName];
        @try {
            id value = [self valueForKey:key];
            if (!value || value == [NSNull null]) continue;
            if ([value respondsToSelector:@selector(copy)]) {
                id copyValue = [value copy];
                [newObj setValue:copyValue forKey:key];
            } else {
                [newObj setValue:value forKey:key];
            }
        } @catch (NSException *exception) {
            // ignore
        }
    }
    free(props);
    return newObj;
}

@end
