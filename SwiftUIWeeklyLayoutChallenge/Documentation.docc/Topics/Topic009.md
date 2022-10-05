# お題 009

アプリ一覧 - その2

- <doc:Topic008> のように、App アイコン、App の名前、サブタイトル、唯一タップ可能な「入手」ボタン、水平線を配置してください
- 各 App の情報は垂直方向に3つずつ表示し、それ以降は水平方向のスクロールで表示します
- iOS 15.0+ の iPhone のみを考慮します
- （App の動作イメージ）[https://twitter.com/treastrain/status/1577672247195541535](https://twitter.com/treastrain/status/1577672247195541535)

|動作プレビュー1|動作プレビュー2|動作プレビュー3|動作プレビュー4|
|:-:|:-:|:-:|:-:|
|![](Topic009_iPhone14Pro_1)|![](Topic009_iPhone14Pro_2)|![](Topic009_iPhone14Pro_3)|![](Topic009_iPhone14Pro_4)|

## コード提供
```swift
import SwiftUI

/// <doc:Topic009>
public struct Topic009View: View {
    public init() {}
    
    public var body: some View {
        #if os(iOS)
        if #available(iOS 15.0, *) {
            NavigationView {
                NavigationContentView()
            }
        } else {
            Text("Support for this platform is not considered.")
        }
        #else
        Text("Support for this platform is not considered.")
        #endif
    }
}

#if os(iOS)
fileprivate struct AppInfo: Identifiable, Equatable {
    let id = UUID()
    let color: Color
    let name: String
    let subtitle: String
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
}

@available(iOS 15.0, *)
fileprivate struct NavigationContentView: View {
    private let appInfo: [AppInfo] = [
        .init(color: .orange, name: "App Name 1", subtitle: "Subtitle 1"),
        .init(color: .yellow, name: "アプリ名 2", subtitle: "サブタイトル 2"),
        .init(color: .green, name: "Long App Name 3 - Long App Name 3", subtitle: "Subtitle 3"),
        .init(color: .mint, name: "長い長いアプリ名 4 - 長い長いアプリ名 4 - 長い長いアプリ名 4", subtitle: "サブタイトル 4"),
        .init(color: .teal, name: "Long App Name 5 - Long App Name 5", subtitle: "Long Subtitle 5 - Long Subtitle 5"),
        .init(color: .cyan, name: "長い長いアプリ名 6 - 長い長いアプリ名 6 - 長い長いアプリ名 6", subtitle: "長い長いサブタイトル 6 - 長い長いサブタイトル 6"),
        .init(color: .blue, name: "App Name 7", subtitle: "Subtitle 7"),
        .init(color: .indigo, name: "アプリ名 8", subtitle: "サブタイトル 8"),
        .init(color: .purple, name: "App Name 9", subtitle: "Subtitle 9"),
    ]
    
    var body: some View {
        Text("Code your layout here!")
    }
}

@available(iOS 15.0, *)
/// <doc:Topic008> より
fileprivate struct AppView: View {
    static let horizontalSpacing: CGFloat = 8
    static let appIconSize: CGFloat = 64
    
    let info: AppInfo
    
    var body: some View {
        HStack(spacing: Self.horizontalSpacing) {
            Image(systemName: "app.fill")
                .resizable()
                .foregroundColor(info.color)
                .frame(width: Self.appIconSize, height: Self.appIconSize)
            VStack(alignment: .leading, spacing: 5) {
                Text(info.name)
                    .lineLimit(2)
                Text(info.subtitle)
                    .lineLimit(1)
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            Button {
                print(#function)
            } label: {
                Text("入手")
                    .font(.headline)
                    .padding(.horizontal, 8)
            }
            .buttonStyle(.bordered)
            .buttonBorderShape(.capsule)
        }
        .frame(maxWidth: .infinity)
    }
}
#endif
```

## お題作成者
treastrain ([@treastrain](https://twitter.com/treastrain))
