import Foundation

struct Album {
    let id: Int
    let title: String
    
    private let coverUrlSmall: URL
    private let coverUrlMedium: URL
    private let coverUrlLarge: URL
    
    let artist: Artist
    
    init(
        id: Int,
        title: String,
        coverUrlSmall: URL,
        coverUrlMedium: URL,
        coverUrlLarge: URL,
        artist: Artist
    ) {
        self.id = id
        self.title = title
        self.coverUrlSmall = coverUrlSmall
        self.coverUrlMedium = coverUrlMedium
        self.coverUrlLarge = coverUrlLarge
        self.artist = artist
    }
    
    func coverUrl(size: ImageSize) -> URL {
        return switch size {
        case .small:
            coverUrlSmall
        case .medium:
            coverUrlMedium
        case .large:
            coverUrlLarge
        }
    }
}
