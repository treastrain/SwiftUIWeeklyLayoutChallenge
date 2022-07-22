//
//  Topic002View.swift
//  SwiftUIWeeklyLayoutChallenge
//
//  Created by treastrain on 2022/07/20.
//

import SwiftUI

// MARK: - Entities
fileprivate struct Vital: Identifiable {
    let id = UUID()
    let title: LocalizedStringKey
    let value: Value
    let date: Date
    let iconSystemName: String
    let color: Color
    
    enum Value {
        case number(value: Double, style: NumberFormatter.Style, customUnit: String? = nil)
        case dateComponents(_ dateComponents: DateComponents)
        case measurement(value: Double, unit: Dimension, formattedUnit: Dimension? = nil)
    }
}

// MARK: - Sample Data
fileprivate let vitalData: [Vital] = [
    .init(title: "取り込まれた酸素のレベル", value: .number(value: 0.99, style: .percent), date: Date(timeIntervalSinceNow: -300), iconSystemName: "o.circle.fill", color: .blue),
    .init(title: "心拍数", value: .number(value: 61, style: .decimal, customUnit: "拍/分"), date: Date(timeIntervalSinceNow: -5400), iconSystemName: "heart.fill", color: .red),
    .init(title: "睡眠", value: .dateComponents(.init(minute: 451)), date: Date(timeIntervalSinceNow: -87000), iconSystemName: "bed.double.fill", color: .green),
    .init(title: "体温", value: .measurement(value: 36.4, unit: UnitTemperature.celsius), date: Date(timeIntervalSinceNow: -172800), iconSystemName: "thermometer", color: .red),
]

// MARK: - Views
/// <doc:Topic002>
public struct Topic002View: View {

    private var vitals: [Vital] = vitalData

    public init() {}


    private func value(_ v: Vital.Value) -> some View {
        switch v {
        case .number(let value, let style, let customUnit):
            let formatter = NumberFormatter()
            formatter.numberStyle = style
            switch style {
            case .percent:
                return Text(formatter.string(from: NSNumber(value: value))!)
                    .font(.title)
                + Text("%")
                    .font(.caption)
                    .foregroundColor(.secondary)
            case .decimal:
                return Text(formatter.string(from: NSNumber(value: value))!)
                    .font(.title)
                + Text(customUnit ?? "")
                    .font(.caption)
                    .foregroundColor(.secondary)
            default:
                fatalError()
            }

        case .dateComponents(let components):
            return Text("\(Int(components.minute! / 60))")
                .font(.title)
            + Text("時間")
                .font(.caption)
                .foregroundColor(.secondary)
            + Text("\(Int(components.minute! % 60))")
                .font(.title)
            + Text("分")
                .font(.caption)
                .foregroundColor(.secondary)


        case .measurement(let value, let unit, let formattedUnit):
            let symbol = formattedUnit?.symbol ?? unit.symbol
            return Text(String(format: "%.1f", value))
                .font(.title)
            + Text(symbol)
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
    
    public var body: some View {

        NavigationView {
            List(vitals) { v in
#if os(iOS)
                VStack(alignment: .leading) {
                    NavigationLink {
                        EmptyView()
                    } label: {
                        HStack {
                            Label(v.title, systemImage: v.iconSystemName)
                                .foregroundColor(v.color)
                            Spacer()
                            Text(v.date, format: .relative(presentation: Date.RelativeFormatStyle.Presentation.named))
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                    value(v.value)
                        .padding([.top, .bottom], 6)
                }
#else
                NavigationLink {
                    EmptyView()
                } label: {
                    VStack(alignment: .leading) {
                        HStack {
                            Label(v.title, systemImage: v.iconSystemName)
                                .foregroundColor(v.color)
                            Spacer()
                            Text(v.date, format: .relative(presentation: Date.RelativeFormatStyle.Presentation.named))
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }

                        value(v.value)
                            .padding([.top, .bottom], 6)
                    }
                }
#endif
            }
            .navigationTitle("バイタルデータ")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Topic002View()
    }
}
