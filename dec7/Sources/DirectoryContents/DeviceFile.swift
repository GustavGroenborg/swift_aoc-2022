import Foundation

class DeviceFile {
    private(set) var name: String
    private(set) var size: uint64

    init(name: String, size: uint64) {
        self.name   = name
        self.size   = size
    }
}