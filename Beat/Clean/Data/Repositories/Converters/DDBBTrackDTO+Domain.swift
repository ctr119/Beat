import Foundation

extension TrackDTO {
    var toDomain: PositionedItem<Track> {
        let track = Track(
            id: self.trackId,
            title: self.name,
            durationInSeconds: self.duration
        )
        // TODO: Map the artistName
        
        return .init(item: track, position: self.position)
    }
}
