import Foundation

protocol TracksRepository {
    func getFavouriteTracks() -> [PositionedItem<Track>]
    func getFavouriteTracks(_ ids: [Int]?) -> [PositionedItem<Track>]
}

struct TracksRepositoryImplementation: TracksRepository {
    private let tracksDataSource: TracksDataSource
    
    init(tracksDataSource: TracksDataSource) {
        self.tracksDataSource = tracksDataSource
    }
    
    func getFavouriteTracks() -> [PositionedItem<Track>] {
        getFavouriteTracks(nil)
    }
    
    func getFavouriteTracks(_ ids: [Int]?) -> [PositionedItem<Track>] {
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
