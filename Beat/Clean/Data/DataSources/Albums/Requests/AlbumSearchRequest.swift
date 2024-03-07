import Foundation

struct AlbumSearchRequest: NetworkRequest {
    var path: String = "/search/album"
    var parameters: [String : String] {
        var params: [String : String] = [:]
        
        params["q"] = query
        params["limit"] = "1"
        
        return params
    }
    
    let query: String
}
