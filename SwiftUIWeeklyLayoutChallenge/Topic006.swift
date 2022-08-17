//
//  Topic006.swift
//  SwiftUIWeeklyLayoutChallenge
//
//  Created by treastrain on 2022/08/17.
//

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

struct Topic006View_Previews: PreviewProvider {
    static var previews: some View {
        Topic006View()
    }
}
