import Foundation

struct Pagination: Codable {
    let currentPage, totalHits, totalPages: Int
}
