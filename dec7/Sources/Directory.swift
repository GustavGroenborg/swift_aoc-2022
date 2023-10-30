import Foundation

class Directory: Root {
    private(set) var parent: Directory

    init(name: String, parent: Directory) {
        self.parent = parent
        super.init(name: name)
    }
}

