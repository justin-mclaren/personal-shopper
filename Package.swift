// swift-tools-version: 5.10
import PackageDescription

let package = Package(
    name: "AIShopperTools",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .executable(name: "adapter-bundle", targets: ["AdapterBundleTool"])
    ],
    dependencies: [],
    targets: [
        .executableTarget(
            name: "AdapterBundleTool",
            path: "Tools/AdapterBundleTool/Sources"
        ),
        .testTarget(
            name: "AdapterBundleToolTests",
            dependencies: ["AdapterBundleTool"],
            path: "Tools/AdapterBundleTool/Tests"
        ),
        .testTarget(
            name: "BuildVerificationTests",
            path: "Tests/BuildVerificationTests"
        )
    ]
)
