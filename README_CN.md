# OCCodeBook

**OCCodeBook** 是一个 Objective-C 代码手册，以 iOS 工程的形式收录了常用的 Objective-C 编程模式与高级特性示例，方便日常开发时快速查阅。

## 涵盖内容

### 宏定义
- `TSWeakify` / `TSStrongify` — 安全的 weak-strong 引用转换，避免 Block 循环引用
- `RUN_BLOCK` — 安全执行可能为 nil 的 Block

### 枚举与常量
- `NS_ENUM` / `NS_OPTIONS` 的标准定义方式
- `FOUNDATION_EXPORT` 暴露常量 vs `static const` 私有常量

### 单例模式
- 基于 `dispatch_once` 的线程安全单例实现

### Block
- Block 类型别名 (`typedef`)
- Block 作为方法参数与属性

### 类变量 (Class Property)
- `@property (class, ...)` 配合静态变量实现类级别属性

### Associated Object（关联对象）
- 通过 `objc_setAssociatedObject` / `objc_getAssociatedObject` 为 Category 动态添加属性
- 涵盖对象类型 (`NSString`)、基本类型 (`NSInteger`) 和 Block 类型的存取

### KVO（键值观察）
- 使用 context 指针区分自身与父类的监听
- 监听普通属性与可变数组 (`mutableArrayValueForKey:`)
- `dealloc` 中正确移除观察者

### GCD（多线程）
- 串行队列 / 并发队列的创建
- 主队列 / 全局队列的获取

### 字符串与 Emoji 处理
- `rangeOfComposedCharacterSequenceAtIndex:` 安全遍历含 Emoji 的字符串
- `rangeOfComposedCharacterSequencesForRange:` 安全截断，避免 Emoji 被截断

### Runtime — 调用私有方法
- 通过 `NSSelectorFromString` + `methodForSelector:` + 函数指针调用未暴露的方法

## 工程结构

```
OCCodeBook/
├── Sources/
│   ├── YMObject.h/.m                    # 核心示例：单例、宏、枚举、Block、常量、私有方法
│   └── YMObject+AssociatedObject.h/.m   # Category + Associated Object 示例
├── ViewController.h/.m                  # GCD、KVO、Emoji 字符串、调用私有方法
└── Support/                             # AppDelegate、SceneDelegate、Storyboard 等
```

## 环境要求

- Xcode 26.0+
- iOS 26.0+
- 无第三方依赖，纯 Foundation / UIKit

## 使用方式

1. Clone 仓库
   ```bash
   git clone https://github.com/yuman07/OCCodeBook.git
   ```
2. 用 Xcode 打开 `OCCodeBook.xcodeproj`
3. 阅读各源文件中的代码与注释
