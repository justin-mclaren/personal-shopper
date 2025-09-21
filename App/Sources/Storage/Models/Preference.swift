import Foundation
import GRDB

struct Preference: Codable, FetchableRecord, PersistableRecord, Identifiable {
    var id: Int64?
    var profileId: Int64
    var key: String
    var value: String
}
