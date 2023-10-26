@testable import dec5

import XCTest

final class StackTest: XCTestCase {
    func test_emptyStack() throws {
        // Given
        let stack = Stack<Int>()

        // Then
        XCTAssertTrue(stack.isEmpty)
    }

    func test_PopEmptyStackReturnsNil() throws {
        // Given
        var stack = Stack<Int>()

        // Then
        XCTAssertNil(stack.pop())
    }

    func test_PeepReturnsTopElement() throws {
        // Given
        let el = 42
        var stack = Stack<Int>()

        // When
        stack.push(el)

        // Then
        XCTAssertEqual(stack.peek(), el)
    }

    func test_InitWithElement() throws {
        // Given
        let el = 42

        // When
        let stack = Stack(element: el)

        // Then
        XCTAssertFalse(stack.isEmpty)
    }

    func test_InitWithArray() throws {
        // Given
        let arr = [1, 2, 3, 4, 5]

        // When
        let stack = Stack(array: arr)

        // Then
        XCTAssertFalse(stack.isEmpty)
    }

    func test_InitWithArrayAndPop() throws {
        // Given
        let arr = [1, 2, 3, 4, 5]

        // When
        var stack = Stack(array: arr)

        // Then
        XCTAssertEqual(arr[arr.count - 1], stack.pop())
    }
}