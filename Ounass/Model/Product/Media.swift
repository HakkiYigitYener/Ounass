import Foundation

struct Media: Codable {
    let position: Int
    let mediaType: String
    let src: String

    enum CodingKeys: String, CodingKey {
        case position, mediaType, src
    }
}
