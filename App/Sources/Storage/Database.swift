import Foundation
import GRDB

final class DatabaseManager {
    static let shared = DatabaseManager()

    let dbQueue: DatabaseQueue

    private init() {
        let fileManager = FileManager.default
        let supportURL = try! fileManager.url(
            for: .applicationSupportDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: true
        )
        let databaseURL = supportURL.appendingPathComponent("aishopper.sqlite")
        dbQueue = try! DatabaseQueue(path: databaseURL.path)
        try? migrator.migrate(dbQueue)
    }
}
