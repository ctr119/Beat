import Foundation

@Observable
class FavouriteTracksViewModel {
    private(set) var tracks: [Track] = []
    private var removedTracks: [Track] = []
    
    private let getFavouriteTracksUseCase: GetFavouriteTracksUseCase
    private let updateFavouriteTracksUseCase: UpdateFavouriteTracksUseCase
    
    init(
        getFavouriteTracksUseCase: GetFavouriteTracksUseCase,
        updateFavouriteTracksUseCase: UpdateFavouriteTracksUseCase
    ) {
        self.getFavouriteTracksUseCase = getFavouriteTracksUseCase
        self.updateFavouriteTracksUseCase = updateFavouriteTracksUseCase
    }
    
    func loadTracks() {
        tracks = getFavouriteTracksUseCase().map { $0.item }
    }
    
    func deleteTrack(atOffsets offsets: IndexSet) {
        guard let index = offsets.first, index < tracks.count else { return }
        let removedTrack = tracks.remove(at: index)
        removedTracks.append(removedTrack)
    }
    
    func moveTrack(fromOffsets source: IndexSet, toOffset destination: Int) {
        tracks.move(fromOffsets: source, toOffset: destination)
    }
    
    func save() {
        do {
            let positionedTracks = tracks.enumerated().map { PositionedItem<Track>(item: $1, position: $0) }
            try updateFavouriteTracksUseCase(tracksToUpdate: positionedTracks, tracksToRemove: removedTracks)
            removedTracks.removeAll()
        } catch {
            
        }
    }
}
