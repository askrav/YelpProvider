// swift-tools-version:4.2
import PackageDescription

let package = Package(
    name: "YelpProvider",
    products: [
        .library(name: "YelpProvider", targets: ["YelpProvider"])
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "3.0.0"),
    ],
    targets: [
        .target(name: "YelpProvider", dependencies: ["Vapor"]),
        .testTarget(name: "YelpProviderTests", dependencies: ["Vapor", "YelpProvider"]),
    ]
)
