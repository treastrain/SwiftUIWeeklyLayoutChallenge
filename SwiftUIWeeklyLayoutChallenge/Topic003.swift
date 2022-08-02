//
//  Topic003.swift
//  SwiftUIWeeklyLayoutChallenge
//
//  Created by treastrain on 2022/07/27.
//

import SwiftUI

/// <doc:Topic003>
public struct Topic003View: View {
    public init() {}
    
    public var body: some View {
        if #available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *) {
            #if os(macOS)
            DepartureSignal()
                .padding()
            #else
            NavigationView {
                DepartureSignal()
            }
            #endif
        } else {
            Text("Support for this platform is not considered.")
        }
    }
}

// MARK: - Protocols
protocol Light: CustomStringConvertible, Identifiable, CaseIterable {
    var color: Color { get }
}

protocol LightReferenceMappable {
    var reference: Lights { get }
}

extension LightReferenceMappable where Self: Light {
    var color: Color { reference.color }
    var description: String { reference.description }
    var id: Lights.ID { reference.id }
}

// MARK: - Enums
enum Lights: Light {
    case red
    case green
    case yellow
    case off
    
    var color: Color {
        switch self {
        case .red:
            return .red
        case .green:
            return .green
        case .yellow:
            return .yellow
        case .off:
            return .black
        }
    }
    
    var description: String {
        switch self {
        case .red:
            return "赤"
        case .green:
            return "緑"
        case .yellow:
            return "黄"
        case .off:
            return "消"
        }
    }
    
    var id: String { description }
}

// MARK: - Views
@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
struct DepartureSignal: View {
    enum Light1: Light, LightReferenceMappable {
        case yellow
        case off
        
        var reference: Lights {
            switch self {
            case .yellow:
                return .yellow
            case .off:
                return .off
            }
        }
    }
    
    enum Light2: Light, LightReferenceMappable {
        case red
        case off
        
        var reference: Lights {
            switch self {
            case .red:
                return .red
            case .off:
                return .off
            }
        }
    }
    
    enum Light3: Light, LightReferenceMappable {
        case green
        case off
        
        var reference: Lights {
            switch self {
            case .green:
                return .green
            case .off:
                return .off
            }
        }
    }
    
    enum Light4: Light, LightReferenceMappable {
        case green
        case yellow
        case off
        
        var reference: Lights {
            switch self {
            case .green:
                return .green
            case .yellow:
                return .yellow
            case .off:
                return .off
            }
        }
    }
    
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
        
        var pattern: (Light1, Light2, Light3, Light4) {
            switch self {
            case .出発進行:
                return (.off, .off, .green, .off)
            case .出発減速:
                return (.yellow, .off, .off, .green)
            case .出発注意:
                return (.off, .off, .off, .yellow)
            case .出発警戒:
                return (.yellow, .off, .off, .yellow)
            case .出発停止:
                return (.off, .red, .off, .off)
            }
        }
        
        var id: String { rawValue }
    }
    
    @State private var light1: Light1 = .off
    @State private var light2: Light2 = .off
    @State private var light3: Light3 = .off
    @State private var light4: Light4 = .off
    @State private var signal: Signal? = nil
    
    var body: some View {
        form
            .navigationTitle("出発信号機")
    }
    
    var light: some View {
        Image(systemName: "circle.fill")
            .font(.largeTitle)
    }
    
    var form: some View {
        Form {
            Section {
                VStack {
                    light
                        .foregroundColor(light1.color)
                    light
                        .foregroundColor(light2.color)
                    light
                        .foregroundColor(light3.color)
                    light
                        .foregroundColor(light4.color)
                }
                .frame(maxWidth: .infinity)
                .padding()
            }
            
            Section {
                #if os(iOS)
                Menu {
                    ForEach(Signal.allCases) { signal in
                        Button(LocalizedStringKey(signal.rawValue)) {
                            self.signal = signal
                        }
                    }
                } label: {
                    Text(signal?.rawValue ?? "--------")
                        .font(.largeTitle)
                        .bold()
                        .frame(maxWidth: .infinity)
                }
                .foregroundColor(.primary)
                #else
                Picker("指差呼称", selection: $signal) {
                    ForEach(Signal.allCases) {
                        Text(LocalizedStringKey($0.rawValue))
                            .tag(Signal?.some($0))
                    }
                }
                #endif
            }
            
            Section {
                SegmentedPicker("灯1", selection: $light1)
                SegmentedPicker("灯2", selection: $light2)
                SegmentedPicker("灯3", selection: $light3)
                SegmentedPicker("灯4", selection: $light4)
            }
        }
        .onChange(of: signal) { updateLights(by: $0) }
        .onChange(of: light1) { updateSignal(by: $0, light2, light3, light4) }
        .onChange(of: light2) { updateSignal(by: light1, $0, light3, light4) }
        .onChange(of: light3) { updateSignal(by: light1, light2, $0, light4) }
        .onChange(of: light4) { updateSignal(by: light1, light2, light3, $0) }
    }
    
    private func updateLights(by signal: Signal?) {
        guard let pattern = signal?.pattern else { return }
        (light1, light2, light3, light4) = pattern
    }
    
    private func updateSignal(by light1: Light1, _ light2: Light2, _ light3: Light3, _ light4: Light4) {
        signal = Signal.allCases.first(where: { $0.pattern == (light1, light2, light3, light4) })
    }
}

struct SegmentedPicker<SelectionValue> : View where SelectionValue : Hashable & Identifiable & CaseIterable & CustomStringConvertible,
                                                    SelectionValue.AllCases : RandomAccessCollection {
    init(_ titleKey: LocalizedStringKey, selection: Binding<SelectionValue>) {
        self.titleKey = titleKey
        self.selection = selection
    }
    
    private let titleKey: LocalizedStringKey
    private let selection: Binding<SelectionValue>
    
    var body: some View {
        HStack {
            #if !os(watchOS)
            Text(titleKey)
            Spacer()
            #endif
            Picker(titleKey, selection: selection) {
                ForEach(SelectionValue.allCases) {
                    Text(LocalizedStringKey($0.description))
                        .tag($0)
                }
            }
            #if os(iOS) || os(tvOS)
            .pickerStyle(.segmented)
            #else
            .pickerStyle(.automatic)
            .labelsHidden()
            #endif
            .fixedSize()
        }
    }
}

struct Topic003View_Previews: PreviewProvider {
    static var previews: some View {
        Topic003View()
    }
}
