import Foundation


func loadInput() -> [Substring] {
    let fp = FileManager.default.homeDirectoryForCurrentUser.path + "/AdventOfCode/aoc_2022/puzzleInputs/dec4.txt"
    guard let url = URL(string: "file://" + fp) else {
        fatalError("Could not make URL")
    }

    var lines: [Substring] = []

    do {
        let data = try String(contentsOf: url)
        lines = data.split(separator: "\n")

    } catch {
        fatalError(error.localizedDescription)
    }

    return lines
}