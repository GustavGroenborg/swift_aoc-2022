@testable import dec4

import XCTest

final class dec4Tests: XCTestCase {
    func disabled_test_ClosedRangeFullyContains_partialContainment() throws {
        // Given
        let a = 2...6
        
        // when
        let b = 4...8

        // Then
        XCTAssertFalse(a.fullyContains(b))
    }

    func disabled_test_ClosedRangeFullyContains_fullContainment() throws {
        // Given
        let a = 2...8

        // When
        let b = 3...7

        // Then
        XCTAssertTrue(a.fullyContains(b))
    }

    func disabled_test_ClosedRangeFullyContains_noContainment() throws {
        // Given
        let a = 2...3

        // When
        let b = 4...5

        // Then
        XCTAssertFalse(a.fullyContains(b))
    }
}
