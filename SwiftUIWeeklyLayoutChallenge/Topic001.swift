//
//  Topic001.swift
//  SwiftUIWeeklyLayoutChallenge
//
//  Created by treastrain on 2022/07/13.
//

import SwiftUI

/// <doc:Topic001>
public struct Topic001View: View {
    public init() {}
    
    public var body: some View {
        VStack {
            HStack {
                Text("Hello, world!")
                    .layoutPriority(1)
                Spacer()
                Text("Hello, world!")
            }
            Spacer()
            Text("Hello, world!")
            Spacer()
            HStack {
                Text("Hello, world!")
                Spacer()
                Text("Hello, world!")
                    .layoutPriority(1)
            }
        }
        .padding()
    }
}

struct Topic001View_Previews: PreviewProvider {
    static var previews: some View {
        Topic001View()
    }
}

