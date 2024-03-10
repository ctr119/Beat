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
                    await albumsRepository.searchAlbum(with: query, limit: 1)
                }
            }
            
            let allAlbums = await group.reduce(into: [Album]()) { partialResult, taskAlbums in
                partialResult += taskAlbums
            }
            return allAlbums.sorted { lhs, rhs in
                lhs.title < rhs.title
            }
        }
    }
}

#if DEBUG
struct GetTopAlbumsUseCasePreviewMock: GetTopAlbumsUseCase {
    func callAsFunction() async -> [Album] {
        [
            .previewEminemMock,
            .previewSoadMock,
            .previewLinkinParkMock
        ]
    }
}
#endif
