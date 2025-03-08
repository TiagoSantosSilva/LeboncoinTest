// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "LeboncoinUIKit",
    platforms: [
        .iOS(.v16) // Ensures compatibility with iOS 16+
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
            path: "Sources", // Ensure the correct path
            exclude: [], // No exclusions needed
            sources: ["Extensions"], // Explicitly include Extensions folder
            resources: []
        ),
        .testTarget(
            name: "LeboncoinUIKitTests",
            dependencies: ["LeboncoinUIKit"]
        ),
    ]
)
