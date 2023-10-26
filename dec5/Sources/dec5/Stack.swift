import Foundation

public struct Stack<T> {
    var isEmpty: Bool {
        contents.isEmpty
    }

    private var contents: Array<T> = []

    func peek() -> T? {
        if contents.isEmpty {
            return nil
        } else {
            return contents.last
        }
    }

    mutating func push(_ element: T) {
        contents.append(element)
    }

    mutating func pop() -> T?{
        contents.popLast()
    }
}
