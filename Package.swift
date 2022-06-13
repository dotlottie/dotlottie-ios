// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "dotLottie",
    platforms: [
        .iOS(.v11),
        .macOS(.v10_12),
        .tvOS(.v9)
    ],
    products: [
        .library(
            name: "dotLottie",
            targets: ["dotLottie"]),
    ],
    dependencies: [
        .package(name: "Lottie", url: "https://github.com/airbnb/lottie-ios.git", from: "3.3.0"),
        .package(name: "dotLottieLoader", url: "https://github.com/dotLottie/dotLottieLoader", from: "0.1.8"),
    ],
    targets: [
        .target(
            name: "dotLottie",
            dependencies: ["Lottie", "dotLottieLoader"]),
        .testTarget(
            name: "dotLottieTests",
            dependencies: ["dotLottie"]),
    ]
)
