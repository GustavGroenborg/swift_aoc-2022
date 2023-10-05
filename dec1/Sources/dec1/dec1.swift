import Foundation

@main
public struct dec1 {
    public private(set) var text = "Hello, World!"

    public static func main() {
        print(dec1().text)

        print("Part 1:")
        part1()

        print("\nPart 2:")
        part2()
    }
}

func part1() {
    let fp = FileManager.default.currentDirectoryPath + "/Sources/Resources/input.txt"

    guard let file = freopen(fp, "r", stdin) else {
        fatalError("Could not find file.")
    }

    // Is executed before exiting the current scope.
    defer {
        fclose(file)
    }

    var current: Int = 0
    var largest: Int = 0

    while let line = readLine() {
        if line.isEmpty {
            if current > largest {
                largest = current
            }

            current = 0
        } else {
            if let num = Int(line) {
                current += num
            } else {
                fatalError("Expected valid numbers, input poluted")
            }
        }
    }

    print("Elf carrying most calories is carrying: \(largest)")
}


func part2() {
    let fp = FileManager.default.currentDirectoryPath + "/Sources/Resources/input.txt"

    guard let file = freopen(fp, "r", stdin) else {
        fatalError("Could not open file.")
    }
    defer {
        fclose(file)
    }

    var top = (0, 0, 0)
    var current = 0

    while let line = readLine() {
        if line.isEmpty {
            if current > top.2 {
                if current > top.1 {
                    if current > top.0 {
                        top.2 = top.1
                        top.1 = top.0
                        top.0 = current
                    } else {
                        top.2 = top.1
                        top.1 = current
                    }
                } else {
                    top.2 = current
                }
            }

            current = 0

        } else {
            if let num = Int(line) {
                current += num
            } else {
                fatalError("Did not expect input to be unparsable")
            }
        }
    }

    print("The top three elves carrying the most calories is carrying: \(top.0 + top.1 + top.2)")
}