# Play With Swift

## [Swift Programming Language](https://github.com/apple/swift)

* 官网：swift.org
* 文档：需要用安装Sphinx（```easy_install -U Sphinx```），安装后，在源码文件夹下```docs``` 执行```make```， 将.rst格式转成.html文件，输出的文档在```docs/_build/html```, 然而并没有像README上说的那样有whitpaper/index.html, 也许是因为文档没有及时更新吧，不过没关系，可以根据自己想看的文档查看对应专题的网页文件。
* 源码： 如果只想要阅读源码而不像修改，可以clone以下代码，
	*  swift语言源码, 可以主要查看stdlib文件夹下的源码： ```git clone https://github.com/apple/swift.git swift```
	*  swift 编译器llvm代码： ```git clone https://github.com/apple/swift-llvm.git llvm```
	*  swift编译c相关编译器源码： ```git clone https://github.com/apple/swift-clang.git clang```
   *  lldb:  ```git clone https://github.com/apple/swift-clang.git clang```
   *  swift包管理工具源码： ```git clone https://github.com/apple/swift-package-manager.git swiftpm```
   *  swift foundation源码，基于OC开源Foudation, NS*.swift源码：```git clone https://github.com/apple/swift-corelibs-foundation.git```
* 想快速上首swift2.2的可以下载[Xcode Swift 2.2 Snapshot](https://swift.org/builds/xcode/swift-2.2-SNAPSHOT-2015-12-01-a/swift-2.2-SNAPSHOT-2015-12-01-a-osx.pkg), 经过安装后，可以在terminal中```alias swift22="/Library/Developer/Toolchains/swift-latest.xctoolchain/usr/bin/swift"```, 不但可以启动REPL，还可以使用swift package manager。 注：只有Xcode 7.2可以使用swift 2.2.
* [swift package manager](https://swift.org/getting-started/#using-the-build-system) 相关示例[代码](https://github.com/apple/example-package-dealer):根据提示只要clone下示例工程，进入文件夹，运行```swift build```即可完成对应依赖工程的下载编译，非常方便，不过目前作者说还只是基础功能，目前还暂不支持iOS,watchOS,tvOS.
* gyb CollectionAlgorithms.swift.gyb > CollectionAlgorithms.swift



## Swift source code directory structure
* /include & /lib: have most of the compiler C++ sources
* /tools/SourceKit
* /stdlib: (mostly written in Swift)
* /stdlib/private: also includes unit test standard library
* /stdlib/public: the standard library (almost)
* /stdlib/public/SDK: look behind the curtain
* /stdlib/public/runtime: where we're going we don't need eyes to see
* /apinotes: rename types, map selectors...
* /docs: don't get too excited
* /unittests: not the unit tests you're looking for
* /test: unit tests, mostly in Swift
* /teset/1_stdlib: helpfully named so it runs first
* /utils: build script, gyb, etc
* /validation-test: test cases, validates shapes of types, conformances, etc

## 记录学习Swift的点滴

* Swift2.playground 学习The Swift Programming Language(Swift 2.0)笔记
* CafeHunter-Stater 是Swift and Cocoa 章节中的Demo
* SwiftReversi Swift vs. Objective-C Demo code
* SHCReversiGame 是SwiftReversi 中的Objective-C 实现
* Swift_Standard_Library.playground 是Apple 提供的Swift标准库的playground
* [The Best of What's New in Swift](https://www.mikeash.com/pyblog/friday-qa-2015-06-19-the-best-of-whats-new-in-swift.html)
* [Advanced NSOperations](https://developer.apple.com/videos/play/wwdc2015-226/)
* AdvancedNSOperations 为WWDC 2015 session 226 Advanced NSOperations 的Sample Code

### Protocol Oriented Programming
* [Protocol-Oriented Programming in Swift](https://developer.apple.com/videos/wwdc/2015/?id=408)
* Crustacean.playground 为WWDC 2015 session 408 Protocol-Oriented Programming in Swift 的Sample Code
* [Protocol Oriented Programming in the Real World](http://matthewpalmer.net/blog/2015/08/30/protocol-oriented-programming-in-the-real-world/)
* [Locksmith](https://github.com/matthewpalmer/Locksmith): A powerful, protocol-oriented library for working with the keychain in Swift.
* [Blurable](https://github.com/FlexMonkey/Blurable): Apply a Gaussian Blur to any UIView with Swift Protocol Extensions
* [mocks in swift via protocols](http://blog.eliperkins.me/mocks-in-swift-via-protocols)

http://www.captechconsulting.com/blogs/ios-9-tutorial-series-protocol-oriented-programming-with-uikit
