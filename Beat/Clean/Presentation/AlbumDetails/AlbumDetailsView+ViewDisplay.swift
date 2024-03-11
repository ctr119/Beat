import Foundation

extension AlbumDetailsView {
    struct ViewDisplay {
        let id: Int
        let title: String
        let coverUrl: URL
        let artist: Artist
        let genres: [Genre]
        let releaseDate: Date?
        let tracks: [FavouriteItem<Track>]
    }
}
