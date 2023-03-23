//
//  YMObject.h
//  OCCodeBook
//
//  Created by yuman on 2022/12/17.
//

#import <Foundation/Foundation.h>

#define TSWeakify(var) \
    __weak typeof(var) TSWeak_##var = var;

#define TSStrongify(var) \
    _Pragma("clang diagnostic push") \
    _Pragma("clang diagnostic ignored \"-Wshadow\"") \
    __strong typeof(var) var = TSWeak_##var; \
    _Pragma("clang diagnostic pop")

#define TSStrongifyAndReturnValueIfNil(var, ret) \
    TSStrongify(var) \
    if (!var) { return ret; }

#define TSStrongifyAndReturnIfNil(var) \
    TSStrongifyAndReturnValueIfNil(var, )

#define RUN_BLOCK(block, ...) \
    do{ __typeof__(block) __a__ = (block); if (__a__) {__a__(__VA_ARGS__);} }while(0)

// 定义枚举：
typedef NS_ENUM(NSInteger, YMViewAnimationTransition) {
    YMViewAnimationTransitionNone,
    YMViewAnimationTransitionFlipFromLeft
};

typedef NS_OPTIONS(NSUInteger, YMViewAutoresizing) {
    YMViewAutoresizingNone                 = 0,
    YMViewAutoresizingFlexibleLeftMargin   = 1 << 0,
    YMViewAutoresizingFlexibleWidth        = 1 << 1,
    YMViewAutoresizingFlexibleRightMargin  = 1 << 2
};

// block别名：
typedef void(^YMPersonCompletionBlock)(void);

NS_ASSUME_NONNULL_BEGIN

// m定义，h暴露：
FOUNDATION_EXPORT NSString * const YMObjectXXXString;

FOUNDATION_EXPORT CGFloat const YMObjectXXXHeight;

@interface YMObject : NSObject

// 单例
+ (instancetype)sharedInstance;

// block参数：
- (void)requestWithCallback:(void (^)(BOOL success, NSString *value))callback;

// 类变量
@property (class, nonatomic, strong) NSString *name;

// block属性：
@property (nonatomic, copy) void(^finBlock)(BOOL isCancel, NSString *value);

@end

NS_ASSUME_NONNULL_END
