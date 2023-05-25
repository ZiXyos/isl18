import XCTest
@testable import Isl;

final class islTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Isl18(lang: ["fr", "en", "esp"]).text, "Hello, World!")
    }
}
