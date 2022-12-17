//
//  YMOperation.h
//  OCCodeBook
//
//  Created by yuman on 2022/12/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YMOperation : NSOperation

// 使用这个代替completionBlock
// isCancel标志该op是否被cancel导致全不执行
// 该回调一定运行在'子'线程
@property (nonatomic, copy) void (^finishBlock)(BOOL isCancel, NSString *value);

@end

NS_ASSUME_NONNULL_END
