import Foundation

struct AlbumDetailsRequest: NetworkRequest {
    var path: String {
        "/album/\(albumId)"
    }
    var parameters: [String : String] = [:]
    
    let albumId: Int
}
