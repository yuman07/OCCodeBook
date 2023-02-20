//
//  YMOperation.m
//  OCCodeBook
//
//  Created by yuman on 2022/12/17.
//

#import "YMOperation.h"

@interface YMOperation()

@property (nonatomic, strong) NSString *result;

@end

@implementation YMOperation

@synthesize executing = _executing;
@synthesize finished = _finished;
@synthesize cancelled = _cancelled;

#pragma mark --- base methods

- (void)start
{
    [self setupFinishBlock];
    
    if (self.isCancelled) {
        [self complete];
        return;
    }
    
    @synchronized(self) {
        self.finished = NO;
        self.executing = YES;
    }
    
    [self executeOperation];
}

- (BOOL)isExecuting
{
    @synchronized(self) {
        return _executing;
    }
}

- (BOOL)isFinished
{
    @synchronized(self) {
        return _finished;
    }
}

- (BOOL)isCancelled
{
    @synchronized(self) {
        return _cancelled;
    }
}

- (void)setExecuting:(BOOL)executing
{
    [self willChangeValueForKey:@"isExecuting"];
    @synchronized(self) { _executing = executing; }
    [self didChangeValueForKey:@"isExecuting"];
}

- (void)setFinished:(BOOL)finished
{
    [self willChangeValueForKey:@"isFinished"];
    @synchronized(self) { _finished = finished; }
    [self didChangeValueForKey:@"isFinished"];
}

- (void)cancel
{
    @synchronized(self) { _cancelled = YES; }
}

- (BOOL)isAsynchronous
{
    return YES;
}

- (void)complete
{
    @synchronized(self) {
        if (!self.isFinished) {
            self.executing = NO;
            self.finished = YES;
        }
    }
}

#pragma mark --- custom methods

- (void)setupFinishBlock
{
    __weak __typeof__(self) weakSelf = self;
    self.completionBlock = ^{
        __strong __typeof__(self) self = weakSelf;
        if (self.finishBlock) {
            self.finishBlock(self.result);
        }
    };
}

- (void)executeOperation
{
    // 执行一个异步任务
    __weak __typeof__(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        __strong __typeof__(self) self = weakSelf;
        if (!self || self.isCancelled) { return [self complete]; }
        self.result = @"returnResult";
        [self complete];
    });
}

@end
