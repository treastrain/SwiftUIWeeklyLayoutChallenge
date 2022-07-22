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
    public init() {}
    
    public var body: some View {
        NavigationView {
            List {
                ForEach(vitalData, id: \.id) { vital in
                    NavigationLink(destination: EmptyView()) {
                        Topic002ListRowView(vital: vital)
                    }
                }
            }
//            .navigationTitle("バイタルデータ")
        }
    }
}

struct Topic002View_Previews: PreviewProvider {
    static var previews: some View {
        Topic002View()
    }
}

private struct Topic002ListRowView: View {
    let vital: Vital
    
    var body: some View {
        HStack {
            Image(systemName: vital.iconSystemName)
            Text(vital.title)
        }
        .foregroundColor(vital.color)
    }
}

struct Topic002ListRowView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            ForEach(vitalData, id: \.id) { vital in
                Topic002ListRowView(vital: vital)
            }
        }
    }
}
