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

    var text: some View {
        Text("Hello, world!")
    }

    public var body: some View {
        VStack {
            HStack {
                text
                    .layoutPriority(1)
                Spacer()
                text
            }

            Spacer()

            HStack {
                text
            }

            Spacer()

            HStack {
                text
                Spacer()
                text
                    .layoutPriority(1)
            }
        }.padding()
    }
}

struct Topic001View_Previews: PreviewProvider {
    static var previews: some View {
        Topic001View()
    }
}
