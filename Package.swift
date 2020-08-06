// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "dotLottie",
    platforms: [
        .iOS(.v9),
        .macOS(.v10_12),
        .tvOS(.v9)
    ],
    products: [
        .library(
            name: "dotLottie",
            targets: ["dotLottie"]),
    ],
    dependencies: [
        .package(name: "Lottie", url: "https://github.com/airbnb/lottie-ios.git", from: "3.1.5"),
        .package(name: "dotLottie", url: "https://github.com/marmelroy/Zip.git", from: "2.0.0"),
    ],
    targets: [
        .target(
            name: "dotLottie",
            dependencies: ["Lottie", "Zip"]),
        .testTarget(
            name: "dotLottieTests",
            dependencies: ["dotLottie"]),
    ]
)
