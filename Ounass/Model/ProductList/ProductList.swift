import Foundation

struct ProductList: Codable {
    let products: [Product]
    let pagination: Pagination
    
    enum CodingKeys: String, CodingKey {
        case products = "hits"
        case pagination
    }
}
