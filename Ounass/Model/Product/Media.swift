import Foundation

class Media: Codable {
    let position: Int
    let mediaType: String
    let src: String

    enum CodingKeys: String, CodingKey {
        case position, mediaType, src
    }

    init(position: Int, mediaType: String, src: String) {
        self.position = position
        self.mediaType = mediaType
        self.src = src
    }
}
