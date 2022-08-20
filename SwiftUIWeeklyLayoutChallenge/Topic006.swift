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
            GeometryReader { geo in
                Topic006ContentView(containerFrame: geo.frame(in: .local))
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
@available(iOS 15.0, *)
fileprivate struct Topic006ContentView: View {

    private let paddingLength: CGFloat = 16
    private let buttonSize: CGSize = .init(width: 44, height: 44)

    @State private var showingAlert = false
    @State private var title: String = "新規音声"
    @State private var location: CGPoint
    @State private var canShowAlert: Bool = true

    public init(containerFrame: CGRect) {
        let frame = containerFrame.insetBy(dx: paddingLength + buttonSize.width / 2,
                                           dy: paddingLength + buttonSize.height / 2)
        location = CGPoint(x: frame.maxX, y: frame.maxY)
    }

    var body: some View {
        ZStack {
            Text("後ろに位置する View")

            Button {
                guard canShowAlert else {
                    canShowAlert.toggle()
                    return
                }

                showingAlert = true
                title = "新規作成"
            } label: {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .scaledToFill()
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.white, Color.accentColor)
            }
            .frame(width: buttonSize.width, height: buttonSize.height)
            .position(location)
            .contextMenu {
                Button {
                    showingAlert = true
                    title = "音声を追加"

                } label: {
                    Label("音声を追加", systemImage: "mic.badge.plus")
                }

                Button {
                    showingAlert = true
                    title = "画像を追加"

                } label: {
                    Label("画像を追加", systemImage: "photo")
                }

                Button {
                    showingAlert = true
                    title = "新規作成"
                } label: {
                    Label("新規作成", systemImage: "square.and.pencil")
                }
            }
            .alert(title, isPresented: $showingAlert) {
                Button(action: { }, label: { Text("閉じる") })
            } message: {
                EmptyView()
            }
            .simultaneousGesture(drag)
        }
    }

    var drag: some Gesture {
        DragGesture()
            .onChanged { value in
                self.location = value.location
            }
            .onEnded { value in
                canShowAlert = false
            }
    }

    func setupInitialPosition(proxy geo: GeometryProxy) {
        if location == .zero {
            let frame = geo.frame(in: .local).insetBy(dx: paddingLength, dy: paddingLength)
            location = CGPoint(x: frame.maxX, y: frame.maxY)
        }
    }
}
#endif

struct Topic006View_Previews: PreviewProvider {
    static var previews: some View {
        Topic006View()
    }
}
