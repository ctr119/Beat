import Foundation

#if DEBUG
extension Album {
    static var previewEminemMock: Album {
        Album(
            id: 103248,
            title: "The Eminem Show",
            coverUrlSmall: URL(string: "https://e-cdns-images.dzcdn.net/images/cover/ec3c8ed67427064c70f67e5815b74cef/56x56-000000-80-0-0.jpg")!,
            coverUrlMedium: URL(string: "https://e-cdns-images.dzcdn.net/images/cover/ec3c8ed67427064c70f67e5815b74cef/250x250-000000-80-0-0.jpg")!,
            coverUrlLarge: URL(string: "https://e-cdns-images.dzcdn.net/images/cover/ec3c8ed67427064c70f67e5815b74cef/500x500-000000-80-0-0.jpg")!,
            artist: .previewEminemMock,
            genres: [.previewHipHopMock],
            releaseDate: "2002-01-01".toDate,
            tracks: .previewEminemTracks
        )
    }
    
    static var previewSoadMock: Album {
        Album(
            id: 73123,
            title: "Mezmerize",
            coverUrlSmall: URL(string: "https://e-cdns-images.dzcdn.net/images/cover/4954f43cc6033ddfa0fa3ee5514a26ca/56x56-000000-80-0-0.jpg")!,
            coverUrlMedium: URL(string: "https://e-cdns-images.dzcdn.net/images/cover/4954f43cc6033ddfa0fa3ee5514a26ca/250x250-000000-80-0-0.jpg")!,
            coverUrlLarge: URL(string: "https://e-cdns-images.dzcdn.net/images/cover/4954f43cc6033ddfa0fa3ee5514a26ca/500x500-000000-80-0-0.jpg")!,
            artist: .previewSoadMock,
            genres: [.previewRockMock, .previewHardRockMock, .previewMetalMock],
            releaseDate: "2005-05-17".toDate,
            tracks: .previewSoadTracks
        )
    }
    
    static var previewLinkinParkMock: Album {
        Album(
            id: 1346746,
            title: "Meteora",
            coverUrlSmall: URL(string: "https://e-cdns-images.dzcdn.net/images/cover/882448ab63952aa16e502c82db2df160/56x56-000000-80-0-0.jpg")!,
            coverUrlMedium: URL(string: "https://e-cdns-images.dzcdn.net/images/cover/882448ab63952aa16e502c82db2df160/250x250-000000-80-0-0.jpg")!,
            coverUrlLarge: URL(string: "https://e-cdns-images.dzcdn.net/images/cover/882448ab63952aa16e502c82db2df160/500x500-000000-80-0-0.jpg")!,
            artist: .previewLinkinParkMock,
            genres: [.previewAlternativeMock],
            releaseDate: "2003-03-24".toDate,
            tracks: .previewLinkinParkTracks
        )
    }
}
#endif
