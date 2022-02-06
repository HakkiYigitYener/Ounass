import Foundation

class CopyAttribute: Codable {
    let key: String
    let name: String
    let value: String
    let linkText: String?

    init(key: String, name: String, value: String, linkText: String?) {
        self.key = key
        self.name = name
        self.value = value
        self.linkText = linkText
    }
}
