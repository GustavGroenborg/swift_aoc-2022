// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "dec3",
    dependencies: [],
    targets: [
        .executableTarget(
            name: "dec3"),
        .testTarget(
            name: "dec3Tests",
            dependencies: ["dec3"]),
    ]
)
