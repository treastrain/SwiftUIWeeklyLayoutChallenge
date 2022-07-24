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
#if !os(macOS)
/// <doc:Topic002>
public struct Topic002View: View {
    public init() {}
    
    public var body: some View {
        #if os(watchOS)
        if #available(watchOS 7.0, *) {
            NavigationView {
                VitalList()
            }
        } else {
            VitalList()
        }
        #else
        NavigationView {
            VitalList()
        }
        #endif
    }
}

struct VitalList: View {
    var body: some View {
        if #available(iOS 14.0, macOS 11.0, macCatalyst 14.0, tvOS 14.0, watchOS 7.0, *) {
            list()
                .navigationTitle("バイタルデータ")
        } else {
            list()
                .navigationBarTitle("バイタルデータ")
        }
    }
    
    private func list() -> some View {
        List(vitalData) { vital in
            VitalNavigationLink(
                destination: { Text(vital.title) },
                vital: vital
            )
        }
    }
}

fileprivate struct VitalNavigationLink<Destination> : View where Destination : View {
    init(@ViewBuilder destination: @escaping () -> Destination, vital: Vital) {
        self.destination = destination
        self.vital = vital
    }
    
    @ViewBuilder
    private let destination: () -> Destination
    private let vital: Vital
    
    var body: some View {
        #if os(iOS)
        ZStack(alignment: .leading) {
            NavigationLink(destination: destination) {
                EmptyView()
            }
            .opacity(0)
            
            VitalLabel(vital: vital)
        }
        #else
        NavigationLink(destination: destination) {
            VitalLabel(vital: vital)
        }
        #endif
    }
}

fileprivate struct VitalLabel: View {
    init(vital: Vital) {
        self.vital = vital
    }
    
    private let vital: Vital
    
    #if os(watchOS)
    private let vStackSpacing: CGFloat? = nil
    #else
    private let vStackSpacing: CGFloat? = 18
    #endif
    
    var body: some View {
        VStack(alignment: .leading, spacing: vStackSpacing) {
            HStack {
                Group {
                    if #available(iOS 14.0, macOS 11.0, macCatalyst 14.0, tvOS 14.0, watchOS 7.0, *) {
                        Label {
                            Text(vital.title)
                                .bold()
                                .font(.subheadline)
                        } icon: {
                            Image(systemName: vital.iconSystemName)
                        }
                    } else {
                        HStack(alignment: .top) {
                            Image(systemName: vital.iconSystemName)
                            Text(vital.title)
                                .bold()
                                .font(.subheadline)
                        }
                    }
                }
                .foregroundColor(vital.color)
                Spacer()
                Text(vital.relativeDateTimeString)
                    .font(.footnote)
                    .foregroundColor(.secondary)
                #if os(iOS)
                DisclosureIndicator()
                #endif
            }
            
            vital.value.localizedString
                .map {
                    $0.isNumber || [".", ",", " "].contains($0)
                    ? Text(String($0))
                        .font(.system(.title, design: .rounded).weight(.medium))
                        .foregroundColor(.primary)
                    : Text(String($0))
                        .font(.callout.weight(.medium))
                        .foregroundColor(.secondary)
                }
                .reduce(Text("")) { $0 + $1 }
        }
        .foregroundColor(.primary)
        .padding(.vertical, 6)
    }
}

#if os(iOS)
struct ChevronForwardIcon: View {
    var body: some View {
        if #available(iOS 14.0, macOS 11.0, macCatalyst 14.0, tvOS 14.0, watchOS 7.0, *) {
            Image(systemName: "chevron.forward")
                .font(.footnote.weight(.bold))
                .foregroundColor(.init(.tertiaryLabel))
        } else {
            Image(systemName: "chevron.right")
                .flipsForRightToLeftLayoutDirection(true)
                .font(.footnote.weight(.bold))
                .foregroundColor(.init(.tertiaryLabel))
        }
    }
}

typealias DisclosureIndicator = ChevronForwardIcon
#endif
#else
/// <doc:Topic002>
public struct Topic002View: View {
    public init() {}
    
    public var body: some View {
        Text("Support for this platform is not considered.")
    }
}
#endif

extension Vital {
    var relativeDateTimeString: String {
        if #available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *) {
            return date.formatted(.relative(presentation: .named))
        } else {
            let formatter = RelativeDateTimeFormatter()
            formatter.dateTimeStyle = .named
            return formatter.localizedString(for: date, relativeTo: Date())
        }
    }
}

extension Vital.Value {
    var localizedString: String {
        switch self {
        case .number(let value, let style, let customUnit):
            if #available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *) {
                return {
                    switch style {
                    case .percent:
                        return value.formatted(.percent)
                    case .decimal:
                        return value.formatted(.number)
                    default:
                        preconditionFailure("The implementation was omitted.")
                    }
                }() + (customUnit ?? "")
            } else {
                let formatter = NumberFormatter()
                formatter.numberStyle = style
                return (formatter.string(from: .init(value: value)) ?? "\(value)") + (customUnit ?? "")
            }
        case .dateComponents(let dateComponents):
            let formatter = DateComponentsFormatter()
            formatter.unitsStyle = .brief
            formatter.allowedUnits = [.hour, .minute]
            return formatter.string(from: dateComponents) ?? "\(dateComponents)"
        case .measurement(let value, let unit, let formattedUnit):
            var measurement = Measurement(value: value, unit: unit)
            measurement.convert(to: formattedUnit ?? unit)
            if #available(iOS 15.0, macOS 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *) {
                return measurement.formatted(.measurement(width: .abbreviated, usage: .asProvided))
            } else {
                let formatter = MeasurementFormatter()
                formatter.unitOptions = .providedUnit
                return formatter.string(from: measurement)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Topic002View()
    }
}
