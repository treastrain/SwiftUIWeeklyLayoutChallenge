// swift-tools-version: 5.5

import PackageDescription

let package = Package(
    name: "SwiftUIWeeklyLayoutChallenge",
    defaultLocalization: "ja",
    platforms: [.iOS(.v14), .macOS(.v10_15), .macCatalyst(.v14), .tvOS(.v13), .watchOS(.v7)],
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
