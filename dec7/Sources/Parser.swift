import Foundation

enum Tokens: String, CaseIterable {
    case cd = #"( )*cd ([A-Za-z]+|[.]{2}|[/])"#
    case ls = #"( )*(ls)(([\n][0-9]+[ ][A-Za-z]+[.][A-Za-z]+)|([\n]dir[ ][A-Za-z]+))*"#
    case dir = #"(?<=dir )[a-z]+"#
    case parentDir = #"[.]{2}"#
    case size = #"[0-9]+"#
    case fileName = "[A-Za-z]+([.][A-Za-z]+)?"
}

class Parser {
    let root: Directory
    var currentDirectory: Directory?

    init(root: Directory) {
        self.root = root
        self.currentDirectory = nil
    }

    func scanCommands(from input: String) -> [String] {
        let input = input.split(separator: "$")
        return input.map { String($0) }
    }

    func parseCommand(from input: String) {
        if input.range(of: Tokens.cd.rawValue, options: .regularExpression) != nil { 
            parseChangeDirectory(from: input) }
        else if input.range(of: Tokens.ls.rawValue, options: .regularExpression) != nil { 
            parseListDirectoryContents(from: input) }
    }


    private func parseChangeDirectory(from str: String) {
        guard let range = str.range(of: Tokens.cd.rawValue, options: .regularExpression) else {
            fatalError(#"Regex: \#(Tokens.cd.rawValue) yielded no range in the string: \#(str)"#)
        }

        let split = String(str[range]).split(separator: " ")

        if str.range(of: Tokens.parentDir.rawValue, options: .regularExpression) != nil {
            self.currentDirectory = self.currentDirectory?.parent ?? self.root
        } else if let locatedDir = locate(directory: String(split[1]), in: self.currentDirectory ?? self.root) {
            self.currentDirectory = locatedDir
        }
    }


    private func parseListDirectoryContents(from str: String) {
        var contents = str.split(separator: "\n")
        contents.removeFirst()
        let currentDirectory = self.currentDirectory ?? root

        for line in contents {
            if let range = line.range(of: Tokens.dir.rawValue, options: .regularExpression) {
                currentDirectory.add(directory: Directory(name: String(str[range])))

            } else if let range = line.range(of: Tokens.size.rawValue + " " + Tokens.fileName.rawValue, options: .regularExpression) {
                let info = String(str[range]).split(separator: " ")
                guard let fileSize = uint64(info[0]) else {
                    fatalError("Could not parse file size as uint64. Got:\(info[0]), in: \(line)")
                }

                currentDirectory.add(file: DeviceFile(name: String(info[1]), size: fileSize))
            }
        }
    }
}
