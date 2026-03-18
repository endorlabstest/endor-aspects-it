// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "VulnDemo",
    products: [
        .executable(name: "VulnDemoApp", targets: ["VulnDemoApp"]),
        .library(name: "VulnDemoLib", targets: ["VulnDemoLib"]),
    ],
    dependencies: [
        .package(url: "https://github.com/beatt83/jose-swift.git", exact: "4.0.0"),
        .package(url: "https://github.com/apple/swift-nio-http2.git", exact: "1.27.0"),
        .package(url: "https://github.com/vapor/leaf-kit.git", exact: "1.4.0"),
        .package(url: "https://github.com/apple/swift-collections.git", exact: "1.1.4"),
    ],
    targets: [
        .target(
            name: "Models",
            path: "Sources/Models"
        ),
        .target(
            name: "Networking",
            dependencies: [
                .product(name: "NIOHTTP2", package: "swift-nio-http2"),
            ],
            path: "Sources/Networking"
        ),
        .target(
            name: "VulnDemoLib",
            dependencies: [
                "Models",
                "Networking",
                .product(name: "jose-swift", package: "jose-swift"),
                .product(name: "NIOHTTP2", package: "swift-nio-http2"),
                .product(name: "LeafKit", package: "leaf-kit"),
            ],
            path: "Sources/VulnDemoLib"
        ),
        .executableTarget(
            name: "VulnDemoApp",
            dependencies: [
                "VulnDemoLib",
                "Models",
                "Networking",
            ],
            path: "Sources/VulnDemoApp"
        ),
        .testTarget(
            name: "VulnDemoTests",
            dependencies: ["VulnDemoLib"],
            path: "Tests/VulnDemoTests"
        ),
    ]
)
