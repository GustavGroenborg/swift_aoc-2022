import Foundation

print("Hello, world!")

let parser = Parser(root: Directory(name: "/"))
let commands = parser.scanCommands(from: loadInput())

for command in commands {
    parser.parseCommand(from: command)
}

let directoriesBelow100_000 = locateDirectories(lessThanOrEqualTo: 100_000, in: parser.root)
var sum: uint64 = 0
directoriesBelow100_000.forEach { sum += $0.size }

let fmt = NumberFormatter()
fmt.numberStyle = .decimal

print("part 1:")
print("The sum of all directories below 100_000 is: \(fmt.string(for: sum)!)")


let neededSpace = parser.root.size + 30_000_000 - 70_000_000
print("root size: \(fmt.string(for: parser.root.size)!)")

var v: Directory
var smallestDirectory = parser.root
var frontier = [parser.root]

while !frontier.isEmpty {
    v = frontier.removeLast()
    if v.size >= neededSpace && v.size < smallestDirectory.size {
        smallestDirectory = v
    }

    v.directories.forEach { frontier.append($0) }
}

print("The total size of the smallest directory, that would free up at least: \(fmt.string(for: neededSpace)!) is: \(fmt.string(for: smallestDirectory.size)!)")


func loadInput() -> String {
    let fp = "file://" + FileManager.default.homeDirectoryForCurrentUser.path + "/AdventOfCode/aoc_2022/puzzleInputs/dec7.txt"
    guard let url = URL(string: fp) else {
        fatalError("Could not make URL")
    }

    do {
        return try String(contentsOf: url)
    } catch {
        fatalError(error.localizedDescription)
    }
}