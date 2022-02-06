import Foundation

class ConfigurableAttribute: Codable {
    let code: String
    let options: [ConfigurableAttributeOption]

    init(code: String, options: [ConfigurableAttributeOption]) {
        self.code = code
        self.options = options
    }
}
