import Foundation

protocol UpdateFavouriteTracksUseCase {
    func callAsFunction(tracksToUpdate: [PositionedItem<Track>], tracksToRemove: [Track]) throws
}

struct UpdateFavouriteTracksUseCaseImplementation: UpdateFavouriteTracksUseCase {
    private let tracksRepository: TracksRepository
    
    init(tracksRepository: TracksRepository) {
        self.tracksRepository = tracksRepository
    }
    
    func callAsFunction(tracksToUpdate: [PositionedItem<Track>], tracksToRemove: [Track]) throws {
        for track in tracksToRemove {
            try tracksRepository.removeFromFavourites(track: track)
        }
        
        try tracksRepository.update(tracks: tracksToUpdate)
    }
}

#if DEBUG
struct UpdateFavouriteTracksUseCasePreviewMock: UpdateFavouriteTracksUseCase {
    func callAsFunction(tracksToUpdate: [PositionedItem<Track>], tracksToRemove: [Track]) throws {
        
    }
}
#endif
