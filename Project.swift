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
        .target(
            name: "AppTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "\(bundleId).tests",
            sources: ["App/Tests/AppTests/**"],
            dependencies: [.target(name: appName)]
        ),
        .target(
            name: "UITests",
            destinations: .iOS,
            product: .uiTests,
            bundleId: "\(bundleId).uitests",
            sources: ["App/Tests/UITests/**"],
            dependencies: [.target(name: appName)]
        )
    ]
)
