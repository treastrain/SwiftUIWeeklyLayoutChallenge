# お題 007

ナンバーパッド

- 数字、\*、# をタップすると、順に画面上部にそれらが表示されます
- 画面下後端のボタンをタップすると、上記の入力内容を1つ削除します
- 画面上部の表示を長押しすると、コピー等のためのメニューを表示します
- iOS 15.0+ の iPhone（Portrait）のみを考慮します

|動作プレビュー1|動作プレビュー2|動作プレビュー3|動作プレビュー4|
|:-:|:-:|:-:|:-:|
|![](Topic007_iPhone13mini_1)|![](Topic007_iPhone13mini_2)|![](Topic007_iPhone13mini_3)|![](Topic007_iPhone13mini_4)|

## コード提供
```swift
import SwiftUI

/// <doc:Topic007>
public struct Topic007View: View {
    public init() {}
    
    public var body: some View {
        #if os(iOS)
        if #available(iOS 15.0, *) {
            Topic007ContentView()
        } else {
            Text("Support for this platform is not considered.")
        }
        #else
        Text("Support for this platform is not considered.")
        #endif
    }
}

#if os(iOS)
@available(iOS 15.0, *)
fileprivate struct Topic007ContentView: View {
    public var body: some View {
        Text("Code your layout here!")
    }
}
#endif
```

## お題作成者
treastrain ([@treastrain](https://twitter.com/treastrain))
