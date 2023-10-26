// The Swift Programming Language
// https://docs.swift.org/swift-book
import Foundation

public struct AOCTools {
    private let puzzlePath = FileManager.default.homeDirectoryForCurrentUser.path + "/AdventOfCode/aoc_2022/puzzleInputs/"

    func loadPuzzleInput(year: String) -> [Substring] {
        guard let url = URL(string: "file://" + puzzlePath) else {
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
}