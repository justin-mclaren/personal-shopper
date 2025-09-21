import Foundation

struct Adapter: Codable {
    let hostPattern: String
    let actions: [String: String]
}

let adapters: [Adapter] = []

let encoder = JSONEncoder()
encoder.outputFormatting = [.prettyPrinted, .sortedKeys]

let data = try encoder.encode(adapters)
let outputURL = URL(fileURLWithPath: "App/Resources/adapters.json")
try data.write(to: outputURL)

print("Wrote adapters bundle to \(outputURL.path)")
