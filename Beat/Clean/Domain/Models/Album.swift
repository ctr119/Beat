import Foundation

struct Album {
    let id: Int
    let title: String
    
    private let coverUrlSmall: URL
    private let coverUrlMedium: URL
    private let coverUrlLarge: URL
    
    let artist: Artist
    let genres: [Genre]?
    let releaseDate: Date?
    let tracks: [Track]?
    
    init(
        id: Int,
        title: String,
        coverUrlSmall: URL,
        coverUrlMedium: URL,
        coverUrlLarge: URL,
        artist: Artist,
        genres: [Genre]?,
        releaseDate: Date?,
        tracks: [Track]?
    ) {
        self.id = id
        self.title = title
        self.coverUrlSmall = coverUrlSmall
        self.coverUrlMedium = coverUrlMedium
        self.coverUrlLarge = coverUrlLarge
        self.artist = artist
        self.genres = genres
        self.releaseDate = releaseDate
        self.tracks = tracks
    }
    
    func coverUrl(size: ImageSize) -> URL {
        return switch size {
        case .small:
            coverUrlSmall
        case .medium:
            coverUrlMedium
        case .large:
            coverUrlLarge
        case .xlarge:
            coverUrlLarge
        }
    }
}
