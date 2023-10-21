// The Swift Programming Language
// https://docs.swift.org/swift-book

//print("Hello, world!")

import Foundation

@main
public struct dec3 {
    static func main() {
        // Find common item in two compartments
        part1()

        // Find common item between three elves
        part2()
    }
}


func part2() {
    // Every three lines is a group of elves. The common item in all the elves'
    // rucksacks denote their group badge. Find the sum of priorities of the group badges.
    let fp = FileManager.default.homeDirectoryForCurrentUser.path + "/AdventOfCode/aoc_2022/puzzleInputs/dec3.txt"

    guard let file = freopen(fp, "r", stdin) else {
        fatalError("Could not open input file")
    }
    defer {
        fclose(file)
    }

    var prioritySum = 0
    var groupCount = 0;
    var elf0: [uint8] = Array(repeating: 0, count: 52)
    var elf1: [uint8] = Array(repeating: 0, count: 52)
    var elf2: [uint8] = Array(repeating: 0, count: 52)

    while let line = readLine() {
        if groupCount < 3 {
            let rucksack = convertToPriorityArray(str: line)
            let countedRucksack = countPriorities(rucksack: rucksack)
            switch groupCount {
                case 0: elf0 = countedRucksack
                case 1: elf1 = countedRucksack
                default: elf2 = countedRucksack
            }
            groupCount += 1

        } else { // Finding the common item.
            if groupCount != 3 {
                print("Group Count is: \(groupCount)")
            }
            prioritySum += comparePriorities(a: elf0, b: elf1, c: elf2)
            // Resetting the group.
            groupCount = 0
        }
    }

    print("The total sum of priorities of common items across a group of elves is: \(prioritySum)")
}


func part1() {
    let fp = FileManager.default.homeDirectoryForCurrentUser.path + "/AdventOfCode/aoc_2022/puzzleInputs/dec3.txt"

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


/// Converts a string to a corresponding priority array.
func convertToPriorityArray(str: String) -> [uint8] {
    let charArr = Array(str)
    var priorityArr: [uint8] = Array(repeating: 0, count: charArr.count)

    for i in 0..<charArr.count {
        priorityArr[i] = computePriority(char: charArr[i])
    }

    return priorityArr
}


/// Computes the unsigned 8-bit integer priority value of a ruck-sack item.
/// - Parameter char: The rucksack value.
/// - Returns: The priority value of the item.
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


/// Splits a string into two
/// - Returns: A tuple containing two arrays of characters. The first tuple, is the
///     first part of the string.
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


/// Finds the common items across three rucksacks and return the sum of those items priorities.
/// - Returns: The sum of priorities of elements in common across the three rucksacks.
func comparePriorities(a: [uint8], b: [uint8], c: [uint8]) -> Int {
    var sum: [Int] = [0]

    for i in 0..<a.count {
        if a[i] > 0 && b[i] > 0 && c[i] > 0 {
            //sum += i + 1
            sum.append(i + 1)
        }
    }
    
    var totalSum = 0;
    for n in sum {
        totalSum += n
    }
    
    if totalSum > 52 {
        print("Sum array:")
        print(sum)
        print("arrays")
        print(a)
        print(b)
        print(c)
        print("\n")
    }

    return totalSum
}