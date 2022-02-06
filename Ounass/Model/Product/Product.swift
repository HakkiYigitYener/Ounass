import Foundation

class Product: Codable {
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
    let amberPointsPerItem: Int

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

    init(sku: String,
         name: String,
         productDescription: String,
         price: Double,
         copyAttributes: [CopyAttribute],
         media: [Media],
         minPrice: Double,
         designerCategoryName: String,
         configurableAttributes: [ConfigurableAttribute],
         relatedProductsLookup: [String: Product],
         amberPointsPerItem: Int) {
        self.sku = sku
        self.name = name
        self.productDescription = productDescription
        self.price = price
        self.copyAttributes = copyAttributes
        self.media = media
        self.minPrice = minPrice
        self.designerCategoryName = designerCategoryName
        self.configurableAttributes = configurableAttributes
        self.relatedProductsLookup = relatedProductsLookup
        self.amberPointsPerItem = amberPointsPerItem
    }
}
