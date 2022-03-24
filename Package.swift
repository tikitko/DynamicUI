// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "DynamicUI",
    platforms: [
        .iOS(.v15),
    ],
    products: [
        .library(
            name: "DynamicUI",
            targets: ["DynamicUI"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "DynamicUI",
            dependencies: [],
            path: "Sources"
        ),
    ]
)
