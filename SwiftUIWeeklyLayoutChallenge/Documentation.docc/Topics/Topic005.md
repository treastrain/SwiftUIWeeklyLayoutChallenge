# お題 005

グループ構造を示すスタイル

- 表示可能領域が不足する場合に備えてスクロール可能にします
- iOS 15.0+、macOS 12.0+ を前提とします
- [Bonus] 最上部の「#SwiftUIレイアウト一本勝負」の文字色を虹色にしてください

|iOS (Light)|iOS (Dark)|macOS (Light)|macOS (Dark)|
|:-:|:-:|:-:|:-:|
|![](Topic005_iOS-Light)|![](Topic005_iOS-Dark)|![](Topic005_macOS-Light)|![](Topic005_macOS-Dark)|

## コード提供
```swift
import SwiftUI

/// <doc:Topic005>
public struct Topic005View: View {
    public init() {}
    
    public var body: some View {
        #if os(iOS) || os(macOS)
        if #available(iOS 15.0, macOS 12.0, *) {
            Topic005ContentView()
        } else {
            Text("Support for this platform is not considered.")
        }
        #else
        Text("Support for this platform is not considered.")
        #endif
    }
}

#if os(iOS) || os(macOS)
@available(iOS 15.0, macOS 12.0, *)
fileprivate struct Topic005ContentView: View {
    var body: some View {
        Text("Code your layout here!")
    }
}
#endif
```

## お題作成者
treastrain ([@treastrain](https://twitter.com/treastrain))
