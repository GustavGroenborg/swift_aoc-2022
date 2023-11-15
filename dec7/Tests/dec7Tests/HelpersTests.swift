@testable import dec7

import XCTest

final class HelpersTest: XCTestCase {
    var root: Directory!
    var dirA: Directory!
    var dirD: Directory!
    var dirE: Directory!

    override func setUp() {
        // Gotta love the smell of duplicate test-code...
        root = Directory(name: "/")
        root.add(file: DeviceFile(name: "b.txt", size: 14848514))
        root.add(file: DeviceFile(name: "c.dat", size: 8504156))
        
        dirD = Directory(name: "d", parent: root)

        dirE = Directory(name: "e")
        dirE.add(file: DeviceFile(name: "i", size: 584))

        dirA = Directory(name: "a")
        dirA.add(directory: dirE)
        dirA.add(file: DeviceFile(name: "f", size: 29116))
        dirA.add(file: DeviceFile(name: "g", size: 2557))
        dirA.add(file: DeviceFile(name: "h.lst", size: 62596))
        root.add(directory: dirA)

        dirD.add(file: DeviceFile(name: "j", size: 4060174))
        dirD.add(file: DeviceFile(name: "d.log", size: 8033020))
        dirD.add(file: DeviceFile(name: "d.ext", size: 5626152))
        dirD.add(file: DeviceFile(name: "k", size: 7214296))
    }


    override func tearDown() {
        root = nil
    }


    func deprecated_test_locateDirectory() throws {
        // Given
        let root = Directory(name: "/")
        let dirA = Directory(name: "a", parent: root)
        dirA.add(directory: Directory(name: "e", parent: dirA))
        let dirD = Directory(name: "d", parent: root)
        let dirF = Directory(name: "f", parent: dirD)

        // When
        guard let foundDir = locate(directory: "f", in: root) else {
            return XCTFail("Could not find directory of name \(dirF.name).")
        }

        // Then
        XCTAssertTrue(dirF === foundDir)
    }

    func test_locateCurrentDirectoryInCurrentDirectory() throws {
        // Given
        let dirName = root.name

        // When
        guard let foundDir = locate(directory: dirName, in: root) else {
            return XCTFail("Could not find directory of name \(dirName).")
        }

        // Then
        XCTAssertTrue(root === foundDir)
    }


    func test_locateDirectoryAtDepth0() throws {
        // Given
        let dirName = dirD.name

        // When
        guard let foundDir = locate(directory: dirName, in: root) else {
            return XCTFail("Could not find directory of name \(dirName).")
        }

        // Then
        XCTAssertTrue(dirD === foundDir)
    }

    func test_locateDirectoryAtDepth1() throws {
        // Given
        let dirName = dirE.name

        // When
        guard let foundDir = locate(directory: dirName, in: root) else {
            return XCTFail("Could not find directory of name \(dirName).")
        }

        // Then
        XCTAssertTrue(dirE === foundDir)
    }


    func test_locateFileAtDepth0() throws {
        // Given
        let fileName = root.files[0].name

        // When
        guard let foundFile = locate(file: fileName, in: root) else {
            return XCTFail("Could not find file with name: \(fileName).")
        }

        // Then
        XCTAssertTrue(root.files[0] === foundFile)

    }


    func test_locateFileAtDepth1() throws {
        // Given
        let fileName = dirA.files[0].name

        // When
        guard let foundFile = locate(file: fileName, in: root) else {
            return XCTFail("Could not find file with name: \(fileName).")
        }

        // Then
        XCTAssertTrue(dirA.files[0] === foundFile)
    }


    func test_locateDirectoriesLessThanSize() throws {
        // Given
        let expected: [Directory] = [dirA, dirE]

        // When
        let found = locateDirectories(lessThan: 100_000, in: root)
        guard found.count == expected.count else {
            return XCTFail("Did not find the expected amount of directories. Found: \(found.count), Expected: \(expected.count)")
        }

        // Then
        XCTAssertTrue((expected[0] === found[0]) || expected[0] === found[1])
        XCTAssertTrue((expected[1] === found[0]) || expected[1] === found[1])
    }
}