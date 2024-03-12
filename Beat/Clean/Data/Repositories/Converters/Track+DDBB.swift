import Foundation

extension Track {
    func toDDBBDTO(at position: Int) -> TrackDTO {
        return .init(
            trackId: self.id,
            name: self.title,
            duration: self.durationInSeconds,
            artistName: self.artistName,
            position: position
        )
    }
}
