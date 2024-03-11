import Foundation

extension TrackDTO {
    var toDomain: PositionedItem<Track> {
        let track = Track(
            id: self.trackId,
            title: self.name,
            durationInSeconds: self.duration,
            artistName: self.artistName
        )
        
        return .init(item: track, position: self.position)
    }
}
