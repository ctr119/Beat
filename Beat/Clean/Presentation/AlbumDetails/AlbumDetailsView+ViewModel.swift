import Foundation

extension AlbumDetailsView {
    @Observable
    class ViewModel {
        private(set) var state: ViewModelState<ViewDisplay> = .idle
        
        private let initialId: Int
        private let getAlbumDetailsUseCase: GetAlbumDetailsUseCase
        
        init(id: Int, getAlbumDetailsUseCase: GetAlbumDetailsUseCase) {
            self.initialId = id
            self.getAlbumDetailsUseCase = getAlbumDetailsUseCase
        }
        
        func loadDetails() async {
            do {
                state = .loading
                
                let albumDetails = try await getAlbumDetailsUseCase(id: initialId)
                let tracks = albumDetails.album.tracks?.map {
                    FavouriteItem(item: $0, isFavourite: albumDetails.favouriteTracksIds.contains($0.id))
                } ?? []
                
                let viewDisplay = ViewDisplay(
                    id: albumDetails.album.id,
                    title: albumDetails.album.title,
                    coverUrl: albumDetails.album.coverUrl(size: .large),
                    artist: albumDetails.album.artist,
                    genres: albumDetails.album.genres ?? [],
                    releaseDate: albumDetails.album.releaseDate,
                    tracks: tracks
                )
                
                await MainActor.run {
                    state = .loaded(viewDisplay)
                }
            } catch {
                state = .failed(error)
            }
        }
    }
}
