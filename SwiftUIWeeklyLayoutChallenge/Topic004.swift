//
//  Topic004.swift
//  SwiftUIWeeklyLayoutChallenge
//
//  Created by treastrain on 2022/08/03.
//

import SwiftUI

/**
 - 2から100までの数字をランダムに表示してください
 - その数字が素数か合成数かを、ユーザーがボタンで回答できるようにします
 - ボタンをタップしたときの挙動などの明示はありません
 - iOS 15.0+、macOS 12.0+、tvOS 15.0+、watchOS 8.0+ を前提とします
 */

/// <doc:Topic004>
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
public struct Topic004View: View {

    @StateObject private var state: ViewState = .init()

    @State private var resultMessage: String?

    @FocusState var isFocused: ButtonFocus?

    enum ButtonFocus: Hashable {
        case prime
        case composite
    }

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
        VStack(spacing: 0) {
            Text("\(state.givenNumber)")
                .font(.system(size: 80, weight: .heavy, design: .default))

            HStack {
                primeButton

                or

                compositeButton
            }
            .padding([.horizontal])
        }
        .alert(item: $resultMessage, content: anAlert)

    }

    @available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
    private var primeButton: some View {
        #if os(watchOS)
        return Button {
            resultMessage = state.judgement(.prime)
        } label: {
            Text("P")
                .font(.system(size: 38, weight: .heavy, design: .rounded))
        }

        #else
        return Button {
            resultMessage = state.judgement(.prime)
        } label: {
            Text("Prime")
                .font(.system(size: 27, weight: .black, design: .rounded))
        }
        .focused($isFocused, equals: .prime)
//        .buttonStyle(RoundedButton(side: .left))
        .buttonStyle(AppButtonStyle())

        #endif
    }

    @available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
    private var compositeButton: some View {
        #if os(watchOS)
        return Button {
            resultMessage = state.judgement(.prime)
        } label: {
            Text("C")
                .font(.system(size: 38, weight: .heavy, design: .rounded))
        }

        #else
        return Button {
            resultMessage = state.judgement(.prime)
        } label: {
            Text("Composite")
                .font(.system(size: 27, weight: .black, design: .rounded))
        }
        .focused($isFocused, equals: .composite)
//        .buttonStyle(MyCustomButton())
        .buttonStyle(RoundedButton(side: .right))
//        .buttonStyle(AppButtonStyle())
//        .buttonStyle(.borderedProminent)

        #endif
    }

    @available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
    private var or: some View {
        #if os(watchOS)
        return Text("/")
            .font(.system(size: 38, weight: .heavy, design: .rounded))
        #else
        return Text("or")
            .font(.system(size: 28, weight: .black, design: .rounded))
        #endif
    }

    func anAlert(item: String) -> Alert {
        let cancel = ActionSheet.Button.cancel(Text("Close")) { state.renew() }
        return Alert(title: Text("Result is..."),
                     message: Text(item),
                     dismissButton: cancel)
    }
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
struct Topic004View_Previews: PreviewProvider {
    static var previews: some View {
        Topic004View()
    }
}
struct MyCustomButton: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(minWidth: 0, maxWidth: 300)
            .foregroundColor(.white)
            .background(configuration.isPressed ? Color.red : Color.green)
    }
}

struct RoundedButton: ButtonStyle {

    enum HalfCircleSide {
        case left
        case right

        var corners: UIRectCorner {
            switch self {
            case .left:
                return [.topLeft, .bottomLeft]
            case .right:
                return [.topRight, .bottomRight]
            }
        }
    }

    struct InnerButton: View {
        let configuration: ButtonStyle.Configuration
        let side: HalfCircleSide
        let radius: CGFloat = .infinity
        @State var focused: Bool = false

        var body: some View {
            if #available(tvOS 15.0, *) {
            configuration.label
                .padding([.horizontal], 16)
                .padding([.vertical], 10)
//                .background(configuration.isPressed ? Color.red : Color.green)
                .background(Color.accentColor)
                .shadow(color: .black, radius: self.focused ? 20 : 0, x: 0, y: 0) //  0
                .scaleEffect(focused ? 1.1 : 1.0)

//                .foregroundColor(.white)
                .cornerRadius(12)
                .clipShape(RoundedCorner(radius: radius, corners: side.corners))
                .scaleEffect(configuration.isPressed ? 1.2 : 1)
                .focusable(true) { focused in
                    withAnimation {
                        self.focused = focused
                    }
                }
            } else {
                fatalError("Support for this platform is not considered.")
            }
        }
    }

    var side: HalfCircleSide
    var radius: CGFloat = .infinity

    func makeBody(configuration: Configuration) -> some View {
        if #available(tvOS 15.0, *) {
            InnerButton(configuration: configuration, side: side)
        } else {
            fatalError("Support for this platform is not considered.")
        }
    }
}

struct AppButtonStyle: ButtonStyle {

  let color: Color = .clear

  func makeBody(configuration: Configuration) -> some View {
    return AppButton(configuration: configuration, color: color)
  }


  struct AppButton: View {
    @State var focused: Bool = false

    let configuration: ButtonStyle.Configuration
    let color: Color

    var body: some View {
      configuration.label
        .foregroundColor(.white)
        .background(RoundedRectangle(cornerRadius: 20).fill(color))
        .compositingGroup()
        .shadow(color: .black, radius: 5)
        .scaleEffect(focused ? 1.1 : 1.0)
        .padding()
        .focusable(true) { focused in
          withAnimation {
            self.focused = focused
          }
        }
    }
  }
}

@available(iOS 15.0, tvOS 15.0, watchOS 8.0, *)
struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}


/*
 解答後に成否を表示
 表示終わると、新しい数字を提示

 Prime/Composite 判定ロジック
 */

final class ViewState: ObservableObject {

    enum Choice {
        case prime
        case composite
    }

    @Published public var givenNumber: Int

    public init() {
        givenNumber = Self.randomNumber()
    }

    public func judgement(_ choice: Choice) -> String {
        if which(givenNumber) == choice {
            return "🎉"
        } else {
            return "👻"
        }
    }

    public func renew() {
        givenNumber = Self.randomNumber()
    }

    private func which(_ number: Int) -> Choice {
        if isPrime(n: givenNumber) {
            return .prime
        }

        return .composite
    }
}


extension ViewState {
    static func randomNumber() -> Int {
        Int.random(in: 2...100)
    }
}


// https://zenn.dev/kyome/articles/0476bf71d29422
// もらった整数が素数かどうかをそこそこの速さで判定
fileprivate func isPrime(n: Int) -> Bool {
    if n == 1 { return false }
    if n == 2 { return true }
    if n % 2 == 0 { return false }
    var i = 3
    while i * i <= n {
        if n % i == 0 { return false }
        i += 2
    }
    return true
}

extension String: Identifiable {
    public var id: String {
        self
    }
}
