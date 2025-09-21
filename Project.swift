import ProjectDescription

let appName = "AIShopperBrowser"
let bundleId = "com.aishopper.browser"
let organizationName = "AI Shopper"

let project = Project(
    name: appName,
    organizationName: organizationName,
    targets: [
        .target(
            name: appName,
            destinations: .iOS,
            product: .app,
            bundleId: bundleId,
            infoPlist: .extendingDefault(with: [
                "UIMainStoryboardFile": "",
                "UIApplicationSceneManifest": .dictionary([:]),
                "UILaunchScreen": .dictionary([:]),
                "ITSAppUsesNonExemptEncryption": .boolean(false)
            ]),
            sources: ["App/Sources/**"],
            resources: ["App/Resources/**"],
            scripts: [
                .pre(script: "bash Scripts/prebuild.sh", name: "Prebuild"),
                .pre(script: "swift Scripts/embed_user_scripts.swift", name: "EmbedUserScripts")
            ],
            dependencies: [
                .external(name: "GRDB"),
                .external(name: "Pulse")
            ]
        ),
        .unitTests(
            name: "AppTests",
            bundleId: "\(bundleId).tests",
            sources: ["App/Tests/AppTests/**"],
            dependencies: [.target(name: appName)]
        ),
        .uiTests(
            name: "UITests",
            bundleId: "\(bundleId).uitests",
            sources: ["App/Tests/UITests/**"],
            dependencies: [.target(name: appName)]
        )
    ],
    packages: [
        .package(url: "https://github.com/groue/GRDB.swift", .upToNextMajor(from: "6.0.0")),
        .package(url: "https://github.com/kean/Pulse", .upToNextMajor(from: "4.0.0"))
    ]
)
