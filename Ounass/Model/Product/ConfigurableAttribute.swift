import Foundation

struct ConfigurableAttribute: Codable {
    let code: String
    let options: [ConfigurableAttributeOption]
}
