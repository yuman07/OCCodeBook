# OCCodeBook

[中文文档](README_CN.md)

**OCCodeBook** is an Objective-C code reference book in the form of an iOS project. It collects commonly used Objective-C programming patterns and advanced features for quick lookup during daily development.

## Topics Covered

### Macros
- `TSWeakify` / `TSStrongify` — Safe weak-strong dance to avoid retain cycles in Blocks
- `RUN_BLOCK` — Safely invoke a Block that may be nil

### Enums & Constants
- Standard `NS_ENUM` / `NS_OPTIONS` definitions
- `FOUNDATION_EXPORT` public constants vs `static const` private constants

### Singleton Pattern
- Thread-safe singleton using `dispatch_once`

### Blocks
- Block type aliases (`typedef`)
- Blocks as method parameters and properties

### Class Properties
- `@property (class, ...)` backed by static variables

### Associated Objects
- Dynamically adding properties to Categories via `objc_setAssociatedObject` / `objc_getAssociatedObject`
- Covers object types (`NSString`), primitive types (`NSInteger`), and Block types

### KVO (Key-Value Observing)
- Using context pointers to distinguish self vs superclass observations
- Observing scalar properties and mutable arrays (`mutableArrayValueForKey:`)
- Proper observer removal in `dealloc`

### GCD (Grand Central Dispatch)
- Creating serial / concurrent queues
- Accessing main queue / global queue

### String & Emoji Handling
- `rangeOfComposedCharacterSequenceAtIndex:` for safely iterating strings containing Emoji
- `rangeOfComposedCharacterSequencesForRange:` for safe truncation without splitting Emoji

### Runtime — Invoking Private Methods
- Calling unexposed methods via `NSSelectorFromString` + `methodForSelector:` + function pointers

## Project Structure

```
OCCodeBook/
├── Sources/
│   ├── YMObject.h/.m                    # Core examples: singleton, macros, enums, blocks, constants, private methods
│   └── YMObject+AssociatedObject.h/.m   # Category + Associated Object examples
├── ViewController.h/.m                  # GCD, KVO, Emoji strings, calling private methods
└── Support/                             # AppDelegate, SceneDelegate, Storyboards, etc.
```

## Requirements

- Xcode 26.0+
- iOS 26.0+
- No third-party dependencies — pure Foundation / UIKit

## Getting Started

1. Clone the repository
   ```bash
   git clone https://github.com/yuman07/OCCodeBook.git
   ```
2. Open `OCCodeBook.xcodeproj` in Xcode
3. Browse the source files and comments for examples

## License

This project is licensed under the [MIT License](LICENSE).
