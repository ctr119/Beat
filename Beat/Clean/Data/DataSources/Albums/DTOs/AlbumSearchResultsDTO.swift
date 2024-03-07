import Foundation

struct AlbumSearchResultsDTO: Decodable {
    struct AlbumResultDTO: Decodable {
        let id: Int
        let title: String
        let coverSmall: String
        let coverMedium: String
        let coverLarge: String
        
        enum CodingKeys: String, CodingKey {
            case id
            case title
            case coverSmall = "cover_small"
            case coverMedium = "cover_medium"
            case coverLarge = "cover_big"
        }
    }
    
    let data: [AlbumResultDTO]
}
