import Foundation
import SwiftData

@Model
class TrackDTO {
    let trackId: Int
    let name: String
    let duration: Int
    let artistName: String
    let position: Int
    
    init(trackId: Int, name: String, duration: Int, artistName: String, position: Int) {
        self.trackId = trackId
        self.name = name
        self.duration = duration
        self.artistName = artistName
        self.position = position
    }
}
