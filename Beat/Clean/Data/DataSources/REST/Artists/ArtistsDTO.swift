import Foundation

struct ArtistDTO: Decodable {
    let id: Int
    let name: String
    let pictureSmall: String
    let pictureMedium: String
    let pictureLarge: String
    let pictureXLarge: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case pictureSmall = "picture_small"
        case pictureMedium = "picture_medium"
        case pictureLarge = "picture_big"
        case pictureXLarge = "picture_xl"
    }
}
