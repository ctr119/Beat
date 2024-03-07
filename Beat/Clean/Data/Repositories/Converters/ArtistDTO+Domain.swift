import Foundation

extension ArtistDTO {
    var toDomain: Artist? {
        .init(id: id, name: name)
    }
}
