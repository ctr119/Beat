import Foundation

struct TracksDTO: Decodable {
    struct TrackDTO: Decodable {
        let id: Int
        let title: String
        let duration: Int
        /// TODO: Consider add the artist info as it already comes from the API as part of the track.
        /// This has to be stored in the DDBB, and the Track domain object will contain the artist name as well
    }
    
    let data: [TrackDTO]
}
