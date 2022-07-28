// swift-tools-version: 5.5

import PackageDescription

let package = Package(
    name: "SwiftUIWeeklyLayoutChallenge",
    defaultLocalization: "ja",
    platforms: [.iOS(.v14), .macOS(.v11), .macCatalyst(.v13), .tvOS(.v14), .watchOS(.v7)],
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
