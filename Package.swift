// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CWRateKit",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(name: "CWRateKit", targets: ["CWRateKit"])
    ],
    targets: [
        .target(name: "CWRateKit", path: "CWRateKit"),
    ],
    swiftLanguageVersions: [.v5]
)
