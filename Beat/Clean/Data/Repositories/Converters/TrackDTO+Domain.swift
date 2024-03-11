import Foundation

extension TracksDTO.TrackDTO {
    var toDomain: Track {
        .init(
            id: id,
            title: title,
            durationInSeconds: duration,
            artistName: artist.name
        )
    }
}
