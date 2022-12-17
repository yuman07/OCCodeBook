//
//  YMObject+AssociatedObject.m
//  OCCodeBook
//
//  Created by yuman on 2022/12/17.
//

#import "YMObject+AssociatedObject.h"
#import <objc/runtime.h>

@implementation YMObject (AssociatedObject)

- (NSString *)name
{
    return objc_getAssociatedObject(self, @selector(name));
}

- (void)setName:(NSString *)name
{
    objc_setAssociatedObject(self, @selector(name), name, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSInteger)age
{
    NSNumber *value = objc_getAssociatedObject(self, @selector(age));
    if (!value) {
        return 0;
    } else {
        return [value integerValue];
    }
}

- (void)setAge:(NSInteger)age
{
    objc_setAssociatedObject(self, @selector(age), @(age), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void (^)(BOOL, NSString * _Nullable))finishBlock
{
    return objc_getAssociatedObject(self, @selector(finishBlock));
}

- (void)setFinishBlock:(void (^)(BOOL, NSString * _Nullable))finishBlock
{
    objc_setAssociatedObject(self, @selector(finishBlock), finishBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
