import Foundation

print("Hello, world!")
let input = loadInput()

print("\nPart 1:")
distinctChars(in: input, limit: 4)

print("\nPart 2:")
distinctChars(in: input, limit: 14)


func distinctChars(in input: String, limit: Int) {
    var buffer = ""
    var charactersProcessed = -1

    for char in Array(input) {
        charactersProcessed += 1
        print(buffer)
        if !buffer.contains(char) && buffer.count < limit{
            buffer += String(char)
        } else if buffer.count == limit {
            break
        } else if buffer.contains(char) {
            print("breaking char: \(char)")
            buffer += String(char)
            let sinner = buffer.firstIndex(of: char)
            let dist = input.distance(from: input.startIndex, to: sinner!)
            buffer = String(buffer.dropFirst(dist + 1))
        } 
    }

    print("Characters processed before the first start-of-packet marker: \(charactersProcessed)")
}

func loadInput() -> String {
    let fp = "file://" + FileManager.default.homeDirectoryForCurrentUser.path + "/AdventOfCode/aoc_2022/puzzleInputs/dec6.txt"

    guard let url = URL(string: fp) else {
        fatalError("Could not make url")
    }

    do {
        return try String(contentsOf: url)
    } catch {
        fatalError(error.localizedDescription)
    }
}

