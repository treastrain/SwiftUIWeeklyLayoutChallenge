# お題 004

角の丸い2つのボタン

- 2から100までの数字をランダムに表示してください
- その数字が素数か合成数かを、ユーザーがボタンで回答できるようにします
- ボタンをタップしたときの挙動などの明示はありません
- iOS 15.0+、macOS 12.0+、tvOS 15.0+、watchOS 8.0+ を前提とします

|iOS|macOS|tvOS|watchOS|
|:-:|:-:|:-:|:-:|
|![](Topic004_iOS)|![](Topic004_macOS)|![](Topic004_tvOS)|![](Topic004_watchOS)|

## コード提供
```swift
import SwiftUI

/// <doc:Topic004>
public struct Topic004View: View {
    public init() {}
    
    public var body: some View {
        if #available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *) {
            content
        } else {
            Text("Support for this platform is not considered.")
        }
    }
    
    @available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
    private var content: some View {
        Text("Code your layout here!")
    }
}
```

## お題作成者
treastrain ([@treastrain](https://twitter.com/treastrain))
