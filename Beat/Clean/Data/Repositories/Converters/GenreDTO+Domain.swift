import Foundation

extension GenresDTO.GenreDTO {
    var toDomain: Genre {
        .init(id: id, name: name)
    }
}
