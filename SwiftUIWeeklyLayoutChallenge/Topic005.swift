//
//  Topic005.swift
//  SwiftUIWeeklyLayoutChallenge
//
//  Created by treastrain on 2022/08/10.
//

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
        ScrollView {
            GroupBox {
                Group {
                    GroupBox("001") {
                        BulletListRow { Text("Stacksと") + Text("layoutPriority(_:)").font(.code) + Text("を使ってみる") }
                    }
                    GroupBox("002") {
                        BulletListRow { Text("NavigationLink").font(.code) + Text("を使ってみる") }
                        BulletListRow { Text("List").font(.code) + Text("を使ってみる") }
                    }
                    GroupBox("003") {
                        BulletListRow { Text("Form").font(.code) + Text("を使ってみる") }
                        BulletListRow { Text("Picker").font(.code) + Text("と") + Text("pickerStyle(_:)").font(.code) + Text("を使ってみる") }
                        BulletListRow { Text("fixedSize(horizontal:vertical:)").font(.code) + Text("を使ってみる") }
                    }
                    GroupBox("004") {
                        BulletListRow { Text("PrimitiveButtonStyle").font(.code) + Text("を使ってみる") }
                    }
                }
            } label: {
                VStack {
                    Text("#SwiftUIレイアウト一本勝負")
                        .font(.system(.largeTitle, design: .monospaced))
                        .fontWeight(.black)
                        .lineLimit(1)
                        .minimumScaleFactor(0.1)
                        .foregroundStyle(
                            .linearGradient(
                                colors: [.purple, .red, .orange, .green, .blue, .indigo, .purple],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                    Text("主なテーマ")
                }
            }
            .padding()
        }
    }
}
#endif

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
fileprivate struct BulletListRow<Content>: View where Content : View {
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    @ViewBuilder
    private let content: () -> Content
    
    var body: some View {
        Label {
            content()
                .frame(maxWidth: .infinity, alignment: .leading)
        } icon: {
            Text("•")
        }
    }
}

extension Font {
    @available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
    fileprivate static let code: Font = .body.monospaced()
}

struct Topic005View_Previews: PreviewProvider {
    static var previews: some View {
        Topic005View()
    }
}
