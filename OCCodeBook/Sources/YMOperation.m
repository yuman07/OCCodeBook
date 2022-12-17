//
//  YMOperation.m
//  OCCodeBook
//
//  Created by yuman on 2022/12/17.
//

#import "YMOperation.h"

@interface YMOperation ()

@property (nonatomic, assign) BOOL isCancel;
@property (nonatomic, assign, getter=isExecuting) BOOL executing;
@property (nonatomic, assign, getter=isFinished) BOOL finished;

@end

@implementation YMOperation

@synthesize executing = _executing;
@synthesize finished = _finished;

- (void)start
{
    [self setupFinishBlock];
    
    if (self.isCancelled) {
        self.isCancel = YES;
        [self done];
        return;
    }
    
    self.executing = YES;
    [self executeOperation];
}

- (void)executeOperation
{
    // 执行一个异步任务
    dispatch_async(dispatch_get_main_queue(), ^{
        [self done];
    });
}

#pragma mark --- base methods
- (void)setExecuting:(BOOL)executing
{
    [self willChangeValueForKey:@"isExecuting"];
    _executing = executing;
    [self didChangeValueForKey:@"isExecuting"];
}

- (BOOL)isExecuting
{
    return _executing;
}

- (void)setFinished:(BOOL)finished
{
    [self willChangeValueForKey:@"isFinished"];
    _finished = finished;
    [self didChangeValueForKey:@"isFinished"];
}

- (BOOL)isFinished
{
    return _finished;
}

- (BOOL)isAsynchronous
{
    return YES;
}

- (void)done
{
    self.executing = NO;
    self.finished = YES;
}

- (void)setupFinishBlock
{
    if (!self.finishBlock) {
        return;
    }
    __weak __typeof__(self) weakSelf = self;
    self.completionBlock = ^{
        __strong __typeof__(self) self = weakSelf;
        if (self.finishBlock) {
            self.finishBlock(self.isCancel, @"value");
        }
    };
}

@end
