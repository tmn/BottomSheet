// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BottomSheet",
    platforms: [
        .iOS(.v13), .macOS(.v10_15)
    ],
    products: [
        .library(
            name: "BottomSheet",
            targets: ["BottomSheet"]),
    ],
    targets: [
        .target(
            name: "BottomSheet",
            dependencies: []),
        .testTarget(
            name: "BottomSheetTests",
            dependencies: ["BottomSheet"]),
    ]
)
