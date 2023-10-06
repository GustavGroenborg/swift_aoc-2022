import Foundation

@main
public struct dec2 {
    /* Opponent symbols:
    *   A == Rock
    *   B == Paper
    *   C == Scissors
    */

    /* Player symbols:
    * X == Rock / Lose
    * Y == Paper / Draw
    * z == Scissors / Win
    */

    /* Scores:
    *    Base scores (b_score):
    *        Rock: 1 pt
    *        Paper: 2 pts
    *        Scissors: 3 pts
    *
    *        win: b_score + 6 pts
    *        draw: b_score + 3 pts
    *        lose: b_score + 0 pts
    */

    public static func main() {
        print("Part 1:")
        part1()

        print("Part 2: ")
        part2()
    }
        
}



enum Shape {
    case rock 
    case paper 
    case scissors 
    case error
}



enum Game: Int {
    case win = 6
    case draw = 3
    case lose = 0
}



func getOpponentShape(opponentSymbol: String) -> Shape {
    switch opponentSymbol {
            case "A":
                return .rock
            case "B":
                return .paper
            case "C":
                return .scissors
            default: 
                fatalError(#"Unexpected opponent symbol. Expected "X", "Y" or "Z", got: \#(opponentSymbol)"#)
        }
}



func getShapeScore(Shape: Shape) -> Int {
    switch Shape {
            case .rock:
                return 1
            case .paper:
                return 2
            case .scissors:
                return 3
            default: // For error checking
                return -1
        }
}



func part1() {
    let fp = FileManager.default.currentDirectoryPath + "/Resources/input.txt"

    guard let file = freopen(fp, "r", stdin) else {
        fatalError("Could not find input file")
    }
    defer {
        fclose(file)
    }

    var totalScore = 0

    // Calculating the total score
    while let line = readLine() {
        guard !line.isEmpty else { continue }

        var playerSymb: Character = "f"
        var opponentSymb: Character = "f"

        for c in line {
            switch c {
                case "A", "B", "C":
                    opponentSymb = c
                case "X", "Y", "Z":
                    playerSymb = c
                default: 
                    break
            }
        }

        var playerShape: Shape {
            switch playerSymb {
                case "X":
                    return .rock
                case "Y":
                    return .paper
                case "Z":
                    return .scissors
                default: 
                    return .error
            }
        }

        guard playerShape != .error else {
            fatalError(#"Wrong player input. Expected, "X”, ”Y" or ”Z”, got \#(playerSymb)"#)
        }

        totalScore += computeScore(opponentShape: getOpponentShape(opponentSymbol: String(opponentSymb)), 
                                   playerShape: playerShape)
        
    }

    print("\t Total score according to the strategy guide: \(totalScore)")
}



func part2() {
    let fp = FileManager.default.currentDirectoryPath + "/Resources/input.txt"

    guard let file = freopen(fp, "r", stdin) else {
        fatalError("Could not open input file")
    }
    defer { // Closing the file, at the end of the scope.
        fclose(file)
    }

    var totalScore = 0

    while let line = readLine() {
        var playerAction = Game.lose
        var playerShape = Shape.error
        var opponentShape = Shape.error

        for char in line {
            switch char {
                case "A", "B", "C":
                    opponentShape = getOpponentShape(opponentSymbol: String(char))
                case "X", "Y", "Z":
                    playerAction = determinePlayerAction(char)
                default:
                    continue
            }
        }

        // Determining the player shape
        if playerAction == .win {
            playerShape = determineWinningShape(opponentShape)
        } else if playerAction == .draw {
            playerShape = determineDrawShape(opponentShape)
        } else { // Player must have lost
            playerShape = determineLosingShape(opponentShape)
        }
        totalScore += computeScore(opponentShape: opponentShape, playerShape: playerShape) 
    }

    print("\t If everything goes exactly to the strategy guide the total score will be: \(totalScore)")
}



/// Computes the player score of a round.
func computeScore(opponentShape: Shape, playerShape: Shape) -> Int {
    let playerScore = getShapeScore(Shape: playerShape)

    // Determining the final score.
    switch opponentShape {
        case .rock:
            if playerShape == .rock {
                return Game.draw.rawValue + playerScore
            } else if playerShape == .paper {
                return Game.win.rawValue + playerScore
            } else { // Player must have lost
                return Game.lose.rawValue + playerScore
            }
        case .paper:
            if playerShape == .paper {
                return Game.draw.rawValue + playerScore
            } else if playerShape == .scissors {
                return Game.win.rawValue + playerScore
            } else {
                return Game.lose.rawValue + playerScore
            }
        case .scissors:
            if playerShape == .scissors {
                return Game.draw.rawValue + playerScore
            } else if playerShape == .rock {
                return Game.win.rawValue + playerScore
            } else {
                return Game.lose.rawValue + playerScore
            }
        default:
            fatalError("Unexpected error while determining final score")
    }
}



func determinePlayerAction(_ char: Character) -> Game {
    switch char {
        case "X":
            return Game.lose
        case "Y":
            return Game.draw
        case "Z":
            return Game.win
        default: 
            fatalError(#"Unexpected player action symbol. Expected "X", "Y" or "Z", got: \#(char)"#)
    }
}



func determineWinningShape(_ opponentShape: Shape) -> Shape {
    switch opponentShape {
        case .rock:
            return .paper
        case .scissors:
            return .rock
        case .paper:
            return .scissors
        default: 
            return .error
    }
}



func determineLosingShape(_ opponentShape: Shape) -> Shape {
    switch opponentShape {
        case .rock:
            return .scissors
        case .scissors:
            return .paper
        case .paper:
            return .rock
        default:
            return .error
    }
}



/// - returns: The same shape, as the opponent.
func determineDrawShape(_ opponentShape: Shape) -> Shape {
    opponentShape
}