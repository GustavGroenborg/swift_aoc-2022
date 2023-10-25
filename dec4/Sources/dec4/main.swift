import Foundation

let input = loadInput().map { $0.split(separator: ",").map { $0.split(separator: "-") } }
let parsedInput = input.map { ( lhs: Int($0[0][0])!...Int($0[0][1])!, rhs: Int($0[1][0])!...Int($0[1][1])! ) }

var fullyContainedPairs = 0

for (lhs, rhs) in parsedInput {
    if pairFullyContains(lhs: lhs, rhs: rhs) {
        fullyContainedPairs += 1
    }
}
print("Part 1:\nOne range fully contains the other in \(fullyContainedPairs) assignments")


var overlappingRanges = 0

for (lhs, rhs) in parsedInput {
    if lhs.overlaps(rhs) {
        overlappingRanges += 1
    }
}

print("Part 2:\nRanges overlap in \(overlappingRanges) assignments")


func pairFullyContains(lhs: ClosedRange<Int>, rhs: ClosedRange<Int>) -> Bool {
    if (lhs.lowerBound <= rhs.lowerBound && lhs.fullyContains(rhs)) || rhs.fullyContains(lhs) {
        return true
    } else {
        return false
    }
}


extension ClosedRange<Int> {
    /// - Returns: False, if the passed closed range is not contained within the calling range.
    func fullyContains(_ a: ClosedRange<Int>) -> Bool {
        let clamped = self.clamped(to: a)

        if clamped.isEmpty {
            return false
        } else {
            if self.lowerBound <= a.lowerBound && self.upperBound >= a.upperBound {
                return true
            } else {
                return false
            }
        }
    }
}



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

