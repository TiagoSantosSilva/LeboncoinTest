// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Ads",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Ads",
            targets: ["Ads"]),
    ],
    dependencies: [
        .package(path: "../LeboncoinUIKit"),
        .package(path: "../Network"),
        .package(path: "../Pandora")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Ads",
            dependencies: [
                "LeboncoinUIKit",
                "Network",
                "Pandora"
            ],
            sources: ["Public"]
        ),
        .testTarget(
            name: "AdsTests",
            dependencies: ["Ads"]
        ),
    ]
)
