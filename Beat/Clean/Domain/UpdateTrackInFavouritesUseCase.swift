import Foundation

protocol UpdateTrackInFavouritesUseCase {
    func callAsFunction(_ track: FavouriteItem<Track>) throws
}

struct UpdateTrackInFavouritesUseCaseImplementation: UpdateTrackInFavouritesUseCase {
    private let tracksRepository: TracksRepository
    
    init(tracksRepository: TracksRepository) {
        self.tracksRepository = tracksRepository
    }
    
    func callAsFunction(_ track: FavouriteItem<Track>) throws {
        if track.isFavourite {
            try tracksRepository.removeFavourites(tracks: [track.item])
        } else {
            try tracksRepository.addToFavourites(track: track.item)
        }
    }
}

#if DEBUG
struct UpdateTrackInFavouritesUseCasePreviewMock: UpdateTrackInFavouritesUseCase {
    func callAsFunction(_ track: FavouriteItem<Track>) throws {
        
    }
}
#endif
