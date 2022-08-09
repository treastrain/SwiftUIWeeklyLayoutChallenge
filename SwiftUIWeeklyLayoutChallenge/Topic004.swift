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
    
    @State private var number = Int.random(in: 2...100)
    
    public var body: some View {
        if #available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *) {
            content
        } else {
            Text("Support for this platform is not considered.")
        }
    }
    
    @available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
    private var content: some View {
        VStack(spacing: 30) {
            Text(number.formatted())
                .font(.system(.largeTitle, design: .monospaced))
                .fontWeight(.black)
                .scaleEffect(2)
            HStack {
                Button {
                    print("action: prime")
                } label: {
                    #if os(watchOS)
                    Text("P")
                        .lineLimit(1)
                    #else
                    Text("Prime")
                        .lineLimit(1)
                        .minimumScaleFactor(0.1)
                        .padding(5)
                    #endif
                }
                #if os(watchOS)
                Text("/")
                #else
                Text("or")
                #endif
                Button {
                    print("action: composite")
                } label: {
                    #if os(watchOS)
                    Text("C")
                        .lineLimit(1)
                    #else
                    Text("Composite")
                        .lineLimit(1)
                        .minimumScaleFactor(0.1)
                        .padding(5)
                    #endif
                }
            }
            #if !os(watchOS)
            .fixedSize()
            #endif
            #if os(iOS)
            .buttonStyle(.borderedProminent)
            #elseif os(macOS)
            .buttonStyle(.link)
            #elseif os(tvOS) || os(watchOS)
            .buttonStyle(.bordered)
            #endif
            .cornerRadius(.infinity)
        }
        .font(.system(.title, design: .rounded).weight(.black))
        .padding()
    }
}

struct Topic004View_Previews: PreviewProvider {
    static var previews: some View {
        Topic004View()
    }
}
