import Foundation

struct SiteAction {
    let identifier: String
    let javascript: String
}

struct AutomationEvent {
    let name: String
    let context: [String: Any]
}

protocol SiteAdapter {
    var hostPatterns: [String] { get }
    func actions(for event: AutomationEvent) -> [SiteAction]
}

enum SiteAdapterLoader {
    static func loadAdapters() -> [SiteAdapter] {
        // In a production app this would parse signed metadata or load from disk.
        // The scaffold returns an empty array, ready to be extended.
        []
    }

    static func matchAdapter(for host: String, adapters: [SiteAdapter]) -> SiteAdapter? {
        adapters.first { adapter in
            adapter.hostPatterns.contains { pattern in
                host.range(of: pattern, options: [.caseInsensitive, .regularExpression]) != nil
            }
        }
    }
}
