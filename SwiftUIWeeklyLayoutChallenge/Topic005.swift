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


    let items: [Item] = {
        [
            Item(number: "001", content: "・Stack と layoutPrio"),
            Item(number: "002", content: "・Stack と layoutPrio"),
            Item(number: "003", content: "・Stack と layoutPrio"),
            Item(number: "004", content: "・Stack と layoutPrio"),
        ]
    }()


    var body: some View {
        ScrollView {
            GroupBox {
                Text("#SwiftUIレイアウト一本勝負")
                    .font(.title2)
                Text("主なテーマ")
                    .bold()

                ForEach(items) { item in
                    GroupBox(content: {
                        Text(item.content)
                    }, label: {
                        Text(item.number)
                    })
                }
            }
        }
    }
}
#endif

struct Item: Identifiable {
    var id: String { number }
    let number: String
    let content: String
}

struct Topic005View_Previews: PreviewProvider {
    static var previews: some View {
        Topic005View()
    }
}
