import XCTest
@testable import dotLottie

final class dotLottieTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(dotLottie().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
