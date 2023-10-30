class Root {
    private(set) var name: String
    var directories: [Directory]
    var files: [DeviceFile]

    init(name: String) {
        self.name = name
        self.files = []
        self.directories = []
    }
}