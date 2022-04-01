// swift-tools-version: 5.5

import PackageDescription


let package = Package(
    name: "API",
    platforms: [
        .macOS("10.15")
    ],
    products: [
        .executable(name: "API", targets: ["API"])
    ],
    dependencies: [
        .package(url: "https://github.com/swift-server/swift-aws-lambda-runtime.git", .upToNextMajor(from:"0.5.0")),
        .package(url: "https://github.com/apple/swift-nio.git", from: "2.0.0")
    ],
    targets: [
        .executableTarget(
            name: "API",
            dependencies: [
                .product(name: "AWSLambdaRuntime", package: "swift-aws-lambda-runtime"),
                .product(name: "AWSLambdaEvents", package: "swift-aws-lambda-runtime"),
                .product(name: "NIOCore", package: "swift-nio")
            ]
        )
    ]
)
