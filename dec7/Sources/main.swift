import Foundation

print("Hello, world!")

var root = Root(name: "/")
var currDir = root


func loadInput() -> String {
    let fp = "file://" + FileManager.default.homeDirectoryForCurrentUser.path + "AdventOfCode/aoc_2022/puzzleInput"
    guard let url = URL(string: fp) else {
        fatalError("Could not make URL")
    }

    do {
        return try String(contentsOf: url)
    } catch {
        fatalError(error.localizedDescription)
    }
}