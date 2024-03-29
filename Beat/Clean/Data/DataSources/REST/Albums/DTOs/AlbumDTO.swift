import Foundation

struct AlbumDTO: Decodable {
    let id: Int
    let title: String
    let coverSmall: String
    let coverMedium: String
    let coverLarge: String
    let artist: ArtistDTO
    
    let genres: GenresDTO?
    let releaseDate: String?
    let tracks: TracksDTO?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case coverSmall = "cover_small"
        case coverMedium = "cover_medium"
        case coverLarge = "cover_big"
        case artist
        case genres
        case releaseDate = "release_date"
        case tracks
    }
}
