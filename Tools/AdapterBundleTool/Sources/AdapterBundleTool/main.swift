import Foundation

struct Adapter: Codable {
    let hostPattern: String
    let actions: [String: String]
}

struct AdapterBundleTool {
    func run(outputPath: String = "App/Resources/adapters.json") throws {
        let adapters: [Adapter] = []

        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]

        let data = try encoder.encode(adapters)
        let outputURL = URL(fileURLWithPath: outputPath)
        try data.write(to: outputURL)

        print("Wrote adapters bundle to \(outputURL.path)")
    }
}

@main
struct AdapterBundleCommand {
    static func main() throws {
        try AdapterBundleTool().run()
    }
}
