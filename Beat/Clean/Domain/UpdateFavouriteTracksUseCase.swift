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
        try tracksRepository.removeFavourites(tracks: tracksToRemove)
        try tracksRepository.updateFavourite(tracks: tracksToUpdate)
    }
}

#if DEBUG
struct UpdateFavouriteTracksUseCasePreviewMock: UpdateFavouriteTracksUseCase {
    func callAsFunction(tracksToUpdate: [PositionedItem<Track>], tracksToRemove: [Track]) throws {
        
    }
}
#endif
