//
//  Topic004.swift
//  SwiftUIWeeklyLayoutChallenge
//
//  Created by treastrain on 2022/08/03.
//

import SwiftUI

/// <doc:Topic004>
public struct Topic004View: View {
    public init() {}
    
    public var body: some View {
        if #available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *) {
            content
        } else {
            Text("Support for this platform is not considered.")
        }
    }
    
    @available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
    private var content: some View {
        Text("Code your layout here!")
    }
}

struct Topic004View_Previews: PreviewProvider {
    static var previews: some View {
        Topic004View()
    }
}
