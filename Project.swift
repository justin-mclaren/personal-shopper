import ProjectDescription

let appName = "AIShopperBrowser"
let bundleId = "com.aishopper.browser"
let organizationName = "AI Shopper"

let project = Project(
    name: appName,
    organizationName: organizationName,
    packages: [
        .remote(url: "https://github.com/groue/GRDB.swift", requirement: .upToNextMajor(from: "6.0.0")),
        .remote(url: "https://github.com/kean/Pulse", requirement: .upToNextMajor(from: "4.0.0"))
    ],
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
                .package(product: "GRDB"),
                .package(product: "Pulse")
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
    ],
    schemes: [
        Scheme.scheme(
            name: "\(appName)-Debug",
            buildAction: .buildAction(targets: [
                .target(appName),
                "AppTests",
                "UITests"
            ]),
            testAction: .targets([
                "AppTests",
                "UITests"
            ]),
            runAction: .runAction(
                configuration: .debug,
                executable: .target(appName)
            ),
            archiveAction: .archiveAction(configuration: .release),
            profileAction: .profileAction(
                configuration: .release,
                executable: .target(appName)
            ),
            analyzeAction: .analyzeAction(configuration: .debug)
        ),
        Scheme.scheme(
            name: "\(appName)-Release",
            buildAction: .buildAction(targets: [
                .target(appName)
            ]),
            runAction: .runAction(
                configuration: .release,
                executable: .target(appName)
            ),
            archiveAction: .archiveAction(configuration: .release),
            profileAction: .profileAction(
                configuration: .release,
                executable: .target(appName)
            ),
            analyzeAction: .analyzeAction(configuration: .release)
        )
    ]
)
