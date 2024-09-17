//
//  ViewController.m
//  OCCodeBook
//
//  Created by yuman on 2022/11/13.
//

#import "ViewController.h"
#import "YMObject.h"

static void * const kSelfClassKVOContext = (void*)&kSelfClassKVOContext;

@interface ViewController ()

@property (nonatomic, strong) YMObject *obj;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSMutableArray *array;

@property (nonatomic, strong) dispatch_queue_t ymQueue;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.obj = [[YMObject alloc] init];
    self.name = @"ori";
    
    // Do any additional setup after loading the view.
    
}

- (void)useQueue
{
    self.ymQueue = dispatch_queue_create("com.ymQueue.serial", DISPATCH_QUEUE_SERIAL);
    
    self.ymQueue = dispatch_queue_create("com.ymQueue.concurrent", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    NSLog(@"%@ %@", mainQueue, globalQueue);
}

// KVO
- (void)setupKVO
{
    [self addObserver:self forKeyPath:NSStringFromSelector(@selector(name)) options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:kSelfClassKVOContext];
    [self addObserver:self forKeyPath:NSStringFromSelector(@selector(array)) options:NSKeyValueObservingOptionNew context:kSelfClassKVOContext];
    
//    self.name = @"111";
//    self.name = @"222";
//    self.name = @"333";
//    NSMutableArray *KVOArray = [self mutableArrayValueForKey:NSStringFromSelector(@selector(array))];
//    [KVOArray addObject:@1];
}

- (void)dealloc
{
    [self removeObserver:self forKeyPath:NSStringFromSelector(@selector(name)) context:kSelfClassKVOContext];
    [self removeObserver:self forKeyPath:NSStringFromSelector(@selector(array)) context:kSelfClassKVOContext];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if (context != kSelfClassKVOContext) {
        // 如果context不为kSelfClassKVOContext，则说明是父类的监听，转发
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        return;
    }
    
    if (object == self && [keyPath isEqualToString:NSStringFromSelector(@selector(name))]) {
        NSString *oldVal = change[NSKeyValueChangeOldKey];
        NSString *newVal = change[NSKeyValueChangeNewKey];
        NSLog(@"old: %@", oldVal);
        NSLog(@"new: %@", newVal);
    }
    
    if (object == self && [keyPath isEqualToString:NSStringFromSelector(@selector(array))]) {
        NSLog(@"%@", @(self.array.count));
    }
}

- (void)stringEmoji
{
    NSString *string = @"12Y5️⃣你😁👪哈🇨🇳🇺🇸🌹正";
    
    // 遍历string中所有Composed subString
    NSRange range = NSMakeRange(0, 0);
    for (NSUInteger i = 0; i < string.length; i += range.length) {
        range = [string rangeOfComposedCharacterSequenceAtIndex:i];
        NSString *subString = [string substringWithRange:range];
        NSLog(@"%@", subString);
    }
    
    NSLog(@"--------------");
    
    // rangeOfComposedCharacterSequencesForRange一般用于辅助截断String
    // 比如某个文本框限制输入10个字符，但在NSString中，emoji不是1，此时强行用substringToIndex去截会造成emoji被截断
    NSRange oriRange = NSMakeRange(0, 10);
    NSRange realRange = [string rangeOfComposedCharacterSequencesForRange:oriRange];
    NSString *subString = [string substringWithRange:realRange];
    NSLog(@"%@", subString);
}

// 调用一个类的私有方法
// https://github.com/dabing1022/Blog/issues/2
- (void)callPrivateMethod
{
    SEL selector = NSSelectorFromString(@"doSomeThingWithName:age:birthday:");
    if (![self.obj respondsToSelector:selector]) { return; }
    IMP imp = [self.obj methodForSelector:selector];
    NSInteger (*func)(id, SEL, NSString*, NSUInteger, NSDate*) = (void *)imp;
    NSInteger res = func(self.obj, selector, @"yuman", 111, [NSDate date]);
    NSLog(@"callPrivateMethod : %@", @(res));
}

@end
