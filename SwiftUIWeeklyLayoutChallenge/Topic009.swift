//
//  Topic009.swift
//  SwiftUIWeeklyLayoutChallenge
//
//  Created by treastrain on 2022/10/05.
//

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
/// <doc:Topic008> より
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
        ScrollView {
            VStack {
                Divider()
                    .padding(.horizontal)
                GeometryReader { geometryProxy in
                    TabView {
                        ForEach(Array(stride(from: 0, to: appInfo.count, by: 3)), id: \.self) { index in
                            VStack {
                                AppView(info: appInfo[index])
                                if index + 1 < appInfo.count {
                                    Divider()
                                    AppView(info: appInfo[index + 1])
                                }
                                if index + 2 < appInfo.count {
                                    Divider()
                                    AppView(info: appInfo[index + 2])
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    .frame(width: geometryProxy.size.width, alignment: .center)
                    .tabViewStyle(.page(indexDisplayMode: .never))
                }
                .frame(height: 230)
            }
        }
        .navigationTitle("App")
    }
}

@available(iOS 15.0, *)
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

struct Topic009View_Previews: PreviewProvider {
    static var previews: some View {
        Topic009View()
    }
}
