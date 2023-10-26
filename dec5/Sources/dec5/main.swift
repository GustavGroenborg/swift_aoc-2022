import Foundation

print("Hello, world!")
let input = loadInput()

print("\nPart 1:")
part1(input)

print("\nPart 2:")
part2(input)


func part2(_ input: [Substring]) {
    let stackInput = produceStackInput(puzzleInput: input)
    let unparsedInstructions = getUnparsedInstructions(from: input)
    var stacks = initStacks(stackInput: stackInput!)

    for unparsedInstruction in unparsedInstructions {
        guard let instruction = parseInstructions(from: unparsedInstruction) else {
            fatalError("Could not parse instruction")
        }

        moveCrates9001(instructions: instruction, stacks: &stacks)
    }

    var message = ""
    for i in 0..<stacks.count {
        if let char = stacks[i].pop() {
            message += String(char)
        } else {
            print("Empty stack")
        }
    }

    print("The message after executing all the instructions is: \(message)")
}


func part1(_ input: [Substring]) {
    let stackInput = produceStackInput(puzzleInput: input)
    let unparsedInstructions = getUnparsedInstructions(from: input)
    var stacks = initStacks(stackInput: stackInput!)

    for unparsedInstruction in unparsedInstructions {
        guard let instruction = parseInstructions(from: unparsedInstruction) else {
            fatalError("Could not parse instruction")
        }

        moveCrates9000(instructions: instruction, stacks: &stacks)
    }

    var message = ""

    for i in 0..<stacks.count {
        if let char = stacks[i].pop() {
            message += String(char)
        } else {
            print("Empty Stack")
        }
    }

    print("The message after executing all the instructions is: \(message)")
}


func moveCrates9000(instructions: (move: Int, from: Int, to: Int), stacks: inout [Stack<Character>]) {
    guard instructions.from > 0 && instructions.to > 0 else {
        fatalError(#"Invalid "from" and "to" instructions. Got from: \#(instructions.from), to: \#(instructions.to)"#)
    }

    for _ in 1...instructions.move {
        guard let moving = stacks[instructions.from - 1].pop() else {
            fatalError("No crates to move in stack \(instructions.from)")
        }
        stacks[instructions.to - 1].push(moving)
    }
}


func moveCrates9001(instructions: (move: Int, from: Int, to: Int), stacks: inout [Stack<Character>]) {
    guard instructions.from > 0 && instructions.to > 0 else {
        fatalError(#"Invalid "from" and "to" instructions. Got from: \#(instructions.from), to: \#(instructions.to)"#)
    }

    var moving: [Character] = []

    for _ in 1...instructions.move {
        if let popped = stacks[instructions.from - 1].pop() {
            moving.append(popped)
        } else {
            fatalError("Could not pop stack.")
        }
    }

    while !moving.isEmpty {
        stacks[instructions.to - 1].push(moving.removeLast())
    }
}


/// Parses crate movement instructions from a string of the input.
func parseInstructions(from str: String) -> (move: Int, from: Int, to: Int)? {
    let split = str.split(separator: " ")
    guard split.count == 6 else { return nil }

    let numbers = split.compactMap { Int($0) }
    guard numbers.count == 3 else { return nil }

    return (move: numbers[0], from: numbers[1], to: numbers[2])
}


/// Gets the instructions from the input, without parsing them.
func getUnparsedInstructions(from input: [Substring]) -> [String] {
    let lines = input.compactMap { ($0.contains("move")) ? String($0) : nil }

    return lines
}


/// Initialises an array of stacks based on a STACK-INPUT.
/// - Parameter stackInput: the STACK-INPUT
/// - Returns: An array of stacks, matching the stack input.
func initStacks(stackInput: [String]) -> [Stack<Character>] {
    let stackIndices = findStackIndices(indicesStr: stackInput[0])
    var stacks = Array(repeating: Stack<Character>(), count: stackIndices.count)

    for line in stackInput.dropFirst() {
        let chars: [Character] = Array(line)
        for (stackIdx, charIdx) in stackIndices.enumerated() {
            guard chars[charIdx].isLetter else { continue }
            stacks[stackIdx].push(chars[charIdx])
        }
    }

    return stacks
}



/// Produces the input for the stack, based on the puzzle input.
func produceStackInput(puzzleInput: [Substring]) -> [String]? {
    var stackInput: [String] = []

    for line in puzzleInput {
        if line.first == "m" {
            return stackInput.reversed()
        } else {
            stackInput.append(String(line))
        }
    }

    return nil
}


/// Finds the indices of the different stacks in the puzzle input.
/// - Returns: An empty array if no indices were found, else and integer array.
func findStackIndices(indicesStr: String) -> [Int] {
    var indices: [Int] = []

    for (idx, char) in Array<Character>(indicesStr).enumerated() {
        if char.wholeNumberValue != nil {
            indices.append(idx)
        }
    }

    return indices
}



func loadInput() -> [Substring] {
    let fp = "file://" + FileManager.default.homeDirectoryForCurrentUser.path + "/AdventOfCode/aoc_2022/puzzleInputs/dec5.txt"
    guard let url = URL(string: fp) else {
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