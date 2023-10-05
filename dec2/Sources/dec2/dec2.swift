import Foundation

@main
public struct dec2 {
    /* Opponent symbols:
    *   A == Rock
    *   B == Paper
    *   C == Scissors
    */

    /* Player symbols:
    * X == Rock
    * Y == Paper
    * z == Scissors
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

        totalScore += computeScore(opponentSymbol: String(opponentSymb), playerSymbol: String(playerSymb))
        
    }

    print("Total score according to the strategy guide: \(totalScore)")
}


func computeScore(opponentSymbol: String, playerSymbol: String) -> Int {
    enum Shape {
        case rock 
        case paper 
        case scissors 
        case error
    }

    var playerShape: Shape {
        switch playerSymbol {
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

    var opponentShape: Shape {
        switch opponentSymbol {
            case "A":
                return .rock
            case "B":
                return .paper
            case "C":
                return .scissors
            default: 
                return .error
            
        }
    }

    let win = 6;
    let draw = 3;
    let lose = 0;

    var playerScore: Int {
        switch playerShape {
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


    guard playerScore != -1 else {
        fatalError(#"Wrong player input. Expected, "X”, ”Y" or ”Z”, got \#(playerSymbol)"#)
    }

    switch opponentShape {
        case .rock:
            if playerShape == .rock {
                return draw + playerScore
            } else if playerShape == .paper {
                return win + playerScore
            } else { // Player must have lost
                return lose + playerScore
            }
        case .paper:
            if playerShape == .paper {
                return draw + playerScore
            } else if playerShape == .scissors {
                return win + playerScore
            } else {
                return lose + playerScore
            }
        case .scissors:
            if playerShape == .scissors {
                return draw + playerScore
            } else if playerShape == .rock {
                return win + playerScore
            } else {
                return lose + playerScore
            }
        default:
            fatalError(#"Unexpected opponent symbol. Expected "X", "Y" or "Z", got: \#(opponentSymbol)"#)
    }
}