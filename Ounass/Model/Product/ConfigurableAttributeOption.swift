import Foundation

class ConfigurableAttributeOption: Codable {
    let optionID: Int
    let label: String
    let simpleProductSkus: [String]
    let isInStock: Bool

    enum CodingKeys: String, CodingKey {
        case optionID = "optionId"
        case label, simpleProductSkus, isInStock
    }

    init(optionID: Int, label: String, simpleProductSkus: [String], isInStock: Bool) {
        self.optionID = optionID
        self.label = label
        self.simpleProductSkus = simpleProductSkus
        self.isInStock = isInStock
    }
}
