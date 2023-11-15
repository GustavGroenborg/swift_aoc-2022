@testable import dec7

import XCTest

final class ParserTests: XCTestCase {
    var parser: Parser!
    var tokenInput: String!

    override func setUp() {
        parser = Parser(root: Directory(name: "/"))
        tokenInput = "$ cd /\n$ ls\ndir a\n14848514 b.txt\n8504156 c.dat\ndir d\n$ cd a\n$ ls\ndir e\n29116 f\n2557 g\n62596 h.lst\n$ cd e\n$ ls\n584 i\n$ cd .. \n$ cd .. \n$ cd d\n$ ls\n4060174 j\n8033020 d.log\n5626152 d.ext\n7214296 k"
    }

    override func tearDown() {
        parser = nil
    }

    func test_scanCommands() throws {
        // Given
        let input = """
        $ cd /
        $ ls
        dir a
        14848514 b.txt
        8504156 c.dat
        dir d
        $ cd a
        $ ls
        dir e
        29116 f
        2557 g
        62596 h.lst
        """
        let expected = [
            " cd /\n",
            " ls\ndir a\n14848514 b.txt\n8504156 c.dat\ndir d\n",
            " cd a\n",
            " ls\ndir e\n29116 f\n2557 g\n62596 h.lst",
        ]

        // When
        let output = parser.scanCommands(from: input)

        // Then
        XCTAssertEqual(expected, output)
    }


    /******************
     * Testing tokens *
     ******************/

    func test_Token_cd() throws {
        // Given
        let str = "$ cd /\n$ ls \ndir a\n14848514 b.txt\n8504156 c.dat\ndir d\n$ cd a\n"
        let expected = " cd /"

        // When
        guard let range = str.range(of: Tokens.cd.rawValue, options: .regularExpression) else {
            return XCTFail("Regex yielded no range: \(Tokens.cd.rawValue)")
        }
        let output = String(str[range])

        // Then
        XCTAssertEqual(expected, output) 
    }

    func test_Token_ls() throws {
        // Given
        let expected = " ls\ndir a\n14848514 b.txt\n8504156 c.dat\ndir d"

        // When
        guard let range = tokenInput.range(of: Tokens.ls.rawValue, options: .regularExpression) else {
            return XCTFail("Regex yielded no range: \(Tokens.ls.rawValue)") 
        }
        let output = String(tokenInput[range])

        // Then
        XCTAssertEqual(expected, output)
    }

    func test_Token_size() throws {
        // Given
        let expected = "14848514"

        // When
        guard let range = tokenInput.range(of: Tokens.size.rawValue, options: .regularExpression) else {
            return XCTFail("Regex yielded no range: \(Tokens.size.rawValue)")
        }
        let output = String(tokenInput[range])

        // Then
        XCTAssertEqual(expected, output)
    }

    func test_Token_dir() throws {
        // Given
        let input = "dir a"
        let expected = "a"

        // When
        guard let range = input.range(of: Tokens.dir.rawValue, options: .regularExpression) else {
            return XCTFail("Regex yielded no range: \(Tokens.dir.rawValue)")
        }
        let output = String(input[range])

        // Then
        XCTAssertEqual(expected, output)
    }

    func test_Token_fileName() throws {
        // Given
        let str = "14848514 b.txt"
        let expected = "b.txt"

        // When
        guard let range = str.range(of: Tokens.fileName.rawValue, options: .regularExpression) else {
            return XCTFail("Regex yielded no range: \(Tokens.fileName.rawValue)")
        }
        let output = String(str[range])

        // Then
        XCTAssertEqual(expected, output)
    }


    func test_parseListDirectoryContents_addFiles() throws {
        // Given
        let localParser = Parser(root: Directory(name: "/"))
        let input = localParser.scanCommands(from: tokenInput)

        let expectedDirNames = ["/", "a", "d"]
        let expectedFileNames = ["i", "f", "g", "h.lst", "b.txt", "c.dat", "j", "d.log", "d.ext", "k"]

        // When
        for str in input {
            localParser.parseCommand(from: str)
        }

        // Then
        for str in expectedDirNames {
            XCTAssertNotNil(locate(directory: str, in: localParser.root), "Could not find directory with name \(str)")
        }

        for str in expectedFileNames {
            XCTAssertNotNil(locate(file: str, in: localParser.root), "Could not find file with name \(str)")
        }
    }


    func test_puzzlenput() throws {
        // Given
        let localParser = Parser(root: Directory(name: "/"))
        let input = localParser.scanCommands(from: tokenInput)
        let expectedSum: uint64 = 95437

        // When
        for str in input {
            localParser.parseCommand(from: str)
        }

        var foundSum: uint64 = 0
        let foundDirectories = locateDirectories(lessThanOrEqualTo: 100_000, in: localParser.root)
        foundDirectories.forEach { foundSum += $0.size }

        // Then
        XCTAssertEqual(expectedSum, foundSum)

    }
}
