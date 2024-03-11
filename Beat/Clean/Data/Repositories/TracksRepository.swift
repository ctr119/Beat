import Foundation

protocol TracksRepository {
    // TODO: Rename both to add "Favourite" in the name
    func getTracks() -> [PositionedItem<Track>]
    func getTracks(_ ids: [Int]?) -> [PositionedItem<Track>]
}

struct TracksRepositoryImplementation: TracksRepository {
    private let tracksDataSource: TracksDataSource
    
    init(tracksDataSource: TracksDataSource) {
        self.tracksDataSource = tracksDataSource
    }
    
    func getTracks() -> [PositionedItem<Track>] {
        getTracks(nil)
    }
    
    func getTracks(_ ids: [Int]?) -> [PositionedItem<Track>] {
        do {
            var tracksDTO: [TrackDTO] = []
            
            if let ids {
                tracksDTO = try tracksDataSource.getTracks(for: ids)
            } else {
                tracksDTO = try tracksDataSource.allTracks()
            }
            
            return tracksDTO.map { $0.toDomain }
        } catch {
            return []
        }
    }
}
