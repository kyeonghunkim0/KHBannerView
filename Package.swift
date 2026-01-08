// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "KHBannerView",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "KHBannerView",
            targets: ["KHBannerView"]
        ),
    ],
    targets: [
        .target(
            name: "KHBannerView",
            path: "KHBannerView",
            exclude: ["KHBannerView.h"]
        ),
        .testTarget(
            name: "KHBannerViewTests",
            dependencies: ["KHBannerView"]
        ),
    ]
)
