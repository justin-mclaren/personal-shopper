import ProjectDescription

let dependencies = Dependencies(
    swiftPackageManager: [
        .remote(url: "https://github.com/groue/GRDB.swift", requirement: .upToNextMajor(from: "6.0.0")),
        .remote(url: "https://github.com/kean/Pulse", requirement: .upToNextMajor(from: "4.0.0"))
    ],
    platforms: [.iOS]
)
