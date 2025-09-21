import XCTest
@testable import AdapterBundleTool

final class AdapterBundleToolTests: XCTestCase {
    func testProducesBundleFile() throws {
        let path = "App/Resources/adapters.json"
        try? FileManager.default.removeItem(atPath: path)

        try AdapterBundleTool().run(outputPath: path)

        XCTAssertTrue(FileManager.default.fileExists(atPath: path))
        try FileManager.default.removeItem(atPath: path)
    }
}
