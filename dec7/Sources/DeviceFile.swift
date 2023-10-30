import Foundation

class DeviceFile {
    private(set) var name: String
    private(set) var size: uint32

    init(name: String, size: uint32) {
        self.name   = name
        self.size   = size
    }
}