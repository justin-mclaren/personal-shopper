import XCTest

final class UITests: XCTestCase {
    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        XCTAssertTrue(app.textFields.firstMatch.exists)
    }
}
