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
        tracksRepository.getTracks().sorted { lhs, rhs in
            lhs.position < rhs.position
        }
    }
}
