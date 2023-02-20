//
//  YMOperation.h
//  OCCodeBook
//
//  Created by yuman on 2022/12/17.
//

#import <Foundation/Foundation.h>

@interface YMOperation : NSOperation

// 使用这个代替completionBlock
// 注意无论该Op是否被取消，最终都会调用finishBlock. 记得使用op.isCancelled去判断
// 该回调一定运行在'子'线程
@property (nonatomic, copy) void (^finishBlock)(NSString *value);

@end
