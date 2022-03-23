// swift-tools-version: 5.5
import PackageDescription

let package = Package(
    name: "DebugPane_Pulse",
    platforms: [
        .iOS(.v14),
    ],
    products: [
        .library(
            name: "DebugPane_Pulse",
            targets: ["DebugPane_Pulse"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/antranapp/DebugPane", .branch("master")),
        .package(
            url: "https://github.com/kean/Pulse",
            .upToNextMajor(from: "0.20.0")
        ),
    ],
    targets: [
        .target(
            name: "DebugPane_Pulse",
            dependencies: [
                "DebugPane",
                "Pulse",
                .product(name: "PulseUI", package: "Pulse"),
            ]
        ),
        .testTarget(
            name: "DebugPane_PulseTests",
            dependencies: ["DebugPane_Pulse"]
        ),
    ]
)
