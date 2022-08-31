//
//  Topic007.swift
//  SwiftUIWeeklyLayoutChallenge
//
//  Created by treastrain on 2022/08/31.
//

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
    var body: some View {
        Text("Code your layout here!")
    }
}
#endif

struct Topic007View_Previews: PreviewProvider {
    static var previews: some View {
        Topic007View()
    }
}
