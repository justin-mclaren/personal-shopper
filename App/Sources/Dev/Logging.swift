import Foundation
import Logging
import Pulse
import PulseLogHandler

enum Log {
    static let store: LoggerStore = .shared

    private static let bootstrap: Void = {
        LoggingSystem.bootstrap { label in
            PersistentLogHandler(label: label, store: store)
        }
    }()

    static let logger: Logger = {
        _ = bootstrap
        return Logger(label: "ai.browser")
    }()

    static func info(_ message: String) {
        logger.info("\(message)")
    }

    static func error(_ message: String) {
        logger.error("\(message)")
    }
}
