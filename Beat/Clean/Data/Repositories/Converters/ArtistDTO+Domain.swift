import Foundation

extension ArtistDTO {
    var toDomain: Artist? {
        guard let small = URL(string: self.pictureSmall),
              let medium = URL(string: self.pictureMedium),
              let large = URL(string: self.pictureLarge),
              let xlarge = URL(string: self.pictureXLarge) else { return nil }
        
        return .init(
            id: id,
            name: name,
            pictureSmallUrl: small,
            pictureMediumUrl: medium,
            pictureLargeUrl: large,
            pictureXLargeUrl: xlarge
        )
    }
}
