@testable import dec4

import XCTest

final class ase10Tests: XCTestCase {
    func test_eg() throws {
        // Given
        let a = 2

        // When
        let b = 2

        // Then
        XCTAssertEqual(a, b)
    }


    func test_ClosedRangeFullyContains_fullContainment() throws {
        // Given
        let a = 1...8

        // When
        let b = 3...5

        // Then
        XCTAssertTrue(a.fullyContains(b))
    }


    func test_ClosedRangeFullyContains_fullSeparation() throws {
        // Given
        let a = 1...3

        // When
        let b = 4...6

        // Then
        XCTAssertFalse(a.fullyContains(b))
    }

    func test_ClosedRangeFullyContains_partialUpperboundContainment() throws {
        // Given
        let a = 1...4

        // When
        let b = 2...6

        // Then
        XCTAssertFalse(a.fullyContains(b))
    }

    func test_ClosedRangeFullyContains_partialLowerboundContainment() throws {
        // Given
        let a = 2...6

        // When
        let b = 1...4

        // Then
        XCTAssertFalse(a.fullyContains(b))
    }

    func test_ClosedRangeFullyContains_onLowerbound() throws {
        // Given
        let a = 2...4

        // When
        let b = 2...2

        // Then
        XCTAssertTrue(a.fullyContains(b))
    }

    func test_ClosedRangeFullyContains_onUpperbound() throws {
        // Given
        let a = 2...4

        // When
        let b = 4...4

        // Then
        XCTAssertTrue(a.fullyContains(b))
    }

    func test_ClosedRangeFullyContains_continuedRanges() throws {
        // Given
        let a = 2...4

        // When
        let b = 4...6

        // Then
        XCTAssertFalse(a.fullyContains(b))
    }

    func test_ClosedRangeFullyContains_identicalRanges() throws {
        // Given
        let a = 6...6

        // When
        let b = 6...6

        // Then
        XCTAssertTrue(a.fullyContains(b))
    }



}
