//
//  YMObject+AssociatedObject.h
//  OCCodeBook
//
//  Created by yuman on 2022/12/17.
//

#import "YMObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface YMObject (AssociatedObject)

@property (nonatomic, strong, nullable) NSString *name;

@property (nonatomic, assign) NSInteger age;

@property (nonatomic, copy, nullable) void(^finishBlock)(BOOL isCancel, NSString * _Nullable value);

@end

NS_ASSUME_NONNULL_END
