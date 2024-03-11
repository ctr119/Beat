import Foundation

protocol TracksRepository {
    func getTracks() -> [PositionedItem<Track>]
}

struct TracksRepositoryImplementation: TracksRepository {
    private let tracksDataSource: TracksDataSource
    
    init(tracksDataSource: TracksDataSource) {
        self.tracksDataSource = tracksDataSource
    }
    
    func getTracks() -> [PositionedItem<Track>] {
        return tracksDataSource.allTracks().map { $0.toDomain }
    }
}
