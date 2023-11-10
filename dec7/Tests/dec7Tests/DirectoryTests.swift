@testable import dec7

import XCTest

final class DirectoryTests: XCTestCase {

    func test_aocExample() throws {
        // Given
        let expectedSize: uint64 = 48381165

        // When
        let root = Directory(name: "/")
        root.add(file: DeviceFile(name: "b.txt", size: 14848514))
        root.add(file: DeviceFile(name: "c.dat", size: 8504156))
        
        let dirD = Directory(name: "d", parent: root)

        let dirE = Directory(name: "e")
        dirE.add(file: DeviceFile(name: "i", size: 584))

        let dirA = Directory(name: "a")
        dirA.add(directory: dirE)
        dirA.add(file: DeviceFile(name: "f", size: 29116))
        dirA.add(file: DeviceFile(name: "g", size: 2557))
        dirA.add(file: DeviceFile(name: "h.lst", size: 62596))
        root.add(directory: dirA)

        dirD.add(file: DeviceFile(name: "j", size: 4060174))
        dirD.add(file: DeviceFile(name: "d.log", size: 8033020))
        dirD.add(file: DeviceFile(name: "d.ext", size: 5626152))
        dirD.add(file: DeviceFile(name: "k", size: 7214296))

        // Then
        XCTAssertEqual(root.size, expectedSize)
    }


    func test_updateSizeAddFile() throws {
        // Given
        let root = Directory(name: "/")
        let fileSize: uint64 = 1234

        // When
        root.add(file: DeviceFile(name: "foo.bar", size: fileSize))

        // Then
        XCTAssertEqual(root.size, fileSize)
    }


    func test_updateSizeAddDirectoryWithThreeFiles() throws {
        // Given
        let root = Directory(name: "/")
        let fileSizeA: uint64 = 20
        let fileSizeB: uint64 = 30
        let fileSizeC: uint64 = 40
        let expectedSize = fileSizeA + fileSizeB + fileSizeC
        let dirA = Directory(name: "a")
        dirA.add(file: DeviceFile(name: "fa", size: fileSizeA))
        dirA.add(file: DeviceFile(name: "fb", size: fileSizeB))
        dirA.add(file: DeviceFile(name: "fc", size: fileSizeC))

        // When
        root.add(directory: dirA)

        // Then
        XCTAssertEqual(root.size, expectedSize)
    }


    func test_AddDirectoryThenAddFiles() throws {
        // Given
        let sizeA: uint64 = 10
        let sizeB: uint64 = 20
        let sizeC: uint64 = 30
        let sizeD: uint64 = 40
        let expectedSize = sizeA + sizeB + sizeC + sizeD

        let root = Directory(name: "/")
        root.add(file: DeviceFile(name: "a", size: sizeA))
        let dir = Directory(name: "dir", parent: root)

        // When
        dir.add(file: DeviceFile(name: "b", size: sizeB))
        dir.add(file: DeviceFile(name: "c", size: sizeC))
        dir.add(file: DeviceFile(name: "d", size: sizeD))

        // Then
        XCTAssertEqual(root.size, expectedSize)
    }

}