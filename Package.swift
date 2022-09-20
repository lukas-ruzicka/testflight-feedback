// swift-tools-version: 5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "testflight-feedback",
    platforms: [
        .macOS(.v12)
    ],
    products: [
        .executable(name: "testflight-feedback", targets: ["Run"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.1.4"),
        .package(url: "https://github.com/jedisct1/swift-sodium", from: "0.9.1")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .executableTarget(
            name: "Run",
            dependencies: ["FetchFeedback", "Authorize", "ClearScreenshots", "Utils", .product(name: "ArgumentParser", package: "swift-argument-parser")]),
        .target(
            name: "FetchFeedback",
            dependencies: ["Utils"]),
        .testTarget(
            name: "FetchFeedbackTests",
            dependencies: ["FetchFeedback"]),
        .target(name: "Authorize",
                dependencies: ["Utils", .product(name: "Sodium", package: "swift-sodium")]),
        .target(
            name: "ClearScreenshots",
            dependencies: ["Utils"]),
        .target(name: "Utils")
    ]
)
