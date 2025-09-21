import Foundation
import Pulse

enum Log {
    static let store = LoggerStore()
    static let logger = Logger(label: "ai.browser")

    static func info(_ message: String) {
        logger.log(level: .info, message: message)
    }

    static func error(_ message: String) {
        logger.log(level: .error, message: message)
    }
}
