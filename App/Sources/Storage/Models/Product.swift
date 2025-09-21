import Foundation
import GRDB

struct Product: Codable, FetchableRecord, PersistableRecord, Identifiable {
    var id: Int64?
    var host: String
    var url: String
    var title: String?
    var priceCents: Int?
    var metaJSON: String?
}
