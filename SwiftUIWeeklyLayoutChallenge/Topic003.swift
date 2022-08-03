//
//  Topic003.swift
//  SwiftUIWeeklyLayoutChallenge
//
//  Created by treastrain on 2022/07/27.
//

import SwiftUI
import Combine

/// <doc:Topic003>
@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
public struct Topic003View: View {

    typealias Signal = DepartureSignal.Signal

    @State var firstColor: Color?
    @State var secondColor: Color?
    @State var thirdColor: Color?
    @State var forthColor: Color?

    var signal: Signal? {
        set {
            firstColor = newValue?.colorForLight(at: .first)
            secondColor = newValue?.colorForLight(at: .second)
            thirdColor = newValue?.colorForLight(at: .third)
            forthColor = newValue?.colorForLight(at: .forth)
        }

        get {
            Signal(first: firstColor, second: secondColor, thrid: thirdColor, forth: forthColor)
        }
    }

    func update(signal newValue: Signal?) {
        firstColor = newValue?.colorForLight(at: .first)
        secondColor = newValue?.colorForLight(at: .second)
        thirdColor = newValue?.colorForLight(at: .third)
        forthColor = newValue?.colorForLight(at: .forth)
    }

    public init() {}
    
    public var body: some View {
#if os(macOS)
        DepartureSignal(firstColor: firstColor, secondColor: secondColor, thirdColor: thirdColor, forthColor: forthColor)
                        .padding()
#else
        if #available(watchOS 7.0, *) {
            NavigationView {
                Form {
                    Section {
                        DepartureSignal(firstColor: firstColor, secondColor: secondColor, thirdColor: thirdColor, forthColor: forthColor)
                            .alignmentGuide(HorizontalAlignment.center, computeValue: { d in d[HorizontalAlignment.center] } )
                    }

                    Section {
                        Menu {
                            ForEach(DepartureSignal.Signal.allCases) { signal in
                                Button(signal.rawValue) { update(signal: signal) }
                            }
                        } label: {
                            Text(self.signal?.rawValue ?? "--------")
                                .font(.largeTitle)
                                .bold()
                                .foregroundColor(.black)
                                .fixedSize(horizontal: true, vertical: false)
                        }
                        .alignmentGuide(HorizontalAlignment.center, computeValue: { d in d[HorizontalAlignment.center] } )
                    }

                    Section {
                        Cell(label: "灯1", position: .first, current: $firstColor)
                        Cell(label: "灯2", position: .second, current: $secondColor)
                        Cell(label: "灯3", position: .third, current: $thirdColor)
                        Cell(label: "灯4", position: .forth, current: $forthColor)
                    }
                }
                .navigationTitle("出発信号機")
            }
        } else {
            DepartureSignal(firstColor: firstColor, secondColor: secondColor, thirdColor: thirdColor, forthColor: forthColor)
        }
#endif
    }
}

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
struct Cell: View {
    var label: String
    var position: DepartureSignal.Position
    @Binding var current: Color?

    var body: some View {
        HStack {
            Text(label)
            Spacer()
            Picker(selection: $current) {
                ForEach(DepartureSignal.Signal.colorPatternForLight(at: position), id: \.self) { color in
                    Text(color.label)
                }
            } label: {
                EmptyView()
            }
            .fixedSize()
        #if os(macOS)
            .pickerStyle(.menu)
        #else
            .pickerStyle(.segmented)
        #endif
        }
    }
}

//final class SignalState: ObservableObject {
//
//    typealias Signal = DepartureSignal.Signal
//
//    @Published var firstColor: Color?
//    @Published var secondColor: Color?
//    @Published var thirdColor: Color?
//    @Published var forthColor: Color?
//
//    var signal: Signal? {
//        set {
//            firstColor = newValue?.colorForLight(at: .first)
//            secondColor = newValue?.colorForLight(at: .second)
//            thirdColor = newValue?.colorForLight(at: .third)
//            forthColor = newValue?.colorForLight(at: .forth)
//        }
//
//        get {
//            Signal(first: firstColor, second: secondColor, thrid: thirdColor, forth: forthColor)
//        }
//    }
//
//
//    init() {
////        firstColor = self.signal?.colorForLight(at: .first)
////        secondColor = self.signal?.colorForLight(at: .second)
////        thirdColor = self.signal?.colorForLight(at: .third)
////        forthColor = self.signal?.colorForLight(at: .forth)
////
////        $firstColor.sink { [weak self] color in
////            self?.signal = .init(first: color, second: nil, thrid: nil, forth: nil)
////        }.store(in: &cancelable)
//    }
//}

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
struct DepartureSignal: View {

    var firstColor: Color?
    var secondColor: Color?
    var thirdColor: Color?
    var forthColor: Color?

    enum Signal: String, CaseIterable, Identifiable {
        /// 上の灯火から順に 消・消・緑・消 で進行信号を現示。
        case 出発進行
        /// 上の灯火から順に 黄・消・消・緑 で減速信号を現示。
        case 出発減速
        /// 上の灯火から順に 消・消・消・黄 で注意信号を現示。
        case 出発注意
        /// 上の灯火から順に 黄・消・消・黄 で警戒信号を現示。
        case 出発警戒
        /// 上の灯火から順に 消・赤・消・消 で停止信号を現示。
        case 出発停止
        
        var id: String { rawValue }

        init?(first: Color?, second: Color?, thrid: Color?, forth: Color?) {
            switch (first, second, thrid, forth) {
            case (nil, nil, Color.green, nil):
                self = .出発進行
            case (Color.yellow, nil, nil, Color.green):
                self = .出発減速
            case (nil, nil, nil, Color.yellow):
                self = .出発注意
            case (Color.yellow, nil, nil, Color.yellow):
                self = .出発警戒
            case (nil, Color.red, nil, nil):
                self = .出発停止
            case (_, _, _, _):
                return nil
            }
        }
    }

    enum Position: Int, Identifiable {
        case first
        case second
        case third
        case forth

        var id: Int { rawValue }
    }
    
    var body: some View {
        VStack {
            light
                .foregroundColor(firstColor ?? .black)
            light
                .foregroundColor(secondColor ?? .black)
            light
                .foregroundColor(thirdColor ?? .black)
            light
                .foregroundColor(forthColor ?? .black)
        }
    }
    
    var light: some View {
        Image(systemName: "circle.fill")
            .font(.largeTitle)
    }
}

struct Topic003View_Previews: PreviewProvider {
    static var previews: some View {
        Topic003View()
    }
}

extension DepartureSignal.Signal {
    func colorForLight(at position: DepartureSignal.Position) -> Color? {
        switch self {
        /// 上の灯火から順に 消・消・緑・消 で進行信号を現示。
        case .出発進行:
            switch position {
            case .first:
                return nil
            case .second:
                return nil
            case .third:
                return .green
            case .forth:
                return nil
            }
        /// 上の灯火から順に 黄・消・消・緑 で減速信号を現示。
        case .出発減速:
            switch position {
            case .first:
                return .yellow
            case .second:
                return nil
            case .third:
                return nil
            case .forth:
                return .green
            }
            /// 上の灯火から順に 消・消・消・黄 で注意信号を現示。
        case .出発注意:
            switch position {
            case .first:
                return nil
            case .second:
                return nil
            case .third:
                return nil
            case .forth:
                return .yellow
            }
            /// 上の灯火から順に 黄・消・消・黄 で警戒信号を現示。
        case .出発警戒:
            switch position {
            case .first:
                return .yellow
            case .second:
                return nil
            case .third:
                return nil
            case .forth:
                return .yellow
            }
            /// 上の灯火から順に 消・赤・消・消 で停止信号を現示。
        case .出発停止:
            switch position {
            case .first:
                return nil
            case .second:
                return .red
            case .third:
                return nil
            case .forth:
                return nil
            }
        }
    }

    static func colorPatternForLight(at position: DepartureSignal.Position) -> [Color?] {
        switch position {
        case .first:
            return [.yellow, nil]
        case .second:
            return [.red, nil]
        case .third:
            return [.green, nil]
        case .forth:
            return [.green, .yellow, nil]
        }
    }
}

protocol Labelable: Identifiable {
    var label: String { get }

    var id: String { get }
}

extension Labelable {
    public var id: String { label }
}

extension Color: Labelable {
    var label: String {
        switch self {
        case .red:
            return "赤"
        case .green:
            return "緑"
        case .yellow:
            return "黄"
        default:
            fatalError()
        }
    }
}

extension Optional: Identifiable where Wrapped == Color {
    public var id: String { label }
}

extension Optional: Labelable where Wrapped == Color {
    var label: String {
        switch self {
        case .none:
            return "消"
        case .some(let wrapped):
            return wrapped.label
        }
    }
}
