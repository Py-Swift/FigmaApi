// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "FigmaApi",
    platforms: [
        .macOS(.v13),
    ],
    products: [
        .library(name: "FigmaApi", targets: ["FigmaApi"]),
    ],
    targets: [
        .target(
            name: "FigmaApi",
            path: "Sources/FigmaApi"
        ),
        .testTarget(
            name: "FigmaApiTests",
            dependencies: ["FigmaApi"],
            path: "Tests/FigmaApiTests",
            resources: [
                .copy("Fixtures"),
            ]
        ),
    ]
)
