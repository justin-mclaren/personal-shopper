import Foundation

let fileManager = FileManager.default
let scriptsDirectory = URL(fileURLWithPath: "App/Sources/Browser/UserScripts")
let resourcesDirectory = URL(fileURLWithPath: "App/Resources")

let scriptNames = ["boot.js", "adapter-loader.js", "readability.js"]

for name in scriptNames {
    let sourceURL = scriptsDirectory.appendingPathComponent(name)
    let destinationURL = resourcesDirectory.appendingPathComponent(name)

    guard fileManager.fileExists(atPath: sourceURL.path) else { continue }

    if fileManager.fileExists(atPath: destinationURL.path) {
        try? fileManager.removeItem(at: destinationURL)
    }

    try fileManager.copyItem(at: sourceURL, to: destinationURL)
}
