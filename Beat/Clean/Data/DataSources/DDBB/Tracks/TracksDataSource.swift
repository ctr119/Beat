import Foundation
import SwiftData

protocol TracksDataSource {
    func allTracks() -> [TrackDTO]
    func removeTrack(id: Int) throws
    func save(track: TrackDTO) throws
}

struct TracksDataSourceImplementation: TracksDataSource {
    private let context: ModelContext
    
    init(container: ModelContainer) {
        self.context = ModelContext(container)
    }
    
    func allTracks() -> [TrackDTO] {
        let descriptor = FetchDescriptor<TrackDTO>()
        return (try? context.fetch(descriptor)) ?? []
    }
    
    func removeTrack(id: Int) throws {
        try context.delete(model: TrackDTO.self, where: #Predicate {
            $0.trackId == id
        })
        try context.save()
    }
    
    func save(track: TrackDTO) throws {
        let trackId = track.trackId
        let descriptor = FetchDescriptor<TrackDTO>(predicate: #Predicate { $0.trackId == trackId })
        let count = try context.fetchCount(descriptor)
        guard count == 0 else { return }
        
        context.insert(track)
        try context.save()
    }
}
