@testable import dec7

import XCTest

final class ParserTests: XCTestCase {
    var parser: Parser!
    var tokenInput: String!

    override func setUp() {
        parser = Parser()
        tokenInput = "$ cd /\n$ ls\ndir a\n14848514 b.txt\n8504156 c.dat\ndir d\n$ cd a\n$ ls\ndir e\n29116 f\n2557 g\n62596 h.lst"
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
        let expected = "$ cd /"

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
        let expected = "$ ls\ndir a\n14848514 b.txt\n8504156 c.dat\ndir d"

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
        let expected = "a"

        // When
        guard let range = tokenInput.range(of: Tokens.dir.rawValue, options: .regularExpression) else {
            return XCTFail("Regex yielded no range: \(Tokens.dir.rawValue)")
        }
        let output = String(tokenInput[range])

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


    func test_parseDirectory() throws {
        // Given
        let input = "cd foo"


    }
}
