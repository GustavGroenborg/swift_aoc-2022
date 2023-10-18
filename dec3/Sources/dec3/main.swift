// The Swift Programming Language
// https://docs.swift.org/swift-book

//print("Hello, world!")

import Foundation

@main
public struct dec3 {
    static func main() {
        print("Hello Wooorld")

        let splitStr = splitString(inp: "vJrwaWtwJgWrhcsFMMfFFhFa")
        var leftArr: [uint8] = Array(repeating: 0, count: splitStr.0.count)
        var rightArr: [uint8] = Array(repeating: 0, count: splitStr.1.count)

        for i in 0..<leftArr.count {
            leftArr[i] = computePriority(char: splitStr.0[i])
        }

        for i in 0..<rightArr.count {
            rightArr[i] = computePriority(char: splitStr.1[i])
        }

        print("Priority arrays:")
        print(leftArr)
        print(rightArr)

        let leftCounted = countPriorities(rucksack: leftArr)
        let rightCounted = countPriorities(rucksack: rightArr)

        print("\nCounted priority arrays")
        print(leftCounted)
        print(rightCounted)


        for i in 0..<52 {
            if leftCounted[i] > 0 && rightCounted[i] > 0 {
                if leftCounted[i] == rightCounted[i] {
                    print("left and right equal occurences")
                } else {
                    print("left and right unequal occurences")
                }

                print("left: \(leftCounted[i]), right: \(rightCounted[i])")
                print("Priority value: \(i + 1)")
            }
        }

        part1()
    }
}

func part1() {
    let fp = FileManager.default.homeDirectoryForCurrentUser.path + "/AdventOfCode/aoc_2022/puzzleInputs/dec3.txt"
    print(fp)

    guard let file = freopen(fp, "r", stdin) else {
        fatalError("Could not open input file")
    }
    defer {
        fclose(file)
    }

    var prioritySum = 0

    while let line = readLine() {
        let splitStr = splitString(inp: line)
        var leftArr: [uint8] = Array(repeating: 0, count: splitStr.0.count)
        var rightArr: [uint8] = Array(repeating: 0, count: splitStr.1.count)

        for i in 0..<leftArr.count {
            leftArr[i] = computePriority(char: splitStr.0[i])
        }

        for i in 0..<rightArr.count {
            rightArr[i] = computePriority(char: splitStr.1[i])
        }

        let leftCounted = countPriorities(rucksack: leftArr)
        let rightCounted = countPriorities(rucksack: rightArr)

        for i in 0..<52 {
            if leftCounted[i] > 0 && rightCounted[i] > 0 {
                prioritySum += i + 1
            }
        }
    }

    print("Sum of priorities of items appearing in both compartments: \(prioritySum)")
}


func computePriority(char: Character) -> uint8{
    guard char.isASCII else {
        fatalError("Character in not ASCII.")
    }

    if char.isLowercase {
        return char.asciiValue! - 96
    } else if char.isUppercase {
        return char.asciiValue! - 38
    } else {
        fatalError("Unexpected Character. Got \(char)")
    }
}


func splitString(inp: String) -> ([Character], [Character]) {
    let start = inp.startIndex
    let middle = inp.index(start, offsetBy: inp.count / 2)

    return (Array(inp[start..<middle]), Array(inp[middle...]))
}


/// Counts the number of occurences of each priority.
/// - Parameter arr: array consisting of priorities.
/// - Returns: An array of size 52, each index represents the number of occurences of that priority.
func countPriorities(rucksack: [uint8]) -> [uint8] {
    var countedPriorities: [uint8] = Array(repeating: 0, count: 52)

    for item in rucksack {
        countedPriorities[Int(item) - 1] += 1
    }

    return countedPriorities
}


func computePriorityArrays(str: String) -> ([uint8], [uint8]) {
    let splitStr = splitString(inp: str) 
    var leftArr: [uint8] = Array(repeating: 0, count: 52)
    var rightArr: [uint8] = Array(repeating: 0, count: 52)

    for i in 0..<splitStr.0.count {
        leftArr[i] = computePriority(char: splitStr.0[i])
    }

    for i in 0..<splitStr.1.count {
        rightArr[i] = computePriority(char: splitStr.1[i])
    }

    return (leftArr, rightArr)
}


/// - Returns: The total sum of priorities of items appearing in both compartments.
func comparePriorities(left: [uint8], right: [uint8]) -> Int {
    var prioritiesSum = 0

    for i in 0..<left.count {
        if left[i] > 0 && right[i] > 0 {
            if left[i] == right[i] {
                prioritiesSum += i + 1
            }
        }
    }

    return prioritiesSum
}