// swift-tools-version: 5.5

import PackageDescription

let package = Package(
    name: "SwiftUIWeeklyLayoutChallenge",
    defaultLocalization: "ja",
    platforms: [.iOS(.v13), .macOS(.v10_15), .macCatalyst(.v13), .tvOS(.v13), .watchOS(.v6)],
    products: [
        .library(
            name: "SwiftUIWeeklyLayoutChallenge",
            targets: ["SwiftUIWeeklyLayoutChallenge"]),
    ],
    targets: [
        .target(
            name: "SwiftUIWeeklyLayoutChallenge",
            path: "."),
    ]
)
