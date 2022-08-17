# お題 006

ユーザーが自由に配置できるビュー

- タップするとアラートが表示されるビューを、下後端からそれぞれ16の位置に配置してください
- そのビューは長押しをすることで別な選択肢が表示され、ドラッグで表示位置を変更できます
- iOS 15.0+ を前提とし、描画サイズの変化（端末の回転など）は考慮しません
- （App の動作イメージ）[https://twitter.com/treastrain/status/1559742341636030464](https://twitter.com/treastrain/status/1559742341636030464)

|iPhone 13 mini|iPhone SE (3rd generation)|iPad mini (6th generation)|
|:-:|:-:|:-:|
|![](Topic006_iPhone13mini)|![](Topic006_iPhoneSE3rdGen)|![](Topic006_iPadmini6thGen)|

## コード提供
```swift
import SwiftUI

/// <doc:Topic006>
public struct Topic006View: View {
    public init() {}
    
    public var body: some View {
        #if os(iOS)
        if #available(iOS 15.0, *) {
            Topic006ContentView()
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
fileprivate struct Topic006ContentView: View {
    private let paddingLength: CGFloat = 16
    
    var body: some View {
        Text("Code your layout here!")
    }
}
#endif
```

## お題作成者
treastrain ([@treastrain](https://twitter.com/treastrain))
