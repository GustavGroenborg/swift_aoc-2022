@testable import dec7

import XCTest

final class HelpersTest: XCTestCase {
    func test_locateDirectory() throws {
        // Given
        var root = Directory(name: "/")
        var dirA = Directory(name: "a", parent: root)
        var dirE = Directory(name: "e", parent: dirA)
        var dirD = Directory(name: "d", parent: root)
        var dirF = Directory(name: "f", parent: dirD)

        // When
        guard let foundDir = locate(directory: "f", in: root) else {
            return XCTFail("Could not find directory of name \(dirF.name).")
        }

        // Then
        XCTAssertTrue(dirF === foundDir)
    }
}