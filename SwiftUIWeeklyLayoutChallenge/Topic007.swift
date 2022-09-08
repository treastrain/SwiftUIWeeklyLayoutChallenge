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
    @State var number = ""
    
    public var body: some View {
        VStack {
            Text(number.isEmpty ? " " : number)
                .font(.largeTitle)
                .enableTextSelection(!number.isEmpty)
            VStack(spacing: 20) {
                HStack(spacing: 20) {
                    RoundButton(phoneNumber: .one, action: append(number:))
                    RoundButton(phoneNumber: .two, action: append(number:))
                    RoundButton(phoneNumber: .three, action: append(number:))
                }
                HStack(spacing: 20) {
                    RoundButton(phoneNumber: .four, action: append(number:))
                    RoundButton(phoneNumber: .five, action: append(number:))
                    RoundButton(phoneNumber: .six, action: append(number:))
                }
                HStack(spacing: 20) {
                    RoundButton(phoneNumber: .seven, action: append(number:))
                    RoundButton(phoneNumber: .eight, action: append(number:))
                    RoundButton(phoneNumber: .nine, action: append(number:))
                }
                HStack(spacing: 20) {
                    RoundButton(phoneNumber: .star, action: append(number:))
                    RoundButton(phoneNumber: .zero, action: append(number:))
                    RoundButton(phoneNumber: .numberSign, action: append(number:))
                }
                HStack(spacing: 20) {
                    RoundButton("") { _ in }
                    RoundButton("📞") { _ in }
                    RoundButton("🆑") { _ in
                        guard !number.isEmpty else { return }
                        number.removeLast()
                    }
                }
            }
        }
        .padding(.horizontal, 50)
    }
    
    private func append(number: String) {
        self.number.append(number)
    }
}

@available(iOS 15.0, *)
extension View {
    @ViewBuilder
    fileprivate func enableTextSelection(_ enabled: Bool) -> some View {
        if enabled {
            textSelection(.enabled)
        } else {
            textSelection(.disabled)
        }
    }
}

@available(iOS 15.0, *)
fileprivate struct RoundButton: View {
    private let number: String
    private let caption: String?
    private let action: (String) -> Void
    
    init(_ number: String, caption: String? = nil, action: @escaping (String) -> Void) {
        self.number = number
        self.caption = caption
        self.action = action
    }
    
    init(phoneNumber: PhoneNumber, action: @escaping (String) -> Void) {
        self.init(phoneNumber.number, caption: phoneNumber.caption, action: action)
    }
    
    var body: some View {
        Button {
            action(number)
        } label: {
            VStack {
                switch number {
                case PhoneNumber.star.number:
                    Image(systemName: "staroflife.fill")
                case PhoneNumber.numberSign.number:
                    Image(systemName: "number")
                case "📞":
                    Image(systemName: "phone.fill")
                        .font(.title)
                case "🆑":
                    Image(systemName: "delete.backward")
                default:
                    if number.isEmpty {
                        EmptyView()
                    } else {
                        Text(number)
                            .font(.title)
                    }
                }
                if let caption = caption {
                    Text(caption)
                        .font(.caption2)
                }
            }
            .frame(width: 60, height: 60)
        }
        .buttonStyle(.bordered)
        .foregroundColor(number == "📞" ? .white : .primary)
        .background(number == "📞" ? .green : .clear)
        .clipShape(Circle())
        .opacity(number.isEmpty ? 0 : 1)
    }
}

fileprivate enum PhoneNumber {
    case one
    case two
    case three
    case four
    case five
    case six
    case seven
    case eight
    case nine
    case zero
    case star
    case numberSign
    
    var number: String {
        switch self {
        case .one:
            return "1"
        case .two:
            return "2"
        case .three:
            return "3"
        case .four:
            return "4"
        case .five:
            return "5"
        case .six:
            return "6"
        case .seven:
            return "7"
        case .eight:
            return "8"
        case .nine:
            return "9"
        case .zero:
            return "0"
        case .star:
            return "*"
        case .numberSign:
            return "#"
        }
    }
    
    var caption: String? {
        switch self {
        case .one:
            return ""
        case .two:
            return "ABC"
        case .three:
            return "DEF"
        case .four:
            return "GHI"
        case .five:
            return "JKL"
        case .six:
            return "MNO"
        case .seven:
            return "PQRS"
        case .eight:
            return "TUV"
        case .nine:
            return "WXYZ"
        case .zero:
            return "+"
        case .star:
            return nil
        case .numberSign:
            return nil
        }
    }
}
#endif

struct Topic007View_Previews: PreviewProvider {
    static var previews: some View {
        Topic007View()
    }
}
