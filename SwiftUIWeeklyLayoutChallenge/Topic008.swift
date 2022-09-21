//
//  Topic008.swift
//  SwiftUIWeeklyLayoutChallenge
//
//  Created by treastrain on 2022/09/21.
//

import SwiftUI

/// <doc:Topic008>
public struct Topic008View: View {
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
        .init(color: .pink, name: "アプリ名 10", subtitle: "Subtitle 10"),
    ]
    
    var body: some View {
        Text("Code your layout here!")
    }
}
#endif

struct Topic008View_Previews: PreviewProvider {
    static var previews: some View {
        Topic008View()
    }
}

