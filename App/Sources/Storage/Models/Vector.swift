import Foundation
import GRDB

struct Vector: Codable, FetchableRecord, PersistableRecord, Identifiable {
    var id: Int64?
    var productId: Int64
    var dim: Int
    var vec: Data
}
