//
//  YMObject.m
//  OCCodeBook
//
//  Created by yuman on 2022/12/17.
//

#import "YMObject.h"

// m定义，不暴露：
static NSString * const kXXXString = @"XXXXXX";
static const CGFloat kXXXHeight = 50.0;

// m定义，h暴露：
NSString * const YMObjectXXXString = @"XXXXXX";
CGFloat const YMObjectXXXHeight = 50.0;

@implementation YMObject

static NSString *_name = nil;

// 单例
+ (instancetype)sharedInstance
{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

+ (NSString *)name
{
    return _name;
}

+ (void)setName:(NSString *)name
{
    _name = name;
}

- (void)requestWithCallback:(void (^)(BOOL, NSString * _Nonnull))callback {}

- (NSInteger)doSomeThingWithName:(NSString *)name age:(NSUInteger)age birthday:(NSDate *)birthday
{
    NSLog(@"%@", @(kXXXHeight));
    NSLog(@"%@", name);
    NSLog(@"%@", @(age));
    NSLog(@"%@", birthday);
    return 123456;
}

@end
