import Foundation

class Pagination: Codable {
    let currentPage, totalHits, totalPages: Int

    init(currentPage: Int, totalHits: Int, totalPages: Int) {
        self.currentPage = currentPage
        self.totalHits = totalHits
        self.totalPages = totalPages
    }
}
