import Foundation

struct GenresDTO: Decodable {
    struct GenreDTO: Decodable {
        let id: Int
        let name: String
    }
    
    let data: [GenreDTO]
}
