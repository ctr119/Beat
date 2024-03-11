import Foundation

struct TracksDTO: Decodable {
    struct TrackDTO: Decodable {
        struct TrackArtistDTO: Decodable {
            let id: Int
            let name: String
        }
        
        let id: Int
        let title: String
        let duration: Int
        let artist: TrackArtistDTO
    }
    
    let data: [TrackDTO]
}
