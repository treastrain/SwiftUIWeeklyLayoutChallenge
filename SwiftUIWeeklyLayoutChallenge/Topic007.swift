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

    @State private var input: String = ""

    let verticalSpacing: CGFloat = 17
    let horizontalSpacing: CGFloat = 30

    var body: some View {
        VStack(spacing: 20) {
            Text(input)
                .font(.largeTitle)
                .textSelection(.enabled)
                .frame(minHeight: 50)

            VStack(spacing: verticalSpacing) {
                HStack(spacing: horizontalSpacing) {
                    NumberPadButton(primaryText: "1",
                                    action:buttonAction(primaryText:type:))
                    NumberPadButton(primaryText: "2",
                                    secondaryText: "ABC",
                                    action:buttonAction(primaryText:type:))
                    NumberPadButton(primaryText: "3",
                                    secondaryText: "DEF",
                                    action:buttonAction(primaryText:type:))
                }

                HStack(spacing: horizontalSpacing) {
                    NumberPadButton(primaryText: "4",
                                    secondaryText: "GHI",
                                    action:buttonAction(primaryText:type:))
                    NumberPadButton(primaryText: "5",
                                    secondaryText: "JKL",
                                    action:buttonAction(primaryText:type:))
                    NumberPadButton(primaryText: "6",
                                    secondaryText: "MNO",
                                    action:buttonAction(primaryText:type:))
                }

                HStack(spacing: horizontalSpacing) {
                    NumberPadButton(primaryText: "7",
                                    secondaryText: "PQRS",
                                    action:buttonAction(primaryText:type:))
                    NumberPadButton(primaryText: "8",
                                    secondaryText: "TUV",
                                    action:buttonAction(primaryText:type:))
                    NumberPadButton(primaryText: "9",
                                    secondaryText: "WXYZ",
                                    action:buttonAction(primaryText:type:))
                }

                HStack(spacing: horizontalSpacing) {
                    NumberPadButton(primaryText: "*",
                                    action:buttonAction(primaryText:type:))
                    NumberPadButton(primaryText: "0",
                                    secondaryText: "+",
                                    action:buttonAction(primaryText:type:))
                    NumberPadButton(primaryText: "#",
                                    action:buttonAction(primaryText:type:))
                }

                HStack(spacing: horizontalSpacing) {
                    NumberPadButton(type: .invisible,
                                    action:buttonAction(primaryText:type:))
                    NumberPadButton(type: .phone,
                                    action:buttonAction(primaryText:type:))
                    NumberPadButton(type: .delete,
                                    action:buttonAction(primaryText:type:))
                }
            }
        }
    }

    func buttonAction(primaryText: String, type: NumberPadButton.ButtonType) {
        switch type {
        case .text:
            input = input + primaryText
        case .phone:
            break
        case .delete:
            input = String(input.dropLast())
        case .invisible:
            fatalError("")
        }
    }
}

@available(iOS 15.0, *)
struct NumberPadButton: View {
    @Environment(\.colorScheme) private var colorScheme

    enum ButtonType {
        case text
        case phone
        case delete
        case invisible

        var image: UIImage {
            switch self {
            case .text:
                fatalError("")
            case .phone:
                return UIImage(systemName: "phone.fill")!
            case .delete:
                return UIImage(systemName: "delete.backward")!
            case .invisible:
                fatalError("")
            }
        }
    }

    typealias ButtonAction = (String, ButtonType) -> Void

    let primaryText: String
    let secondaryText: String?
    let action: ButtonAction
    let type: ButtonType

    let buttonLength: CGFloat = 80

    init(primaryText: String, secondaryText: String? = nil, action: @escaping ButtonAction) {
        self.primaryText = primaryText
        self.secondaryText = secondaryText
        self.type = .text
        self.action = action
    }

    init(type: ButtonType, action: @escaping ButtonAction) {
        self.primaryText = ""
        self.secondaryText = nil
        self.type = type
        self.action = action
    }

    var body: some View {
        if type == .invisible {
            Color.clear
                .frame(width: buttonLength, height: buttonLength)
        } else {
            Button {
                action(primaryText, type)
            } label: {
                labelContent()
            }
            .frame(width: buttonLength, height: buttonLength)
            .background(backgroundColor())
            .clipShape(Circle())
        }
    }

    func labelContent() -> some View {
        Group {
            switch type {
            case .text:
                VStack {
                    Text(primaryText)
                        .font(.title)
                        .foregroundColor(Color(uiColor: .label))

                    if let a = secondaryText {
                        Text(a)
                            .font(.caption2)
                            .foregroundColor(Color(uiColor: .label))
                    }
                }
            case .phone:
                VStack {
                    Image(systemName: "phone.fill")
                        .font(.title)
                        .tint(.white)
                    if let a = secondaryText {
                        Text(a)
                    }
                }
            case .delete:
                VStack {
                    Image(systemName: "delete.backward")
                        .font(.body)
                        .tint(Color(uiColor: .label))
                    if let a = secondaryText {
                        Text(a)
                            .font(.caption)
                            .foregroundColor(Color(uiColor: .label))
                    }
                }
            case .invisible:
                fatalError("")
            }
        }
    }

    func backgroundColor() -> Color {
        switch type {
        case .phone:
            return Color.phoneGreen
        case .invisible:
            return Color.clear
        default:
            return colorScheme == .dark ? .buttonBackgroundDark : .buttonBackgroundLight
        }
    }
}


extension Color {
    public init(_ hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 8) & 0xFF) / 255,
            blue: Double(hex & 0xFF) / 255,
            opacity: alpha
        )
    }

    public static var phoneGreen: Color { .init(0x35B04D) }

    public static var buttonBackgroundLight: Color { .init(0xE4E4E5) }
    public static var buttonBackgroundDark: Color { .init(0x1D1C1F) }
}





#endif

struct Topic007View_Previews: PreviewProvider {
    static var previews: some View {
        Topic007View()
    }
}
