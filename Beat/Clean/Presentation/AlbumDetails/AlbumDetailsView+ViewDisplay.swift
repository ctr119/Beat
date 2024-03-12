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
        
        func clone(with newTracks: [FavouriteItem<Track>]) -> ViewDisplay {
            .init(
                id: self.id,
                title: self.title,
                coverUrl: self.coverUrl,
                artist: self.artist,
                genres: self.genres,
                releaseDate: self.releaseDate,
                tracks: newTracks
            )
        }
    }
}
