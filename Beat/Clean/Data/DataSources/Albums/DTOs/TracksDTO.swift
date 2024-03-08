import Foundation

struct TracksDTO: Decodable {
    struct TrackDTO: Decodable {
        let id: Int
        let title: String
        let duration: Int
    }
    
    let data: [TrackDTO]
}
