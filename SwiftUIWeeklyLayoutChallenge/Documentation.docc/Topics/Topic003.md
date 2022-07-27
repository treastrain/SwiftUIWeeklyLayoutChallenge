# お題 003

出発信号機

- Picker を用いて色を選択可能にしてください
- 色のパターンが一致した場合、指差喚呼用の文字を表示してください
- iOS 14.0+、macOS 11.0+、tvOS 14.0+、watchOS 7.0+ を前提とします
- コードの一部提供があります（利用は必須ではありません）
- [Bonus] 指差喚呼用の文字（出発進行 など）の部分をタップして選択肢を表示させて、そこでも色を変えられるようにしてください
- （iOS App の動作イメージ）[https://twitter.com/treastrain/status/1552168376113729536](https://twitter.com/treastrain/status/1552168376113729536)

|iOS|macOS|tvOS|watchOS|
|:-:|:-:|:-:|:-:|
|![](Topic003_iOS)|![](Topic003_macOS)|![](Topic003_tvOS)|![](Topic003_watchOS)|

## コード提供
```swift
import SwiftUI

/// <doc:Topic003>
public struct Topic003View: View {
    public init() {}
    
    public var body: some View {
        if #available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *) {
            #if os(macOS)
            DepartureSignal()
                .padding()
            #else
            if #available(watchOS 7.0, *) {
                NavigationView {
                    DepartureSignal()
                }
            } else {
                DepartureSignal()
            }
            #endif
        } else {
            Text("Support for this platform is not considered.")
        }
    }
}

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
struct DepartureSignal: View {
    enum Signal: String, CaseIterable, Identifiable {
        /// 上の灯火から順に 消・消・緑・消 で進行信号を現示。
        case 出発進行
        /// 上の灯火から順に 黄・消・消・緑 で減速信号を現示。
        case 出発減速
        /// 上の灯火から順に 消・消・消・黄 で注意信号を現示。
        case 出発注意
        /// 上の灯火から順に 黄・消・消・黄 で警戒信号を現示。
        case 出発警戒
        /// 上の灯火から順に 消・赤・消・消 で停止信号を現示。
        case 出発停止
        
        var id: String { rawValue }
    }
    
    var body: some View {
        Text("Code your layout here!")
    }
    
    var light: some View {
        Image(systemName: "circle.fill")
            .font(.largeTitle)
    }
}
```

## お題作成者
treastrain ([@treastrain](https://twitter.com/treastrain))
