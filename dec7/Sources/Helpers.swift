import Foundation

fileprivate enum SizeOptions{
    case lessThan
    case lessThanOrEqual
    case greaterThan
    case greaterThanOrEqual
}


func locate(directory name: String, in directory: Directory) -> Directory? {
    var v = directory
    var frontier = [directory]
    while !frontier.isEmpty {
        v = frontier.removeLast()
        if v.name == name {
            return v
        } else {
            v.directories.forEach { frontier.append($0) }
        }
    }

    return nil
}

func locateDirectories(lessThan size: uint64, in directory: Directory) -> [Directory] {
    return locateDirectory(with: size, options: .lessThan, in: directory)
}

func locateDirectories(lessThanOrEqualTo size: uint64, in directory: Directory) -> [Directory] {
    return locateDirectory(with: size, options: .lessThanOrEqual, in: directory)
}

func locateDirectories(greaterThan size: uint64, in directory: Directory) -> [Directory] {
    return locateDirectory(with: size, options: .greaterThan, in: directory)
}

fileprivate func locateDirectory(with size: uint64, options: SizeOptions, in directory: Directory) -> [Directory] {
    var v = directory
    var found: [Directory] = []
    var frontier = [directory]
    while !frontier.isEmpty {
        v = frontier.removeLast()
        switch options {
            case .lessThan:
                if v.size < size { found.append(v) }
            case .lessThanOrEqual:
                if v.size <= size { found.append(v) }
            case .greaterThan:
                if v.size > size { found.append(v) }
            case .greaterThanOrEqual:
                if v.size >= size { found.append(v) }
        }

        v.directories.forEach { frontier.append($0) }
    }
    return found
}


func locate(file name: String, in directory: Directory) -> DeviceFile? {
    var v = directory
    var frontier = [directory]

    while !frontier.isEmpty {
        v = frontier.removeLast()

        for f in v.files {
            if f.name == name {
                return f
            }
        }
        v.directories.forEach { frontier.append($0) }
    }

    return nil
}
