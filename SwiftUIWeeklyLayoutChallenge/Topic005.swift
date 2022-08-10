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
        Text("Code your layout here!")
    }
}
#endif

struct Topic005View_Previews: PreviewProvider {
    static var previews: some View {
        Topic005View()
    }
}
