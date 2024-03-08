import Foundation

protocol GetTopAlbumsUseCase {
    func callAsFunction() async -> [Album]
}

struct GetTopAlbumsUseCaseImplementation: GetTopAlbumsUseCase {
    private let albumsQueries = [
        "eminem", "soad", "linkinpark"
    ]
    
    private let albumsRepository: AlbumsRepository
    
    init(albumsRepository: AlbumsRepository) {
        self.albumsRepository = albumsRepository
    }
    
    func callAsFunction() async -> [Album] {
        await withTaskGroup(of: [Album].self) { group -> [Album] in
            for query in albumsQueries {
                group.addTask {
                    await albumsRepository.searchAlbum(with: query)
                }
            }
            
            return await group.reduce(into: [Album]()) { partialResult, taskAlbums in
                partialResult += taskAlbums
            }
        }
    }
}

#if DEBUG
struct GetTopAlbumsUseCasePreviewMock: GetTopAlbumsUseCase {
    func callAsFunction() async -> [Album] {
        [
            Album(
                id: 103248,
                title: "The Eminem Show",
                coverUrlSmall: URL(string: "https://e-cdns-images.dzcdn.net/images/cover/ec3c8ed67427064c70f67e5815b74cef/56x56-000000-80-0-0.jpg")!,
                coverUrlMedium: URL(string: "https://e-cdns-images.dzcdn.net/images/cover/ec3c8ed67427064c70f67e5815b74cef/250x250-000000-80-0-0.jpg")!,
                coverUrlLarge: URL(string: "https://e-cdns-images.dzcdn.net/images/cover/ec3c8ed67427064c70f67e5815b74cef/500x500-000000-80-0-0.jpg")!,
                artist: Artist(id: 13, name: "Eminem")
            ),
            Album(
                id: 73123,
                title: "Mezmerize",
                coverUrlSmall: URL(string: "https://e-cdns-images.dzcdn.net/images/cover/4954f43cc6033ddfa0fa3ee5514a26ca/56x56-000000-80-0-0.jpg")!,
                coverUrlMedium: URL(string: "https://e-cdns-images.dzcdn.net/images/cover/4954f43cc6033ddfa0fa3ee5514a26ca/250x250-000000-80-0-0.jpg")!,
                coverUrlLarge: URL(string: "https://e-cdns-images.dzcdn.net/images/cover/4954f43cc6033ddfa0fa3ee5514a26ca/500x500-000000-80-0-0.jpg")!,
                artist: Artist(id: 458, name: "System of A Down")
            ),
            Album(
                id: 1346746,
                title: "Meteora",
                coverUrlSmall: URL(string: "https://e-cdns-images.dzcdn.net/images/cover/882448ab63952aa16e502c82db2df160/56x56-000000-80-0-0.jpg")!,
                coverUrlMedium: URL(string: "https://e-cdns-images.dzcdn.net/images/cover/882448ab63952aa16e502c82db2df160/250x250-000000-80-0-0.jpg")!,
                coverUrlLarge: URL(string: "https://e-cdns-images.dzcdn.net/images/cover/882448ab63952aa16e502c82db2df160/500x500-000000-80-0-0.jpg")!,
                artist: Beat.Artist(id: 92, name: "Linkin Park")
            )
        ]
    }
}
#endif
