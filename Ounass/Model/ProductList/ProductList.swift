import Foundation

class ProductList: Codable {
    let products: [Product]
    let pagination: Pagination
    
    enum CodingKeys: String, CodingKey {
        case products = "hits"
        case pagination
    }

    init(products: [Product], pagination: Pagination) {
        self.products = products
        self.pagination = pagination
    }
}
