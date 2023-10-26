@testable import dec5

import XCTest

final class dec5Tests: XCTestCase {
    func test_produceStackInput() throws {
        // Given
        let str = """
        [a]
        [b]
        [c]
        [d]
         1 

        move 1 from 2 to 3
        """
        let subStr = str.split(separator: "\n")

        // when
        let stackInput = produceStackInput(puzzleInput: subStr)

        // Then
        XCTAssertEqual([" 1 ", "[d]","[c]","[b]","[a]"], stackInput)
    }


    func test_findStackIndices() throws {
        // Given
        let indices = " 1   2   3 "
        let expected: [Int] = [1, 5, 9]

        // When
        let output = findStackIndices(indicesStr: indices)

        // Then
        XCTAssertEqual(expected, output)
    }


    func test_initStacks() throws {
        // Given
        let input = [
            "    [c]",
            "[a] [d]",
            "[b] [e]",
            " 1   2 ",
        ]
        var expected = [Stack<Character>(array: ["b", "a"]), Stack<Character>(array: ["e", "d", "c"])]

        // when
        var output = initStacks(stackInput: input.reversed())
        print(output)
        XCTAssertFalse(output.isEmpty)

        // Then
        for _ in 0..<3 {
            XCTAssertEqual(expected[0].pop(), output[0].pop())
        }
        for _ in 0..<4 {
            XCTAssertEqual(expected[1].pop(), output[1].pop())
        }
    }


    func test_parseInstructions() throws {
        // Given
        let input = "move 10 from 2 to 1"
        let expected = (move: 10, from: 2, to: 1)

        // when
        let output = parseInstructions(from: input)

        // Then
        XCTAssertEqual(expected.move, output!.move)
        XCTAssertEqual(expected.from, output!.from)
        XCTAssertEqual(expected.to, output!.to)
    }


    func test_getUnparsedInstructions_twoInstructionsEqualCount() throws {
        // Given
        let puzzleInput = """
            [D]    
        [N] [C]    
        [Z] [M] [P]
         1   2   3 

        move 1 from 2 to 1
        move 3 from 1 to 3
        """
        let expected = ["move 1 from 2 to 1", "move 3 from 1 to 3"]
        let input = puzzleInput.split(separator: "\n")

        // When
        let output = getUnparsedInstructions(from: input)

        // Then
        XCTAssertEqual(expected.count, output.count)
    }


    func test_getUnparsedInstructions_twoInstructions() throws {
        // Given
        let puzzleInput = """
            [D]    
        [N] [C]    
        [Z] [M] [P]
         1   2   3 

        move 1 from 2 to 1
        move 3 from 1 to 3
        """
        let expected = ["move 1 from 2 to 1", "move 3 from 1 to 3"]
        let input = puzzleInput.split(separator: "\n")

        // When
        let output = getUnparsedInstructions(from: input)

        // Then
        XCTAssertEqual(expected, output)
    }


    func test_moveCrates9000_oneInstruction() {
        // Given
        let puzzleInput = """
            [D]    
        [N] [C]    
        [Z] [M] [P]
         1   2   3 

        move 1 from 2 to 1
        """
        var input = puzzleInput.split(separator: "\n")
        let stackInput = produceStackInput(puzzleInput: input)
        var expected = [
            Stack<Character>(array: ["Z", "N", "D"]),
            Stack<Character>(array: ["M", "C"]),
            Stack<Character>(array: ["P"])
        ]
        /* Expected output:
            [D]        
            [N] [C]    
            [Z] [M] [P]
             1   2   3
        */

        // When
        var stacks = initStacks(stackInput: stackInput!)
        let instructions = getUnparsedInstructions(from: input).compactMap { parseInstructions(from: $0) }
        for instruction in instructions {
            moveCrates9000(instructions: instruction, stacks: &stacks)
        }

        // Then
        for _ in 0..<3 {
            XCTAssertEqual(expected[0].pop(), stacks[0].pop())
        }
        for _ in 0..<3 {
            XCTAssertEqual(expected[1].pop(), stacks[1].pop())
        }
        for _ in 0..<2 {
            XCTAssertEqual(expected[2].pop(), stacks[2].pop())
        }
    }


    func test_moveCrates9000_twoInstructions() {
        // Given
        let puzzleInput = """
        [D]        
        [N] [C]    
        [Z] [M] [P]
         1   2   3 

        move 3 from 1 to 3
        move 2 from 2 to 1
        """
        let input = puzzleInput.split(separator: "\n")
        let stackInput = produceStackInput(puzzleInput: input)
        var expected = [
            Stack<Character>(array: ["C", "M"]),
            Stack<Character>(),
            Stack<Character>(array: ["P", "D", "N", "Z"])
        ]
        /* Expected output:
                    [Z]
                    [N]
            [M]     [D]
            [C]     [P]
             1   2   3
        */

        // When
        var stacks = initStacks(stackInput: stackInput!)
        let instructions = getUnparsedInstructions(from: input).compactMap { parseInstructions(from: $0) }
        for instruction in instructions {
            moveCrates9000(instructions: instruction, stacks: &stacks)
        }

        // Then
        for _ in 0..<3 {
            XCTAssertEqual(expected[0].pop(), stacks[0].pop())
        }

        XCTAssertEqual(expected[1].pop(), stacks[1].pop())

        for _ in 0..<5 {
            XCTAssertEqual(expected[2].pop(), stacks[2].pop())
        }

    }
}
