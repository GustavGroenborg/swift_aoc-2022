import Foundation

enum Tokens: String, CaseIterable {
    case cd = #"\$ cd (.)+"#
    case ls = #"\$( )?(ls)(([\n][0-9]+[ ][A-Za-z]+[.][A-Za-z]+)|([\n]dir[ ][A-Za-z]+))*"#
    case dir = #"(?<=\ndir )[a-z]+"#
    case parentDir = #"[.]{2}"#
    case size = #"[0-9]+"#
    case fileName = "[A-Za-z]+([.][A-Za-z]+)?"
}


struct Parser {
    func scanCommands(from input: String) -> [String] {
        let input = input.split(separator: "$")
        return input.map { String($0) }
    }


    func parseCommand(from input: String) {
    }

    private func parseChangeDirectory(from str: String) {

    }

}