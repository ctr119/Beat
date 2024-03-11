import Foundation
import SwiftData

@Model
class TrackDTO {
    let trackId: Int
    let name: String
    let duration: String
    let artistName: String
    
    init(trackId: Int, name: String, duration: String, artistName: String) {
        self.trackId = trackId
        self.name = name
        self.duration = duration
        self.artistName = artistName
    }
}
