import Foundation

protocol TracksRepository {
    func addToFavourites(track: Track) throws
    func getFavouriteTracks() -> [PositionedItem<Track>]
    func getFavouriteTracks(_ ids: [Int]?) -> [PositionedItem<Track>]
    func removeFavourites(tracks: [Track]) throws
    func updateFavourite(tracks: [PositionedItem<Track>]) throws
}

struct TracksRepositoryImplementation: TracksRepository {
    private let tracksDataSource: TracksDataSource
    
    init(tracksDataSource: TracksDataSource) {
        self.tracksDataSource = tracksDataSource
    }
    
    func addToFavourites(track: Track) throws {
        let count = try tracksDataSource.getAllTracksCount()
        let trackDTO = track.toDDBBDTO(at: count)
        try tracksDataSource.save(track: trackDTO)
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
    
    func removeFavourites(tracks: [Track]) throws {
        guard tracks.count > 0 else { return }
        try tracksDataSource.removeTracks(ids: tracks.map { $0.id })
    }
    
    func updateFavourite(tracks: [PositionedItem<Track>]) throws {
        guard tracks.count > 0 else { return }
        let tracksDDBB = tracks.map { $0.item.toDDBBDTO(at: $0.position) }
        try tracksDataSource.update(tracks: tracksDDBB)
    }
}
