import Foundation

struct ConfigurableAttributeOption: Codable {
    let optionID: Int
    let label: String
    let simpleProductSkus: [String]
    let isInStock: Bool

    enum CodingKeys: String, CodingKey {
        case optionID = "optionId"
        case label, simpleProductSkus, isInStock
    }
}
