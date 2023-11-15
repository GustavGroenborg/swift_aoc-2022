import Foundation

class Directory {
    private(set) var name: String
    private(set) var size: uint64
    private(set) var parent: Directory?

    private(set) var directories: [Directory]
    private(set) var files: [DeviceFile]

    init(name: String) {
        self.name = name
        self.size = 0

        self.files = []
        self.directories = []
    }


    convenience init(name: String, parent: Directory) {
        self.init(name: name)
        parent.add(directory: self)
    }


    func add(directory: Directory) {
        for d in self.directories {
            if d.name == directory.name {
                return
            }
        }
        directories.append(directory)
        directory.parent = self
        self.size += directory.size

        updateParents(with: directory.size)
    }


    func add(file: DeviceFile) {
        for f in self.files {
            if file.name == f.name {
                return
            }
        }
        files.append(file)
        self.size += file.size

        updateParents(with: file.size)
    }


    /// Updates all parent directories of this directory, with a specified size.
    private func updateParents(with size: uint64) {
        var currentParent = self.parent

        while currentParent != nil {
            currentParent?.size += size
            currentParent = currentParent?.parent
        }
    }
}