@testable import dec3
import XCTest

final class dec3Tests: XCTestCase {
    func test_eg() throws {
        // Given
        let a = 2

        // When
        let b = a + a

        // Then
        XCTAssertEqual(b, a * a)
    }


    func test_computePriority() throws {
        // Given
        let chars: [Character] = ["a", "A", "z", "Z"]
        let expected: [uint8] = [1, 27, 26, 52]

        // Then
        for i in 0...3 {
            XCTAssertEqual(computePriority(char: chars[i]), expected[i])
        }
    }


    func test_splitEvenString() throws {
        // Given
        let str = "foobar"

        // When
        let output = splitString(inp: str)

        // Then
        XCTAssertEqual(output.0.count, output.1.count)
    }


    func test_splitUnevenString() throws {
        // Given
        let str = "foobarfoo"

        // When
        let output = splitString(inp: str)

        // Then
        XCTAssertEqual(output.0.count, output.1.count - 1)
    }


    func test_countedPriorities() throws {
        // Given
        let input: [uint8] = [1, 27, 27, 26, 26, 26, 52, 52, 52, 52]
        var expected: [uint8] = Array(repeating: 0, count: 52)
        expected[1 - 1] = 1
        expected[27 - 1] = 2
        expected[26 - 1] = 3
        expected[52 - 1] = 4

        // When
        let output = countPriorities(rucksack: input) 

        // Then
        XCTAssertEqual(output, expected)
    }


    func test_foo() throws {
        let str = "foooar"
        let start = str.startIndex
        let middle = str.index(start, offsetBy: str.count / 2)

        let substrL = str[start..<middle]
        let substrR = str[middle...]

        XCTAssertEqual(substrL, "foo")
        XCTAssertEqual(substrR, "obar")
    }

}
