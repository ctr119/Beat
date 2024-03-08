import Foundation

#if DEBUG
extension Artist {
    static var previewEminemMock: Artist {
        Artist(
            id: 13,
            name: "Eminem",
            pictureSmallUrl: URL(string: "https://e-cdns-images.dzcdn.net/images/artist/19cc38f9d69b352f718782e7a22f9c32/56x56-000000-80-0-0.jpg")!,
            pictureMediumUrl: URL(string: "https://e-cdns-images.dzcdn.net/images/artist/19cc38f9d69b352f718782e7a22f9c32/250x250-000000-80-0-0.jpg")!,
            pictureLargeUrl: URL(string: "https://e-cdns-images.dzcdn.net/images/artist/19cc38f9d69b352f718782e7a22f9c32/500x500-000000-80-0-0.jpg")!,
            pictureXLargeUrl: URL(string: "https://e-cdns-images.dzcdn.net/images/artist/19cc38f9d69b352f718782e7a22f9c32/1000x1000-000000-80-0-0.jpg")!
        )
    }
    
    static var previewSoadMock: Artist {
        Artist(
            id: 458,
            name: "System of A Down",
            pictureSmallUrl: URL(string: "https://e-cdns-images.dzcdn.net/images/artist/67460cdb0b52bfde1b807650958058d6/56x56-000000-80-0-0.jpg")!,
            pictureMediumUrl: URL(string: "https://e-cdns-images.dzcdn.net/images/artist/67460cdb0b52bfde1b807650958058d6/250x250-000000-80-0-0.jpg")!,
            pictureLargeUrl: URL(string: "https://e-cdns-images.dzcdn.net/images/artist/67460cdb0b52bfde1b807650958058d6/500x500-000000-80-0-0.jpg")!,
            pictureXLargeUrl: URL(string: "https://e-cdns-images.dzcdn.net/images/artist/67460cdb0b52bfde1b807650958058d6/1000x1000-000000-80-0-0.jpg")!
        )
    }
    
    static var previewLinkinParkMock: Artist {
        Artist(
            id: 92,
            name: "Linkin Park",
            pictureSmallUrl: URL(string: "https://e-cdns-images.dzcdn.net/images/artist/4d517aca6ced96c003aa4aae7073b8a1/56x56-000000-80-0-0.jpg")!,
            pictureMediumUrl: URL(string: "https://e-cdns-images.dzcdn.net/images/artist/4d517aca6ced96c003aa4aae7073b8a1/250x250-000000-80-0-0.jpg")!,
            pictureLargeUrl: URL(string: "https://e-cdns-images.dzcdn.net/images/artist/4d517aca6ced96c003aa4aae7073b8a1/500x500-000000-80-0-0.jpg")!,
            pictureXLargeUrl: URL(string: "https://e-cdns-images.dzcdn.net/images/artist/4d517aca6ced96c003aa4aae7073b8a1/1000x1000-000000-80-0-0.jpg")!
        )
    }
}
#endif
