import Foundation

struct Product: Codable {
    let sku: String
    let name: String
    let productDescription: String
    let price: Double
    let copyAttributes: [CopyAttribute]
    let media: [Media]
    let minPrice: Double
    let designerCategoryName: String
    let configurableAttributes: [ConfigurableAttribute]
    let relatedProductsLookup: [String: Product]?
    let amberPointsPerItem: Double

    enum CodingKeys: String, CodingKey {
        case sku
        case name
        case productDescription = "description"
        case price, copyAttributes
        case media, minPrice
        case designerCategoryName
        case configurableAttributes
        case relatedProductsLookup
        case amberPointsPerItem
    }
}
