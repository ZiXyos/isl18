import XCTest
@testable import Isl;

final class islTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Isl18(lang: ["fr", "en", "esp"]).text, "Hello, World!")
    }
	
	func testDoesLangExist() throws {
		let islConf = IslConfig(lang: []);
		XCTAssert(islConf.doesLangExist());
	}
	
	func testIsFrDirectory() throws {
		
		let isl = IslConfig(lang: ["fr"]);
		let res = isl.doesLocalFolderExist();
		switch res {
		case .success(_):
			XCTAssert(true);
		case .failure(_):
			XCTAssert(false);
		}
	}
	
	func testIslEnDoNotExist() throws {
		let isl = IslConfig(lang: ["en"]);
		let res = isl.doesLocalFolderExist();
		switch res {
		case .success(_):
			XCTAssert(true);
		case .failure(_):
			XCTAssert(false);
		}
	}
}
