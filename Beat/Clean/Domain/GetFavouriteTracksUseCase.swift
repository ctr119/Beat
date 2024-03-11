import Foundation

protocol GetFavouriteTracksUseCase {
    func callAsFunction() -> [PositionedItem<Track>]
}

struct GetFavouriteTracksUseCaseImplementation: GetFavouriteTracksUseCase {
    private let tracksRepository: TracksRepository
    
    init(tracksRepository: TracksRepository) {
        self.tracksRepository = tracksRepository
    }
    
    func callAsFunction() -> [PositionedItem<Track>] {
        tracksRepository.getFavouriteTracks().sorted { lhs, rhs in
            lhs.position < rhs.position
        }
    }
}
