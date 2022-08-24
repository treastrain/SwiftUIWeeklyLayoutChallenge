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
    private let coordinateSpaceName = "stacks"
    private var coordinateSpace: CoordinateSpace { .named(coordinateSpaceName) }
    private let paddingLength: CGFloat = 16
    
    @State private var selectedTitle = ""
    @State private var isPresented = false
    @State private var position: CGPoint? = nil
    
    var drag: some Gesture {
        DragGesture(coordinateSpace: coordinateSpace)
            .onChanged { position = $0.location }
    }
    
    var body: some View {
        ZStack {
            Text("後ろに位置する View")
            
            VStack(alignment: .trailing) {
                Spacer()
                
                HStack(alignment: .bottom) {
                    Spacer()
                    
                    Menu(
                        content: {
                            Button(action: compose) {
                                Label("新規作成", systemImage: "square.and.pencil")
                            }
                            Button(action: addImage) {
                                Label("画像を追加", systemImage: "photo")
                            }
                            Button(action: addAudio) {
                                Label("音声を追加", systemImage: "mic.badge.plus")
                            }
                        },
                        label: {
                            Image(systemName: "plus")
                                .imageScale(.large)
                                .frame(width: 50, height: 50)
                                .foregroundColor(.white)
                                .background(Color.accentColor)
                                .clipShape(Circle())
                        },
                        primaryAction: compose
                    )
                    .padding(paddingLength)
                    .ifLet(position) { view, position in
                        view.position(position)
                    }
                    .gesture(drag)
                    .background(
                        GeometryReader { geometryProxy in
                            Color.clear
                                .onAppear {
                                    if position == nil {
                                        let frame = geometryProxy.frame(in: coordinateSpace)
                                        position = .init(
                                            x: frame.midX - (paddingLength / 2),
                                            y: frame.midY - (paddingLength / 2)
                                        )
                                    }
                                }
                        }
                    )
                }
            }
            .coordinateSpace(name: coordinateSpaceName)
        }
        .alert(selectedTitle, isPresented: $isPresented) {
            Button("閉じる") { isPresented = false }
        }
    }
    
    private func compose() {
        selectedTitle = "新規作成"
        isPresented = true
    }
    
    private func addImage() {
        selectedTitle = "画像を追加"
        isPresented = true
    }
    
    private func addAudio() {
        selectedTitle = "音声を追加"
        isPresented = true
    }
}

extension View {
    @ViewBuilder
    fileprivate func `ifLet`<Wrapped, Content: View>(_ value: Optional<Wrapped>, transform: (Self, Wrapped) -> Content) -> some View {
        if let value = value {
            transform(self, value)
        } else {
            self
        }
    }
}
#endif

struct Topic006View_Previews: PreviewProvider {
    static var previews: some View {
        Topic006View()
    }
}
