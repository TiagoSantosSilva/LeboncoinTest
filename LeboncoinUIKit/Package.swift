// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LeboncoinUIKit",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "LeboncoinUIKit",
            targets: ["LeboncoinUIKit"]
        ),
    ],
    targets: [
        .target(
            name: "LeboncoinUIKit",
            path: "Sources",
            exclude: [],
            sources: [
                "Extensions",
                "Enumerations"
            ],
            resources: []
        ),
        .testTarget(
            name: "LeboncoinUIKitTests",
            dependencies: ["LeboncoinUIKit"]
        ),
    ]
)
