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


    func disabled_test_foo() throws {
        let str = "foooar"
        let start = str.startIndex
        let middle = str.index(start, offsetBy: str.count / 2)

        let substrL = str[start..<middle]
        let substrR = str[middle...]

        XCTAssertEqual(substrL, "foo")
        XCTAssertEqual(substrR, "obar")
    }


    func test_compare3PriorityArrays() {
        // Given
        /*
        let lines = ["vJrwpWtwJgWrhcsFMMfFFhFp", 
            "jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL", 
            "PmmdzqPrVvPwwTWBwg"]
            */
        let lines = ["wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn",
            "ttgJtRGJQctTZtZT",
            "CrZsJsPPZsGzwwsLwLmpwMDw"]
        let elf1 = countPriorities(rucksack: convertToPriorityArray(str: lines[0]))
        let elf2 = countPriorities(rucksack: convertToPriorityArray(str: lines[1]))
        let elf3 = countPriorities(rucksack: convertToPriorityArray(str: lines[2]))
        let expected = 52

        print(elf1)
        print(elf2)
        print(elf3)

        // When
        let output = comparePriorities(a: elf1, b: elf2, c: elf3)

        // Then
        XCTAssertEqual(output, expected)
    }

}
